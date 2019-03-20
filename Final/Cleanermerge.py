#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Mar  6 17:45:43 2019

@author: dishabhaiya
"""

import pandas as pd
AP = pd.read_csv("Airpollution_droppedcolumns.csv")
F = pd.read_csv("Fire_droppedcolumns.csv")
#AP.groupby('parameter_name').size().sort_values()
#AP['parameter_name'].count()
SingleParameter = 'Lead PM2.5 LC'
AP_Single = AP[AP['parameter_name'] == SingleParameter]

AP_Single['date_local'] = pd.to_datetime(AP_Single['date_local'])
F['DISCOVERY_DATE'] = pd.to_datetime(F['DISCOVERY_DATE'])
cutoffmin = max(min(F['DISCOVERY_DATE']), min(AP_Single['date_local']))
cutoffmax = min(max(F['DISCOVERY_DATE']), max(AP_Single['date_local']))

#print (min(F['DISCOVERY_DATE']), min(AP_Single['date_local']))
#print (max(F['DISCOVERY_DATE']), max(AP_Single['date_local']))
#F['FIRE_YEAR'].unique()
#AP_Single.columns.values
AP_Single = AP_Single[(AP_Single['date_local'] >= cutoffmin) & (AP_Single['date_local'] <= cutoffmax)]
F = F[(F['DISCOVERY_DATE'] >= cutoffmin) & (F['DISCOVERY_DATE'] <= cutoffmax)]
#F['FIRE_YEAR'].unique()

CA = pd.merge(AP_Single, F,  how='inner', left_on=['state_name','county_code','date_local'], right_on = ['STATE','FIPS_CODE','DISCOVERY_DATE'])
CA = CA.rename(index=str, columns={"arithmetic_mean": "Mean - Day of Event", "first_max_value": "First Max - Day of Event"})
print(CA.columns.values)
#print (AP_Single.columns.values)

i = -5
for i in range(-5,4,1):
    if i!=0:  
        if i!=1:
            if i!=2:
                CA["DiscDate{0}".format(i)]= pd.to_datetime(CA['DISCOVERY_DATE']) + pd.DateOffset(days = i)
                #print (F["DiscDate{0}".format(i)])
                CA = pd.merge(AP_Single, CA,  how='right', left_on=['state_name','county_code','date_local'], right_on = ['STATE','FIPS_CODE',"DiscDate{0}".format(i)])        
                #print (CA.head())
                #print (CA.columns.values)
                CA = CA.rename(index = str, columns={"arithmetic_mean": "Mean{0}".format(i)})


   
CA = CA.drop_duplicates(subset=None, keep='first', inplace=False)
keep_columns = ['Mean3','Mean-1','Mean-2', 'Mean-3', 'Mean-4','Mean-5','Mean - Day of Event','FIRE_YEAR','DISCOVERY_DOY', 'CONT_DOY', 'FIRE_SIZE','F_longitude','AP_longitude','AP_latitude','F_latitude']
CA_final = CA[keep_columns]
#CA_final = CA_final.rename(index = str, columns={"AP_longitude_x": "AP_longitude", 'AP_latitude_x':'AP_latitude'})
print (CA_final.columns.values)

CA_final=CA_final.dropna(subset = ['AP_longitude'])
CA_final=CA_final.dropna(subset = ['AP_latitude'])
CA_final=CA_final.dropna(subset = ['F_latitude'])
CA_final=CA_final.dropna(subset = ['F_longitude'])

CA_final.to_csv("CleanMerged_US_Lead.csv")
print (CA_final.shape)

