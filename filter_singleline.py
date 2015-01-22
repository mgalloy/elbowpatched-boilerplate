#!/usr/bin/env python

import fileinput
import re

START = '(^\s*:.*: |-)'

def main():
  start = re.compile(START)
  previousline = ''
  for line in fileinput.input():
    m = start.match(line)
    if m:
      if len(previousline) > 0:
        print previousline.rstrip()
      previousline = line[:-1]
    else:
      previousline += line[:-1].lstrip() + ' '
  print previousline.rstrip()

if __name__ == '__main__':
  main()