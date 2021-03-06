% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getDHScountry.R
\name{getDHScodes}
\alias{getDHScodes}
\alias{getDHScountry}
\alias{getDHSindicator}
\title{Create a lookup table for DHS country and indicator codes, and find the country/indicator code based on the list}
\usage{
getDHScountry(country_names, return_table = FALSE)

getDHSindicator(indicators, refresh_indicators = FALSE,
  return_table = FALSE)
}
\arguments{
\item{country_names}{string or list of strings of country names}

\item{return_table}{whether to return the codes in a table containing their name and code, or just a collapsed list of the codes}

\item{indicators}{string or list of strings of indicator names (or parts of their names)}

\item{refresh_indicators}{T/F of whether to re-pull the indicator list from the DHS website. Takes a bit of time to execute}
}
\description{
Create a lookup table for DHS country and indicator codes, and find the country/indicator code based on the list
}
\section{Functions}{
\itemize{
\item \code{getDHScountry}: Function to pull the DHS codes for country names.
Can take either a single country or multiple ones; also can return entire table or just the country code
Matching is *exact* matching; input name must exactly match a country name within the DHS dataset.

\item \code{getDHSindicator}: Function to lookup the DHS indicator codes. Partially matches to input indicator; user can select which indicator(s) they want
}}

\examples{
getDHScountry(c('Niger', 'Nigeria', 'Rwanda', 'Zambia'), return_table = FALSE)
getDHScountry(c('Niger', 'Nigeria', 'Rwanda', 'Zambia'), return_table = TRUE)
getDHScountry('Rwanda')
getDHScountry('Nige') # Returns an error.
stunted_indic = getDHSindicator('stunted', return_table = TRUE)
malnourished = getDHSindicator(c('stunted', 'wasted', 'underweight'))
getDHSindicator('studnted') # returns nothing
}
