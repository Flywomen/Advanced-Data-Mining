# Advanced-Data-Mining
System design from course project IIT CS522

for Evaluation of LSA and LDA

Goal:

 Evaluate the dimensionality reduction techniques LSA and LDA. Use 2 data sets. The first data set is one of the standard research data sets, 20 NewsGroups. The second is the Yelp review data set from the Yelp data Challenge. Compute the LSA and LDA representation for documents from both data sets and evaluate if it help to achieve better performance for clustering

for Hierarchical Dataless Classification

Goal:

1.Extended the dataless classifier approach to extract hierarchical categories from Wikipedia, constructed summary representations for the higher levels of categories.

2.Analyzed if they can be used for hierarchical categorization by applying Explicit Semantic Analysis to derive meaning and build up word vectors for each concept.

Summary:

In the era of Big Data, Data Mining is increasingly becoming an essential technology for business efficiency. I took graduate course Advanced Data Mining for state-of-the-art technology at Illinois Tech. Traditionally, standard text classification schemes rely on supervised training with labeled data. However, people can categorize documents into named categories without any explicit training because the meanings of category names are known. So, I always keep my eye on the dataless classification. In the final project, I worked with 3 graduate students to implement the hierarchical dataless classification based on Wikipedia, which depends on understanding the labels of the categories and requires no labeled data. We first created the hierarchical categories with nodes Biology and Area of Computer Science to get a label tree as part of semantic space. To get the categories, we got 2 sqlfiles (in English Wiki): one for the pages and another for the categories. Both of them were loaded to an SQL DB and were linked together to get the pages in each category. During the process, we found that the Wikipedia had no precise hierarchy. Since a category could belong to different parent categories. This allowed multiple categorizations and sometimes, categories looped around a certain group without an end point or seep into unrelated topics. In fact, it is more like a graph or a cluster. After several attempts, we established a depth limit of 4 to create the hierarchy. We picked 2 categories, Biology and Areas of Computer Science, to train and test on. Then, we got 450000 pages for Biology in total, which was sorted into 14000 subcategories. It used too much memory to store and took too long to process. With the constraints of representativeness, we got a sample of 2000 pages for each topic using Probability Proportional to Size (PPS) Sampling methods. With sampling, we fetched the pages from those selected categories and pre-processed them to get the plain text document. Later, we implemented two representation mapping functions, tf-idf and Doc2Vec, for document conversion to embed both labels and documents into a semantic space and get each category with its vector. Also, we used the same method to build the document vector for potential input documents. The tf-idf converted the whole corpus into a document-term matrix with tf-idf index as its weight. The only tuning parameter was the sampling size. Besides, the Doc2Vec used the CBOW model with document id. The tuning parameters included the size of the sliding window for training the CBOW, and the dimension of the document vector apart from the sampling size. Later, we computed their similarity and outputted the top K labels in the label set as its result hierarchical category. Finally, we computed the accuracy with a top-down traverse method to analyze if this dataless classifier could be used for hierarchy category. For Doc2Vec, the result revealed that the dimension of 100 had the highest accuracy for both categories (Areas of Computer Science was 0.6904 and Biology was 0.5212). For tf-idf, the accuracy of the Areas of Computer Science was 0.7123 and Biology was 0.7287. Our model performed well at the main category, but not that satisfying when it came to the specific subcategory because there were many categories that had 0 representation after sampling. The accuracy was less than prefect confirming the fact that the structure of Wikipedia was messy to begin with because it could be edited by everyone. The Areas of Computer Science had higher accuracy because its original structure was relatively organized. After sampling, the training data contained fewer unrelated topics and was more representative. Whereas, the new document input could be classified to some clear hierarchical categories, which meant our model was fairly well and fit for the hierarchy category. To extend the project, I could use other algorithms like Word2Vec to compare their efficiency. I could also apply the method to data structures other than Wikipedia, for example, 20 Newsgroups or a Yelp dataset that I used in a previous research. I could also run tests with variations of our study, for example, bigger samples or better pruning to make the classification more precise.
