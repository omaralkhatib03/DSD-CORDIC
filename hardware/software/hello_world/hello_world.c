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

//test 1
// #define step 5
// #define N 52

//test 2
#define step 1/8.0
#define N 2041

//test 3
// #define step 1/1024.0
// #define N 261121

void generateVector(float x[N]){
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

union MyFloat {
  float f;
  unsigned i;
} typedef MyFloat;

int main()
{
  printf("Task 2!\n");
  float x[N];
  MyFloat y;

  generateVector(x);
  char buf[50];
  
  // clock_t exec_t1, exec_t2;
  // exec_t1 = times(NULL);
  y.f = sumVector(x, N);
  // exec_t2 = times(NULL);
  
  // gcvt((exec_t2 - exec_t1), 10, buf);
  // alt_putstr("proc time = "); alt_putstr(buf); alt_putstr(" ticks \n");
  printf("Result Raw: %x\n", y.i);
  
  // int i;
  // for(i=0; i<<10; i++)
  //   y.f = y.f/2.0;

  printf("Result: %lu\n", (unsigned long) y.f);
  
  return 0;
}
