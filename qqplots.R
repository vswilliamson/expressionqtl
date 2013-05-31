setwd("C:/Users/User/Desktop/Stanley_eQTLs")
dir()
#qqplots of siginificant mirna and normalized data 
norm = read.table("normalized_data_siginificant_mirna-3-17-13.txt", 
header = T, sep = "\t")
png("qqplot1.png",height=3600,width=6000,res=600)
par(mfrow=c(2,1))
qqnorm(norm[,2], main = "hsa-mir-132")
qqnorm(norm[,3], main = "hsa-mir-132-normalized")




