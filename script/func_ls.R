mean_cal <- function(data, by = "row", is_numeric){
  # check if the user want the col or row
  # data = employee_data; by = "row"
  if (by == "row"){
    result <- apply(data[,is_numeric], 1, mean)
    names(result) <- data$Name
  } else if (by == "column") {
    result <- apply(unname(data[,is_numeric]), 2, mean)
    names(result) <- colnames(data[,is_numeric])
  }
  # return final result
  return(result)
}

row_mean_cal <- function(data, is_numeric){
  # check if the user want the col or row
  # data = employee_data; by = "row"
  # if (by == "row"){
  result <- apply(data[,is_numeric], 1, mean)
  names(result) <- data$Name
  # }
  # return final result
  return(result)
}

col_mean_cal <- function(data, is_numeric){
  # check if the user want the col or row
  # data = employee_data; by = "row"
  result <- apply(unname(data[,is_numeric]), 2, mean)
  names(result) <- colnames(data[,is_numeric])
  # return final result
  return(result)
}


