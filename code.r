library(ggplot2)
library(taxonomizr)
kreport=read.delim('300cycle.report', sep ='\t', header=FALSE)

#preview
head(kreport)
nrow(kreport)

colnames(kreport) = c('percent', 'readsRooted', 'reads', 'taxRank', 'taxID', 'sciName')
# Filter rows where readsRooted is greater than 10,000
filtered_kreport <- fam.kreport[fam.kreport$readsRooted > 10000, ]

# Plot the filtered data
ggplot(data = filtered_kreport) +
  geom_bar(aes(x = sciName, y = percent), stat = 'identity')


fam.kreport = subset(kreport, kreport$taxRank=='G')


ggplot(data=fam.kreport) +
  geom_bar(aes(x=sciName, y = readsRooted), stat='identity') 


