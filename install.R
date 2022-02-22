install.packages(c("Bchron",
"changepoint",
"DescTools",
"devtools",
"doParallel", 
"doRNG", 
"doSNOW", 
"dplyr", 
"ff", 
"ffbase",
"foreach",
"forecast", 
"FuzzyNumbers",
"IntCal",
"knitr",
"lubridate",
"maptools",
"Metrics",
"nloptr",
"R.devices",
"Rcpp", 
"raster", 
"remotes",
"rstan", 
"sets", 
"tseries", 
"tidyverse"), repos= "https://cloud.r-project.org")# when I know everythin is working, quiet = TRUE) 
library("devtools")
install_github("earthsystemdiagnostics/hamstr", ref="master", args = "--preclean")
install_github("earthsystemdiagnostics/hamstrbacon", ref="main")
install_version("clam", version="2.3.9", repos= "https://cloud.r-project.org")
install_version("rbacon", version="2.5.2", repos= "https://cloud.r-project.org")