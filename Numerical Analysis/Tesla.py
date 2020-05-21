# -*- coding: utf-8 -*-
"""
Created on Fri Nov 22 16:55:58 2019

@author: JungleBook
"""
#Tesla closing price for one year.
tsla = [ 264.769989, 337.320007,350.480011,332.799988,307.019989,319.880005,279.859985,238.690002,185.160004,223.460007,241.610001,225.610001,240.869995]


ERR, rate_of_return = exp_rate_return( tesla);
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


np.cov( (msft_RR , axgt_RR) , y =  (tsla_RR, google_RR)  ) # why tf are these different. 
# I think the format presented account for all.




[[ 3.59988262e+01,  2.37339546e+02, -3.62713938e+00,   2.03172196e+01],
 [ 2.37339546e+02,  4.35810940e+04, -8.10627518e+02,3.44528625e+02],
 [-3.62713938e+00, -8.10627518e+02,  2.11639246e+02, -9.94461762e+00],
 [ 2.03172196e+01,  3.44528625e+02, -9.94461762e+00, 4.04465174e+01]])


