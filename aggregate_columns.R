# dependencies

library(dplyr)
library(lazyeval)

#' aggregate_columns.R
#' aggregator function for multiple columns with repeating name / numeric index
#'
#' @param df dataframe as character
#' @param col_name colname prefix
#' @param col_range number of columns with prefix to use
#' @param formula formula to apply to selected dataframe columns
#'
#' @return dataframe returned with additional columns prefixed with aggregated columns
#' @export
#'
#' @examples
#' md <- data.frame(Day1=1,Day2=4,Day3=2)
#' agg_cols('md','Day',1:3)
#' agg_cols('md','Day',1:3,'~a * b')
agg_cols <- function(df,col_name,col_range,formula = '~ a + b'){
  
  mydf <- get(df)
  
  rangeCols <- col_range
  col1 <- paste0(col_name,rangeCols[1])
  col2 <- paste0(col_name,rangeCols[2])
  
  f <- function(col1, col2, new_col_name) {
    mutater <- lazyeval::interp(as.formula(formula), a = as.name(col1), b = as.name(col2))
    mydf %>% mutate_(.dots = setNames(list(mutater), new_col_name))
  }
  
  for(i in rangeCols[-length(rangeCols)]){
  new_col <- paste0(col_name,gsub(col_name,'',col1),gsub(col_name,'',col2))
  mydf <- f(col1,col2,new_col)
  col1 <- new_col
  col2 <- paste0(col_name,i+2)
  }
  
  mydf
}

