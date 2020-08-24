load('phsample.RData')
psub = subset(dpus,with(dpus,(PINCP>1000)&(ESR==1)&
                            (PINCP<=250000)&(PERNP>1000)&(PERNP<=250000)&
                            (WKHP>=40)&(AGEP>=20)&(AGEP<=50)&
                            (PWGTP1>0)&(COW %in% (1:7))&(SCHL %in% (1:24))))
View(head(psub))
dim(psub)
