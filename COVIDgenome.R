# this code downloads the genome of the coronavirus, and extracts the sequence of the spike protein using
# the sequence of the beginning and the end of the sequence. 
# the beginning of the sequence gave in the assignment was not in the actual sequence, so I went on NCBI 
# and took the actual beginning of the spike protein (it had an extra T)

library(rentrez)
setwd("./")

#download the genome of the coronavirus, and turns it in a vector containing the header and the sequence.
covid<-entrez_fetch(db = "nuccore", id = "NC_045512.2", rettype = "fasta")
covid = unlist(strsplit(covid,"complete genome\n"))
#removes the \n from the sequence and assign it to a new variable.
Sequence = gsub("\n", "", covid[2])

#isolates the sequence of the spike protein using regex.
Sequence = sub("(\\w+)(ATGTTTGTTTTTCTTGTTTTA)(\\w+)(\\GTCAAATTACATTACACATAA)(\\w+)","\\2\\3\\4", Sequence)
Sequence

# according to the BLAST search, the 100 first sequences have 100% identity to the  query. 
# They locally align perfectly without any gaps. It is possible to conclude that the spike protein
# is well conserved and does not evolve rapidly. 