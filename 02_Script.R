####################################
# SCRIPT FOR DAY 2 - TIDYVERSE
###################################

#Load tidyverse package
library(tidyverse)

#load dataset in R
surveys <- read_csv("data/portal_data_joined.csv")

#check if data has loaded
head(surveys)

#print 15 rows
print(surveys, n=15)

str(surveys)

#######Drawing plots
#draw a scatter plot
ggplot(data=surveys, mapping=aes(x=weight, y=hindfoot_length)) +
  geom_point()

# show transparency in data points - to identify density
ggplot(data=surveys, mapping=aes(x=weight, y=hindfoot_length)) +
  geom_point(alpha=0.1)

#add colour to my data points
ggplot(data=surveys, mapping=aes(x=weight, y=hindfoot_length)) +
  geom_point(alpha=0.1, colour="blue")

#if you would like to plot more than one plot using the same data and mapping
surveys_plot <- ggplot(data=surveys, mapping=aes(x=weight, y=hindfoot_length)) 

#draw a scatter plot
surveys_plot +
  geom_point()

#draw a geom_smooth plot
surveys_plot +
  geom_smooth()

#plot two different plots on top of each other
# Adding Layers 
surveys_plot +
  geom_point() +
  geom_smooth()

##SELECT COLUMNS FROM A DATASET 
#extract the columns species_id, weight, hindfoot_length, year and sex
select(surveys, species_id, weight, hindfoot_length, year, sex)

#select all columns except record_id and species_id columns
select(surveys, -record_id, -species_id)


##FILTERING ROWS

# keep only rows (animal observations) that have been collected from 1995 onwards
filter(surveys, year >= 1995)

#filtering by multiple conditions
#keep only animals collected from 1995 onwards AND that are female
filter(surveys, year >=1995 & sex=="F")

#which values of column weight are NA
is.na(surveys$weight)

#which values of the weight column are not missing?
surveys[!is.na(surveys$weight),]

#using dplyr
filter(surveys, !is.na(weight), !is.na(hindfoot_length))

#using drop_na
drop_na(surveys, weight, hindfoot_length)

#remove all NAs from the dataset (all missing data)
drop_na(surveys)

surveys_complete <- drop_na(surveys)


#### PIPES
# Different ways of using multiple functions of tidyverse together

#1. using intermediate steps
surveys2 <- select(surveys_complete, species_id, weight, hindfoot_length, year, sex)
surveys_recent <- filter(surveys2, year>=1995)

#2. using nesting
surveys_recent <- filter(
                    select(surveys_complete, species_id, weight, hindfoot_length, year, sex)
                    , year >=1995)

#3.  pipes %>%
surveys_complete %>% 
  select(species_id, weight, hindfoot_length, year, sex) %>% 
  filter(year >= 1995)

surveys_recent <- surveys_complete %>% 
                    select(species_id, weight, hindfoot_length, year, sex) %>% 
                    filter(year >= 1995)
                  

# Challenge 1 - Pipes

select(surveys_complete, weight)

surveys_complete %>% 
    select(species_id, weight, hindfoot_length, year, sex) %>% 
    filter(year >= 1995) %>%
    ggplot(mapping = aes(x = weight, y=hindfoot_length)) +
      geom_point()

# Challenge 2

surveys_recent <- surveys_complete %>%
    select(species_id, weight, hindfoot_length, year, sex) %>%
    filter(year >= 1995)

## using multiple data sets in a ggplot
ggplot(mapping=aes(x=weight, y=hindfoot_length)) +
    geom_point(data=surveys_complete) +
    geom_point(data=surveys_recent, colour="red") 

## using a conditional in a ggplot aesthetic mapping
ggplot(surveys_complete, mapping=aes(x = weight, y=hindfoot_length)) +
    geom_point(aes(colour = year > 1995))

## Manipulating data framees

## columns - `[]` - `select`
## rows - `[]` - `filter`

## Create new columns

#### mutate

surveys_complete %>% 
    mutate(weight_kg = weight / 1000) #%>%
    #select(record_id, weight, weight_kg)

##### creating more than one column

surveys_complete %>%
    mutate(weight_kg = weight / 1000, 
           weight_lb = weight * 2.2)

surveys_complete %>%
    mutate(weight_kg = weight / 1000) %>%  
    mutate(weight_lb = weight * 2.2)

# Sorting a data frame

## sorting a data table - `arrange`

surveys_recent %>%
    arrange(weight, hindfoot_length, year)

## sort descending 

surveys_recent %>%
    arrange(weight, hindfoot_length, desc(year))

surveys_recent %>%
    arrange(desc(species_id), weight, hindfoot_length, desc(year))

# Summarising data

summary(surveys_recent)

# get the mean of the weight column

meanWeight <- surveys_complete %>% 
    summarise(mean_weight = mean(weight))

