# -*- coding: utf-8 -*-
"""
Created on Fri Nov 22 16:55:58 2019

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

def actual_rate_return(cl_price_array):
    count = 0
    sum_of_ave = 0
    for i in range(0,len(cl_price_array) - 1):
        a_i = ((cl_price_array[i+1] - cl_price_array[i])/cl_price_array[i])*100 #calculate the rate of return for consecutive months
        sum_of_ave += a_i #add to previous rates
        count += 1;
    average = sum_of_ave/count #creates the average of all rates of returns
    return average;




#Tesla closing price for one year.
tsla = [ 264.769989, 337.320007,350.480011,332.799988,307.019989,319.880005,279.859985,238.690002,185.160004,223.460007,241.610001,225.610001,240.869995]


ERR, rate_of_return = exp_rate_return( tsla);
print(ERR, rate_of_return)
print( "------------------------ ");


msft = [ 114.370003,106.809998,110.889999,101.57,104.43,112.029999,117.940002,130.600006,123.68,133.960007,136.270004,137.860001,139.029999 ]
msft_ERR, msft_RR = exp_rate_return(msft)
print(msft_ERR )
print(np.var(msft_RR))
print("-------------------------")

axgt = [19.360001,14.96,14.48,7.968,8.4,1.33,10.64,8.8,6.6,6.23,6.94,7.03,6.46]
axgt_ERR, axgt_RR = exp_rate_return(axgt)
print(axgt_ERR )
print(np.var(axgt_RR ))
print("-------------------------")

tsla = [ 264.769989, 337.320007,350.480011,332.799988,307.019989,319.880005,279.859985,238.690002,185.160004,223.460007,241.610001,225.610001,240.869995]
tsla_ERR, tsla_RR = exp_rate_return(tsla)
print(tsla_ERR )
print(np.var(tsla_RR ))
print("-------------------------")


google_array = [1207.079956, 1090.579956, 1109.650024, 1044.959961, 1125.890015,1126.550049,1176.890015,1198.959961,1106.5,1082.800049,1218.199951,1190.530029,1221.140015]
google_ERR, google_RR= exp_rate_return(google_array) #store the average rate of return and array of rate of return
print(google_ERR )
print(np.var(google_RR ))
print("-------------------------")

northrop_array = [317.369995,261.950012,259.880005,244.899994,275.549988,289.959991,269.600006,289.910004,303.25,323.109985,345.570007,367.869995,374.790009]
northrop_ERR, northrop_RR = exp_rate_return(northrop_array) #store 
print(northrop_ERR )

print("-------------------------")

np.var((msft_RR , axgt_RR,tsla_RR, google_RR, northrop_RR) )

np.var(msft_RR )

V = np.cov( (msft_RR , axgt_RR,tsla_RR, google_RR, northrop_RR) ) # why tf are these different. 
# I think the format presented account for all.
np.corrcoef( (msft_RR , axgt_RR,tsla_RR, google_RR, northrop_RR) )

#Organize the below correctly. 
weight = np.array( [	0.22, 0.3,  0.17	, .01,	0.3]) ;

weighttrans = np.transpose(weight)

wV = np.matmul(weight, V)
wVwt = np.matmul(wV, weighttrans)

#Standard Dev
port_std =  np.sqrt(wVwt)
print(port_std)

#Last month rate of return. 
msft_oct = [ 143.37, 151.38 ];
msft_oct_actual =  exp_rate_return(msft_oct);

#
actual = 1.868941946 * 100
std = 61.58249487886797

actual_std = (actual - (0.136209767*100)) / std
print('We find that we are ' + str(actual_std) + 'standard deviations away from expected return')

print("=========================================================================================================")

tesla_actual = [240.869995, 314.920013]
tesla_rate = actual_rate_return(tesla_actual)
print("The actual rate of return for Oct 2019 for Tesla is:")
print(tesla_rate)
print("=========================================================================================================")


google_actual = [1219, 1260.109985]
google_rate = actual_rate_return(google_actual)
print("The actual rate of return for Oct 2019 for Google is:")
print(google_rate)
print("=========================================================================================================")


microsoft_actual = [139.029999, 143.369995]
microsoft_rate = actual_rate_return(microsoft_actual)
print("The actual rate of return for Oct 2019 for Microsoft is:")
print(microsoft_rate)
print("=========================================================================================================")


north_actual = [374.790009,352.480011]
north_rate = actual_rate_return(north_actual)
print("The actual rate of return for Oct 2019 for Northrop Grumman is:")
print(north_rate)
print("=========================================================================================================")


axgt_actual = [6.46,6.18]
axgt_rate = actual_rate_return(axgt_actual)
print("The actual rate of return for Oct 2019 for Axo is:")
print(axgt_rate)
print("=========================================================================================================")


interpolated = 1.868941946 * 100
std = 61.58249487886797
ex = (0.136209767*100)
interpolated_std = (interpolated - ex) / std
print('We find that we are ' + str(interpolated_std) + 'standard deviations away from expected return, with interpolated return rates')


actual = 0.02860637 *100
actual_std = (actual - ex) /std


