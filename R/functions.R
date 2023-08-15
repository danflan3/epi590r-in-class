##### Functions Exercise ######

## Create a function for squaring numbers
x <- 4
x^2

square <- function(x) {
	n <- c(x)
	square_val <- n^2
	return(square_val)
}

# Test function -- are the following results equal?
square(53)
53^2

# See what happens if you don't define each argument in the function
squared <- function() {
	x^2
}
squared(7)



## Create a function for raising a number to any power
raise <- function(x, power) {
	a <- c(x)
	b <- power
	raise_val <- a^b
	return(raise_val)
}

raise(x=3, power=7)
3^7

# Louisa's answer -- could simplify function as:
raised <- function(x, power) {
	raise_val <- x^power
	return(raise_val)
}

raised(x=3, power=5)



## Create a function that defaults to square x when power is not specified
raise_2 <- function(x, power = 2) {
	a <- c(x)
	b <- power
	raise_val <- a^b
	return(raise_val)
}

raise_2(x=5)
