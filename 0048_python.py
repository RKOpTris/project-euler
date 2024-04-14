#!/usr/bin/env python3
# -*- coding: utf-8 -*-

val = 0

for i in range(1, 1000):
    val += i ** i
    
print(str(val)[-10:])

