# Starting with Data - tabular data

dir.create("data")
download.file(url="https://ndownloader.figshare.com/files/2292169",
              destfile = "data/portal_data_joined.csv")

# Reading data in from a file

surveys <- read.csv("data/portal_data_joined.csv")

heights <- c(1, 2, 3, 4, 5, 2,3 ,3, 43, 43, 56, 89, 100, 4)
head(heights)

head(surveys)
View(surveys)

# Dataframe

## Structure of the data frame
str(surveys)

## The size of our data frame

dim(surveys)
dim(surveys)[1]

nrow(surveys)
ncol(surveys)

## Content

head(surveys)
head(surveys, n = 20)

tail(surveys)

## Names

colnames(surveys)
rownames(surveys)

## Summary

str(surveys)
summary(surveys)

# Challenge

str(surveys)
class(surveys)
class(heights)
class(TRUE)

# Indexing or subsetting a data.frame

## numeric indexing - [row, column]
heights[4:6]

surveys[2, 3]
surveys[2, 4]

surveys[, 1]
surveys[1, ]

surveys[1:3, ]

surveys[1:3, 7]

surveys[1:6, ]

### omitting rows/columns

-7:10
-(7:10)

surveys[1:3, -(7:10)]

## Name indexing

### in the square brackets
surveys[, "species_id"]

### using $
surveys$species_id

### mulitple columns with names
surveys[1:5, c("species_id", "sex")]

## Logical indexing

surveys_abl <- surveys[surveys$species == "albigula", ]

dim(surveys)
dim(surveys_abl)

surveys_abl <- surveys[surveys$weight > 50, ]
nrow(surveys_abl)

## Challenge

### 1. a data frame with only row 200

surveys_200 <- surveys[200, ]
surveys_200

## 2. nrow

nrow(surveys)
tail(surveys)
last_row <- surveys[nrow(surveys), ]
last_row

# 3. middle row
### build up the code
nrow(surveys) # number of rows in table
nrow(surveys) / 2 # middle row index
surveys[nrow(surveys) / 2, ]  # middle row
surveys_middle <- surveys[nrow(surveys) / 2, ] # assign to a new variable

# 4. reproduce `head` using `nrow`

head(surveys)
surveys[-(7:nrow(surveys)), ]

################################################

surveys[ ,"year"]
surveys$year

surveys[, c("species_id", "year")]
surveys$c("species_id", "year")

surveys[1:3 ,"year"]
surveys$year[1:3]

################################################

## complete.cases

weight <- c(2, 3, NA, 6, 7)
weight[complete.cases(weight)]

ccSurveys <- complete.cases(surveys)
class(ccSurveys)
length(ccSurveys)
surveys_complet <- surveys[complete.cases(surveys), ]
dim(surveys_complet)

###############################################

## Factors

sex <- c("male", "male", "female", "female", "male", "female")
class(sex)
sex

sex.f <- factor(sex)
class(sex.f)
sex.f

levels(sex.f)

sex.f <- factor(sex, levels = c("male", "female"))
sex.f

sex.f <- c(sex.f, "male")
sex.f

### converting factors
sex.f <- factor(sex)
sex.c <- as.character(sex.f)
class(sex)
class(sex.f)
class(sex.c)

##### with numbers

year_fct <- factor(c(1990, 1983, 1977, 1990, 1998))
year_fct

as.character(year_fct)
as.numeric(year_fct)

as.numeric(as.character(year_fct))

## plotting

plot(surveys$sex)
sex <- surveys$sex
levels(sex)

levels(sex)[1] <- "missing"
sex

plot(sex)

## factors when reading data

surveys2 <- read.csv("data/portal_data_joined.csv",
                     stringsAsFactors = FALSE)
class(surveys$sex)
class(surveys2$sex)

str(surveys2)

surveys2$sex <- factor(surveys2$sex)
class(surveys2$sex)
