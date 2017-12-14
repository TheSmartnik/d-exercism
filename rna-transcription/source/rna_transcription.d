module rna_transcription;
import std.string;
import std.algorithm;
import std.;
import std.exception :enforce;


string dnaComplement(string dna_sequence) {
  char[] dna = ['C', 'G', 'T', 'A'];
  char[] rna = ['G', 'C', 'A', 'U'];

  writeln(dna.findAmong(dna_sequence) !is empty);

  return dna_sequence.tr(dna, rna);
}

unittest {
import std.exception : assertThrown;

const int allTestsEnabled = 0;

    assert(dnaComplement("C") == "G");
    assert(dnaComplement("G") == "C");
    assert(dnaComplement("T") == "A");
    assert(dnaComplement("A") == "U");

    assert(dnaComplement("ACGTGGTCTTAA") == "UGCACCAGAAUU");

    assertThrown(dnaComplement("U"));
    assertThrown(dnaComplement("XXX"));
    assertThrown(dnaComplement("ACGTXXXCTTAA"));
  }

}
