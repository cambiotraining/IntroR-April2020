######################################
# Day 1 Script
# Date:  20 April 2020
#####################################

#Comments in are


###VARIABLES
weight_kg <- 55 #weight in kilograms
weight_g <- weight_kg * 1000 # transform weight into grams
weight_kg <- 57.5 # assigned a new value to weight_kg
weight_g <- weight_kg * 1000

####CHALLENGE
mass <- 47.5            # mass?
age  <- 122             # age?
mass <- mass * 2.0      # mass?
age  <- age - 20        # age?
mass_index <- mass/age  # mass_index?

####FUNCTIONS
round(3.142)
round(x=3.142, digits=0) #function round using named arguments
round(3.142, 0) #function round without using named arguments

#round a number by 2 decimal places
p <- round(x=3.142, digits=2) #this the the best way
round(2, 3.142) #wrong way 
round(digits=2, x=3.142)

round(x=3.142, digits=1)

temperature <- 36.864
temperature <- round(x=temperature, digits=1)


#####VECTORS
weight_g <- c(50,60,65,82) #created a weight in grams list (integer vector)

animals <- c("mouse", "rat", "dog") #create a vector of character values

length(weight_g) # get the length of weight_g
length(animals) # get the length of animals

str(weight_g)
str(animals)  #get the structure of the vector

# add another element at the end of a vector:
weight_g <- c(weight_g, 90)
# add another element at the beginning of a vector:
weight_g <- c(30, weight_g)

####CHALLENGE
height_mm <- c(100, 150, 99, 87)
sum(height_mm)
height_mm <- c(220, height_mm)
total_height <- sum(height_mm)

### VECTOR INDECES
weight_g <- c(21, 34, 39, 54, 55)
weight_g[2] # give me the value of the second index of my vector
weight_g[c(3,1)] #give me the value of the 3rd and 1st index of my vector
weight_g[c(3,3,1,4,1,1,1,1,1)]

weight_g[c(TRUE, FALSE, TRUE, FALSE, FALSE)] # extraction of values by using logic(boolean) TRUE/FALSE

#extract items that are less than 50
weight_g[weight_g < 50] #this gives the actual values back
# this is just the conidition/logical operation to apply on each item
# of my vector
weight_g < 50

#extract items that are greater than 30
weight_g[weight_g > 30]
#extract items that are greater than 30 AND less than 50
weight_g[weight_g > 30 & weight_g < 50]
#extract items that are greater than 30 OR less than 50
weight_g[weight_g > 30 | weight_g < 50]


animals <- c("mouse", "rat", "dog", "cat")
#check if I have a cat or a rat in my vector
animals[animals=="cat" | animals=="rat"] 
#check if I have a cow in my vector
animals[animals=="cow"]

#%in%
#check if cow is present in animals vector
animals[animals %in% "cow"]
#check if rat, cat dog, duck, goat are present in animals
animals[animals %in% c("rat", "cat", "dog", "duck", "goat")]

# Missing values/data

heights <- c(2, 4, 4, NA, 6) # In Excel - #N/A
heights

# get the mean with a missing value
mean(heights)

# get the max with a missing value
max(heights)

# get a mean ignoring the missing value
mean(heights, na.rm = TRUE)

# get a max ignoring the missing value
max(heights, na.rm = TRUE)

# remove missing values from a vector
is.na(heights)
heights[!is.na(heights)]

# na.omit
na.omit(heights)

# complete.cases

complete.cases(heights)

# challenge

heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 
             63, 63, NA, 72, 65, 64, 70, 63, 65)
heights

# 1. create a new vector with no missing values

heights_no_na <- heights[!is.na(heights)]
heights_no_na

heights_no_na <- na.omit(heights)
heights_no_na

heights_no_na <- heights[complete.cases(heights)]
heights_no_na

# 2. Find the median

median(heights)
?median
median(heights, na.rm=TRUE)
median(heights_no_na)

# 3. Find how many are taller than 67

heights > 67

heights_no_na > 67

length(heights)

length(heights[heights > 67])

length(heights_no_na[heights_no_na>67])

