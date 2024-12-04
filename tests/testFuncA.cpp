#include <iostream>
#include <cassert>
#include <stdio.h>
#include "../FuncA.h"

void testFuncA() {
    FuncA func;

    assert(func.calculate(10, 0.0) == 0.0);

    double result = func.calculate(10, 0.5);
    double expected = 0.5493;
    assert(abs(result - expected) < 0.0001);

    std::cout << "All tests passed!" << std::endl;
}

int main() {
    testFuncA();
    return 0;
}

