gs_url<-"https://scholar.google.com/scholar?hl=en&as_sdt=7%2C26&q=political+parties&btnG="
pg1<-gs_url%>%
  read_html()%>%
  html_nodes(".gs_ri a , .gs_a , .gs_rt") %>%
  html_text()
pg1

text = c()

for(i in 0:5){
  gs_url<-paste0("https://scholar.google.com/scholar?start=", i*10 ,"&q=political+parties&hl=en&as_sdt=7,26")
  print(gs_url)
  page<-gs_url%>%
    read_html()%>%
    html_nodes(".gs_ri a , .gs_a , .gs_rt") %>%
    html_text()
  text<-append(text, page)
}

titles=c()
citations=c()

for(i in 1:(length(text)-1)){
  if(str_detect(text[i], "\\[BOOK\\]") || str_detect(text[i], "\\[CITATION\\]") || str_detect(text[i], "\\[PDF\\]") ||(text[i]==text[i+1] && text[i+1]!="")){
    titles<-append(titles, text[i+1])
  }
  else if(str_detect(text[i], "Cited")){
    num<-substr(text[i], start=10, stop=100)
    citations<-append(citations,num)
  }
}

titles
citations<-strtoi(citations)
text

log.citations<-log(strtoi(citations), base=10)
log.citations

df2<-data.frame(titles, log.citations)
str(df2)

ggplot(data=df2, mapping=aes(x=titles, y=log.citations))+
  geom_bar(stat="identity")+
  xlab("Article")+
  ylab("log_10(Citations)")+
  coord_flip()+
  theme(axis.text.x=element_text(angle=90, hjust=-1))
