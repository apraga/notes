```{=org}
#+filetags: cs
```
(From \@Melissa on discord #haskell-beginners)

# UTF8 and Bytestring in Haskell

Text (and String) represent a sequence of unicode codepoints. These are
numbers in the range of 0 to 0x10FFFF which have been assigned certain
properties (including a name) by the unicode standard, such as U+0065
LATIN SMALL LETTER E, which, besides the name I listed, is a Lowercase
Letter. However, you can\'t put codepoints in a file, you can only put
bytes. You need some way to translate codepoints into bytes. These ways
are encodings, and UTF-8 is the most popular one. UTF-8 has the neat
property that all the codepoints that correspond to the ASCII characters
(U+0000 to U+00FF) are encoded as single bytes identical to their ASCII
representation. But any other codepoint is encoded as multiple bytes.

So, U+00E9 LATIN SMALL LETTER E WITH ACUTE (decimal 233) is encoded as
the two-byte sequence 0xC3 0xA9 (195 162 in decimal). ByteStrings
represent bytes, as found in the file. So to get back to the codepoint,
you have to decodeUtf8