#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Nov  8 11:55:48 2019

@author: jmbols
"""
import numpy as np
from vita.modules.fiesta.field_line import FieldLine
from vita.modules.utils import intersection

def map_field_lines(x_vec_at_omp, file_path, configuration='diverted'):
    '''
    Function for mapping each field-line to the intersection with the vessel walls

    Input: x_vec_at_omp,  a numpy array with the radial points at the OMP where
                          we want the mapping to start
           file_path,     a string with the path to the FIESTA equilibrium .mat file
           configuration, a string with either 'limited' or 'diverted', where 'diverted'
                          is the defualt configuration

    return: field_line_dict, a python dictionary with the radial position from the OMP in m
                             as the key and the field-line dictionary with the R, phi
                             and Z components along the field line as well as the length, l,
                             from the LCFS to the current point along the field-line
    '''
    field_line = FieldLine(file_path)
    field_line_dict = {}
    for i in x_vec_at_omp:
        field_lines = field_line.follow_field_in_plane(p_0=[i, 0, 0], max_length=10.0)

        func1 = np.array([field_lines["R"], field_lines["Z"]])
        func2 = np.array([field_line.fiesta_equil.r_limiter, field_line.fiesta_equil.z_limiter])

        (i_intersect_func1, _),\
        (r_intersect, z_intersect) = intersection(func1, func2)
        if not np.any(np.isnan(r_intersect)):
            i_int = int(np.floor(i_intersect_func1))
            i_first_intersect = np.argmin(field_lines["l"][i_int])
            i_intersection = i_intersect_func1[i_first_intersect]
            i_intersection = int(np.ceil(i_intersection))
            if configuration == 'limited':
                i_min_intersect = np.argmin(field_lines["R"][i_intersection] - r_intersect)
                i_intersection = np.where(field_lines["R"][:] < r_intersect[i_min_intersect])[0][0]
            elif configuration == 'diverted':
                i_min_intersect = np.argmin(field_lines["Z"][i_intersection] - z_intersect)
                i_intersection = np.where(field_lines["Z"][:] < z_intersect[i_min_intersect])[0][0]
            else:
                raise NotImplementedError("Error: unknown configuration.\
                                          Please use either 'limited' or 'diverted'")

            field_lines["l"] = field_lines["l"][:i_intersection+1]
            field_lines["R"] = field_lines["R"][:i_intersection+1]
            field_lines["Z"] = field_lines["Z"][:i_intersection+1]

            field_lines["Vessel_Intersect"] = (r_intersect[i_min_intersect],
                                               z_intersect[i_min_intersect])

            field_line_dict[i] = field_lines
        else:
            field_lines["Vessel_Intersect"] = (np.nan, np.nan)
            field_line_dict[i] = field_lines

    return field_line_dict
