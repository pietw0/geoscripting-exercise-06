# Geoscripting 2020 
# Exercise 4
# Intro to raster
# Tests
# 28/10/2019

# Load testing package
suppressWarnings(library('testthat'))
library('testthat')

# Source main.r
cat('Running main.R...\n')  
cat('Log of main.R:\n\n')
try(source('main.R'))

# Start tests
cat('\nChecking functions...\n')

# Test if required functions exist
fun_req <- c("detectFires")
fun_found <- c(lsf.str())

# If the required functions do not exists, stop testing
for (fun in fun_req){
  new_fun <- paste0("^", fun, "$")
  if (TRUE %in% Vectorize(grepl, USE.NAMES = FALSE)(new_fun, fun_found) == T){
    cat(paste0('\nFunction ', fun, ' successfully created\n'))
  }else{
    stop(paste0("No function found called ", fun, ". Aborting tests."))
  }
}

cat('\nTesting script output...\n')

# Set fail variable
failed_tests <- 0

# Test folder creation
if (!dir.exists('data')) {
  cat('\nNo folder called "data" created in your script\n')
  failed_tests <- failed_tests + 1
} else {
  cat('\nData folder successfully created in your script\n')
}

if (!dir.exists('output')) {
  cat('\nNo folder called "output" created in your script\n')
  failed_tests <- failed_tests + 1
} else {
  cat('\nOutput folder successfully created in your script\n')
}



# Check output file creation
if (!file.exists('output/LE070440322018111601T1-SC20191001153746.png')) {
  cat('\nNo image called "LE070440322018111601T1-SC20191001153746.png" found in "output" folder\n')
  failed_tests <- failed_tests + 1
} else {
  cat('\n"LE070440322018111601T1-SC20191001153746.png" successfully created and correctly placed\n')
}

if (!file.exists('output/LC080440322018110801T1-SC20190925130645.png')) {
  cat('\nNo image called "LC080440322018110801T1-SC20190925130645.png" found in "output" folder\n')
  failed_tests <- failed_tests + 1
} else {
  cat('\n"LC080440322018110801T1-SC20190925130645.png" successfully created and correctly placed\n')
}

if (!file.exists('output/Active_fires_California.png')) {
  cat('\nNo file called "Active_fires_California.png" found in "output" folder\n')
  failed_tests <- failed_tests + 1
} else {
  cat('\n"Active_fires_California.png" successfully created and correctly placed\n')
}


# Test temperature calculations
variables <- c('T_start_mean', 'T_start_max', 'T_end_mean', 'T_end_max')
answers <- c(46, 100, 36, 81)

for (variable in variables){
  if (exists(variable)){
  
    if (round(get(variable), 0) == answers[match(variable, variables)]){
      cat(paste0('\nVariable ', variable,' exists and value is correct\n'))
    
    } else {
      failed_tests <- failed_tests + 1
      cat(paste0('\nVariable ', variable,' exists but value not correct, with a difference of ', abs(answers -round(get(variable), 0)),'\n'))
    }
  
  } else {
    failed_tests <- failed_tests + 1
    cat(paste0('\nVariable ', variable, ' opt_area not found\n'))
  }
}

# Communicate number of tests passed
cat(paste0("\n", failed_tests," tests failed in total.\n"))

if (failed_tests != 0){
  stop("Build failed: not all tests passed")  
}

# Check bonus
if (!file.exists('output/Camp_fire_severity.png')) {
  cat('\nBonus not succeeded: no file called "Camp_fire_severity.png" found in "output" folder\n')
} else {
  cat('\nWell done, bonus task succeeded: "Camp_fire_severity.png" successfully created and correctly placed\n')
}


cat("\nDone testing\n")
