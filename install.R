install.packages(c("Bchron",
"changepoint",
"DescTools",
"devtools",
"doParallel", 
"doRNG", 
"doSNOW", 
"dplyr", 
"ff", 
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
"sets", 
"tseries", 
"tidyverse"), repos= "https://cloud.r-project.org")
library("devtools")
install_github("edwindj/ffbase", subdir="pkg")
install_github("earthsystemdiagnostics/hamstr", ref="master")
install_github("earthsystemdiagnostics/hamstrbacon", ref="main")
install_version("clam", version="2.3.9", repos= "https://cloud.r-project.org")
install_version("rbacon", version="2.5.2", repos= "https://cloud.r-project.org")