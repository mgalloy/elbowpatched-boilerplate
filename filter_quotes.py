#!/usr/bin/env python

import fileinput
import re

QUOTES = "^(\s*:.*:) '(.*)'"

def main():
  quotes = re.compile(QUOTES)
  for line in fileinput.input():
    m = quotes.match(line)
    if m:
      if m.group(1).lstrip() == ':title:':
        print line[:-1]
      else:
        print m.group(1) + ' ' + m.group(2)
    else:
      print line[:-1]

if __name__ == '__main__':
  main()
