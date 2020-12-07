import numpy as np

from matplotlib import pyplot as plt 

class Exponential:
    ''' Exponential Class '''
    def __init__(self):
        self.name = 'Exponential'
        self.scalingFactor = 1
        self.expConstant = 0.5
        self.length = 10
        self.delay  = 0
        self.causality = 'causal'
        self.t = 0
        self.y = 0
    
    def tt(self, length, delay, causality):
        if causality.lower() == 'causal':
            a, b = delay, delay+length
        else:
            a, b = delay-length, delay
        
        start = a - abs(a-b)/2
        stop  = b + abs(a+b)/2
        t = np.arange(start, stop+0.01, 0.01)
        return t
    
    def yy(self, scalingFactor, expConstant, length, delay, causality, t):
        if causality.lower() == 'causal':                       
            y = scalingFactor*np.exp(-expConstant*(t-delay))\
                            *((delay<=t)&(t<=delay+length))
        else:
            y = scalingFactor*np.exp( expConstant*(t-delay))\
                            *((delay-length<=t)&(t<=delay))
        return y
                                                            
    def exponential(self, scalingFactor, expConstant, length, delay, causality):
        ''' Setting signal parameters '''
        self.scalingFactor = scalingFactor
        self.expConstant = expConstant
        self.length = length
        self.delay  = delay
        self.causality = causality
        self.t = self.tt(length, delay, causality)
        self.y = self.yy(scalingFactor, expConstant, length, delay, causality, self.t)


# if __name__ == "__main__":
#     exp = Exponential()
#     exp.exponential(1,1,10,0,'caus')
#     plt.plot(exp.t,exp.y)
#     plt.show()