{rcahelpr}
================

## ❓ What and Why is This?

In short, a tool to support the Resident Corrections Analyst program
through bespoke functions written in R and data sets for learning
purposes. Interested? You can install is using R:

``` r
remotes::install_github("cllghn/rcahelpr")
```

## 🔎 Examples

### 📚 Codebooks

Codebooks are often to provide a comprehensive guide to the variables
and coding schemes in a data set, ensuring consistent and accurate
interpretation of data. They serve as a reference tool to facilitate
understanding and analysis of complex data structures by researchers and
analysts. To support this crucial functionality, we include a codebook
function into this package:

``` r
# Load the library
library(rcahelpr)

# Create a test data set
test <- data.frame(
  "person" = c("chris", "maeve", "joseph", "brooks"),
  "org" = c("csg", "wdoc", "ccjbh", "asu"),
  "years_in_org" = c(1, 0.3, 0.2, NA),
  "role" = as.factor(c("mentor", "rca", "rca", "mentor")),
  "date" = as.Date(c("2020-01-01", "2020-01-01", NA, "2020-01-02"))
)

# Create codebook
make_codebook(input_df = test, return_df = FALSE, escape = FALSE)
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Variable Name
</th>
<th style="text-align:left;">
Data Class
</th>
<th style="text-align:left;">
Valid Values
</th>
<th style="text-align:left;">
Statistics
</th>
<th style="text-align:right;">
Unique Values
</th>
<th style="text-align:left;">
Missing Values
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
person
</td>
<td style="text-align:left;">
Character
</td>
<td style="text-align:left;">
Unique strings (n=4): chris, maeve, joseph, and more.
</td>
<td style="text-align:left;">
4 unique strings, top three: <br> brooks (n=1) <br> chris (n=1) <br>
joseph (n=1)
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
org
</td>
<td style="text-align:left;">
Character
</td>
<td style="text-align:left;">
Unique strings (n=4): csg, wdoc, ccjbh, and more.
</td>
<td style="text-align:left;">
4 unique strings, top three: <br> asu (n=1) <br> ccjbh (n=1) <br> csg
(n=1)
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
years_in_org
</td>
<td style="text-align:left;">
Numeric
</td>
<td style="text-align:left;">
Numeric range from 0.2 to 1.
</td>
<td style="text-align:left;">
Min: 0.2 <br> Avg: 0.5 <br> Median: 0.3 <br> Max: 1 <br> SD: 0.44
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
1 (25%)
</td>
</tr>
<tr>
<td style="text-align:left;">
role
</td>
<td style="text-align:left;">
Factor
</td>
<td style="text-align:left;">
Categorical variable with 2 levels: mentor, rca
</td>
<td style="text-align:left;">
2 Unique factors: mentor, rca
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
date
</td>
<td style="text-align:left;">
Date
</td>
<td style="text-align:left;">
Date rage from 2020-01-01 to 2020-01-02.
</td>
<td style="text-align:left;">
Min: 2020-01-01 <br> Mode: 2020-01-01 <br> Max: 2020-01-02 <br> Time
difference: 1 days
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:left;">
1 (25%)
</td>
</tr>
</tbody>
</table>

Should you want to add information to describe the variables described
in the codebook, you can do so by left joining and additional data set:

``` r
# Set a secondary data.frame describing the variables in your original data set
more <- data.frame(
  "vars" = c("person", "org", "years_in_org", "role"),
  "description" = rep("Interesting details about my variable.", 4),
  "origin" = rep("Detailed notes on where the data came from.", 4),
  "notes" = rep("Yet more useful information", 4)
)

