# Get data for 2012
query <- c("cbt" = "'systems biology' AND 2012[DP]")
pub.efetch <- searchPubmed(query)
cbt_2012 <- extractJournal()

# Get data for 2011
query <- c("cbt" = "'systems biology' AND 2011[DP]")
pub.efetch <- searchPubmed(query)
cbt_2011 <- extractJournal()
 
# Get data for 2010
query <- c("cbt" = "'systems biology' AND 2010[DP]")
pub.efetch <- searchPubmed(query)
cbt_2010 <- extractJournal()

# Get data for 2009
query <- c("cbt" = "'systems biology' AND 2009[DP]")
pub.efetch <- searchPubmed(query)
cbt_2009 <- extractJournal()

# Get data for 2008
query <- c("cbt" = "'systems biology' AND 2008[DP]")
pub.efetch <- searchPubmed(query)
cbt_2008 <- extractJournal()

# Get data for 2007
query <- c("cbt" = "'systems biology' AND 2007[DP]")
pub.efetch <- searchPubmed(query)
cbt_2007 <- extractJournal()

# Get data for 2006
query <- c("cbt" = "'systems biology' AND 2006[DP]")
pub.efetch <- searchPubmed(query)
cbt_2006 <- extractJournal()

# Get data for 2005
query <- c("cbt" = "'systems biology' AND 2005[DP]")
pub.efetch <- searchPubmed(query)
cbt_2005 <- extractJournal()

# Get data for 2004
query <- c("cbt" = "'systems biology' AND 2004[DP]")
pub.efetch <- searchPubmed(query)
cbt_2004 <- extractJournal()


# Get data for 2003
query <- c("cbt" = "'systems biology' AND 2003[DP]")
pub.efetch <- searchPubmed(query)
cbt_2003 <- extractJournal()

# Get data for 2002
query <- c("cbt" = "'systems biology' AND 2002[DP]")
pub.efetch <- searchPubmed(query)
cbt_2002 <- extractJournal()

 # Get data for 2001
query <- c("cbt" = "'systems biology' AND 2001[DP]")
pub.efetch <- searchPubmed(query)
cbt_2001 <- extractJournal()

 # Get data for 2000
query <- c("cbt" = "'systems biology' AND 2000[DP]")
pub.efetch <- searchPubmed(query)
cbt_2000 <- extractJournal()

 # Get data total data for all years
query <- c("cbt" = "'systems biology'")
pub.efetch <- searchPubmed(query)
cbt_any <- extractJournal()


####


#
# RESHAPING THE DATA
#

# Add year-column
cbt_2010$year <- "2010"
cbt_2011$year <- "2011"
cbt_2012$year <- "2012"
cbt_2009$year <- "2009"
cbt_2008$year <- "2008"
cbt_2007$year <- "2007"
cbt_2006$year <- "2006"
cbt_2005$year <- "2005"
cbt_2004$year <- "2004"
cbt_2003$year <- "2003"
cbt_2002$year <- "2002"
cbt_2001$year <- "2001"
cbt_2000$year <- "2000"


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
cbt_2012 <- cbt_2012[cbt_2012$x %in% cbt_any$x,]
cbt_2009 <- cbt_2009[cbt_2009$x %in% cbt_any$x,]
cbt_2008 <- cbt_2008[cbt_2008$x %in% cbt_any$x,]
cbt_2008 <- cbt_2008[cbt_2008$x %in% cbt_any$x,]
cbt_2007 <- cbt_2007[cbt_2007$x %in% cbt_any$x,]
cbt_2006 <- cbt_2006[cbt_2006$x %in% cbt_any$x,]
cbt_2005 <- cbt_2005[cbt_2005$x %in% cbt_any$x,]
cbt_2004 <- cbt_2004[cbt_2004$x %in% cbt_any$x,]
cbt_2003 <- cbt_2003[cbt_2003$x %in% cbt_any$x,]
cbt_2002 <- cbt_2002[cbt_2002$x %in% cbt_any$x,]
cbt_2001 <- cbt_2001[cbt_2001$x %in% cbt_any$x,]
cbt_2000 <- cbt_2000[cbt_2000$x %in% cbt_any$x,]
 
# Combine data into one data frame
cbt_total <- rbind(cbt_2012,cbt_2011, cbt_2010, cbt_2009,cbt_2008,cbt_2007,cbt_2006,cbt_2005,cbt_2004,cbt_2003,cbt_2002,cbt_2001,cbt_2000,cbt_any)
 
# Copy levels from cbt_any, but with levels in reverse order
# since I want the hightest value at the top
cbt_total$x <- factor(cbt_total$x, levels=rev(cbt_any$x))

#
# GGPLOT CODE
#

## Names for plot legend ##
my_labels <- c("1977-2012","2012","2011","2010","2009","2008","2007","2006","2005","2004","2003","2002","2001","2000")

my_labels=rev(my_labels);


ColorLabels=c("2012"="mediumpurple4","2011"="mediumseagreen","2010"="mediumslateblue","2009"="darkorange","2008"="mediumspringgreen","2007"="mediumturquoise","2006"="mediumvioletred","2005"="tomato2","2004"="tomato3","2003"="tomato4","2002"="turquoise","2001"="coral4","2000"="cornflowerblue","All"= "tan3")

# Box plot
ggplot(cbt_total, aes(x, percent, group=year, fill=year)) + geom_bar(stat="identity") + 
  coord_flip() +
  scale_fill_manual(values=ColorLabels, labels=my_labels) +
  xlab(NULL) +
  opts(legend.position = "bottom")

# Line plot

LineType=c("All" = "dashed", "2012" = "solid", "2011" = "solid", "2010" = "solid","2009" = "solid","2008" = "solid","2007" = "solid","2006" = "solid","2005" = "solid","2004" = "solid","2003" = "solid","2002" = "solid","2001" = "solid","2000" = "solid");

ggplot(cbt_total, aes(x, percent, group=year, color=year, linetype=year)) + geom_line(size=0.7) + 
  coord_flip() +
  scale_color_manual(values=ColorLabels, labels=my_labels) +
  scale_linetype_manual(values=LineType, labels=my_labels) +
  xlab(NULL) +
  opts(legend.position = "bottom")

