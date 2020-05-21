# -*- coding: utf-8 -*-
"""
Created on Sun Nov 24 17:19:49 2019

@author: JungleBook
"""

import numpy as np

def divdiff( vec_x, vec_f, Q_table = None, i0 = -1, j0 = -1):
  n = np.size(vec_x) - 1;  # x0, x1, ..., xn.

  if (Q_table == None):
    Q_table = np.zeros((n + 1, n + 1));

  for i in np.arange(0, n + 1):
    Q_table[i][0] = vec_f[i];
  
  for j in np.arange(1, n + 1):
    for i in np.arange(j, n + 1):
      # compute Q_{i,j}
      Q_table[i][j]  = 0.0;
      Q_table[i][j] += Q_table[i][j - 1]; # Needs to be q table
      Q_table[i][j] -= Q_table[i - 1][j - 1];
      Q_table[i][j] /= (vec_x[i] - vec_x[i - j]);
                   
  return Q_table[n][n], Q_table;

x = np.array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 , 11])
y = np.array([264.769989, 337.320007,350.480011,332.799988,307.019989,319.880005,279.859985,238.690002,185.160004,223.460007,241.610001,225.610001,240.869995])
         

if __name__ == "__main__":
  # run the module as script

  print("================================================================================");
  print("Neville's Method");
  print("Date: Today");
  print("Author of Script: Paul J. Atzberger.");
  print("--------------------------------------------------------------------------------");
  vec_x = x;  # Possible just pass it as an array
  vec_f = y; #yep, needed to be an array; # point we need to interpolate 

  print(" ");
  print("Interpolating polynomial will be determined using the data:");
  np.set_printoptions(precision=4)
  print("vec_x: ");
  print(vec_x);
  print("vec_f: ");
  print(vec_f);
 #print("x: ");
    #print("%.4e"%x);

  # Compute the interpolation
  print(" ");
  print("Computing the interpolating polynomial using Divided differences.");
  P_x, Q_table = divdiff( vec_x, vec_f);
  #P_x = 1.3;

  #print(" ");
  #print("Interpolating polynomial P(x) has value:");
  #print("P(%.4e) = %.4e"%(x,P_x));
  print(" ");
  print("Q_table has value:");
  print(Q_table);


     


