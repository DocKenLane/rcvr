extract_preference <- function(code){
  sub_str <- str_extract(code, "^(.*?)O{1}")
  if(is.na(sub_str)){
    sub_str <- code
  }
  sub_str <- str_replace(sub_str, "O", "")
  
#  sub_str1 <- str_extract(sub_str, "^((.*?)(U)){2}")
#  sub_str1 <- str_extract(sub_str, "^((.*?)(U)){2}")
  sub_str1 <- str_extract(sub_str, "^(.*?)(U){2}")
  if(!is.na(sub_str1)){
    sub_str <- sub_str1
  }
  sub_str
#  sub_str <- str_replace_all(sub_str, "U", "")
#  paste(unique(unlist(str_split(sub_str, ""))),sep="", collapse="")
}