# Create codebook
make_codebook(input_df = test, return_df = FALSE, escape = FALSE,
              extra_vars = more, extra_key = "vars")
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Variable Name
</th>
<th style="text-align:left;">
Data Class
</th>
<th style="text-align:left;">
Valid Values
</th>
<th style="text-align:left;">
Statistics
</th>
<th style="text-align:right;">
Unique Values
</th>
<th style="text-align:left;">
Missing Values
</th>
<th style="text-align:left;">
Description
</th>
<th style="text-align:left;">
Origin
</th>
<th style="text-align:left;">
Notes
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
date
</td>
<td style="text-align:left;">
Date
</td>
<td style="text-align:left;">
Date rage from 2020-01-01 to 2020-01-02.
</td>
<td style="text-align:left;">
Min: 2020-01-01 <br> Mode: 2020-01-01 <br> Max: 2020-01-02 <br> Time
difference: 1 days
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:left;">
1 (25%)
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
<td style="text-align:left;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
org
</td>
<td style="text-align:left;">
Character
</td>
<td style="text-align:left;">
Unique strings (n=4): csg, wdoc, ccjbh, and more.
</td>
<td style="text-align:left;">
4 unique strings, top three: <br> asu (n=1) <br> ccjbh (n=1) <br> csg
(n=1)
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
0 (0%)
</td>
<td style="text-align:left;">
Interesting details about my variable.
</td>
<td style="text-align:left;">
Detailed notes on where the data came from.
</td>
<td style="text-align:left;">
Yet more useful information
</td>
</tr>
<tr>
<td style="text-align:left;">
person
</td>
<td style="text-align:left;">
Character
</td>
<td style="text-align:left;">
Unique strings (n=4): chris, maeve, joseph, and more.
</td>
<td style="text-align:left;">
4 unique strings, top three: <br> brooks (n=1) <br> chris (n=1) <br>
joseph (n=1)
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
0 (0%)
</td>
<td style="text-align:left;">
Interesting details about my variable.
</td>
<td style="text-align:left;">
Detailed notes on where the data came from.
</td>
<td style="text-align:left;">
Yet more useful information
</td>
</tr>
<tr>
<td style="text-align:left;">
role
</td>
<td style="text-align:left;">
Factor
</td>
<td style="text-align:left;">
Categorical variable with 2 levels: mentor, rca
</td>
<td style="text-align:left;">
2 Unique factors: mentor, rca
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
0 (0%)
</td>
<td style="text-align:left;">
Interesting details about my variable.
</td>
<td style="text-align:left;">
Detailed notes on where the data came from.
</td>
<td style="text-align:left;">
Yet more useful information
</td>
</tr>
<tr>
<td style="text-align:left;">
years_in_org
</td>
<td style="text-align:left;">
Numeric
</td>
<td style="text-align:left;">
Numeric range from 0.2 to 1.
</td>
<td style="text-align:left;">
Min: 0.2 <br> Avg: 0.5 <br> Median: 0.3 <br> Max: 1 <br> SD: 0.44
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
1 (25%)
</td>
<td style="text-align:left;">
Interesting details about my variable.
</td>
<td style="text-align:left;">
Detailed notes on where the data came from.
</td>
<td style="text-align:left;">
Yet more useful information
</td>
</tr>
</tbody>
</table>

### 📊 Data

Some key data sets, for learning or general use have been included in
the library. Access them using the `::` accessor:

``` r
str(rcahelpr::hpsa_primarycare)
```

    ## 'data.frame':    230 obs. of  17 variables:
    ##  $ HPSA_Discipline_Class           : chr  "Primary Care" "Primary Care" "Primary Care" "Primary Care" ...
    ##  $ HPSA_Name                       : chr  "Low Income - MSSA 78.2ddd/Bell SW/Cudahy/Maywood/V" "MSSA 6/Pioneer" "MSSA 78.2uuu/Athens" "MSSA 137/Isleton" ...
    ##  $ HPSA_ID                         : chr  "1061017434" "1061018308" "1061038158" "1061081242" ...
    ##  $ County_Equivalent_Name          : chr  "Los Angeles" "Amador" "Los Angeles" "Sacramento" ...
    ##  $ Designation_Type                : chr  "HPSA Population" "Geographic HPSA" "High Needs Geographic HPSA" "Geographic HPSA" ...
    ##  $ HPSA_Population_Type            : chr  "Low Income Population HPSA" "Geographic Population" "Geographic Population" "Geographic Population" ...
    ##  $ HPSA_Score                      : int  13 16 18 9 12 15 10 9 19 11 ...
    ##  $ PC_MCTA_Score                   : int  NA NA NA NA NA 18 NA 13 NA NA ...
    ##  $ HPSA_Provider_Ratio_Goal        : chr  "3000:1" "3500:1" "3000:1" "3500:1" ...
    ##  $ HPSA_FTE                        : num  0.16 0.1 3.75 0.95 9.26 3.2 1.75 27.5 4 0 ...
    ##  $ HPSA_Designation_Population     : int  53040 5848 84994 5597 39476 17795 13687 101329 54088 7045 ...
    ##  $ HPSA_Formal_Ratio               : chr  "331500:1" "58480:1" "22665:1" "5892:1" ...
    ##  $ HPSA_Shortage                   : num  17.52 1.57 24.58 0.65 3.9 ...
    ##  $ HPSA_Status                     : chr  "Proposed For Withdrawal" "Proposed For Withdrawal" "Proposed For Withdrawal" "Proposed For Withdrawal" ...
    ##  $ HPSA_Designation_Date           : chr  "9/12/2011" "7/11/2008" "10/9/2012" "5/13/2008" ...
    ##  $ HPSA_Designation_Last_Update_Dat: chr  "9/10/2021" "9/10/2021" "5/20/2022" "9/10/2021" ...
    ##  $ Data_Warehouse_Record_Create_Dat: chr  "1/17/2023" "1/17/2023" "1/17/2023" "1/17/2023" ...

