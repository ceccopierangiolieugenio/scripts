import sys
for line in sys.stdin:
    if 'Exit' == line.rstrip():
        break
    print(line.rstrip())
