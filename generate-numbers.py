#!/usr/bin/python
import random
import os
fn = 'rns'
if os.path.exists(fn):
  os.remove(fn)
a = {}
f = open('rns', 'w')
for i in range(1,1000000):
  num = str(random.randint(-10000,10000))
  if num not in a:
    a[num] = 1
    f.write(num)
    f.write('\n')
f.close()
