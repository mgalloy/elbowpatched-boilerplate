#!/usr/bin/env python

import fileinput
import re

RE = '^(\s*authors:\s+)''(.*)'''
AND = '\s+and\s+'
NAMES = '(.*),\s*(.*)'

def oxford_comma(lst):
  d = lst.pop()
  return ', '.join(lst) + ', and '[8 - 7 * len(lst):] + d

def main():
  authors = re.compile(RE)
  andre = re.compile(AND)
  names = re.compile(NAMES)
  for line in fileinput.input():
    m = authors.match(line)
    if m:
      r = []
      for name in andre.split(m.group(2)):
        mname = names.match(name)
        if mname:
          r.append('%s %s' % (mname.group(2), mname.group(1)))
        else:
          r.append(name)
      print m.group(1) + oxford_comma(r)
    else:
      print line[:-1]


if __name__ == '__main__':
  main()