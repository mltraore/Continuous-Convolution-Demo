import numpy as np

from matplotlib import pyplot as plt

class Gaussian:
    ''' Gaussian Class '''
    def __init__(self):
        self.name = 'Gaussian'
        self.scalingFactor = 1
        self.expConstant = 0.5
        self.length = 10
        self.delay  = 0
        self.y = 0
        self.t = 0
        
    def gaussian(self, scalingFactor, expConstant, length, delay):
        ''' Setting signal paras '''
        
        # Computing time interval
        a, b  = delay-length/2, delay+length/2
        start = a - abs(a-b)/2
        stop  = b + abs(a-b)/2
        
        self.scalingFactor = scalingFactor
        self.expConstant = expConstant
        self.length = length
        self.delay = delay
        self.t = np.arange(start, stop+0.01, 0.01)
        self.y = scalingFactor*np.exp(-expConstant*((self.t-delay)**2))
        
# if __name__ == "__main__":
#     gaus = Gaussian()
#     gaus.gaussian(5,2,6,8)
#     plt.plot(gaus.t, gaus.y)
#     plt.show()

         
    