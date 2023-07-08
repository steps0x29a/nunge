<h1 align="center">
  	nunge
</h1>

<p align="center">
    <img alt="GitHub issues" src="https://img.shields.io/github/issues/steps0x29a/nunge?style=plastic">
    <img alt="GitHub tag (latest by date)" src="https://img.shields.io/github/v/tag/steps0x29a/nunge?style=plastic">
    <img alt="Contributions" src="https://img.shields.io/badge/contributions-welcome-brightgreen?style=plastic">
    <img alt="License" src="https://img.shields.io/github/license/steps0x29a/nunge?style=plastic">
    <img alt="Static Badge" src="https://img.shields.io/badge/version-0.2.0-green?style=plastic">

</p>

# nunge

`nunge` is a nim rewrite of the OG `munge` by [Th3S3cr3tAg3nt](https://github.com/Th3S3cr3tAg3nt/Munge).

This program is *heavily* inspired by the original munge, but adds its own twists to the inner workings as well as a few more levels of detail to the wordlist generation process.

Credits go to [Th3S3cr3tAg3nt](https://github.com/Th3S3cr3tAg3nt) for their work on the original `munge`.

`nunge` was written in 👑 nim by [steps0x29a](https://github.com/steps0x29a) and is licensed under the MIT license.

# Installation
No installation is required. Simply download or build a binary and run it (see below).

# Usage
Show help:

```
./nunge --help

Options:
  -h, --help
  -i, --input=INPUT          Read words from this file, line by line
  -o, --output=OUTPUT        Save generated wordlist to this file
  -l, --level=LEVEL          Amount of shenanigans [0-9] (default 5)
  -u, --unique               Prevent duplicate entries (slower)

```

## Levels
Levels are arbitrary levels of shenanigans. Here's a brief overview:

Level 0: Basically does nothing

Level 1: Some case swapping, some appendices are added (x24)

Level 2: Same as level 1, but more appendices (x81)

Level 3: More case-stuff and appendices (x168)

Level 4: More case-stiff and appendices (x665)

Level 5: Leet speak, prefixing (x1087)

Level 6: Spongebob, prefixing (x1443)

Level 7: More prefixes (x1563)

Level 8: More prefixes (1987)

Level 9: Combined prefixes and appendices (x2427)

The number in parentheses tells you the multiplier. For example, passing in a single word to a level 9 `nunge` will yield 2427 unique words. Keep that in mind when using large wordlists as inputs.

```
nunge -l 9 -u -o lots-of-bananas.txt banana
```

## Input and output files
You can use the `-i` and `-o` parameters to use input and output files. If you use an input file, the words you pass via the command line are skipped and only the input file is processed.

```
./nunge -l 9 -u -i input.txt
```

Will read all lines in `input.txt` and print the result to `stdout`.

## Multiple words
Say you just want to generate a quick wordlist based on a few words you've picked up:

```
./nunge -l 9 -u -o wordlist.txt banana avocado lentils
```

Will write 10332 unique words (variations of banana, avocado and lentils) to `wordlist.txt`.

# Build from source
Requires a working installation of [nim](https://nim-lang.org/install.html), of course.

```
nimble install argparse
nim c -d:release nunge.nim
```
