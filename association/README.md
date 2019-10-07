#Market Basket Analysis
Association rules using Apriori Algorithm

	1.apriori.r is on random data
	2.aprioridb.r is on Georgia cafe sales records

Steps:-

1.Load the reuiqred libraries
	xlsx
	arules

2.Convert the values into 0 and 1
	:-0 indicating absence while 1 indicating presence

3.Convert dataframe into transactions

4.apply apriori algorithm on transaction dataframe with appropirate support and condidence

5.Prune redundant rules
	Rules are redundnat if and only if any subset of antecedent yield conseuqent with same or more confidence.
 
