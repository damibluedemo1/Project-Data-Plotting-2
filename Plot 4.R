# Question 4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?


# Set the URL for the dataset
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

# Download the dataset and extract it to the current working directory
download.file(fileurl,destfile=paste0(getwd(),"/NEI_data.zip"),method = "curl")
unzip("NEI_data.zip",exdir="./")

# Load the required datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter for SCC codes related to coal sources
coalMatches  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
subsetSCC <- SCC[coalMatches, ]

# Merge the NEI and SCC datasets based on SCC code
NEISCC <- merge(NEI, subsetSCC, by="SCC")

# Calculate total emissions per year
total_emission_year <- tapply(NEISCC$Emissions, NEISCC$year, sum)

# Create a barplot to visualize the total emissions from coal sources over the years
barplot(total_emission_year, col = "green", xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission from coal sources")