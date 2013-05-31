setwd("C:/Users/User/Desktop/Stanley_eQTLS")
library(MatrixEQTL) 
useModel = modelANOVA ; # modelANOVA, modelLINEAR, or modelLINEAR_CROSS

SNP_file_name = "ch1-genotypes.csv";
snps_location_file_name = "ch1-snplocation.csv";

expression_file_name = "expression_masterv2.csv";
gene_location_file_name = "ch1-gene-location.txt";

covariates_file_name = "covariates_sex-ph.csv";

output_file_name_cis = "eQTL_results_R_cis-ch1.txt";
output_file_name_tra = "eQTL_results_R_tra-ch1.txt";

# Only associations significant at this level will be saved
#pvOutputThreshold_cis = 1e-4;
#pvOutputThreshold_tra = 1e-4;

pvOutputThreshold_cis = 1e-2;
pvOutputThreshold_tra = 1e-2;

# Error covariance matrix
# Set to numeric() for identity.
errorCovariance = numeric();
# errorCovariance = read.table("Sample_Data/errorCovariance.txt");

cisDist = 1e6; #1e6 is default listing

## Load genotype data

snps = SlicedData$new();
snps$fileDelimiter = ","; # the TAB character
snps$fileOmitCharacters = "NA"; # denote missing values;
snps$fileSkipRows = 1; # one row of column labels
snps$fileSkipColumns = 1; # one column of row labels
snps$fileSliceSize = 2000; # read file in pieces of 2,000 rows
snps$LoadFile(SNP_file_name);

## Load gene expression data

gene = SlicedData$new();
gene$fileDelimiter = ","; # the TAB character
gene$fileOmitCharacters = "NA"; # denote missing values;
gene$fileSkipRows = 1; # one row of column labels
gene$fileSkipColumns = 1; # one column of row labels
gene$fileSliceSize = 2000; # read file in pieces of 2,000 rows
gene$LoadFile(expression_file_name);

## Load covariates

cvrt = SlicedData$new();
cvrt$fileDelimiter = ","; # the TAB character
cvrt$fileOmitCharacters = "NA"; # denote missing values;
cvrt$fileSkipRows = 1; # one row of column labels
cvrt$fileSkipColumns = 1; # one column of row labels
cvrt$fileSliceSize = 2000; # read file in one piece
if(length(covariates_file_name)>0) {
	cvrt$LoadFile(covariates_file_name);
}

## Run the analysis
snpspos = read.csv(snps_location_file_name, header = T, stringsAsFactors = T);
genepos = read.table(gene_location_file_name, header = T, stringsAsFactors = T);

me = Matrix_eQTL_main(
		snps = snps, 
		gene = gene, 
		cvrt = cvrt,
		output_file_name     = output_file_name_tra,
		pvOutputThreshold     = pvOutputThreshold_tra,
		useModel = useModel, 
		errorCovariance = errorCovariance, 
		verbose = TRUE, 
 		output_file_name.cis = output_file_name_cis,
		pvOutputThreshold.cis = pvOutputThreshold_cis,
		snpspos = snpspos, 
		genepos = genepos,
		cisDist = cisDist,
		pvalue.hist = "qqplot");

## Plot the Q-Q plot of local and distant p-values

plot(me)

