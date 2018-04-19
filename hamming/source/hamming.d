module hamming;

import std.exception : enforce;

int distance(string str1, string str2) {
    enforce(str1.length == str2.length);

    int difference = 0;

    for(int i = 0; i < str1.length; i++)
    {
        if(str1[i] != str2[i]) difference++;
    }

    return difference;
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
