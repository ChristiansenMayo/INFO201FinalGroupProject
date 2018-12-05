library(ggplot2)
library(dplyr)
data_grad <- read.csv("data/grad-students.csv", stringsAsFactors = FALSE)
data_nongrad <- read.csv("data/all-ages.csv", stringsAsFactors = FALSE)
data_all <- left_join(data_nongrad, data_grad)
data_need <- select(data_all, Major_code, Major, Grad_median, Grad_P25, Grad_P75, Nongrad_median, Nongrad_P25, Nongrad_P75 )
nickFunction(ARCHITECTURE)

nickFunction <- function(major){
data_1 <- filter(data_need, Major==major)
grad_d <- data.frame(
  Students = factor(c("Graduate","Graduate","Graduate","Undergraduate","Undergraduate","Undergraduate")),
  percentage = factor(c("25Median","Median","75Median","25Median","Median","75Median"), levels=c("Median","25Median","75Median")),
  Earnings = c(data_1[1,3], data_1[1,4], data_1[1,5], data_1[1,6], data_1[1,7], data_1[1,8])
)
p <- ggplot(data=grad_d, aes(x=percentage, y=Earnings, fill=Students)) +
  geom_bar(stat="identity", position=position_dodge(), colour="black")+
  geom_text(aes(label=Earnings), vjust=1.6, color="black", size=3.5,check_overlap = FALSE)+
  theme_minimal()
p + labs(title = "Graduates and Non-Graduates earning",subtitle = major)+
theme(plot.title=element_text(size=18, hjust=0.5, face="italic",colour="maroon",vjust=-1))+
theme(plot.subtitle=element_text(size=13, hjust=0.5, face="italic", color="black"))


}