This means that we can use these data for a range of purposes, such as
pairing them with other libraries and analyzing it:

``` r
# Load the graphing library ggplot2 and data management library dplyr
library(dplyr)
library(forcats)
library(ggplot2)

# Wrangle some data to identify the average Health Professional Shortage Area 
# (HPSA) score in a given county:
demo <- rcahelpr::hpsa_primarycare %>%
  group_by(County_Equivalent_Name) %>%
  summarize(mean_hpsa_score = mean(HPSA_Score),
            total_hpsa_population = sum(HPSA_Designation_Population))

# Make a beautiful graph
ggplot(data = demo) +
  geom_point(aes(x = total_hpsa_population , y = fct_rev(County_Equivalent_Name),
                 color = mean_hpsa_score)) +
  geom_segment(aes(x = 0 , xend = total_hpsa_population ,
                   y = County_Equivalent_Name, yend = County_Equivalent_Name,
                   color = mean_hpsa_score)) +
  theme_minimal() +
  labs(title = "Affected Populations in HPSA by County",
       subtitle = "HPSA scores determine priorities for the assignment of clinitians",
       caption = "Data from CCHS") +
  xlab("Total Population in all County HPSAs") +
  ylab("") +
  scale_color_gradient2(low="#F5F5DC", mid = "#FFA500", high="#8B0000", 
                        midpoint = mean(demo$mean_hpsa_score),
                        name = "Average County HPSA Score") +
  theme(legend.position = "bottom")
```

