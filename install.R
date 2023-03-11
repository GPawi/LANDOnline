install.packages("Bchron", repos = "https://cloud.r-project.org")
library("devtools")
#New test - from binder-rethinking
Sys.setenv(DOWNLOAD_STATIC_LIBV8 = 1)
if (!file.exists(dotR)) dir.create(dotR)
M <- file.path(dotR, "Makevars")
if (!file.exists(M)) file.create(M)
cat("\nCXX14FLAGS=-O3 -march=native -mtune=native -fPIC",
    "CXX14=g++", # or clang++ but you may need a version postfix
    file = M, sep = "\n", append = TRUE)
dotR <- file.path(Sys.getenv("HOME"), ".R")
if (!file.exists(dotR)) dir.create(dotR)
M <- file.path(dotR, "Makevars")
if (!file.exists(M)) file.create(M)
cat("\nCXX14FLAGS=-O3 -march=native -mtune=native -fPIC",
    "CXX14=g++", # or clang++ but you may need a version postfix
    file = M, sep = "\n", append = TRUE)
install.packages("rstan", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
install_github("edwindj/ffbase", subdir="pkg")
install_github("earthsystemdiagnostics/hamstr", ref="master")
install_github("earthsystemdiagnostics/hamstrbacon", ref="main")
install_version("clam", version="2.3.9", repos= "https://cloud.r-project.org")
install_version("rbacon", version="2.5.2", repos= "https://cloud.r-project.org")