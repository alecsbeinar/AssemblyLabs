#define ARRAY_LENGTH 5

#include <iostream>
#include <time.h>

using namespace std;


int main()
{
    float ar[ARRAY_LENGTH], sum = 0;
    cout << "Enter " << ARRAY_LENGTH << " numbers: " << endl;
    for (int i = 0; i < ARRAY_LENGTH; i++)
        cin >> ar[i];

    clock_t start, end;
    start = clock();
    for (int i = 0; i < ARRAY_LENGTH; i++)
        sum += ar[i];
    end = clock();

    cout << "C: " << sum << endl;
    cout << "Time: " << (double)(end - start) / CLK_TCK << "s." << endl;

    start = clock();
    sum = 0;

    __asm {

        xor edx, edx //counter
        mov ebx, ARRAY_LENGTH //num elements in array
        lea ecx, ar //address of first element in array
        fldz

        L1 :
        fld dword ptr[ecx + edx * 4]
            fadd
            dec ebx
            jz done

            inc edx
            jmp L1

            done :
        fstp sum
    }

    cout << "ASM: " << sum << endl;

    end = clock();

    cout << "Time: " << (double)(end - start) / CLK_TCK << "s." << endl;
    system("pause");
}