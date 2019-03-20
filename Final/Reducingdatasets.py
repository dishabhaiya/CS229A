#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Feb 24 20:45:17 2019

@author: dishabhaiya
"""
## %reset - 

import pandas as pd
Airpollution = pd.read_csv("epa_hap_daily_summary.csv")
Fire = pd.read_csv("Fires.csv")

Airpollution_Column_names = Airpollution.columns.values
print (Airpollution_Column_names)

Airpollution_remove_columns = ['site_num','parameter_code','poc','datum','sample_duration','pollutant_standard','observation_count', 'observation_percent','aqi' ,'method_code','method_name','address','cbsa_name']
AP_red = Airpollution.drop(columns=Airpollution_remove_columns)

AP_red = AP_red.rename(index=str, columns={"latitude": "AP_latitude", "longitude": "AP_longitude"})

print(AP_red.columns.values)

AP_red.shape

AP_red = AP_red.drop_duplicates(subset=None, keep='first', inplace=False)
AP_red.shape

AP_red.to_csv("Airpollution_droppedcolumns.csv")

Fire_Column_names = Fire.columns.values
print (Fire_Column_names)
#Fire_remove_columns = ['OBJECTID','FOD_ID','FPA_ID','SOURCE_SYSTEM_TYPE','SOURCE_SYSTEM','NWCG_REPORTING_AGENCY','NWCG_REPORTING_UNIT_ID','NWCG_REPORTING_UNIT_NAME','SOURCE_REPORTING_UNIT','SOURCE_REPORTING_UNIT_NAME','LOCAL_FIRE_REPORT_ID','LOCAL_INCIDENT_ID','ICS_209_INCIDENT_NUMBER','ICS_209_NAME','MTBS_ID','MTBS_FIRE_NAME','STAT_CAUSE_CODE','STAT_CAUSE_DESCR','OWNER_CODE','OWNER_DESCR','FIPS_NAME']
Fire_remove_columns = ['FOD_ID']
Fire_red = Fire.drop(columns=Fire_remove_columns)
Fire_red = Fire_red.rename(index=str, columns={"LATITUDE": "F_latitude", "LONGITUDE": "F_longitude"})
print(Fire_red.columns.values)


Fire_red.shape

Fire_red = Fire_red.drop_duplicates(subset=None, keep='first', inplace=False)
Fire_red.shape

Fire_red.to_csv("Fire_droppedcolumns.csv")






