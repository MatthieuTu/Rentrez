#16/02/2022
# this R script downloads 3 fasta files from NCBI and uses regex to rearrange it.
# A csv file containing the results is eventually written. Its first column contains
# The first column contains the header of the sequences and the second contains the 
# sequences
#---------------------------------------------------------------------------------------------

setwd("./")

# loads the rentrez package, which allows to search and downloads data from the NCBI database
library(rentrez)


# create a vector containing NCBI unique IDs of 3 sequences
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")

# loads files from NCBI: In the "nuccore" database, looks for the files with the unique ID in
# the vector ncbi_ids, and downloads them in a fasta file. 
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta") 

# split the string at the \n\n, the convert it in a vector
Sequences = strsplit(Bburg, "\n\n")
Sequences<-unlist(Sequences)

# use regex to separate headers and sequences
header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences<-data.frame(Name=header,Sequence=seq)

# removes all \n from Sequences$Sequence.
Sequences$Sequence = gsub("\n", "", Sequences$Sequence)

# writes a csv file containing the processed sequences
write.csv(Sequences, file = "Sequences.csv", row.names = F)


