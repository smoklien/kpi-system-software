#include <stdio.h>
#include <cpuid.h>

int main()
{
    unsigned int i, eax, ebx, ecx, edx;

    for (i = 0; i < 5; i++)
    {
        __cpuid(i, eax, ebx, ecx, edx);
        printf("InfoType %x\nEAX: %x\nEBX: %x\nECX: %x\nEDX: %x\n", i, eax, ebx, ecx, edx);
    }

    return 0;
}