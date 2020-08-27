library(ggplot2)

#loading data
custdata <- read.table('custdata.tsv', header = TRUE, sep = '\t', stringsAsFactors = TRUE)
View(custdata)
head(custdata)
tail(custdata)
dim(custdata)
summary(custdata)
sqrt(var(custdata$income))
mean(custdata$income)
print(sqrt(var(custdata$income))/mean(custdata$income))

#Spotting problems using graphics and visualization
custdata.age.density <- ggplot(custdata, mapping = aes(x = age)) + geom_density(color = "blue")
custdata.age.histogram <- ggplot(custdata, mapping = aes(x = age)) + geom_histogram(binwidth = 5, fill = "gray", color = "black")
custdata.income.density <- ggplot(custdata, mapping = aes(x = income)) + geom_density(color = "red")
custdata.income.density.logscale <- ggplot(custdata, mapping = aes(x = income)) + geom_density(color = "magenta") + scale_x_log10(breaks = c(100, 1000, 10000, 100000)) + annotation_logticks(sides = "bt")
custdata.marital.stat.histogram <- ggplot(custdata, mapping = aes(x = marital.stat)) + geom_bar(fill = "gray")
custdata.state.of.res.bar <- ggplot(custdata, mapping = aes(x = state.of.res)) + geom_bar(fill = "gray") + coord_flip() + theme(axis.text.y = element_text(size = rel(0.8)))

#Producing a bar with sorted categories
statesums <- table(custdata$state.of.res)
statef <- as.data.frame(statesums)
colnames(statef) <- c("state.of.res", "count")
summary(statef)
statef <- transform(statef, state.of.res = reorder(state.of.res, count))
summary(statef)
custdata.state.of.res.bar.reorder <- ggplot(statef) + geom_bar(aes(x = state.of.res, y = count), stat = "identity", fill = "gray") + coord_flip() + theme(axis.text.y = element_text(size = rel(0.8)))

#Visually checking relationships between two variables
x <- runif(100)
y <- x^2 + 0.2*x
ggplot(data.frame(x = x, y = x), mapping = aes(x = x, y = y)) + geom_line()
ggplot(data.frame(x = x, y = x), mapping = aes(x = x, y = y)) + geom_point() + stat_smooth(method = "lm", formula = y~x)

#Examining the correlation between age and income
custdata2 <- subset(custdata, custdata$age > 0 & custdata$age < 100 & custdata$income > 0)
cor(custdata2$age, custdata2$income) #Output: -0.02240845
ggplot(custdata2, mapping = aes(x = age, y = income)) + geom_point()
ggplot(custdata2, mapping = aes(x = age, y = income)) + geom_point() + stat_smooth(method = "lm") + ylim(0, 200000)
ggplot(custdata2, mapping = aes(x = age, y = income)) + geom_point() + geom_smooth() + ylim(0, 200000)
ggplot(custdata2, mapping = aes(x = age, y = as.numeric(health.ins))) + geom_point(position = position_jitter(w = 0.05, h = 0.05)) + geom_smooth()

library(hexbin)
ggplot(custdata2, mapping = aes(x = age, y = income)) + geom_hex(binwidth = c(5, 10000)) + geom_smooth(color = "white", se = FALSE) + ylim(0, 200000)

#Diffrent kind of bar plot
ggplot(custdata, mapping = aes(x = marital.stat, fill = health.ins)) + geom_bar()
ggplot(custdata, mapping = aes(x = marital.stat, fill = health.ins)) + geom_bar(position = "dodge")
ggplot(custdata, mapping = aes(x = marital.stat, fill = health.ins)) + geom_bar(position = "fill")
ggplot(custdata, mapping = aes(x = marital.stat, fill = health.ins)) + geom_bar(position = "fill") + geom_point(mapping = aes(y = -0.05), size = 0.75, alpha = 0.3, position = position_jitter(h = 0.01))

ggplot(custdata2, mapping = aes(x = housing.type, fill = marital.stat)) + geom_bar(position = "dodge") + theme(axis.text.x = element_text(angle = 45, hjust = 1))
ggplot(custdata, mapping = aes(x = marital.stat)) + geom_bar(position = "dodge", fill = "darkgray") + facet_wrap(~housing.type, scales = "free_y") + theme(axis.text.x = element_text(angle = 45, hjust = 1))
