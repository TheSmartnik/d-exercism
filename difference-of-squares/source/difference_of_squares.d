module difference_of_squares;

import std.range : iota;
import std.algorithm : sum, reduce;
import std.stdio;

struct squares {
    int square;

    ulong squareOfSum() {
        return iota(0, square + 1).sum() ^^ 2;
    }

    ulong sumOfSquares()
    {
        return reduce!((a, b) => a + b * b)(0, iota(0, square + 1));
    }

    ulong difference()
    {
        return squareOfSum() - sumOfSquares();
    }

}
unittest {
const int allTestsEnabled = 1;

    assert(squares(5).squareOfSum == 225);
    assert(squares(10).squareOfSum == 3_025);
    assert(squares(100).squareOfSum == 25_502_500);

    assert(squares(5).sumOfSquares == 55);
static if (allTestsEnabled) {
    assert(squares(10).sumOfSquares == 385);
    assert(squares(100).sumOfSquares == 338_350);

    assert(squares(0).difference == 0);
    assert(squares(5).difference == 170);
    assert(squares(10).difference == 2_640);
    assert(squares(100).difference == 25_164_150);
}

}
