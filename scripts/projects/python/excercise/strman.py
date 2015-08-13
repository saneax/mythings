#!/usr/bin/python3

def strman(str):
    str_c=str.lower()
    c = list(str_c)
    ctr=0
    alphabets=list(map(chr,range(97,123)))
    for l in list(str_c):
        if l == ' ':
            ctr = ctr +1
            continue

        if alphabets.index(l) == 25:
            i = 0;
        else:
            i=alphabets.index(l) + 1

        c[ctr] = alphabets[i]
        ctr = ctr +1

    str_c = ''.join(c)
    vowels = list("aeiou")
    for i in range(len(str_c)):
        if str_c[i] in vowels:
            c[i] = str_c[i].upper()

    return ''.join(c)

if __name__ == '__main__':
    str = "Why is this funny encoding"
    print (str)
    print(strman(str))


