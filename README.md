# aggregate_columns
A function to aggregate multiple columns with repeating name / numeric index

df = character input name of a dataframe
col_name = character column name (e.g. if the data frame has columns Day1, Day2, Day3, etc. the input would be 'Day')
col_range = numeric vector of columns (to achieve a column Day12, and Day123 write 1:3)
