# Question 3
# Of the four types of sources indicated by the type(point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

# Install and load necessary packages (if not already installed)
install.packages("ggplot2")
library(ggplot2)

# Set the URL for the dataset
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

# Download the dataset and extract it to the current working directory
download.file(fileurl,destfile=paste0(getwd(),"/NEI_data.zip"),method = "curl")
unzip("NEI_data.zip",exdir="./")

# Load the required datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# summing emission data per year per type
data <- aggregate(Emissions ~ year + type, NEI_Baltimore, sum)

# plotting
gt <- ggplot(data, aes(year, Emissions, color = type))
gt + geom_line() +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emissions")) +
  ggtitle("Total Emissions per type in Baltimore")