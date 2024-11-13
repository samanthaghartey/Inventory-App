import numpy as np

import matplotlib.pyplot as plt

pi = np.pi
t = np.linspace(0,100,1000)
R = 10000
C = -1/(R*pow(100*pi,2))
I = (1/((1/R) + pow(100*pi, 2)))* (((1/R)* np.cos(100*pi*t)) + (230*np.sqrt(2)*100*pi*np.sin(100*pi*t))) + (C/(np.exp(t/R)))

plt.plot(t,I)
plt.show()
