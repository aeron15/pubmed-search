# As opposed to the previously mentioned trend searcher this tool searches PubMed and parses the data

# Get data for 2012
query <- c("cbt" = "'systems biology' AND 2012[DP]")
pub.efetch <- searchPubmed(query)
cbt_2012 <- extractJournal()

# Get data for 2011
query <- c("cbt" = "'systems biology' AND 2011[DP]")
pub.efetch <- searchPubmed(query)
cbt_2011 <- extractJournal()

# Get data total data for all years
query <- c("cbt" = "'systems biology'")
pub.efetch <- searchPubmed(query)
cbt_any <- extractJournal()


#
# RESHAPING THE DATA
#

# Add year-column
cbt_2010$year <- "2010"
cbt_2011$year <- "2011"
cbt_any$year <- "All"
 
# Reorder by $freq
cbt_any <- cbt_any[order(cbt_any$freq, decreasing=TRUE),]
# keep top 20
cbt_any <- cbt_any[1:20,]
#  Reorder factor levels, this will also drop levels not used
cbt_any$x <- factor(cbt_any$x, levels=cbt_any$x)
 
# Only keep values that's in Top 20 all time
cbt_2010 <- cbt_2010[cbt_2010$x %in% cbt_any$x,]
cbt_2011 <- cbt_2011[cbt_2011$x %in% cbt_any$x,]
 
# Combine data into one data frame
cbt_total <- rbind(cbt_2010,cbt_2011,cbt_any)
 
# Copy levels from cbt_any, but with levels in reverse order
# since I want the hightest value at the top
cbt_total$x <- factor(cbt_total$x, levels=rev(cbt_any$x))

#
# GGPLOT CODE
#

## Names for plot legend ##
my_labels <- c("2010", "2011", "1977-2012")

my_labels <- c("1", "2", "3")
 
# Box plot
ggplot(cbt_total, aes(x, percent, group=year, fill=year)) + geom_bar(stat="identity") + 
  coord_flip() +
  scale_fill_manual(values=c("All" = "#b41f5b", "2010" = "#A6CEE3", "2011" = "#1F78B4"), labels=my_labels) +
  xlab(NULL) +
  opts(legend.position = "bottom")
 
# Line plot
ggplot(cbt_total, aes(x, percent, group=year, color=year, linetype=year)) + geom_line(size=0.7) + 
  coord_flip() +
  scale_color_manual(values=c("All" = "#b41f5b", "2010" = "#A6CEE3", "2011" = "#1F78B4"), labels=my_labels) +
  scale_linetype_manual(values=c("All" = "dashed", "2010" = "solid", "2011" = "solid"), labels=my_labels) +
  xlab(NULL) +
  opts(legend.position = "bottom")