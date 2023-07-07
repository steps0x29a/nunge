<h1 align="center">
  	nunge
</h1>

<p align="center">
    <img alt="AppVeyor" src="https://img.shields.io/appveyor/ci/steps0x29a/nunge?style=plastic">
    <img alt="GitHub issues" src="https://img.shields.io/github/issues/steps0x29a/nunge?style=plastic">
    <img alt="GitHub tag (latest by date)" src="https://img.shields.io/github/v/tag/steps0x29a/nunge?style=plastic">    
    <img alt="GitHub" src="https://img.shields.io/github/license/steps0x29a/nunge?style=plastic">
    <img alt="Contributions" src="https://img.shields.io/badge/contributions-welcome-brightgreen?style=plastic">
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

# Build from source
Requires a working installation of [nim](https://nim-lang.org/install.html), of course.

```
nim c -d:release nunge.nim
```
