#include "FuncA.h"
#include <cmath>
#include <stdexcept>

double FuncA::calculate(int n, double x) {
    double sum = 0.0;
    if (std::abs(x) >= 1.0) {
        throw std::invalid_argument("x must be in the range (-1, 1)");
    }

    for (int i = 0; i < n; ++i) {
        double term = (1.0 / (2 * i + 1)) * std::pow(x, 2 * i + 1);
        sum += term;
    }

    return sum;
}


