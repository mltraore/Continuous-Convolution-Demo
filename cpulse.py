import numpy as np

class Pulse(object):
    def __init__(self):
        self.name = 'Pulse'
        self.amplitude = 1
        self.width  = 2
        self.delay  = 0
        self.t = 0
        self.y = 0
        
    def formulaString(self):
        TOL = 1e-6
        if  abs(self.amplitude-1) < TOL:
            sA = ' '
        elif abs(self.amplitude+1) < TOL:
            sA = '-'
        else:
            sA = str(self.amplitude) + ' * '
        
        d = self.delay*(abs(self.delay)>TOL)
        w = (self.delay+self.width)*(abs(self.delay+self.width)>TOL)
        signd = str( '-' * (d>=0) + '+' * (d<0) )
        signw = str( '-' * (w>=0) + '+' * (w<0) )
        #TODO u1 // u2
        if d == 0:
            u1 = 'u(t)'
        else:
            u1 = 'u(t ' + signd + ' ' + str(abs(d)) + ')'
        
        if w == 0:
            u2 = 'u(t)'
        else:
            u2 = 'u(t ' + signw + ' ' + str(abs(w)) + ')'
        
        if abs(self.amplitude) < TOL:
            formula = '0'
        else:
            formula = sA + '[ ' + u1 + ' - ' + u2 + ' ]'
            
        return formula
    
    def pulse(self, amplitude, width, delay):
        #DONE  Compting time interval
        a, b  = delay, delay+width
        start = a - abs(a-b)/2
        stop  = b + abs(a-b)/2
        
        # Setting parameters' values
        self.amplitude = amplitude
        self.width = width
        self.delay = delay
        self.t = np.arange(start,stop+0.01,0.01)
        self.y = self.amplitude*((self.t>=a)&(self.t<b))
        
# if __name__ == "__main__":
#     cpu = Cpulse()
#     cpu.pulse(1000000000000000000000000000000000005,2,3)
#     print(cpu.formulaString())