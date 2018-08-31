colpc= list(c("red","white","green"),c("orange","white"),
            c("white","blue"),c("red","white","orange"),c("red","blue"),
            c("blue","white"),c("orange","white"),c("red","white","blue","green"),
            c("red","white","blue"),c("yellow"))
colpc
library(arules)
##part1##
  # converting list to transactions
  il = as(colpc,"transactions")
  inspect(il)
  image(il)
  summary(il)
  #converting transactions to matrix format
  im = as(il,"matrix")
  im
  
########part2################
  ilables=c("red","white","blue","green","yellow","orange")
  ## converting list to transactions and encoding
  il1 = encode(colpc,ilables)
  inspect(il1)
  image(il1)
  # converting transactions to matrix
  im1=as(il1,"matrix")
  im1
  
## converting transactions to transaction lists
inspect(as(il,"tidLists"))

## converting im1 matrix to binary matrix
  im1
  ## converting columns to numeric values
  imbinary =apply(im1,c(2),as.numeric);imbinary
  ##changng its headers of row and columns
  dimnames(imbinary) = list(c(1:nrow(im1)),ilables);imbinary

##frequent item sets with  support >=0.2
  isets= eclat(il1,parameter = list(support=0.2))
  isets1=inspect(isets)
  ##sorting according to no of items,order gives rank
  isets1=isets1[order(size(isets)),]
  isets1
  
##apripori algorithm
  ##binary matrix,supoort=0.2,confidence=0.7
  rules1 = apriori(imbinary,parameter = list(support= 0.2,confidence=0.7));inspect(rules1)
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
  
  