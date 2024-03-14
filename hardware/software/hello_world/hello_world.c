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
#include <unistd.h>

// test 1
#define step1 5
#define N1 52

// test 2
#define step2 1 / 8.0
#define N2 2041

// test 3
#define step3 1 / 1024.0
#define N3 261121

#define one  1.00000000000000000000e+00f /* 0x3FF00000, 0x00000000 */
#define half 0.5f
#define C1   4.16666666666666019037e-02f /* 0x3FA55555, 0x5555554C */
#define C2  -1.38888888888741095749e-03f /* 0xBF56C16C, 0x16C15177 */
#define C3   2.48015872894767294178e-05f /* 0x3EFA01A0, 0x19CB1590 */
#define C4  -2.75573143513906633035e-07f /* 0xBE927E4F, 0x809C52AD */
#define C5   2.08757232129817482790e-09f /* 0x3E21EE9E, 0xBDB4B1C4 */
#define C6  -1.13596475577881948265e-11f /* 0xBDA8FAE9, 0xBE8838D4 */
#define OneTwoEight 128
#define reciprocalOneTwoEight 0.0078125f

#define ALT_CI_FP_ADD_0(A,B) __builtin_custom_fnff(ALT_CI_FP_ADD_0_N,(A),(B))
#define ALT_CI_FP_ADD_0_N 0x1
#define ALT_CI_FX_OPTIMISED_0(A) __builtin_custom_fnf(ALT_CI_FX_OPTIMISED_0_N,(A))
#define ALT_CI_FX_OPTIMISED_0_N 0x0

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


float cosMcluren(float x) {
  const float x2 = (x * x);
  const float x4 = x2 * x2;
  const float x6 = (x4 * x2);
  const float x8 = (x4 * x4);
  return one - x2 * half + (x4) * C1 + (x6) * C2;
}


float trigSum(float x[], int M)
{
  int i;
  float sum = 0;
  float el = 0;

  for (i = 0; i < M; i++)
  {
    sum = ALT_CI_FP_ADD_0(ALT_CI_FX_OPTIMISED_0(x[i]),sum);
  }

  return sum;
}

union MyFloat {
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
  printf("proc time avg: %f ms\n", (diff * 0.1f));
  printf("IEEE 754 Format: 0x%lx\n", (unsigned long)y.i);
}

int main()
{
  printf("Task 6!\n");
  printf("Test Case %d\n", 1);
  runTest(N1, step1);
  printf("\n");
  printf("Test Case %d\n", 2);
  runTest(N2, step2);
  printf("\n");
  printf("Test Case %d\n", 3);
  runTest(N3, step3);
  printf("\n");

  // MyFloat x;
  // x.f = 255.f;
  // MyFloat y;
  // y.f = ALT_CI_COMPUTE_TERM_0(x.f);
  // 
  // printf("y: %f x:%f \n", y.f, x.f);

  return 0;
}
