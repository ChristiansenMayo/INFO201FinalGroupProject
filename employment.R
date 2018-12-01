data <- read.csv("data/all-ages.csv")
major <- read.csv("data/majors-list.csv")
major_list <- unique(major$Major_Category)
data <- select(data, Major_category, Major, Total, Employed)

employment_rate <- function(category) {
  major_name <- filter(data, data$Major_category == category)
  for (i in nrow(major_name)) {
    return (major_name[i,]$employed / major_name[i,]$Total)
  }
}
