using DataFrames
# Dataset should be there as mentioned in the chapter
DfTRoadSafety_Accidents_2014 = readtable("DfTRoadSafety_Accidents_2014.csv")
DfTRoadSafety_Vehicles_2014 = readtable("DfTRoadSafety_Vehicles_2014.csv")
left_DfTRoadSafety_2014 = join(DfTRoadSafety_Accidents_2014, DfTRoadSafety_Vehicles_2014, on = :_Accident_Index, kind = :left)
by(DfTRoadSafety_Accidents_2014, :Location_Northing_OSGR, size)
