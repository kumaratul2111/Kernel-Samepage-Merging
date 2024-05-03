#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#define CLOCKID CLOCK_MONOTONIC
#define SIG SIGALRM
#define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
                        } while (0);
int counter_exit = 0 ;
unsigned long counter=0;
  
static void
handler(int sig, siginfo_t *si, void *uc)
{
    if(counter_exit == 5){
        printf("\n");
        exit(0);
    }
    counter_exit++ ;
    printf("%lu\t", counter);
}

int
main(int argc, char *argv[])
{
    timer_t            timerid;
    sigset_t           mask;
    int                freq_secs;
    struct sigevent    sev;
    struct sigaction   sa;
    struct itimerspec  its;
    
    /* Establish handler for timer signal. */
    // printf("Establishing handler for signal %d\n", SIG);
    sa.sa_flags = SA_SIGINFO;
    sa.sa_sigaction = handler;
    sigemptyset(&sa.sa_mask);
    if (sigaction(SIG, &sa, NULL) == -1)
        errExit("sigaction")
   
    sev.sigev_notify = SIGEV_SIGNAL;
    sev.sigev_signo = SIG;
    sev.sigev_value.sival_ptr = &timerid;
    if (timer_create(CLOCKID, &sev, &timerid) == -1)
        errExit("timer_create")
    // printf("timer ID is %#jx\n", (uintmax_t) timerid);
    /* Start the timer. */
    freq_secs = 2;
    its.it_value.tv_sec = freq_secs;
    its.it_value.tv_nsec = 0;
    its.it_interval.tv_sec = its.it_value.tv_sec;
    its.it_interval.tv_nsec = its.it_value.tv_nsec;
    if (timer_settime(timerid, 0, &its, NULL) == -1)
         errExit("timer_settime")
    /* Sleep for a while; meanwhile, the timer may expire
       multiple times. */
    while(1)
        counter++ ;
    
    exit(EXIT_SUCCESS);
}

