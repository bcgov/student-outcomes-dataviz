# BC Stats / Student Outcomes Data Visualization
Data visualization of the results of the B.C. post-secondary student outcomes surveys.

[![img](https://img.shields.io/badge/Lifecycle-Stable-97ca00)](https://github.com/bcgov/repomountie/blob/master/doc/lifecycle-badges.md)

## About the app

The BC Student Outcomes Data Viewer was created to be a simple, dynamic interface that allows users to view up-to-date student outcomes information (three years of aggregated data) from six Student Groups referenced as follows, under the Student Group drop-down menu: 

- Apprenticeship (includes Traditional and Progressive apprenticeship programs; public and private institutions are included in the Overall and Program Area results)
- Associate Degree (includes university transfer programs) 
- Bachelor’s Degree
- Certificate (includes Post-degree Certificates and Advanced Certificates) 
- Diploma (includes Post-degree Diplomas and Advanced Diplomas) 
- Trades Foundation 

BC Student Outcomes results in the Data Viewer are available by Student Group, by Institution, by Program Area, and by Program Name. Aggregated data for the three most recent survey years are presented.  Note: For the Apprenticeship student group results, public and private institutions are included in the Overall and Program Area results.  For results by Institution and Program Level, only data for public institutions are available.

The data visualization tool is written in R, using the {shiny} package. The application is hosted at https://bcstats.shinyapps.io/so_data_viewer/

## Installation instructions

### System Requirements

Local installation requires R statistical software to be installed.

## Data Sources

BC Stats / Student Outcomes Data Visualization Platform uses the following datasets: 

- BC Student Outcomes Survey

## RPackages
```
R version 4.0.0 (2020-04-24)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 10 x64 (build 18362)

Matrix products: default

locale:
[1] LC_COLLATE=English_Canada.1252  LC_CTYPE=English_Canada.1252    LC_MONETARY=English_Canada.1252 LC_NUMERIC=C                    LC_TIME=English_Canada.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] shiny_1.4.0.2

loaded via a namespace (and not attached):
 [1] Rcpp_1.0.4.6         rstudioapi_0.11      magrittr_1.5         tidyselect_1.1.0     xtable_1.8-4         R6_2.4.1             rlang_0.4.6          fastmap_1.0.1       
 [9] dplyr_0.8.5          tools_4.0.0          shinydashboard_0.7.1 packrat_0.5.0        miniUI_0.1.1.1       bcgovr_1.0.4         htmltools_0.4.0      ellipsis_0.3.1      
[17] assertthat_0.2.1     digest_0.6.25        tibble_3.0.1         lifecycle_0.2.0      crayon_1.3.4         purrr_0.3.4          later_1.0.0          vctrs_0.3.0         
[25] promises_1.1.0       mime_0.9             glue_1.4.1           compiler_4.0.0       pillar_1.4.4         jsonlite_1.6.1       httpuv_1.5.2         pkgconfig_2.0.3     
  
```

## Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an
[issue](https://github.com/bcgov/student-outcomes-dataviz/issues).


## How to Contribute

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.


### License

    Copyright 2019 Province of British Columbia

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at 

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    
This repository is maintained by [BC Stats](http://bcstats.gov.bc.ca/Home.aspx). Click [here](https://github.com/bcgov/BCStats) for a complete list of our repositories on GitHub.


