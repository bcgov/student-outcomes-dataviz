# BC Stats / Student Outcomes Data Visualization
Data visualization of the results of the B.C. post-secondary student outcomes surveys.

## About the app

The BC Student Outcomes Data Viewer was created to be a simple, dynamic interface that allows users to view up-to-date student outcomes information (three years of aggregated data) from six Student Groups referenced as follows, under the Student Group drop-down menu: 

- Apprenticeship (includes Traditional and Progressive apprenticeship programs; public and private institutions are included in the Overall and Program Area results)
- Associate Degree (includes university transfer programs) 
- Bachelor’s Degree
- Certificate (includes Post-degree Certificates and Advanced Certificates) 
- Diploma (includes Post-degree Diplomas and Advanced Diplomas) 
- Trades Foundation 

BC Student Outcomes results in the Data Viewer are available by Student Group, by Institution, by Program Area, and by Program Name. Aggregated data for the three most recent survey years are presented.  Note: For the Apprenticeship student group results, public and private institutions are included in the Overall and Program Area results.  For results by Institution and Program Level, only data for public institutions are available.


## Installation instructions

### System Requirements

Local installation requires R statistical software to be installed.

## Data Sources

BC Stats / Student Outcomes Data Visualization Platform uses the following datasets: 

- BC Student Outcomes Survey

## RPackages
```
R version 3.6.2 (2019-12-12)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 10 x64 (build 18362)

Matrix products: default

Random number generation:
 RNG:     Mersenne-Twister 
 Normal:  Inversion 
 Sample:  Rounding 
 
locale:
[1] LC_COLLATE=English_Canada.1252  LC_CTYPE=English_Canada.1252    LC_MONETARY=English_Canada.1252 LC_NUMERIC=C                    LC_TIME=English_Canada.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] shinyalert_1.0             shinyBS_0.61               markdown_1.1               shinycssloaders_0.3.0.9002 shinyjs_1.1                plotly_4.9.2              
 [7] ggplot2_3.2.1              shinydashboard_0.7.1       shinythemes_1.1.2          tidyr_1.0.2                htmlwidgets_1.5.1          shiny_1.4.0               
[13] lintr_2.0.1.9000          

loaded via a namespace (and not attached):
 [1] httr_1.4.1         pkgload_1.0.2      viridisLite_0.3.0  jsonlite_1.6.1     R.utils_2.9.2      assertthat_0.2.1   xmlparsedata_1.0.3 yaml_2.2.1         remotes_2.1.1     
[10] sessioninfo_1.1.1  pillar_1.4.3       backports_1.1.5    glue_1.3.1         digest_0.6.23      promises_1.1.0     colorspace_1.4-1   htmltools_0.4.0    httpuv_1.5.2      
[19] R.oo_1.23.0        pkgconfig_2.0.3    devtools_2.2.1     purrr_0.3.3        xtable_1.8-4       scales_1.1.0       processx_3.4.2     later_1.0.0        tibble_2.1.3      
[28] styler_1.3.2       usethis_1.5.1      ellipsis_0.3.0     withr_2.1.2        lazyeval_0.2.2     cli_2.0.1          magrittr_1.5       crayon_1.3.4       mime_0.9          
[37] memoise_1.1.0      ps_1.3.0           R.methodsS3_1.8.0  fs_1.3.1           fansi_0.4.1        R.cache_0.14.0     xml2_1.2.2         pkgbuild_1.0.6     tools_3.6.2       
[46] data.table_1.12.8  prettyunits_1.1.1  cyclocomp_1.1.0    lifecycle_0.1.0    stringr_1.4.0      munsell_0.5.0      callr_3.4.1        packrat_0.5.0      rex_1.1.2         
[55] compiler_3.6.2     rlang_0.4.4        grid_3.6.2         rstudioapi_0.11    crosstalk_1.0.0    testthat_2.3.1     gtable_0.3.0       codetools_0.2-16   curl_4.3          
[64] R6_2.4.1           knitr_1.28         dplyr_0.8.4        fastmap_1.0.1      rprojroot_1.3-2    desc_1.2.0         stringi_1.4.6      Rcpp_1.0.3         vctrs_0.2.2       
[73] tidyselect_1.0.0   xfun_0.12     
```


## Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an
[issue](https://github.com/bcgov/student-outcomes-dataviz/issues).


## How to Contribute

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

## License

Detailed guidance around licenses is available 
[here](/BC-Open-Source-Development-Employee-Guide/Licenses.md)

Attach the appropriate LICENSE file directly into your repository before you do anything else!

The default license For code repositories is: Apache 2.0

Here is the boiler-plate you should put into the comments header of every source code file as well as the bottom of your README.md:

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

