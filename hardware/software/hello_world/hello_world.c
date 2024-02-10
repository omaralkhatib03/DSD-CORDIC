/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdlib.h>
#include <sys/alt_stdio.h>
#include <sys/alt_alarm.h>
#include <sys/times.h>
#include <alt_types.h>
#include <system.h>
#include <stdio.h>
#include <unistd.h>
#include <math.h>

//test 1
// #define step 5
// #define N 52

//test 2
// #define step 1/8.0
// #define N 2041

//test 3
// #define step 1/1024.0
// #define N 261121

#define TestsToRun 3

const float steps[3] = {5, 1/8.0, 1/1024.0};
const int Ns[3] = {52, 2041, 261121};

void generateVector(float x[], float step, int N){
  int i;
  x[0] = 0;
  for(i=1; i<N; i++){
    x[i] = x[i-1] + step;
  }
}

float sumVector(float x[], int M){
  int i;
  float sum = 0;

  for(i = 0; i < M; i++){
    sum += x[i] + (x[i] * x[i]);
  }
  return sum;
}

float trigSum(float x[], int M){
  int i;
  float sum = 0;
  for(i = 0; i < M; i++){
    sum += 0.5*x[i] + (x[i] * x[i])*cosf((x[i]-128)/128);
  }
  return sum;
}

union MyFloat {
  float f;
  unsigned i;
} typedef MyFloat;

void runTest(int N, float step) {
  float x[N];
  MyFloat y;
  clock_t diff;
  clock_t exec_t1, exec_t2;
  int j = 0;
  float avgTicks = 0;

  generateVector(x, step, N);
  exec_t1 = times(NULL);
  for (;j < 10; j++) {
    y.f = sumVector(x, N);

  }
  exec_t2 = times(NULL);
  printf("%ld\n", exec_t2 - exec_t1);
  diff = (exec_t2 - exec_t1 ) ;
  
  printf("Result: %f\n", y.f);
  printf("proc time avg: %f ms\n", (diff/10.));

  printf("IEEE 754 Format: 0x%lx\n", (unsigned long) y.i);

}

int main()
{
  printf("Task 2!\n");
  int t = 0;
  for (; t < TestsToRun; t++) {
    printf("Test Case %d\n", t + 1);
    runTest(Ns[t], steps[t]);
    printf("\n");
  }
  return 0;
}
