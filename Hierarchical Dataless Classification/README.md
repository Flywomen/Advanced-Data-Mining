# Advanced-Data-Mining

Advanced Data Mining: Hierarchical Dataless Classification		       

•	Implemented the hierarchy dataless classification based on English Wikipedia, which depends on understanding the labels of the categories and requires no labels data.

•	Fetched and loaded SQL files for pages and categories to SQL DB, and then created the hierarchical categories to get a label tree as part of the semantic space by setting the depth limit for 4 to avoid the unrelated topics or the loop. 

•	Applied Probability Proportional to Size (PPS) sampling methods to fetch representative pages from selected categories, and then pre-processed them to get the plain text document. 

•	Implemented Doc2Vec and tf-idf as representation mapping functions to convert the documents to get each category with its vector, and then used same method to build the document vector for potential testing documents.

•	Computed their meaningful semantic similarity, outputted the top K in the label set as its result hierarchical category.

•	Calculated the accuracy with a top-down traverse method, getting an accuracy of 0.6904 for the Doc2Vec model (dimension#100), and 0.7287 for the tf-idf model.
