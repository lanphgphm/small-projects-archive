# 
def count0(s): 
    count0 = 0
    for i in range(len(s)):
        if s[i]=='0':
            count0+=1
    return count0

def count1(s):
    count1 = 0
    for i in range(len(s)):
        if s[i]=='1':
            count1+=1
    return count1

def check1z1(s):
    if s[0]=='1' and s[-1]=='1':
        return True
    else:
        return False 

def check0z0(s):
    if s[0]=='0' and s[-1]=='0':
        return True
    else:
        return False

def main(): 
    # input 
    s = "1000011101"

    ans = "NO"
    op = 0; 
    maxOp = 300 
    n = len(s)
    
    if count0(s) == count1(s):
        while ((n != 0) and (op <= maxOp)):    
            if check1z1(s): 
                s = s[1:] + s[0]
                op += 1
            elif check0z0(s): 
                s = s[-1] + s[:-1]
                op += 1
            else: 
                s = s[1:-1]

        t = '0'*(n/2) + '1'*(n/2)
        if s == t: 
            ans = "YES"
    
    print(ans)

main() 