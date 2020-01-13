# Advanced-Data-Mining

Advanced Data Mining: Hierarchical Dataless Classification		       

•	Implemented the hierarchy dataless classification based on English Wikipedia, which depends on understanding the labels of the categories and requires no labels data.

•	Fetched and loaded SQL files for pages and categories to SQL DB, and then created the hierarchical categories to get a label tree as part of the semantic space by setting the depth limit for 4 to avoid the unrelated topics or the loop. 

•	Applied Probability Proportional to Size (PPS) sampling methods to fetch representative pages from selected categories, and then pre-processed them to get the plain text document. 

•	Implemented Doc2Vec and tf-idf as representation mapping functions to convert the documents to get each category with its vector, and then used same method to build the document vector for potential testing documents.

•	Computed their meaningful semantic similarity, outputted the top K in the label set as its result hierarchical category.

•	Calculated the accuracy with a top-down traverse method, getting an accuracy of 0.6904 for the Doc2Vec model (dimension#100), and 0.7287 for the tf-idf model.


高级数据挖掘：层次式无数据分类 （Hierarchical Dataless Classification）			    
•	基于对分类（category）标签（label）的理解，无需具体标签数据实现了英文维基百科的层次无数据分类
•	获取页面（page）和分类的SQL文件并加载到SQL DB中，然后创建层次式类别结构（hierarchical categories）来获得标签树作为语义空间的一部分，设置深度限制为4以拒绝无关话题和循环
•	采用PPS抽样方法从所选分类中获取代表性页面，并对其预处理获得纯文本文档
•	利用Doc2Vec和tf-idf作为文本转换的表征映射函数来获得每个分类（category）及其向量，并用相同的方法来生成测试输入文档的向量
•	计算其语义相似度，输出标签集中最高的K个（Top-K）作为其层次分类（hierarchical category）
•	使用自上而下的遍历方法计算准确度，计算可得Doc2Vec模型(维度#100）准确度为0.6904，tf-idf的模型准确度为0.7287

