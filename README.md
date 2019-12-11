# BC Stats / Student Outcomes Data Visualization
Data visualization of the results of the B.C. post-secondary student outcomes surveys.


An interactive data visualization built using [RStudio's](https://www.rstudio.com/)
[Shiny](https://www.rstudio.com/products/shiny/) open source R package.

## Usage

Every year, BC Student Outcomes administers surveys to almost 30,000 former B.C. public post-secondary students. Click [here](http://outcomes.bcstats.gov.bc.ca/AboutUs/AboutStudentOutcomes.aspx) for more information about the program.  The intent is to build a reporting tool that can be used by public, prospective students and parents.


### R Packages

```
> sessionInf()
R version 3.4.4 (2018-03-15)
Platform: i386-w64-mingw32/i386 (32-bit)
Running under: Windows 7 x64 (build 7601) Service Pack 1

Matrix products: default

locale:
[1] LC_COLLATE=English_Canada.1252  LC_CTYPE=English_Canada.1252    LC_MONETARY=English_Canada.1252 LC_NUMERIC=C                    LC_TIME=English_Canada.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] bindrcpp_0.2.2        shinycssloaders_0.2.0 shinyjs_1.0           plotly_4.8.0          ggplot2_3.0.0.9000    flexdashboard_0.5.1   shinydashboard_0.7.0 
 [8] shinythemes_1.1.1     dplyr_0.7.6           tidyr_0.8.1           shiny_1.1.0          

loaded via a namespace (and not attached):
 [1] withr_2.1.2       promises_1.0.1    tidyselect_0.2.4  rprojroot_1.3-2   pkgconfig_2.0.1   compiler_3.4.4    stringr_1.3.1     htmlwidgets_1.3  
 [9] xtable_1.8-2      viridisLite_0.3.0 Rcpp_0.12.18      plyr_1.8.4        httr_1.3.1        tools_3.4.4       rmarkdown_1.9     R6_2.2.2         
[17] bindr_0.1.1       purrr_0.2.5       knitr_1.20        crosstalk_1.0.0   scales_1.0.0      assertthat_0.2.0  digest_0.6.15     evaluate_0.10.1  
[25] gtable_0.2.0      mime_0.5          stringi_1.1.7     reshape2_1.4.3    backports_1.1.2   htmltools_0.3.6   munsell_0.5.0     grid_3.4.4       
[33] colorspace_1.3-2  data.table_1.11.4 glue_1.2.0        httpuv_1.4.5      rlang_0.2.1       magrittr_1.5      lazyeval_0.2.1    yaml_2.2.0       
[41] later_0.7.3       pillar_1.2.1      jsonlite_1.5      tibble_1.4.2

```

### License

    Copyright 2017 Province of British Columbia

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at 

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
