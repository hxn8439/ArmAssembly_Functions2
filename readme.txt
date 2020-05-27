Arm Assembly functions that implement the following C functions:
a. float sumF32(const float x[], uint32_t count)
// returns the sum of the elements in an array (x) containing count entries

b. double prodF64(const double x[], uint32_t count)
// returns the product of the elements in an array (x) containing count entries

c. double dotpF64(const double x[], const double y[],uint32_t count)
// returns the dot product of two arrays (x and y) containing count entries

d. float maxF32(const float x[], uint32_t count)
// returns the maximum value in the array (x) containing count entries

Arm Assembly Compile instructions on Raspberry Pi b+ model

->gcc -o test hw4.c hw4.s 
->./test
