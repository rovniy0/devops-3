#include <iostream>
#include <cassert>
#include <cmath>
#include <chrono>
#include "../FuncA.h"

void testFuncA() {
    FuncA func;

    assert(func.calculate(10, 0.0) == 0.0);

    double result = func.calculate(10, 0.5);
    double expected = 0.5493;
    assert(abs(result - expected) < 0.0001);

    int n = 500000000; // with the smaller value the test runs too fust (verified :3 )
    double x = 0.5;

    auto start = std::chrono::high_resolution_clock::now();
    func.calculate(n, x);
    auto end = std::chrono::high_resolution_clock::now();

    std::chrono::duration<double> elapsed = end - start;

    assert(elapsed.count() >= 5.0 && elapsed.count() <= 20.0);

    std::cout << "All tests passed!" << std::endl;
}

int main() {
    testFuncA();
    return 0;
}

