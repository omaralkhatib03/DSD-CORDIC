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

// remember to add random seed test

// test 1
//  #define step 5
//  #define N 52

// test 2
//  #define step 1/8.0
//  #define N 2041

// test 3
//  #define step 1/1024.0
//  #define N 261121


#define ALT_CI_FP_ADD_SUB_0(n,A,B) __builtin_custom_fnff(ALT_CI_FP_ADD_SUB_0_N+(n&ALT_CI_FP_ADD_SUB_0_N_MASK),(A),(B))
#define ALT_CI_FP_ADD_SUB_0_N 0x2
#define ALT_CI_FP_ADD_SUB_0_N_MASK ((1<<1)-1)
#define ALT_CI_FP_MULT_0(A,B) __builtin_custom_fnff(ALT_CI_FP_MULT_0_N,(A),(B))
#define ALT_CI_FP_MULT_0_N 0x0


#define TestsToRun 3

const float steps[3] = {5, 1 / 8.0, 1 / 1024.0};
const int Ns[3] = {52, 2041, 261121};

void generateVector(float x[], float step, int N)
{
  int i;
  x[0] = 0;
  for (i = 1; i < N; i++)
  {
    x[i] = x[i - 1] + step;
  }
}

float sumVector(float x[], int M)
{
  int i;
  float sum = 0;

  for (i = 0; i < M; i++)
  {
    sum += x[i] + (x[i] * x[i]);
  }
  return sum;
}

// float trigSum(float x[], int M){
//   int i;
//   float sum = 0;
//   float t1;
//   float t2;
//   float t3;
//   float t4;
//   float t5;
//   float t6;

//   for(i = 0; i < M; i++){
//     t1 = ALT_CI_FP_MULT_0(0.5, x[i]);
//     t2 = ALT_CI_FP_MULT_0(x[i], x[i]);
//     t3 = ALT_CI_FP_ADD_SUB_0(0, x[i], 128);
//     t4 = ALT_CI_FP_MULT_0(t3, 0.0078125);
//     t5 = ALT_CI_FP_MULT_0(t2, cosf(t4));
//     t6 = ALT_CI_FP_ADD_SUB_0(1, t5, t1);
//     sum = ALT_CI_FP_ADD_SUB_0(1, sum, t6);
//   }
//   return sum;
// }

float trigSum(float x[], int M)
{
  int i;
  float sum = 0;

  for (i = 0; i < M; i++)
  {
    sum = ALT_CI_FP_ADD_SUB_0(1, sum, ALT_CI_FP_ADD_SUB_0(1, ALT_CI_FP_MULT_0(ALT_CI_FP_MULT_0(x[i], x[i]), 
          cosf(ALT_CI_FP_MULT_0(ALT_CI_FP_ADD_SUB_0(0, x[i], 128), 0.0078125))), ALT_CI_FP_MULT_0(0.5, x[i])));
  }
  return sum;
}

union MyFloat
{
  float f;
  unsigned i;
} typedef MyFloat;

void runTest(int N, float step)
{
  float x[N];
  MyFloat y;
  clock_t diff;
  clock_t exec_t1, exec_t2;
  int j = 0;

  generateVector(x, step, N);
  exec_t1 = times(NULL);

  for (; j < 10; j++)
  {
    y.f = trigSum(x, N);
  }

  exec_t2 = times(NULL);
  diff = exec_t2 - exec_t1;

  printf("Result: %f\n", y.f);
  printf("proc time avg: %f ms\n", (diff/10.));
  printf("IEEE 754 Format: 0x%lx\n", (unsigned long) y.i);
}

int main()
{
  printf("Task 6!\n");

  int t = 0;
  for (; t < TestsToRun; t++)
  {
    printf("Test Case %d\n", t + 1);
    runTest(Ns[t], steps[t]);
    printf("\n");
  }

  // MyFloat a;
  // MyFloat b;
  // MyFloat c;

  // a.f = 1;
  // b.f = 3;
  // c.f = ALT_CI_FP_MULT_0(a.i, b.i);
  // c.f = ALT_CI_FP_ADD_SUB_0(1, a.f, b.f);

  // printf("n: 1, a:%x, b:%x, c:%x\n", a.i, b.i, c.i);

  // c.f = ALT_CI_FP_ADD_SUB_0(0, a.f, b.f);

  // printf("n: 0, a:%x, b:%x, c:%x\n", a.i, b.i, c.i);

  return 0;
}
