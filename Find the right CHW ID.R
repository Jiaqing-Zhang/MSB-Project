library(haven)

original_know<-read_sav("/knowledge data/Participant PRE_FINAL KNOWLEDGE survey_RE.sav")
original_QOL<-read_sav("/quality of life data/MSB_QOL3.sav")
chw_link<-read_sav("/knowledge data/CHW_link.sav")
dim(chw_link)
dim(original_know)
dim(original_QOL)
know_id<-original_know[, c(1, 128)]
colnames(know_id)<-c("MSB", "CHW")
chw_link_id<-chw_link[, c(2, 4)]
colnames(chw_link_id)<-colnames(know_id)


mm<-merge(know_id, chw_link_id, by="MSB")
mm$CHW.x<-as.numeric(mm$CHW.x)
mm$CHW.y<-as.numeric(mm$CHW.y)
mm$find<-mm$CHW.x-mm$CHW.y

#the chw number did not fit each other
not_equal<-mm[c(which(mm$find!=0 | is.na(mm$find))),]
colnames(not_equal)<-c("MSB", "Know_chw", "link_chw", "find")
dim(not_equal)
not_equal

#id in knowledge data but does not in link data
exist_know<-subset(know_id, !(know_id$MSB %in% chw_link_id$MSB))
colnames(exist_know)<-c("MSB", "know_chw")
exist_know
dim(exist_know)
#id in link data but does not in knowledge data
exist_link<-subset(chw_link_id, !(chw_link_id$MSB %in% know_id$MSB))
colnames(exist_link)<-c("MSB", "link_chw")
exist_link
dim(exist_link)