
import numpy as np 

t = np.arange(1,11)
d = 5
w = 7
t1 = ((t>=d)&(t<w))*1
t2 = 1*(d<=t<w)

print(t1)
print(t2)