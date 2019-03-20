#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar 15 20:09:28 2019

@author: dishabhaiya
"""

!pip install geopy


import pandas as pd
from math import sin, cos, sqrt, atan2, radians
from geopy import distance


CA_lead = pd.read_csv("CleanMerged_US_Arsenic.csv")
CA_lead.head()
CA_lead.shape
CA_lead['FIRE_YEAR'].unique()
#CA_lead.dtypes
#CA_lead.describe()
CA_lead.shape
#CA_lead.columns.values

a = CA_lead.columns.get_loc('AP_latitude')
b = CA_lead.columns.get_loc('AP_longitude')
c = CA_lead.columns.get_loc('F_latitude')
d = CA_lead.columns.get_loc('F_longitude')
print(a,b,c,d)

CA_lead['ddist'] = CA_lead.apply(lambda x: distance.distance((x[a], x[b]), (x[c], x[d])).km, axis = 1)
#CA_lead['MeanAQ_day_of_fire'] = CA_lead['Mean-10'] - CA_lead['Mean - Day of Event']
CA_lead['MeanAQ_3days_after'] = CA_lead['Mean - Day of Event'] - CA_lead['Mean3']
#CA_lead['MaxAQ_day_of_fire'] = CA_lead['Max-10'] - CA_lead['First Max - Day of Event']
#CA_lead['MaxAQ_10days_after'] = CA_lead['First Max - Day of Event'] - CA_lead['Max10']

CA_lead.columns.values
#Relevant_columns = [ 'Mean10', 'Max10', 'Mean9', 'Max9', 'Mean8', 'Max8','Mean7', 'Max7', 'Mean6', 'Max6', 'Mean5', 'Max5', 'Mean4', 'Max4','Mean3', 'Max3', 'Mean2', 'Max2', 'Mean1', 'Max1', 'Mean-1','Max-1', 'Mean-2', 'Max-2', 'Mean-3', 'Max-3', 'Mean-4', 'Max-4','Mean-5', 'Max-5', 'Mean-6', 'Max-6', 'Mean-7', 'Max-7', 'Mean-8','Max-8', 'Mean-9', 'Max-9', 'Mean-10', 'Max-10','Mean - Day of Event', 'First Max - Day of Event',  'FIRE_YEAR','DISCOVERY_DOY',  'CONT_DOY', 'FIRE_SIZE', 'ddist', 'MeanAQ_10days_after']
#Relevant_columns = [ 'Mean10', 'Mean9', 'Mean8', 'Mean7', 'Mean6','Mean5',  'Mean4', 'Mean3', 'Mean2', 'Mean1', 'Mean-1','Mean-2', 'Mean-3', 'Mean-4','Mean-5', 'Mean-6', 'Mean-7', 'Mean-8', 'Mean-9', 'Mean-10','Mean - Day of Event',  'FIRE_YEAR','DISCOVERY_DOY',  'CONT_DOY', 'FIRE_SIZE', 'ddist', 'MeanAQ_10days_after']

Relevant_columns = ['Mean-1','Mean-2', 'Mean-3', 'Mean-4','Mean-5','Mean - Day of Event','FIRE_YEAR','DISCOVERY_DOY', 'CONT_DOY', 'FIRE_SIZE', 'ddist', 'MeanAQ_3days_after']

Final_CA_lead = CA_lead[Relevant_columns]

Final_CA_lead.columns.values

Final_CA_lead = Final_CA_lead.apply(lambda x: x.fillna(x.mean()),axis=0)

Final_CA_lead['FIRE_YEAR'].unique()
Final_CA_lead.shape
Final_CA_lead = Final_CA_lead.drop_duplicates(subset=None, keep='first', inplace=False)
Final_CA_lead.shape
Final_CA_lead.to_csv("Final_dataset_US_Arsenic.csv")
