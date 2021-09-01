#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

ind<-read.csv(args[1],header=FALSE,sep="\t")
ind<- as.matrix(ind)
png(args[2])
barplot(ind,names.arg=c("15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50"),col=c("red","green","blue","hotpink"),legend=c("A","C","G","T"),beside=FALSE,ylab="read counts",main=args[1])
dev.off() 
