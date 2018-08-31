library(xlsx)
library(arules)
df = read.xlsx(file.choose(),1,header = T)
##check whether there are null values
  colSums(is.na(df))

df = df[,!apply(is.na(df),2,all)]
backup =df
##head observations
  head(df)

##data types of colums
  str(df)
##convert it into 0 and 1
  ##convert it into true and false and then 0 and 1
  df = apply(df,c(1,2),as.logical)
  df = apply(df,c(1,2),as.numeric)
  df

##convert xlsx into transactions
  dftrans = as(df[,-1],"transactions")
  inspect(dftrans)

##apriori 
  rules1 = apriori(dftrans,parameter = list(support= 20/148,confidence=0.5));inspect(rules1)
  ##sort by lift ration
  rules1.sorted = sort(rules1, by ="lift");inspect(rules1.sorted)  

##excluding subsets
  ##check whether there are subsets
  subset1=is.subset(rules1.sorted)
  subset1
  ##make lower triangle as false
  subset1[lower.tri(subset1, diag=T)] <-FALSE
  subset1
  ##if sumofcol is >=1 then it is a subset of other,redundnt rules
  redundant=colSums(subset1)>=1
  redundant
        ##code from 54-59 can be rewritten as 
        ##is.redundant(rules1.sorted)
  ##see which rules are redundant
  which(redundant)
  ##from rules exclude which are redunttant i.e which are subset of another
  rules1.pruned=rules1.sorted[!redundant]
  inspect(rules1.pruned)  
  