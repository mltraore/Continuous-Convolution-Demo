#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt

class Sine:
    ''' Sine Class '''
    def __init__(self):
        self.name = 'Sine'
        self.amplitude = 1
        self.period = 10
        self.phase = 0
        self.length = 10
        self.delay = 0
        self.t = 0
        self.y = 0
    
    def sine(self, amplitude, period, phase, length, delay):
        a, b  = delay, delay+length
        start = a - abs(a-b)/2
        stop  = b + abs(a-b)/2

        self.amplitude = amplitude
        self.period = period
        self.phase = phase
        self.length = length
        self.delay = delay
        self.t = np.arange(start, stop+0.01, 0.01)
        self.y = self.amplitude*np.sin(2*np.pi/self.period*(self.t - self.delay)
                                       +self.phase)*((self.delay <= self.t)&(self.t <= self.delay+self.length))

# if __name__ == "__main__":
#     si = Sine()
#     si.sine(1,1,5,4,4)
#     plt.plot(si.t,si.y)
#     plt.show()