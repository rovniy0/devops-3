#include <iostream>
#include "FuncA.h"

int main() {
    FuncA seventeenth_exmpl;
    double x = 0.5;
    int n = 5;

    try {
        std::cout << "arth(" << x << ") = " << seventeenth_exmpl.calculate(n, x) << std::endl;
    }
    catch (const std::invalid_argument& e) {
        std::cerr << e.what() << std::endl;
    }
    system("pause");
    return 0;
}