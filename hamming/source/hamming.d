module hamming;

import std.conv : to;
import std.algorithm : count;
import std.range : zip, StoppingPolicy;

int distance(string str1, string str2) {
    return to!int(StoppingPolicy.requireSameLength.zip(str1, str2).count!( a => a[0] != a[1]));
}

unittest
{
import std.exception : assertThrown;

const int allTestsEnabled = 1;

    assert(distance("A", "A") == 0);
static if (allTestsEnabled)
{
    assert(distance("A", "G") == 1);
    assert(distance("AG", "CT") == 2);
    assert(distance("AT", "CT") == 1);
    assert(distance("GGACG", "GGTCG") == 1);
    assertThrown(distance("AAAG", "AAA"));
    assertThrown(distance("AAA", "AAAG"));
    assert(distance("GATACA", "GCATAA") == 4);
    assert(distance("GGACGGATTCTG", "AGGACGGATTCT") == 9);
}

}
