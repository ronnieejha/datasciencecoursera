
#Data was in text format and then pasted to excel as of ease of doing things


#Loading data

library(readxl)
raw <- read_excel("C:/Users/ronniee/Desktop/Book1.xlsx")
View(raw)

#Column 1 is subdivison which is assam
#column 1-12 are months respectively
#column x-1 is blah blah
#column x-2 is year

#removing unwanted columns 

raw <- raw[,-1]
raw <- raw[,-13]
head(raw)

#renaming X-2
raw$year <- raw$X__2
head(raw)
raw <- raw[,-13]

# reshaping data

reshape_raw <- reshape(raw, varying = 1:12 , v.names = "value",timevar = "month", 
                       times=names(raw)[1:12],idvar = "Value" , direction = "long")

str(reshape_raw)

# Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	1728 obs. of  4 variables:
#   $ year : chr  "1871" "1872" "1873" "1874" ...
# $ month: chr  "1" "1" "1" "1" ...
# $ value: num  27 185 106 357 452 148 329 103 65 384 ...
# $ Value: int  1 2 3 4 5 6 7 8 9 10 ...
# - attr(*, "reshapeLong")=List of 4
# ..$ varying:List of 1
# .. ..$ value: chr  "1" "2" "3" "4" ...
# .. ..- attr(*, "v.names")= chr "value"
# .. ..- attr(*, "times")= chr  "1" "2" "3" "4" ...
# ..$ v.names: chr "value"
# ..$ idvar  : chr "Value"
# ..$ timevar: chr "month"


reshape_raw <- reshape_raw[,-4]

#combining year and month to form a date

library(zoo)
reshape_raw$date <- as.yearmon(paste(reshape_raw$year,reshape_raw$month, sep = "-"))
head(reshape_raw)
str(reshape_raw)

reshape_raw$Date <- as.Date(paste(month.abb[as.numeric(reshape_raw$month)], "01", reshape_raw$year, sep="-"), 
                   format = "%b-%d-%Y")
dataset <- reshape_raw[,c("Date","value")]

