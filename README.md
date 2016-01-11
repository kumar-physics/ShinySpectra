# ShinySpectra
N15 HSQC simulation of BMRB data base enries

Required R libraries

1. shiny
2. ggvis
3. httr
4. reshape2
5. ggplot2

If the above packages are not installed in your system, then you may install those packages using the follwing command in your R

install.packages(c('shiny','ggvis','httr','reshape2','ggplot2'))

Once you have all the necessary packages in your system, you may use the following commands to run the visualization

library(shiny)
runGitHub("ShinySpectra","uwbmrb")
