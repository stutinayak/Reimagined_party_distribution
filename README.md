# Analyzing and generating political parties #

Dimensionality reduction of the ![Chapel Hill Expert Survey data](https://www.chesdata.eu/2019-chapel-hill-expert-survey) and projecting the political parties in the 2D space. In the "_notebook_" folder you will find two files: (i) The file "party_projections_2.ipynb" can be used to judge the solution. (ii) The file "Redistributing party projections.ipynb" you will find a similar file as specified earlier which has all the print statements and checks the outputs to ensure the code is running correctly (since I do not have any prior experience in writing the unit test). 

## Running Docker Instructions ##

* Build the docker container using the following command:

`docker-compose up -d`

* Run the docker build using the following command (here _party_ is the name of the docker container):

`docker-compose up party`

## Summary of the methods used in the analysis

### Part A ###

#### Part I: Preprocessing the dataset ####
* For preprocessing - the columns with >50% of missing data were dropped as they would not contribute significantly for the projections. The target variable is  was selected as “party_id” as the political parties need to be represented in 2-dimensional space. The 
columns where the description was not clear were also dropped - for e.g. the column “id”. 

* There were some unknown values in the dataset: those values were replaced by mode (most frequent value) in that particular column.

* The column of date of birth was binned in the intervals of 10: the range of values was between 1933 to 1995. 

* The missing data was imputed in the following way:
	1. for categorical data (object or ints), used the most frequent value (mode)

	2.  for continuous values (floats), used the median

Additionally, more complex imputations like k-Nearest Neighbour imputation or Iterative imputation could also be used for preprocessing, but were not explored as dataset was uniformly ordered and was not significantly imbalanced. 

#### Part II: Dimensionality Reduction ####

* For performing dimensionality reduction the data needs to be scaled in a uniform range
* The Principal Component Analysis (PCA) was applied for reducing the dimensionality to a 2D space. 
* For dimensionality reduction t-distributed Stochastic Neighbour Embedding (t-SNE) method was used to create a visualisation, but is not used for density estimation and further analysis as PCA is more widely used technique. For future work tSNE and other state-of-the-art techniques could also be explored for party projections. 

#### Part III: Estimating a probability distribution ####
* For estimating the distribution of the 2D points from dimensionality reduction the probability distributions needs to calculated - which is done using Kernel Density Estimation.
* From the probability distribution 10 samples were extracted and visualized. In order to map these 10 samples back to the original space _”pca.inverse_transform”_ was used.

#### Part IV: 
* In order to paint the valid area in the 2D space according to the bounds of the high-dimensional data - 2D Gaussian Kernel density estimation was painted. According to the graph the innermost kernel is highly dense which means a lot of data points are present in that area. This makes sense since the data was scaled before applying the dimensionality reduction.  

### Part B ###

In order to understand the analysis of the dimensionality reduction better: the features that are of highest importance need to be extracted from the respective principal components. When extracted the two most important feature for the principal components were: *nationalism and deregulation*. So the politicians can build their campaign agenda around these two points. Furthermore, the analysis can be shown to a domain expert who could make a game plan for political party’s future actions, policies etc. 

### Part C ###

For a highly-available, fault-tolerant, and low latency cloud architecture: it is a good practice to decouple your storage layer and compute/analytics components. This is to ensure that failure of one component does not lead to the failure of the whole architecture. For this use-case ![Amazon EMR](https://aws.amazon.com/emr/?whats-new-cards.sort-by=item.additionalFields.postDateTime&whats-new-cards.sort-order=desc) would be a good choice. Please refer to the following sketch that could be a possible workflow. The architecture also has a component of auto-scaling which is cost-effective and helps to automatically manage a large traffic. After the workflow, the security settings and access management should be decided together with the team and the stakeholders.

![Image of Cloud Architecture](https://github.com/stutinayak/Reimagined_party_distribution/blob/master/images/Cloud%20architecture.png)
