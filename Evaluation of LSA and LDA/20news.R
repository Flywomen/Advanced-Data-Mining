libs <-c("tm","plyr","class","SnowballC","wordcloud","RColorBrewer","topicmodels","ggplot2","e1071","NbClust","cluster") 
lapply(libs,require,character.only=TRUE) 
options(stringsAsFactors=FALSE)
dataset<-c('/Users/ruhuishen/Desktop/522/hw1/20news-18828/alt.atheism', 
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/comp.graphics',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/comp.os.ms-windows.misc',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/comp.sys.ibm.pc.hardware',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/comp.sys.mac.hardware',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/comp.windows.x',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/misc.forsale',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/rec.autos',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/rec.motorcycles',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/rec.sport.baseball',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/rec.sport.hockey',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/sci.crypt',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/sci.electronics',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/sci.med',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/sci.space',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/soc.religion.christian',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/talk.politics.guns',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/talk.politics.mideast',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/talk.politics.misc',
           '/Users/ruhuishen/Desktop/522/hw1/20news-18828/talk.religion.misc ')
cleanCorpus <- function(news){
  news <- tm_map(news,removeWords,stopwords("English")) 
  news <- tm_map(news, removePunctuation)
  news <- tm_map(news, stemDocument)
  news <- tm_map(news, removeWords, "Subject")
  news <- tm_map(news, removeWords, "Organization")
  news <- tm_map(news, removeWords, "Writes")
  news <- tm_map(news, removeWords, "From")
  news <- tm_map(news, removeWords, "Lines")
  news <- tm_map(news, removeWords, "NNTP-Posting-Host") 
  news <- tm_map(news, removeWords, "Article")
  news <- tm_map(news, tolower)
  news <- tm_map(news, removeWords, "line")
  news <- tm_map(news, removeWords, "newsgroup")
  news <- tm_map(news, removeWords, "newsgroups")
  news <- tm_map(news, removeWords, "date")
  news <- tm_map(news, removeWords, "messageid")
  news <- tm_map(news, removeWords, "path")
  news <- tm_map(news, removeWords, "will")
  news <- tm_map(news, removeWords, "articl")
  news <- tm_map(news, removeWords, "know")
  news <- tm_map(news, removeWords, "references")
  news <- tm_map(news, removeWords, "compsysibmpchardwar") 
  news <- tm_map(news,removeWords,stopwords("English")) 
  news <- tm_map(news, removeNumbers)
  news <- tm_map(news, stripWhitespace)
  #news <- tm_map(news , PlainTextDocument)
  return(news)
}
Generate_tdm <- function(dataset) {
  news<-Corpus(DirSource(dataset, recursive=TRUE),readerControl = list(reader=readPlain)) 
  news <- cleanCorpus(news)
  dtm <- DocumentTermMatrix(news,control=list(wordLengths=c(4,Inf)))
  dtms <- removeSparseTerms(dtm, 0.95)
  result <- list(name = dataset, dtm = dtms) }
# Load the data
data <- c("/Users/ruhuishen/Desktop/522/hw1/20news-18828/alt.atheism",
          "/Users/ruhuishen/Desktop/522/hw1/20news-18828/comp.graphics",
          "/Users/ruhuishen/Desktop/522/hw1/20news-18828/comp.os.ms-windows.misc",
          "/Users/ruhuishen/Desktop/522/hw1/20news-18828/misc.forsale",
          "/Users/ruhuishen/Desktop/522/hw1/20news-18828/rec.sport.baseball",
          "/Users/ruhuishen/Desktop/522/hw1/20news-18828/talk.politics.guns")
news <- Corpus(DirSource(data, recursive=TRUE), readerControl =list(reader=readPlain)) 
news
category <- vector("character", length(news))
category[1:1000] <- "alt.atheism"
category[1001:2000] <- "comp.graphics"
category[2001:3000] <- "comp.os.ms-windows.misc"
category[3001:4000] <- "misc.forsale"
category[4001:5000] <- "rec.sport.baseball"
category[5001:6000] <- "talk.politics.guns"


news<-cleanCorpus(news)
#Document Term Matrix
dtm <- DocumentTermMatrix(news,control=list(wordLengths=c(4,Inf)))

