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
#include <unistd.h>

//remember to add random seed test

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



// void runTest(int N, float step) {
//   float x[N];
//   MyFloat y;
//   clock_t diff;
//   clock_t exec_t1, exec_t2;
//   int j = 0;
//   float avgTicks = 0;

//   generateVector(x, step, N);
//   char buf[50];

//   for (;j < 10; j++) {
//     exec_t1 = times(NULL);
//     y.f = trigSum(x, N);
//     exec_t2 = times(NULL);
//     diff = exec_t2 - exec_t1;
//     gcvt(diff, 10, buf);
//     avgTicks += diff;
//   }

//   printf("Result: %d\n", (int) y.f);
//   printf("proc time avg: %d ticks\n", (int) avgTicks/10);
//   printf("IEEE 754 Format: 0x%lx\n", (unsigned long) y.i);

// }

union MyFloat {
  float f;
  unsigned i;
} typedef MyFloat;

int main()
{
  printf("Task 6!\n");
  // int t = 0;
  // for (; t < TestsToRun; t++) {
  //   printf("Test Case %d\n", t + 1);
  //   runTest(Ns[t], steps[t]);
  //   printf("\n");
  // }
  
  MyFloat a;
  MyFloat b;
  MyFloat c;

  a.f = 18;
  b.f = 6;
  c.i = ALT_CI_FP_MULT_0(a.i, b.i);

  printf("a:%x, b:%x, c:%x\n", a.i, b.i, c.i);


  return 0;
}
