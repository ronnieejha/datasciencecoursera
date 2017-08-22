#Now working data set is "dataset"

qplot(x= value , y = Date, data = dataset)


library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$Date, y = dataset$value),
             colour = 'red') +
  geom_line() +
  ggtitle('Truth or Bluff (Polynomial Regression)') +
  xlab('Level') +
  ylab('Salary')

rainfall.plot <- function(rainfall, col="value"){
  require(ggplot2)
  p <- ggplot(rainfall, aes_string('Date', col)) +
    geom_line() +
    ggtitle(paste('Time series of', col)) +
    xlab("TIme in years")
  print(p)
}
rainfall.plot(dataset)




count = ts(na.omit(dataset$value), frequency=12)
decomp = stl(count, s.window="periodic")#, allow.multiplicative.trend=TRUE)
deseasonal_cnt <- seasadj(decomp)
plot(decomp)

library(forecast)
library(tseries)

adf.test(count, alternative = "stationary")

Acf(count, main='')

Pacf(count, main='')



count_d1 <- diff(deseasonal_cnt, differences = 12)
plot(count_d1)
adf.test(count_d1, alternative = "stationary")


Acf(count_d1, main='ACF for Differenced Series')
Pacf(count_d1, main='PACF for Differenced Series')

auto.arima(deseasonal_cnt, seasonal=FALSE)


fit2 = arima(deseasonal_cnt, order=c(1,12,6))
tsdisplay(residuals(fit2), lag.max = 45, main = "")