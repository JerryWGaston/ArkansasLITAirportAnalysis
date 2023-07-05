<h1 align="center"></nobr>Bill & Hillary Clinton National Airport Analysis <br/> (October 2022-March 2023) </h1>

## Overview:
The main aim of this project is to develop a specialized Power BI Dashboard that effectively analyzes and extracts valuable insights from Airline data related to the Bill & Hillary Clinton National Airport in Little Rock, AR from October 2022-March 2023. The project focuses on utilizing the capabilities of Power BI to provide comprehensive and detailed information about the airport's airline operations, specifically focusing on four major airlines: American Airlines, Inc., Delta Airlines Inc, Frontier Airlines Inc, and Southwest Airlines Co. 

## Click [here](https://app.powerbi.com/links/FSWYzRjnKU?ctid=3df58405-572a-41cd-82c9-c5e56efcc914&pbi_source=linkShare) for the Power BI Dashboard:</h2>
<p align="center">
  <a href="https://public.tableau.com/app/profile/jerry.gaston.iii/viz/COVIDDashboard_16881458439100/U_S_CovidCasesStory"> <img src= "https://github.com/JerryWGaston/ArkansasLITAirportAnalysis/blob/c41ceafde15e3c53b86d9859361ace0d5a7a2bf3/images/dashboard%20overview.png"/></a>
</p>


## Key Findings:
- Southwest Airlines Co emerged as the most frequently chosen airline, with a total of 1228 flights recorded between October 2022 and March 2023.
- American Airlines experienced the longest average departure delay, with an average delay of 15.01 minutes per flight. On the other hand, Southwest Airlines, despite having the highest number of flights, had the shortest departure delay, averaging -0.41 minutes per flight, indicating a tendency to depart earlier than scheduled.
- The state of Georgia was the most frequently visited, with a total of 1154 flights recorded to and from the state.
- December 2022 witnessed the highest number of flights out of the six-month period, with a total of 505 flights. This peak in flight activity during December is likely attributable to the holiday season.

### The following questions can be answered by the dashboard: 

- How many flights were there?
- What is the average duration of arrival and departure delays for the airline(s)?
Additionally, we can identify the airline with the shortest delay duration.
- How many departure/arrival delays exceeded 15 minutes for the airline(s)?
- Which state was visited most frequently by the airline(s)?
- How many flights occurred per month between October 2022 and March 2023 for the airline(s)?
- What were the reasons for the cancellations of each canceled flight?
- Which airline was the most favored/preferred?

The main goal of this data project is to provide valuable insights regarding the four major airlines operating at Bill & Hillary Clinton National Airport and determine the airline that is most preferred. By examining key data points, we can assess customer preferences and make informed conclusions about the most favored airline.

