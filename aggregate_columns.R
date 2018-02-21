# author: daniel hough
# filename: aggregate_columns.R
# date: 2018-02-21

agg_cols <- function(df,col_name,col_range){
  ### aggregator function for multiple columns with repeating name / numeric index
  
  mydf <- get(df)
  
  rangeCols <- col_range
  col1 <- paste0(col_name,rangeCols[1])
  col2 <- paste0(col_name,rangeCols[2])
  
  f <- function(col1, col2, new_col_name) {
    mutater <- lazyeval::interp(~ a + b, a = as.name(col1), b = as.name(col2))
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

# example
md <- data.frame(Day1=1,Day2=4,Day3=2)
agg_cols('md','Day',1:3)

