module crypto;

import std.string;
import std.regex;
import std.range;
import std.uni;
import std.math;
import std.typecons : Yes;
import std.algorithm.iteration;
import std.conv;

class Cipher
{
	string encodedString;
	string normalizedString;
	ulong cipherSquareSize;

	this(string str)
	{
		this.encodedString = str;
	}


	Cipher normalize() @property
	{
		this.cipherSquareSize = to!ulong(sqrt(to!real(normalizePlainText().length)));

		return this;
	}

	string normalizePlainText()
	{
		if (normalizedString)
			return normalizedString;

		this.normalizedString = encodedString.replaceAll(regex(r"[\W\s]", "g"), "").toLower;
		return normalizedString;
	}

	ulong size()
	{
		float normalizedLength = normalizePlainText().length;
		ulong rows;
		ulong columns;
		do {
			rows ++;
			columns = cast(ulong)(ceil(normalizedLength / rows));
		} while(columns - rows > 1);

		return columns;
	}

	string[] plainTextSegments()
	{
		string regexString = ".{%s}".format(size());
		auto regEx = regex(regexString, "g");
		auto split = normalizePlainText.splitter!(Yes.keepSeparators)(regEx).filter!(a => !a.empty);

		return split.array;
	}

	string cipherText()
	{
		string cipher;
		int k;
		auto segments = plainTextSegments();

		for(int i = 0; i < size(); i++)
		{
			foreach(segment; segments)
			{
				k ++;
				if(segment.length > i) cipher ~= segment[i];
				if(k % cipherSquareSize == 0 && k < normalizePlainText.length - 1) cipher ~= " ";
			}
		}

		return cipher;
	}
}


unittest
{
immutable int allTestsEnabled = 0;

// normalize_strange_characters
{
	auto theCipher = new Cipher("s#$%^&plunk");
	assert("splunk" == theCipher.normalizePlainText());
}

static if (allTestsEnabled)
{
// normalize_numbers
{
	auto theCipher = new Cipher("1, 2, 3 GO!");
	assert("123go" == theCipher.normalizePlainText());
}

// size_of_small_square
{
	auto theCipher = new Cipher("1234");
	assert(2U == theCipher.size());
}

// size_of_slightly_larger_square
{
	auto theCipher = new Cipher("123456789");
	assert(3U == theCipher.size());
}

// size_of_non_perfect_square
{
	auto theCipher = new Cipher("123456789abc");
	assert(4U == theCipher.size());
}

// size_of_non_perfect_square_less
{
	auto theCipher = new Cipher("zomgzombies");
	assert(4U == theCipher.size());
}

// plain_text_segments_from_phrase
{
	const string[] expected = ["neverv", "exthin", "eheart", "withid", "lewoes"];
	auto theCipher = new Cipher("Never vex thine heart with idle woes");
	const auto actual = theCipher.plainTextSegments();

	assert(expected == actual);
}

// plain_text_segments_from_complex_phrase
{
	const string[] expected = ["zomg", "zomb", "ies"];
	auto theCipher = new Cipher("ZOMG! ZOMBIES!!!");
	const auto actual = theCipher.plainTextSegments();

	assert(expected == actual);
}

// Cipher_text_short_phrase
{
	auto theCipher = new Cipher("Time is an illusion. Lunchtime doubly so.");
	assert("tasneyinicdsmiohooelntuillibsuuml" == theCipher.cipherText());
}

// Cipher_text_long_phrase
{
	auto theCipher = new Cipher("We all know interspecies romance is weird.");
	assert("wneiaweoreneawssciliprerlneoidktcms" == theCipher.cipherText());
}

// normalized_Cipher_text1
{
	auto theCipher = new Cipher("Madness, and then illumination.");
	assert("msemo aanin dnin ndla etlt shui" == theCipher.normalize.cipherText());
}

// normalized_Cipher_text2
{
	auto theCipher = new Cipher("Vampires are people too!");
	auto text = theCipher.normalize.cipherText();
	assert("vrel aepe mset paoo irpo" == text);
}
}

}
