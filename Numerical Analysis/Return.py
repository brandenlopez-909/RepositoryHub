# -*- coding: utf-8 -*-
"""
Created on Fri Nov 22 16:41:04 2019

@author: JungleBook
"""
import numpy as np

def exp_rate_return(cl_price_array):
    count = 0
    sum_of_ave = 0
    rate_of_return= []
    for i in range(0,len(cl_price_array) - 1):
          a_i = ((cl_price_array[i+1] - cl_price_array[i])/cl_price_array[i] )*100
          sum_of_ave = sum_of_ave +  a_i
          rate_of_return.append( a_i )
          count += 1;
          
    ERR = (sum_of_ave/count)
    return (ERR, rate_of_return)



company = tsla

ERR, rate_of_return = exp_rate_return( company);
print(ERR, rate_of_return)
print( "------------------------ ");

print(np.var(rate_of_return))

