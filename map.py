#!/usr/bin/python
import sys
for line in sys.stdin:
  line = line.strip()
  print line
  kv = line.split(':')
  k = int(kv[1]) + int(sys.argv[1])
  v = kv[2]+','+sys.argv[1]
  print str(abs(k))+':'+str(k)+':'+v
