#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Oct 20 18:28:22 2019

@author: Daniel.Ibanez

"""
from sol_heat_flux.eich import Eich
import numpy as np

footprint = Eich(2.5e-3, 0.5e-3, r0_lfs=0.75, r0_hfs=0.2)  # lambda_q=2.5, S=0.5

x = np.linspace(-1, 10, 1000)*1e-3
footprint.set_coordinates(x)
footprint.s_disconnected_dn_max = 2.1e-3
footprint.f_x_in_out = 5.
q_0 = 1e6

footprint.calculate_heat_flux_density("lfs-mp")
footprint.plot_heat_power_density()
print(q_0*footprint.calculate_heat_power()*2*np.pi*footprint.r0_lfs)
