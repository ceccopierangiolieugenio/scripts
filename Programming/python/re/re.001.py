#!/bin/python3
# Simple re:
#   https://docs.python.org/3/library/re.html
#

import re


m = re.search('(?<=abc)def', 'abcdef')

print(m.group(0))

pattern = re.compile('\(Eugenio\) Parodi \(\D{2,4}\).*')
pattern = re.compile('(Eugenio) Parodi (\d{2,4})([^ ]*) (franco|ciccio)')

match = pattern.match('Eugenio Parodi 1234567890 ciccio')

print(match)
print(match.groups())

