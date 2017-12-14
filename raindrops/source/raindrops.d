import std.conv;
import std.stdio;


bool detect(int[] array, int num)
{
    bool detect = false;

    foreach(i; array)
    {
        if(i == num)
        {
            detect = true;
            break;
        }

    }
    return detect;
}

string convert(int number)
{
    int[] findFactors(int num, int[] factors = [])
    {
        for(int i = 1; i <= num; i++)
            if(num % i == 0) factors ~= i;

        return factors;
    }

    int[] factors = findFactors(number);
    writeln(factors);

    string return_string = "";

    if(factors.detect(3))
        return_string ~= "Pling";
    if(factors.detect(5))
        return_string ~= "Plang";
    if(factors.detect(7))
        return_string ~= "Plong";
    if(return_string == "")
        return_string ~= to!string(number);

    return return_string;
}

unittest {
const int allTestsEnabled = 1;

    assert(convert(1) == "1");
    assert(convert(3) == "Pling");
    assert(convert(5) == "Plang");
    assert(convert(7) == "Plong");
    assert(convert(6) == "Pling");
    assert(convert(9) == "Pling");
    assert(convert(10) == "Plang");
    assert(convert(14) == "Plong");
    assert(convert(15) == "PlingPlang");
static if (allTestsEnabled) {
    assert(convert(21) == "PlingPlong");
    assert(convert(25) == "Plang");
    assert(convert(30) == "PlingPlang");
    assert(convert(35) == "PlangPlong");
    assert(convert(49) == "Plong");
    assert(convert(52) == "52");
    assert(convert(105) == "PlingPlangPlong");
  }

}
