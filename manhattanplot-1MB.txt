#set working dir
# p values must be changed to -log prior to graph
setwd("C:/Users/User/Desktop/Stanley_eQTLS")
getwd()
dir() #sanity for neccessary files
library(gap)
library(plyr)
snps = read.table("pruned5.txt", header = T)
#delete duplicates 
#unique(df)
snps1 = unique(snps)
#arrange
snpA = arrange (snps1, (snps1[,1]))
#arrange(myCars, cyl, desc(disp)

#converting p values to -log10 equivalent
#define chromosome, location, p value
#ids = genes$ids;
#mirchrom = genes$chromosome;
#chrom= snps[,3]
#BP = snps [,4]
chrom = snpA[,1]
ID = snpA[,2]
BP = snpA[,3]
effect = -log10(snpA[,4])


png("manhattan5.png",height=3600,width=6000,res=600)
opar <- par()
par(cex=0.4)
colors <- rep(c("blue","green"), 12)
#define mappable object
data = with(snps, cbind(chrom,BP,effect))
#hdata = with(genes, cbind(ids,mirchrom))
#par(las=2, xpd=TRUE, cex.axis= 4, cex=0.4)
ops <- mht.control(colors=colors,srt=0,yline=2,xline=2.5, logscale = F,cutoffs = 8, gap = 3, usepos = F)
mhtplot(data, ops,xlab = "chromosomes", ylab = "PGCGWAS pvalues (-log(10))", pch = 19, bg=colors)
axis(2,at=0:20)

#box()
title("PGC-2 SNPS falling within 1MB of MIRNAs profiled by Kim et al (2010)", cex.main = 4)
dev.off()