![](README_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

Also, the data and functions in this package can be combined:

``` r
make_codebook(input_df = rcahelpr::hpsa_primarycare, return_df = FALSE, 
              escape = FALSE)
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Variable Name
</th>
<th style="text-align:left;">
Data Class
</th>
<th style="text-align:left;">
Valid Values
</th>
<th style="text-align:left;">
Statistics
</th>
<th style="text-align:right;">
Unique Values
</th>
<th style="text-align:left;">
Missing Values
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
HPSA_Discipline_Class
</td>
<td style="text-align:left;">
Character
</td>
<td style="text-align:left;">
Unique strings: Primary Care.
</td>
<td style="text-align:left;">
1 Unique strings: Primary Care
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
HPSA_Name
</td>
<td style="text-align:left;">
Character
</td>
<td style="text-align:left;">
Unique strings (n=230): Low Income - MSSA 78.2ddd/Bell
SW/Cudahy/Maywood/V, MSSA 6/Pioneer, MSSA 78.2uuu/Athens, and more.
</td>
<td style="text-align:left;">
230 unique strings, top three: <br> Colusa County (n=1) <br> LI-MFW-MSSA
176b/East Palo Alto (n=1) <br> LI-MFW/MSSA 186 Anderson (n=1)
</td>
<td style="text-align:right;">
230
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
HPSA_ID
</td>
<td style="text-align:left;">
Character
</td>
<td style="text-align:left;">
Unique strings (n=230): 1061017434, 1061018308, 1061038158, and more.
</td>
<td style="text-align:left;">
230 unique strings, top three: <br> 1061017434 (n=1) <br> 1061018308
(n=1) <br> 1061038158 (n=1)
</td>
<td style="text-align:right;">
230
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
County_Equivalent_Name
</td>
<td style="text-align:left;">
Character
</td>
<td style="text-align:left;">
Unique strings (n=52): Los Angeles, Amador, Sacramento, and more.
</td>
<td style="text-align:left;">
52 unique strings, top three: <br> Los Angeles (n=42) <br> San
Bernardino (n=15) <br> Kern (n=14)
</td>
<td style="text-align:right;">
52
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
Designation_Type
</td>
<td style="text-align:left;">
Character
</td>
<td style="text-align:left;">
Unique strings: HPSA Population, Geographic HPSA, High Needs Geographic
HPSA.
</td>
<td style="text-align:left;">
3 Unique strings: HPSA Population, Geographic HPSA, High Needs
Geographic HPSA
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
HPSA_Population_Type
</td>
<td style="text-align:left;">
Character
</td>
<td style="text-align:left;">
Unique strings (n=6): Low Income Population HPSA, Geographic Population,
Low Income Migrant Farmworker Population HPSA, and more.
</td>
<td style="text-align:left;">
6 unique strings, top three: <br> Geographic Population (n=125) <br> Low
Income Population HPSA (n=46) <br> Medicaid Eligible Population HPSA
(n=31)
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
HPSA_Score
</td>
<td style="text-align:left;">
Integer
</td>
<td style="text-align:left;">
Numeric range from 4 to 20.
</td>
<td style="text-align:left;">
Min: 4 <br> Avg: 13.03 <br> Median: 13 <br> Max: 20 <br> SD: 3.32
</td>
<td style="text-align:right;">
17
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
PC_MCTA_Score
</td>
<td style="text-align:left;">
Integer
</td>
<td style="text-align:left;">
Numeric range from 1 to 22.
</td>
<td style="text-align:left;">
Min: 1 <br> Avg: 13.47 <br> Median: 14 <br> Max: 22 <br> SD: 4.7
</td>
<td style="text-align:right;">
22
</td>
<td style="text-align:left;">
97 (42%)
</td>
</tr>
<tr>
<td style="text-align:left;">
HPSA_Provider_Ratio_Goal
</td>
<td style="text-align:left;">
Character
</td>
<td style="text-align:left;">
Unique strings: 3000:1, 3500:1.
</td>
<td style="text-align:left;">
2 Unique strings: 3000:1, 3500:1
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
HPSA_FTE
</td>
<td style="text-align:left;">
Numeric
</td>
<td style="text-align:left;">
Numeric range from 0 to 43.14.
</td>
<td style="text-align:left;">
Min: 0 <br> Avg: 5.71 <br> Median: 2.04 <br> Max: 43.14 <br> SD: 7.93
</td>
<td style="text-align:right;">
162
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
HPSA_Designation_Population
</td>
<td style="text-align:left;">
Integer
</td>
<td style="text-align:left;">
Numeric range from 748 to 173639.
</td>
<td style="text-align:left;">
Min: 748 <br> Avg: 35656.43 <br> Median: 25296 <br> Max: 173639 <br> SD:
33617.59
</td>
<td style="text-align:right;">
230
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
HPSA_Formal_Ratio
</td>
<td style="text-align:left;">
Character
</td>
<td style="text-align:left;">
Unique strings (n=173): 331500:1, 58480:1, 22665:1, and more.
</td>
<td style="text-align:left;">
173 unique strings, top three: <br> (n=52) <br> 3553:1 (n=2) <br> 3556:1
(n=2)
</td>
<td style="text-align:right;">
173
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
HPSA_Shortage
</td>
<td style="text-align:left;">
Numeric
</td>
<td style="text-align:left;">
Numeric range from 0.01 to 30.15.
</td>
<td style="text-align:left;">
Min: 0.01 <br> Avg: 5.86 <br> Median: 3.18 <br> Max: 30.15 <br> SD: 6.6
</td>
<td style="text-align:right;">
216
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
HPSA_Status
</td>
<td style="text-align:left;">
Character
</td>
<td style="text-align:left;">
Unique strings: Proposed For Withdrawal, Designated.
</td>
<td style="text-align:left;">
2 Unique strings: Proposed For Withdrawal, Designated
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
HPSA_Designation_Date
</td>
<td style="text-align:left;">
Character
</td>
<td style="text-align:left;">
Unique strings (n=159): 9/12/2011, 7/11/2008, 10/9/2012, and more.
</td>
<td style="text-align:left;">
159 unique strings, top three: <br> 6/22/2022 (n=9) <br> 1/31/2022 (n=6)
<br> 3/14/2022 (n=6)
</td>
<td style="text-align:right;">
159
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
HPSA_Designation_Last_Update_Dat
</td>
<td style="text-align:left;">
Character
</td>
<td style="text-align:left;">
Unique strings (n=50): 9/10/2021, 5/20/2022, 8/27/2021, and more.
</td>
<td style="text-align:left;">
50 unique strings, top three: <br> 9/10/2021 (n=118) <br> 3/30/2022
(n=8) <br> 6/22/2022 (n=8)
</td>
<td style="text-align:right;">
50
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
Data_Warehouse_Record_Create_Dat
</td>
<td style="text-align:left;">
Character
</td>
<td style="text-align:left;">
Unique strings: 1/17/2023.
</td>
<td style="text-align:left;">
1 Unique strings: 1/17/2023
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
0 (0%)
</td>
</tr>
</tbody>
</table>
