# Question 1 
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Set the URL for the dataset
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

# Download the dataset and extract it to the current working directory
download.file(fileurl,destfile=paste0(getwd(),"/NEI_data.zip"),method = "curl")
unzip("NEI_data.zip",exdir="./")

# Load the required datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Calculate the total emissions for each year
total_emission_year<-tapply(NEI$Emissions, NEI$year, sum, na.rm=TRUE)

# Set up the plot parameters
par(mfrow=c(1,1),mar=c(5,5,4,2))

# Create a bar plot
barplot(total_emission_year/1000, names.arg = names(total_emission_year), col="green", main="Emissions of PM2.5 by year", 
        xlab = "Year", ylab="Amount of emissions (kilotons)", ylim = range(0,total_emission_year/1000) * 1.1)

# Add a line plot on top of the bar plot
lines(names(total_emission_year), total_emission_year/1000, lwd=2, col="green") 

# Create a bar plot to visualize total PM2.5 emissions for the years 1999, 2002, 2005, and 2008
png("plot1.png", width=640, height=640)