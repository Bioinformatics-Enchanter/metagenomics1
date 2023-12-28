library(ggplot2)
library(taxonomizr)
library(dplyr)

#read data from tab-delimited file with read.delim function 
kreport=read.delim('300cycle.report', sep ='\t', header=FALSE)

##Assign Column names 
colnames(kreport) = c('percent', 'readsRooted', 'reads', 'taxRank', 'taxID', 'sciName')

#preview
head(kreport)
nrow(kreport)
ncol(kreport) 

## counting total number of reads in the sample
total_reads <- sum(kreport$reads)
#calculate relative abundance 
kreport$relative_abundance <- kreport$reads / total_reads


# Filter rows with reads Rooted is greater than 10,000 using dpler
filtered_kreport <- kreport %>%
  filter(readsRooted > 10000, percent> 1, taxRank == 'S')

#filtered_kreport <- kreport %>%
 # filter(readsRooted > 10000, taxRank == 'G')

# Print the filtered data
print(filtered_kreport)
#View(filtered_kreport)

# Plot the filtered data
gplot <- ggplot(data = filtered_kreport) +
  geom_bar(aes(x = sciName, y = relative_abundance), stat = 'identity') +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


