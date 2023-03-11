install.packages(c("Bchron",
"changepoint",
"devtools",
"doParallel", 
"doRNG", 
"doSNOW", 
"dplyr", 
"ff", 
"foreach",
"forecast", 
"IntCal",
"nloptr",
"R.devices",
"Rcpp", 
"remotes", 
"sets",
"tidyverse"), repos= "https://cloud.r-project.org")
library("devtools")
Sys.setenv(DOWNLOAD_STATIC_LIBV8 = 1)
install.packages("rstan")
install_github("edwindj/ffbase", subdir="pkg")
install_github("earthsystemdiagnostics/hamstr", ref="master")
install_github("earthsystemdiagnostics/hamstrbacon", ref="main")
install_version("clam", version="2.3.9", repos= "https://cloud.r-project.org")
install_version("rbacon", version="2.5.2", repos= "https://cloud.r-project.org")