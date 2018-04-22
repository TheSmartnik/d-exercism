
module nucleotide_count;

import core.exception;
import std.string;
import std.stdio;
import std.array;
import std.algorithm.sorting: sort;
import std.algorithm.comparison: equal;

class Counter {

	string dna;

	this(string dna) {
		this.dna = dna;
	}

	ulong countOne(char nucleotide) {
		try {
			return nucleotideCounts()[nucleotide];
		} catch(core.exception.RangeError) {
			throw new Exception("Wrong nucleotide");
		}
	}

	ulong[char] nucleotideCounts() {
		ulong[char] nucleotides = ['A': 0, 'T': 0, 'C': 0, 'G': 0];

		foreach(nucleotide; dna) {
			nucleotides[nucleotide] ++;
		}

		return nucleotides;
	}
}

unittest
{

// test associative array equality
bool aaEqual (const ulong[char] lhs, const ulong[char] rhs)
{
	auto lhs_pairs = lhs.byKeyValue.array;
	auto rhs_pairs = rhs.byKeyValue.array;
	lhs_pairs.sort!(q{a.key < b.key});
	rhs_pairs.sort!(q{a.key < b.key});

	return equal!("a.key == b.key && a.value == b.value")(lhs_pairs, rhs_pairs);
}

immutable int allTestsEnabled = 1;

// has_no_nucleotides
{
	Counter dna = new Counter("");
	const ulong[char] expected = ['A': 0, 'T': 0, 'C': 0, 'G':0];

	auto actual = dna.nucleotideCounts();

	assert(aaEqual(expected, actual));
}

// has_no_adenosine
{
	Counter dna = new Counter("");

	assert(dna.countOne('A') == 0);
}

// repetitive_cytidine_gets_count
{
	Counter dna = new Counter("CCCCC");

	assert(dna.countOne('C') == 5);
}

// repetitive_sequence_has_only_guanosine
{
	Counter dna = new Counter("GGGGGGGG");
	const ulong[char] expected = ['A': 0, 'T': 0, 'C': 0, 'G': 8];

	const auto actual = dna.nucleotideCounts();

	assert(aaEqual(expected, actual));
}

// count_only_thymidine
{
	Counter dna = new Counter("GGGGTAACCCGG");

	assert(dna.countOne('T') == 1);
}

// count_a_nucleotide_only_once
{

	Counter dna = new Counter("GGTTGG");

	dna.countOne('T');

	assert(dna.countOne('T') == 2);
}


// validates_nucleotides
{
	import std.exception : assertThrown;

	Counter dna = new Counter("GGTTGG");

	assertThrown(dna.countOne('X'));
}

static if (allTestsEnabled) {
// count_all_nucleotides)
{
	Counter dna = new Counter("AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC");
	const ulong[char] expected = ['A': 20, 'T': 21, 'G': 17, 'C': 12 ];

	auto actual = dna.nucleotideCounts();

	assert(aaEqual(expected, actual));
}
}

}
