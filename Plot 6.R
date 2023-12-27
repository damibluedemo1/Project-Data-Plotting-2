# Question 6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

# Set the URL for the dataset
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

# Download the dataset and extract it to the current working directory
download.file(fileurl,destfile=paste0(getwd(),"/NEI_data.zip"),method = "curl")
unzip("NEI_data.zip",exdir="./")

# Load the required datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter data for Los Angeles County (fips == "06037")
los <- subset(NEI, fips == "06037")

# Filter SCC codes related to motor vehicle sources
vehicleMatches  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
subsetSCC <- SCC[vehicleMatches, ]

# Merge data for Baltimore City and Los Angeles County
dataBalt <- merge(NEI_Baltimore, subsetSCC, by="SCC")
dataBalt$city <- "Baltimore City"
dataLos <- merge(los, subsetSCC, by="SCC")
dataLos$city <- "Los Angeles County"
data <- rbind(dataBalt, dataLos)

# Aggregate data to calculate total emissions per year and city
data <- aggregate(Emissions ~ year + city, data, sum)

# Create a line plot to visualize the total emissions from motor vehicle sources in both cities over the years
gt <- ggplot(data, aes(year, Emissions, color = city))
gt + geom_line() +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emissions")) +
  ggtitle("Total Emissions from motor sources in Baltimore and Los Angeles")