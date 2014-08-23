require(plyr)
require(data.table)
data<-read.table("test/X_test.txt", sep = "",skip=0, header=FALSE)
subject<-read.table("test/subject_test.txt", sep = "",skip=0, header=FALSE)
result<-read.table("test/y_test.txt", sep = "",skip=0, header=FALSE)

testdata<-cbind(subject,data,result)

data<-read.table("train/X_train.txt", sep = "",skip=0, header=FALSE)
subject<-read.table("train/subject_train.txt", sep = "",skip=0, header=FALSE)
result<-read.table("train/y_train.txt", sep = "",skip=0, header=FALSE)

traindata<-cbind(subject,data,result)

data<-rbind(testdata,traindata)

features<-read.table("features.txt", sep = "",skip=0, header=FALSE)
colnames<-as.data.frame(features$V2)
colnames[,1]<-as.character(colnames[,1])
colnames(data)<-c('subject',t(colnames),'label')
ds1<-as.data.frame(rbind(apply(data,2,mean),apply(data,2,sd)))
write.table(ds1,"dt1.txt",row.name=FALSE)

library(data.table)
DT <- data.table(data)
ds2<-DT[,lapply(.SD,mean), by = subject]

write.table(ds2,"dt2.txt",row.name=FALSE)