meanWeight
meanWeight$mean_weight

mean(surveys_complete$weight)

## get multiple summary statistics in one go

surveys_complete %>% 
    summarise(mean_weight = mean(weight),
              median_weight = median(weight),
              mean_hindfoot_length = mean(hindfoot_length))

## counting the frequency of entry

surveys_complete %>%
    count(sex)

### count the frequency across multiple columns

surveys_complete %>% 
    count(species, sex)

## Challenge

# 1. How many animals in each `plot_type`

surveys_complete %>% 
    count(plot_type)

# 2. How many of species of each sex, order by species by descending frequency

surveys_complete %>% 
    count(sex, species) %>% 
    arrange(species, desc(n))

# Plot of yearly counts of each genus

yearly_counts <- surveys_complete %>% 
    count(year, genus, name = "count")

yearly_counts

## grouping line data

ggplot(data = yearly_counts, 
       mapping = aes(x = year, y = count, group = genus)) +
    geom_line()

### add some colour

ggplot(data = yearly_counts, 
       mapping = aes(x = year, y = count, colour = genus)) +
    geom_line()


# Plot histograms

ggplot(surveys_complete, aes(x = weight)) +
    geom_histogram()

## Grouping of data

surveys_complete %>% 
    filter(sex=="M") %>%
    summarise(mean_weight=mean(weight))

surveys_complete %>% 
    filter(sex=="F") %>%
    summarise(mean_weight=mean(weight))

#### `group_by`

surveys_complete %>% 
    group_by(sex) %>% 
    summarise(mean_weight = mean(weight))

#### `group_by` multiple columns

surveys_complete %>% 
    group_by(species_id, sex) %>% 
    summarise(mean_weight = mean(weight),
              mean_hindfoot_length=mean(hindfoot_length))

## Challenge

## 1. Use `group_by` and `summarise` to find summary statistics for each species

surveys_complete %>% 
    count(species_id)

surveys_complete %>% 
    group_by(species_id) %>% 
    summarise(count = n())



surveys_complete %>%
    group_by(species_id) %>% 
    summarise(
        mean_hindfoot_length = mean(hindfoot_length),
        min_hindfoot_length = min(hindfoot_length),
        max_hindfoot_length = max(hindfoot_length),
        count = n()
    )

# Find the heaviest animal in each year?

surveys_complete %>% 
    group_by(year) %>%
    filter(weight == max(weight))

surveys_complete %>% 
    select(year, species_id, weight) %>% 
    group_by(year) %>% 
    mutate(max_weight = max(weight)) %>%
    filter(weight==max_weight)

surveys_complete %>% 
    group_by(year) %>%
    filter(weight == max(weight)) %>% 
    select(year, genus, species, weight) %>% 
    arrange(year)

## Extra challenge

### See what happens if you use `mutate` instead of `summarise` after `group_by`
### Can you use this to calculate for each animal the ratio of it's weight to 
### the mean for it's genus

surveys_complete %>%
    select(genus, weight) %>% 
    group_by(genus) %>% 
    mutate(mean_weight = mean(weight)) %>%
    mutate(Ratio = weight / mean_weight)

## Further Visualisation - Facetting

# time line of weight
ggplot(data = yearly_counts, aes(x = year, y = count)) +
    geom_line(aes(colour = genus)) +
    facet_wrap(facets = vars(genus))

# adjust the scales to the data in each facet

ggplot(data = yearly_counts, aes(x = year, y = count)) +
    geom_line(aes(colour = genus)) +
    facet_wrap(facets = vars(genus), scale = "free")


ggplot(data = yearly_counts, aes(x = year, y = count)) +
    geom_line(aes(colour = genus)) +
    facet_wrap(facets = vars(genus), scale = "free_y")

# adjust the number of columns

ggplot(data = yearly_counts, aes(x = year, y = count)) +
    geom_line(aes(colour = genus)) +
    facet_wrap(facets = vars(genus), ncol = 2)

# `facet_grid`

yearly_counts <- surveys_complete %>% 
    count(year, genus, sex, name = "count")
yearly_counts

ggplot(data = yearly_counts, aes(x = year, y = count)) +
    geom_line(aes(colour = genus)) +
    facet_grid(cols=vars(sex), rows = vars(genus))

# Customising the colour scale

goodPlot <- ggplot(surveys_complete, mapping=aes(x = weight, y=hindfoot_length)) +
    geom_point(aes(colour = year > 1995, shape = year > 1995)) +
    scale_colour_manual(values = c("black", "red"))
ggsave("My_plot.png", plot = goodPlot)

# Writing data out to a file

## reading in file: `read_csv`


write_csv(surveys_complete, "data_output/surveys_complete.csv")
write_tsv(surveys_complete, "data_output/surveys_complete.txt")






