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

// test 1
 #define step1 5
 #define N1 52

// test 2
 #define step2 1/8.0
 #define N2 2041

// test 3
 #define step3 1/1024.0
 #define N3 261121

#define ALT_CI_FP_ADD_SUB_0(n,A,B) __builtin_custom_fnff(ALT_CI_FP_ADD_SUB_0_N+(n&ALT_CI_FP_ADD_SUB_0_N_MASK),(A),(B))
#define ALT_CI_FP_ADD_SUB_0_N 0x2
#define ALT_CI_FP_ADD_SUB_0_N_MASK ((1<<1)-1)
#define ALT_CI_FP_MULT_0(A,B) __builtin_custom_fnff(ALT_CI_FP_MULT_0_N,(A),(B))
#define ALT_CI_FP_MULT_0_N 0x0


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

float cosN(float x) {
    float x2 = x * x;
    float term2 = ALT_CI_FP_MULT_0(x2,0.5f);
    float x4 = ALT_CI_FP_MULT_0(x2,x2);
    float term3 = ALT_CI_FP_MULT_0(4.16666666666666019037e-02f,x4);
    float x6 = ALT_CI_FP_MULT_0(x2,x4);
    float term4 = ALT_CI_FP_MULT_0(-1.38888888888741095749e-03f,x6);
    float x8 = ALT_CI_FP_MULT_0(x2,x6);
    float term5 = ALT_CI_FP_MULT_0(2.48015872894767294178e-05f,x8);
    float r = ALT_CI_FP_ADD_SUB_0(0, 1.0f,term2);
    float x10 = ALT_CI_FP_MULT_0(x2,x8);
    float term6 = ALT_CI_FP_MULT_0(-2.75573143513906633035e-07f,x10);
    float x12 = ALT_CI_FP_MULT_0(x2,x10);
    float term7 = ALT_CI_FP_MULT_0(2.08757232129817482790e-09f,x12);
    float x14 = ALT_CI_FP_MULT_0(x2,x12);
    float term8 = ALT_CI_FP_MULT_0(-1.13596475577881948265e-11f,x14);
    r = ALT_CI_FP_ADD_SUB_0(1, r,term8);
    r = ALT_CI_FP_ADD_SUB_0(1, r,term7);
    r = ALT_CI_FP_ADD_SUB_0(1, r,term3);
    r = ALT_CI_FP_ADD_SUB_0(1, r,term4);
    r = ALT_CI_FP_ADD_SUB_0(1, r,term5);
    r = ALT_CI_FP_ADD_SUB_0(1, r,term6);
    return r;
  }



float trigSum(float x[], int M)
{
  int i;
  float sum = 0;

  for (i = 0; i < M; i++)
  {
    sum += 0.5f*x[i] + (x[i] * x[i])*cosf((x[i] + -128) * 0.0078125f);
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
    printf("Test Case %d\n", 1);
    runTest(N1, step1);
    printf("\n");
    printf("Test Case %d\n", 2);
    runTest(N2, step2);
    printf("\n");
    printf("Test Case %d\n", 3);
    runTest(N3, step3);
    printf("\n");
  
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
