#' Access Demographic & Health Surveys Data
#'
#' Accesses information from the Demographic and Health Surveys, via their API.
#'
#' Information is the same as from the DHS StatCompiler
#' Documentation code for DHS API: \link{http://api.dhsprogram.com/#/index.html}
#' Filter options: \link{http://api.dhsprogram.com/#/api-data.cfm}
#' Country codes: \link{http://dhsprogram.com/data/File-Types-and-Names.cfm#CP_JUMP_10136}
#' Indicator codes: \link{http://api.dhsprogram.com/rest/dhs/indicators?returnFields=IndicatorId,Label,Definition&f=html}
#' @param breakdown one of 'national', 'subnational', 'background', or 'all'
#' @param indicators: list of DHS indicator codes as a string separated by commas *NO SPACES between*, e.g. 'CN_NUTS_C_WH2,CN_NUTS_C_HA2,ED_EDUC_W_SEP'
#' @param countries: list of DHS country names as a string separated by commas with *NO SPACES between*, e.g. 'SN,SL,TG'
#' @param years: list of survey years to include as a string separated by commas, e.g. '2010,2012,2014'
#' @param apiKey: API Key to include, to be able to obtain 5000 records instead of 1000.
#' @param numResults: number of records to include
#'
#' @import dplyr RJSONIO
#'
#' @examples
#' rw_stunting = loadDHS(breakdown = 'national', indicators = 'CN_NUTS_C_HA2', countries = 'RW')
#' @author Laura Hughes

loadDHS = function(breakdown = "national",
                   indicators,
                   countries,
                   years = paste0(seq(1984,
                                      as.numeric(format(Sys.Date(), "%Y"))), collapse = ","), apiKey = NA, numResults = 1000) {

  query = paste0("http://api.dhsprogram.com/rest/dhs/data?breakdown=",
                 breakdown, "&indicatorIds=", paste(indicators, collapse = ','), "&countryIds=", paste(countries, collapse = ','), "&SurveyYear=",
                 years, "&apiKey=", apiKey, "&perpage=", numResults)

  json_file = fromJSON(query)

  # Unlist the JSON file entries
  json_data = lapply(json_file$Data, function(x) {
    unlist(x)
  })

  # Convert JSON input to a data frame
  df = as.data.frame(do.call("rbind", json_data), stringsAsFactors = FALSE)


  # Throw a warning if number of returned results > numResults
  if (json_file$RecordCount > numResults) {
    warning(paste0("query results in ", json_file$RecordCount, " hits; first ", numResults,
                   " returned"))
  }

  # Check that everything are numbers.  grepl('^[[:digit:]]',y$Indicator)

  # Check that it returns a value.
  if (length(df) > 0) {
    # Convert values to numbers.
    df = df %>% mutate(Value = as.numeric(Value),
                              Precision = as.numeric(Precision),
                              SurveyYear = as.numeric(SurveyYear),
                              IsTotal = as.numeric(IsTotal),
                              CILow = as.numeric(CILow),
                              CIHigh = as.numeric(CIHigh))
  }
  return(df)
}