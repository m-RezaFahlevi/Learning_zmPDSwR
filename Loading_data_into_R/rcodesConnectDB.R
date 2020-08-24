library(RJDBC)
library(sqldf)
library(reshape2)
drv <- JDBC("com.mysql.jdbc.Driver", "mysql-connector-java.jar", identifier.quote="'")
conn <- dbConnect(drv, "jdbc:mysql://localhost/perpustakaan?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "")
dataFromDB <- dbGetQuery(conn, "SELECT * FROM buku")
print(dataFromDB)
class(dataFromDB)

View(dataFromDB, "buku")

#Transforming data
authorsDataFromDB <- sqldf("SELECT judul FROM dataFromDB")
length(authorsDataFromDB$judul)
help("melt")

#Disconnet to databases;
dbDisconnect(conn)
