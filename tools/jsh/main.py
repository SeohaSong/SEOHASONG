from sys import stdin


stack = [' '] * 100

for line in stdin.readlines()[:-1]:

    idx = 0
    rslt = True

    for ltr in line:
        if ltr in "([":
            stack[idx] = ')' if ltr == '(' else ']'
            idx += 1
        elif ltr in ")]":
            idx -= 1
            if idx < 0 or stack[idx] != ltr:
                rslt = False
                break
    
    if idx:
        rslt = False
    
    print("yes" if rslt else "no")
