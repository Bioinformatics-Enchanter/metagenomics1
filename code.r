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

## filter reads
filter_300cycle <- subset(kreport, readsRooted > 10000 & taxRank == "S")

################################################
write.table(filter_300cycle, 
            file = 'filter_300cycle.report', 
            sep = '\t', 
            row.names = FALSE)

#### Plot krona using this reoprt #########
############################################################################
## counting total number of reads in the sample
total_reads <- sum(kreport$reads)
#calculate relative abundance 
kreport$relative_abundance <- kreport$reads / total_reads

# Filter rows with reads Rooted is greater than 10,000, less than 1 % and only Species(S)
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


