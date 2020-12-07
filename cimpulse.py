import numpy as np

class Impulse:
    ''' Impulse Class '''
    def __init__(self):
        self.name = 'Impulse'
        self.area = 1
        self.delay = 0
    
    def fromulaString(self):
        TOL = 1e-6
        if  abs(self.area-1) < TOL:
            sA = ' '
        elif abs(self.area+1) < TOL:
            sA = '-'
        else:
            sA = str(self.area) + ' '
        
        d = self.delay*(abs(self.delay)>TOL)
        signd = str( '-' * (d>=0) + '+' * (d<0) )
        
        if d == 0:
            delta = 'delta(t)'
        else:
            delta = 'delta(t ' + signd + ' ' + str(abs(d)) + ')'
            
        if abs(self.area) < TOL:
            formula = '0'
        else:
            formula = sA + delta
        return formula
                
    def impulse(self, area, delay):
        self.area = area
        self.delay = delay