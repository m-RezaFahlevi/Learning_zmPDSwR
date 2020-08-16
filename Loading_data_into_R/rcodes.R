#Initialize the data from the urls
uciCar <- read.table('car.data.csv', sep = ',', header = TRUE, stringsAsFactors = TRUE)
View(uciCar)
#Examining our data
class(uciCar)
summary(uciCar)

#Read data files in .xlsx extension
library(gdata)
bookings <- read.xls('Workbook1.xlsx', sheet = 1, pattern = 'date', stringsAsFactors = FALSE, as.is = TRUE)
print(bookings)
prices <- read.xls('Workbook1.xlsx', sheet = 2, pattern = 'date', stringsAsFactors = FALSE, as.is = TRUE)
print(prices)
class(bookings)
View(bookings)
View(prices)
summary(bookings)
summary(prices)

#Using melt to restructured data
library(reshape2)
bthin <- melt(bookings, id.vars = c('date'), variable.name = 'daysBefore', value.name = 'bookings')
pthin <- melt(prices, id.vars = c('date'), variable.name = 'daysBefore', value.name = 'prices')
daysCodes <- c('day.of.stay', 'X1.before', 'X2.before', 'X3.before')
bthin$nDaysBefore <- match(bthin$daysBefore, daysCodes)-1
pthin$nDaysBefore <- match(pthin$daysBefore, daysCodes)-1
pthin$prices <- as.numeric(gsub('\\$', '',pthin$prices))
print(head(pthin))
print(head(bthin))

#Lining up for the data for analysis
library(sqldf)
sqlBookingThin <- sqldf('select * from bthin')
sqlPriceThin <- sqldf('SELECT * FROM pthin')
print(sqlBookingThin)
print(sqlPriceThin)

#Using R on less-structure data
d <- read.table('https://archive.ics.uci.edu/ml/machine-learning-databases/statlog/german/german.data', sep = ' ', header = FALSE, stringsAsFactors = FALSE)
View(d)
colnames(d) <- c('Status.of.existing.checking.account',
                'Duration.in.month', 'Credit.history', 'Purpose',
                'Credit.amount', 'Savings account/bonds',
                'Present.employment.since',
                'Installment.rate.in.percentage.of.disposable.income',
                'Personal.status.and.sex', 'Other.debtors/guarantors',
                'Present.residence.since', 'Property', 'Age.in.years',
                'Other.installment.plans', 'Housing',
                'Number.of.existing.credits.at.this.bank', 'Job',
                'Number.of.people.being.liable.to.provide.maintenance.for',
                'Telephone', 'foreign.worker', 'Good.Loan')
d$Good.Loan <- as.factor(ifelse(d$Good.Loan == 1, 'GoodLoan', 'BadLoan'))
print(d[1:3,])
source('scratch.r')
dim(d)  #print the dimension of the table, row x columns
class(d$Status.of.existing.checking.account)
for (i in 1:dim(d)[2]) {
    if (class(d[,i]) == "character") {
        d[,i] <- as.factor(as.character(mapping[d[,i]]))
    }
}

#Examining our new data
table(d$Purpose, d$Good.Loan)
summary(d)