# Term Document Matrix
tdm <- TermDocumentMatrix(news,control=list(wordLengths=c(4,Inf)))
inspect(news)

#Using TDM to find frequency of words: 
tdms <- removeSparseTerms(tdm, 0.95) 
m <- as.matrix(tdms)
n <- sort(rowSums(m), decreasing=TRUE) 
o <- data.frame(word = names(n),freq=n) 
head(o, 10)
dtms <- removeSparseTerms(dtm, 0.95) 
rowSum <- apply(dtms,1,sum)
dtms <- dtms[rowSum>0,]############
tfidf <- weightTfIdf(dtms)
#Preparing data to build word cloud:
dms <- as.matrix(dtms)
freq <- sort(colSums(dms),decreasing = TRUE)
dark2 <- brewer.pal(6, "Dark2")
wordcloud(names(freq), freq, max.words=100, rot.per=0.2,colors=dark2)
# Normalization
norm_eucl <- function(tfidf) tfidf/apply(tfidf, MARGIN=1, FUN=function(x) sum(x^2)^.5)

#deal with the NA value
#library(Hmisc)
#impute(tfxidf_norm$ptratio, mean)  # replace with mean

# Cluster with kMeans 
set.seed(123)
tfxidf_norm <- norm_eucl(tfidf) 
#library(Hmisc)
#impute(tfxidf_norm$ptratio, mean)  # replace with mean
#nc <- NbClust(tfxidf_norm, min.nc=2, max.nc=15, method="kmeans")
cl <- kmeans(tfxidf_norm, 6, nstart=25) 
table(cl$cluster)

#install.packages("factoextra")
library("factoextra")
fviz_cluster(cl, data = as.matrix(tfidf), geom = "point", stand = FALSE, frame.type = "norm")


## LSA
#Compute SVD: 
SVD<-function(mat,num){
sv<-svd(mat)
u<-as.matrix(sv$u[,1:num]) 
v<-as.matrix(sv$v[,1:num]) 
d<-as.matrix(diag(sv$d)[1:num,1:num]) 
return(as.matrix(u%*%d%*%t(v),type="blue"))
} 
svd_dtm<-SVD(dtms,5)
# Cluster with kMeans
lsa_cl <- kmeans(norm_eucl(svd_dtm), 6)
lsa_Confm <- table(category, lsa_cl$cluster) 
#Confusion Matrix
lsa_Confm
#SSE
lsa_cl$totss
lsa_cl$tot.withinss 
100-(lsa_cl$tot.withinss/lsa_cl$totss)*100
#Accuracy
(sum(apply(lsa_Confm, 1, max))/sum(lsa_cl$size))*100 
#plot
pr<-prcomp(norm_eucl(svd_dtm))$x
plot( pr,col=lsa_cl$cluster,main='SVD for d=200')
# Find representative words 
num=5 
concept<-function(num){
sv<-sort.list((svd(dtms))$v[,num],decreasing = FALSE) 
dm<-dtms$dimnames$Terms[head(sv,10)]
dm
} 
i<-(1:num)
lapply(i,concept)

# LDA
burnin <- 4000
iter <- 1000
thin <- 500
seed <-list(2003,5,63,100001,765) 
nstart <- 5
best <- TRUE

lda <- LDA(dtms,7, method="Gibbs", control=list(nstart=nstart, seed = seed, best=best, burnin = burnin, iter = iter, thin=thin))
terms(lda,10)
lda_data<-as.data.frame(lda@gamma)
lda_mat<-as.matrix(lda_data) 
rownames(lda_mat)<-1:nrow(lda_mat) 
norm_lda<-norm_eucl(lda_mat)
# Cluster with kMeans
lda_cl <- kmeans(norm_lda, 7)
lda_Confm <- table(category, lda_cl$cluster) 
#Confusion Matrix
lda_Confm
#SSE
lda_cl$totss
lda_cl$tot.withinss 
100-(lda_cl$tot.withinss/lda_cl$totss)*100
#Accuracy
(sum(apply(lda_Confm, 1, max))/sum(lda_cl$size))*100 #plot
pr<-prcomp(norm_lda$x)
plot( pr,col=lda_cl$cluster,main='LSA for k=3')