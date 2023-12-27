# Question 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question

# Set the URL for the dataset
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

# Download the dataset and extract it to the current working directory
download.file(fileurl,destfile=paste0(getwd(),"/NEI_data.zip"),method = "curl")
unzip("NEI_data.zip",exdir="./")

# Load the required datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset data for Baltimore City, Maryland (fips == "24510")
NEI_Baltimore<-subset(NEI, fips == "24510")

# Calculate total emissions for each year in Baltimore City
total_emission_year_Baltimore<-tapply(NEI_Baltimore$Emissions, NEI_Baltimore$year, sum, na.rm=TRUE)

# Set up the plot parameters
par(mfrow=c(1,1),mar=c(5,5,4,2))

# Create a bar plot to visualize total PM2.5 emissions for each year in Baltimore City
barplot(total_emission_year_Baltimore, names.arg = names(total_emission_year_Baltimore), col="green", 
        main="Emissions of PM2.5 by year in Baltimore City", xlab = "Year", 
        ylab="Amount of emissions (tons)", ylim = range(0,total_emission_year_Baltimore)*1.1)

# Save the plot as a PNG file
png("plot2.png", width=640, height=640)