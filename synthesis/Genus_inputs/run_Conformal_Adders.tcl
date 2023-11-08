# Script to run Conformal to perform the Logig Equivalece Check
source /CMC/scripts/cadence.confrml21.10.100.csh
 
# LEC of RTL to Intermediate
lec -XL -do ./outputs_Nov01-02:55:10/rtl2intermediate.lec.do

# LEC of Intermediate to Optimized
#lec -XL -do ./outputs_Nov01-02:55:10/intermediate2final.lec.do


# LEC of RTL to Optimized
#lec -XL -do ./outputs_Nov01-02:55:10/rtl2final.lec.do

