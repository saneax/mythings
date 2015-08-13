#!/usr/bin/python3

def factor(f):
    if f < 1:
        return 1
    else:
        return f * factor(f-1)

def fact(n):
    for i in range(1, n+1):
        p = "{0:2d}! {1}".format(i,factor(i))
        print (p)

if __name__ == '__main__':
    fact(7)
    fact(5)
    fact(9)