## Data Gathering
#### With these questions I had, I downloaded 4 datasets to help me answer my questions: 
1. **[Airline On-Time Performance Data](https://www.transtats.bts.gov/Tables.asp?QO_VQ=EFD&QO_anzr=Nv4yv0r%FDb0-gvzr%FDcr4s14zn0pr%FDQn6n&QO_fu146_anzr=b0-gvzr)** (Source: Bureau of Transportation Statistics)
- The data required for our analysis covers the period from October 2022 to March 2023.
- To actively engage in the analysis, please click on the link provided to download the "Marketing Carrier On-Time Performance (Beginning January 2018)" dataset. This dataset will enable you to access and download the specific datasets mentioned below for further examination.
2. **[Airline Unique Carrier Codes & Descriptions](https://www.transtats.bts.gov/Oneway.asp?Svryq_Qr5p=h0v37r%FDPn44vr4%FDP1qr.%FDjur0%FD6ur%FD5nzr%FDp1qr%FDun5%FDorr0%FD75rq%FDoB%FDz7y6v2yr%FDpn44vr45%FP%FDn%FD07zr4vp%FD57ssvA%FDv5%FD75rq%FDs14%FDrn4yvr4%FD75r45%FP%FDs14%FDrAnz2yr%FP%FDcN%FP%FDcN%FLE%FM%FP%FDcN%FLF%FM.%FDh5r%FD6uv5%FDsvryq%FDs14%FDn0nyB5v5%FDnp4155%FDn%FD4n0tr%FD1s%FDBrn45.&Svryq_gB2r=Pun4&fry_Pn6=bc_haVdhR_PNeeVRe&Y11x72_gnoyr=Y_haVdhR_PNeeVRef&fry_in4=cPg_bagVZR_Nee&fry_f6n6=a/N&Qn6n_gB2r=PNg&cr4pr06_Synt=D&Qv52ynB_Synt=D)** (Source: Bureau of Transportation Statistics)
- The dataset includes the Unique Carrier code and the corresponding name of each airline. This information will be merged with the main dataset to accurately identify and analyze the four specific airlines that we will be focusing on.
3. **[Airport Identification Numbers & Descriptions](https://www.transtats.bts.gov/Oneway.asp?Svryq_Qr5p=b4vtv0%FDNv42146%FP%FDNv42146%FDVQ.%FDN0%FDvqr06vsvpn6v10%FD07zor4%FDn55vt0rq%FDoB%FDhf%FDQbg%FD61%FDvqr06vsB%FDn%FD70v37r%FDnv42146.%FD%FDh5r%FD6uv5%FDsvryq%FDs14%FDnv42146%FDn0nyB5v5%FDnp4155%FDn%FD4n0tr%FD1s%FDBrn45%FDorpn75r%FDn0%FDnv42146%FDpn0%FDpun0tr%FDv65%FDnv42146%FDp1qr%FDn0q%FDnv42146%FDp1qr5%FDpn0%FDor%FD4r75rq.&Svryq_gB2r=a7z&fry_Pn6=beVTVa_NVecbeg_VQ&Y11x72_gnoyr=Y_NVecbeg_VQ&fry_in4=cPg_bagVZR_QRc&fry_f6n6=a/N&Qn6n_gB2r=PNg&cr4pr06_Synt=D&Qv52ynB_Synt=D)** (Source: Bureau of Transportation Statistics)
 - Provides the Airport identification number assigned by US DOT. Will be joined with the main dataset to identify the airport we're analyzing.
4. **[Cancellation Numbers & Descriptions](https://www.transtats.bts.gov/Tables.asp?QO_VQ=EFD&QO_anzr=Nv4yv0r%FDb0-gvzr%FDcr4s14zn0pr%FDQn6n&QO_fu146_anzr=b0-gvzr)** (Source: Bureau of Transportation Statistics)
 - Provides the specified reasons for cancellation(s) 


## Data Cleaning + Data Manipulation
I utilized SQL Server Management Studio (SSMS) to import and query my downloaded datasets using Data Manipulation Language (DML) and Data Query Language (DQL). To facilitate the analysis and ensure data accuracy, I employed a combination of UNION and JOIN operations to merge the datasets.

One of the queries I executed involved performing a UNION operation to combine individual files for each month. This consolidation enhanced efficiency and simplified the analysis. The query selected the four airlines of interest based on their carrier ID and filtered the flights based on the Origin ID to specifically focus on Little Rock's Airport.
```
CREATE VIEW lr_airport_data AS
	SELECT * FROM OCT_2022_T_ONTIME_REPORTING oct
	WHERE oct.OP_UNIQUE_CARRIER IN ('AA', 'DL', 'WN','F9') AND oct.ORIGIN = 'LIT'
	UNION 
	SELECT * FROM NOV_2022_T_ONTIME_REPORTING nov
	WHERE nov.OP_UNIQUE_CARRIER IN ('AA', 'DL', 'WN','F9') AND nov.ORIGIN = 'LIT'
	UNION 
	SELECT * FROM DEC_2022_T_ONTIME_REPORTING dec
	WHERE dec.OP_UNIQUE_CARRIER IN ('AA', 'DL', 'WN', 'F9') AND dec.ORIGIN = 'LIT'
	UNION 
	SELECT * FROM JAN_2023_T_ONTIME_REPORTING jan
	WHERE jan.OP_UNIQUE_CARRIER IN ('AA', 'DL', 'WN', 'F9') AND jan.ORIGIN = 'LIT'
	UNION 
	SELECT * FROM FEB_2023_T_ONTIME_REPORTING feb
	WHERE feb.OP_UNIQUE_CARRIER IN ('AA', 'DL', 'WN', 'F9') AND feb.ORIGIN = 'LIT'
	UNION 
	SELECT * FROM lr_airport_data mar 
	WHERE mar.OP_UNIQUE_CARRIER IN ('AA', 'DL', 'WN','F9') AND mar.ORIGIN = 'LIT'
```

The rest of the SQL queries that I performed can be accessed [here](https://github.com/JerryWGaston/ArkansasLITAirportAnalysis/blob/main/LIT%20Airport%20SQL%20Queries.sql).

Once I had run this database, I copy & paste the data into a .CSV file so I can import it into Power BI. 

## DAX Formulas Used in Measures
After exporting the queried data as an .CSV file, it was imported into Power BI for visualization. The uploaded tables included the result of the previously mentioned query, the airport_id table, the cancellation table, and the unique carriers table.

Before commencing the data visualization process, it was necessary to establish several measures to calculate and gather the required data. To consolidate all the measurements in one location, a table named '#Measure' was created. Once the table was in place, the process of creating the measures began.

1. Arrival Delays Title Bar:
```
ArrDelayTitleBar = 

var CurrencySelected = 
IF(ISFILTERED(lr_airport_data[AIRLINE_NAME]),VALUES(lr_airport_data[AIRLINE_NAME]), BLANK())

RETURN

IF(ISFILTERED(lr_airport_data[AIRLINE_NAME]), "Average length of Arrival Delays For:  " & 
CurrencySelected, "Average length of Arrival Delays for All Airlines")
```
2. Departure Delays Title Bar:
```
DepDelayTitleBar = 

var CurrencySelected = 
IF(ISFILTERED(lr_airport_data[AIRLINE_NAME]),VALUES(lr_airport_data[AIRLINE_NAME]), BLANK())

RETURN

IF(ISFILTERED(lr_airport_data[AIRLINE_NAME]), "Average length of Departure Delays For:  " & 
CurrencySelected, "Average length of Depearture Delays for All Airlines")
```
3. Arrival Delays:
```
Arrival Delays = COUNTROWS(FILTER('lr_airport_data', 'lr_airport_data'[ARR_DELAY] > 0))
```
4. Departure Delays:
```
Departure Delays = COUNTROWS(FILTER('lr_airport_data', 'lr_airport_data'[DEP_DELAY] > 0))
```
5. Number of Flights:
```
NumofFlights = COUNTROWS(lr_airport_data)
```
6. Total Cancellations:
```
Total Cancellations = COUNTROWS(FILTER(lr_airport_data, 'lr_airport_data'[CANCELLED] = 1))
```
7. Total Flights By Airline:
```
TotalFlightsByAirline = 

var TotalFlights = COUNTROWS(lr_airport_data)

var AmericanAirlines = CALCULATE(TotalFlights,lr_airport_data[AIRLINE_NAME]="American Airlines Inc.")
var DeltaAirlines = CALCULATE(TotalFlights,lr_airport_data[AIRLINE_NAME]="Delta Air Lines Inc.")
var FrontierAirlines = CALCULATE(TotalFlights,lr_airport_data[AIRLINE_NAME]="Frontier Airlines Inc.")
var SouthwestAirlines = CALCULATE(TotalFlights,lr_airport_data[AIRLINE_NAME]="Southwest Airlines Co.")

RETURN

IF(HASONEVALUE(lr_airport_data[AIRLINE_NAME]),
IF(SELECTEDVALUE(lr_airport_data[AIRLINE_NAME])="American Airlines Inc.", AmericanAirlines,
IF(SELECTEDVALUE(lr_airport_data[AIRLINE_NAME])="Delta Air lines Inc.", DeltaAirlines,
IF(SELECTEDVALUE(lr_airport_data[AIRLINE_NAME])="Frontier Airlines Inc.", FrontierAirlines,
IF(SELECTEDVALUE(lr_airport_data[AIRLINE_NAME])="Southwest Airlines Co.", SouthwestAirlines,
"No Airline Selected")))))
```

Having established our DAX measures, we can now initiate the data visualization process, enabling us to derive significant insights from the data at hand. 

## Data Visualizing
The visuals presented depict the dashboards for each airline, showcasing a comprehensive view of the relevant data. These dashboards provide the ability to apply filters based on the desired month and airline name, allowing for dynamic exploration and analysis of specific subsets of the data. 

### All Airlines
<p align="center">
  <img src= " ">
</p>

Explanation

### American Airlines Inc. 
<p align="center">
  <img src= " ">
</p>

Explanation


### Delta Airlines Inc. 
<p align="center">
  <img src= " ">
</p>

Explanation

### Frontier Airlines Inc. 
<p align="center">
  <img src= "">
</p>

Explanation

### Southwest Airlines Co. 
<p align="center">
  <img src= "">
</p>

Explanation

## Conclusion

In conclusion...
