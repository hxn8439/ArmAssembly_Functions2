#include <stdio.h>
#include <stdint.h>

extern float sumF32(const float x[], uint32_t count);
extern double prodF64(const double x[], uint32_t count);
extern double dotpF64(const double x[], const double y[], uint32_t count);
extern float maxF32(const float x[], uint32_t count);

int main()
{
    uint32_t COUNT =4;
    float result;
    double result1;
    
    
    //A. sumF32
    
    float x[] = {1.6, 1.3, 1.2, 2.6};
    result = sumF32(x, COUNT);
    printf("result = %f\r\n\n", result);
    
     //B. prodF64
    double a[] = {1.6,1.3,1.2,2.6};
    result1 = prodF64(a, COUNT);
    printf("result = %lf\r\n\n", result1);
    
    //c.dotpF64
    double b[] = {1.8,1.5,1.2, 3.4}; 
    result1 = dotpF64(a, b, COUNT);
    printf("result = %lf\r\n\n", result1);
    
    //d.maxF32
    result = maxF32(x, COUNT);
    printf("result = %f\r\n\n", result);
    
    return 0; 
}

