# nunge v 0.1.0
# Find the repo here: https://github.com/steps0x29a/nunge

import unicode
import std/tables
import std/strutils
import std/strformat
import os
import argparse
import math

var level = 5
var make_unique:bool = false
var wordlist = newSeq[string]()
var arg_words = newSeq[string]()
var inputfile:string = ""
var outputfile:string = ""

let leet_tables: array[12, Table[char, char]] = [
  {'e': '3'}.toTable(),
  {'a': '4'}.toTable(),
  {'o': '0'}.toTable(),
  {'i': '!'}.toTable(),
  {'i': '1'}.toTable(),
  {'l': '1'}.toTable(),
  {'a': '@'}.toTable(),
  {'s': '$'}.toTable(),
  {'e': '3', 'a': '4', 'o': '0', 'i': '1', 's': '$'}.toTable(),
  {'e': '3', 'a': '@', 'o': '0', 'i': '1', 's': '$'}.toTable(),
  {'e': '3', 'a': '4', 'o': '0', 'i': '!', 's': '$'}.toTable(),
  {'e': '3', 'a': '4', 'o': '0', 'l': '1', 's': '$'}.toTable(),
]

# Add a word to the wordlist.
# If unique mode is on, make sure it is not in there yet.
proc add_word(word:string) =
  if word.len > 0:
    if make_unique:
      if wordlist.contains(word):
        return
    wordlist.add(word);

# Generates a leet speak version of a word using a map of replacement tables
proc leet_speak(word:string, map:Table[char, char]):string =
  var tmp = word
  for key, value in map:
    tmp = tmp.replace(key, value)
  return tmp

proc spongebob(word: string, reverse: bool) : string = 
  var tmp = word.toLower()
  let marker = if reverse: 1 else: 0
  for i in 0 ..< tmp.len:
    if i mod  2 == marker:
      let c = Rune(ord(tmp[i]))
      tmp[i] = char(unicode.toUpper(c))
  return tmp

proc munge(word:string, level:int) = 
  if level > 0:
    add_word(word)
    add_word(word.toLower())
    add_word(word.toUpper())
    add_word(word.capitalize())
  
  # if level > 1:
  #   echo "Level 1 implementation still missing";
  
  if level > 2:
    add_word(word.capitalize().swapCase())
  
  # if level > 3:
  #   echo "Level 3 implementation still missing";

  # Level 5 and above get the leet speak treatment
  if level > 4:
    for leet_table in leet_tables:
      add_word(leet_speak(word, leet_table))
      add_word(leet_speak(word.capitalize(), leet_table))
  
  # Level 6 and above get the sPoNgEbOb treatment
  if level > 5:
    add_word(spongebob(word, false))
    add_word(spongebob(word, true))
  
  if level > 6:
    echo "Level 6 implementation still missing";

  if level > 7:
    echo "Level 7 implementation still missing";

  if level > 8:
    echo "Level 8 implementation still missing";


proc munge_word(word_arg:string, level:int) = 
  let word = unicode.strip(word_arg)
  munge(word, level)

  if level > 4:
    let appendices:array[7, string] = ["1", "123456", "12", "2", "123", "!", "."]
    for appendix in appendices:
      munge(word & appendix, level)
  
  # if level > 5:
  #   echo "Level 5 implementation still missing";
  
  if level > 6:
    let appendices:array[20, string] = ["?", "_", "0", "01", "69", "21", "22", "23", "1234", "8", "9", "10", "11", "12", "13", "3", "4", "5", "6", "7"]
    for appendix in appendices:
      munge(word & appendix, level)
  
  if level > 7:
    let appendices:array[15, string] = ["07", "08", "09", "14", "15", "16", "17", "18", "19", "24", "77", "88", "99", "12345", "123456789"]
    for appendix in appendices:
      munge(word & appendix, level)
  
  if level > 8:
    let appendices:array[55, string] = ["00", "02", "03", "04", "05", "06", "19", "20", "25", "26", "27", "28", "29", "007", "1234567", "12345678", "111111", "111", "777", "666", "420", "101", "33", "44", "55", "66", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98"]
    for appendix in appendices:
      munge(word & appendix, level)

var p = newParser:
  option("-i", "--input", help="Read words from this file, line by line")
  option("-o", "--output", help="Save generated wordlist to this file")
  option("-l", "--level", help="Amount of shenanigans [0-9] (default 5)")
  flag("-u", "--unique", help="Prevent duplicate entries (slower)")
  arg("word", nargs = -1)

try:
  var opts = p.parse(commandLineParams())

  if opts.level != "":
    level = parseInt(opts.level)
    level = if level < 0: 0 elif level > 9: 9 else: level
  
  if opts.input != "":
    inputfile = opts.input
  
  if opts.output != "":
    outputfile = opts.output

  if len(opts.word) > 0:
    arg_words = opts.word
  
  make_unique = opts.unique

  if len(opts.word) > 0:
    for word in opts.word:
      munge_word(word, level)
  elif opts.input != "":
    for line in lines opts.input:
      munge_word(line, level)
  else:
    for line in lines stdin:
      if len(unicode.strip(line)) == 0: break
      munge_word(line, level)
  
  # If output file given, write to it, else print to stdout
  if opts.output != "":
    stdout.write(fmt("Writing {len(wordlist)} words to {opts.output}  "))
    let out_handle = open(opts.output, fmWrite)
    defer: out_handle.close()
    for word in wordlist:
      out_handle.writeLine(word)
    echo "DONE"
  else:
    for word in wordlist:
      echo word

except ShortCircuit as err:
  if err.flag == "argparse_help":
    echo err.help
    quit(0)

except:
  stderr.writeLine getCurrentExceptionMsg()