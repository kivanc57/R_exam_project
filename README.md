# Indonesia Evaluation Data Analysis

## Aim
The objective of this project is to apply the concepts learned in the DATA1 course, specifically Exploratory Data Analysis (EDA) and Descriptive Data Analysis (DDA), to evaluate and analyze data from Indonesia. Our goal is to conduct a thorough analysis of individual features and the dataset as a whole, providing comprehensive illustrations and descriptions of the process and methodology.

## Solution
This project involves the following steps:

1. **Reading the Data**: The R script reads the entire dataset.
2. **Feature Analysis**: We examine the column names and select two random features to calculate their sum, mean, quartiles, and median. We then visualize these features using boxplots and scatter plots.
3. **Correlation Analysis**: We observe the correlation between various dimensions using Spearman's method and visualize the results with corrgrams.
4. **Logistic Regression**: We analyze the correlation between binary data (Gender) and other features using logistic regression.
5. **Principal Component Analysis (PCA)**: We conduct PCA to reduce dimensionality and visualize the data.
6. **Multidimensional Scaling (MDS)**: We apply MDS to visualize the similarity or dissimilarity between data points.
7. **Clustering**: We perform hierarchical clustering and visualize the dendrogram.

## R Script
```R
data <- read.table("/Users/admin/Desktop/data.txt", header=TRUE, dec=",", sep="\t", row.names=1)
#We do not include the Gender feature since it binary so that we do not complicate the calculations.
my_data <- data[,-8]
colnames(my_data)

sum_1 = summary(my_data$Prambanan)
mean_1 = mean(my_data$Prambanan)
quartiles_1<-quantile(my_data$Prambanan, probs = c(0.25,0.75))
first_quartile <- quartiles_1[1]
# or first_quartile = sum_1[2]
third_quartile <- quartiles_1[2]
# or third_quartile = sum_1[4]
median_1 = median(my_data$Prambanan)
#or median_1 = sum_1[3]
sd_1 = sd(my_data$Prambanan)


sum_2 = summary(my_data$Azul_Beach_Club)
mean_2 = mean(my_data$Azul_Beach_Club)
quartiles_2<-quantile(my_data$Azul_Beach_Club, probs = c(0.25,0.75))
first_quartile_2 <- quartiles_2[1]
third_quartile_2 <- quartiles_2[2]
median_2 = median(my_data$Azul_Beach_Club)
sd_2 = sd(my_data$Azul_Beach_Club)

boxplot(my_data)
#The most favourable place is Gili_Meno_Beach because median is the highest, 6.
#50% of people voted between 8 and 4.
#On the contorary, the least favourable places are Azul_Beach_Club, Prambanan and GiliTrawangan_FreeDive with 2.
# It is relatively obvious for the most of people in case of Prambanan since the scale is from ~1.5 to 4.
#The highest varience is in GiliTrawangan_FreeDive.
#However, for the other places, variance is the highest. Meaning that, there is not a significant agreement among people voted.
#On the other hand, the there is one person that voted "significantly high" that we can see as 10 and 9 in Bali_Safari and Prambanan respectively.
#Those are outliers.
x <- my_data$Prambanan
y <- my_data$Azul_Beach_Club
plot(x, y)


cor ( my_data, method="spearman" )
#I chosed Spearman because it  analyses not only linear but also monotone vector based on rankings.
library(corrgram)
corrgram(my_data)
corrgram(my_data, upper.panel=panel.conf, lower.panel=panel.pie)
#The bigger percent of the coloured pie is, the higher correlation they have.
corrgram(my_data, upper.panel=panel.conf, lower.panel=panel.ellipse)
#The confidence ellipse is more circular when two variables are uncorrelated.
#Correlation efficient is plus if it raises from left to right. Accordingly, if it is negative it descends from left to right.
#Logistic regression: Gender and Prombanan would not have correlation. p-value ≈ 0.682135 so p-value>5%
#Logistic regression: Gender and Azul_Beach_Club have correlation. p-value ≈ 0.005184 so p-value>5%


#We do not need to scale the data because all the entities are in the same scale.
#Latent components are ordered based on the importance/proportion of their variance.
#If we want a 2D graph, the most wise option would be to choose Comp1 and Comp2 with approximately 85% of Cumulative Proportion.
PCA_result <- princomp(my_data)
biplot(PCA_result)
summary(PCA_result)
PCA_result$loadings
#Here we can also realise that the first components have a relations with each of the features.


#we will be using "euclidean" becauase there is almost no outlier and we do not care how different is the distribution of the entities.
distance_matrix <- dist(my_data, method="euclidean")
map <- cmdscale(distance_matrix)
plot(map)
text(map, pos = 4, labels = row.names(my_data))
my_data[2,]
my_data[6,]
my_data[75,]
MDS_gof <- cmdscale(distance_matrix, eig=TRUE)$GOF
MDS_gof
#GOF ≈ 80%. We have almost 80 percent of information used for MDS.
#We see 3 different clusters because of polarisations, including 2 extremes.
#TIP: Look at middle points of clusters to deduce their identity.
#Maybe look at extreme of x and y to identify the osy.

library(plotly)
hc <- hclust(distance_matrix, method="average")
my_dendrogram <- as.dendrogram(hc)
plot(my_dendrogram, horiz=T)
png("/Users/admin/Desktop/my_hc.png", width=10, height=19, units="in", res=600)
plot(my_dendrogram, horiz=T)
dev.off()
```

## Screenshots
### Pie Chart Correlation Graph of Each Feature
![Pie Chart Correlation](/screenshots/correlation1.png?raw=true)

### Ellipse Correlation of Graph Each Feature
![Pie Chart Correlation](/screenshots/correlation2.png?raw=true)

### Logistic Regression Graph of Gender and Prombanan columns
![Regression of Gender/Prombanan](/screenshots/regression1.png?raw=true)

### Logistic Regression Graph of Gender and Azul_Beach_Club columns
![Regression of Gender/Azul_Beach_Club](/screenshots/regression2.png?raw=true)

### Scatterplot Graph of Azul_Beach_Club and Mirror_Bali
![Scatterplot of Azul_Beach_Club/Mirror_Bali](/screenshots/scatterplot.png?raw=true)

## Conclusions
Applying these analytical methods has proven highly beneficial for comprehensive data analysis. We conducted a step-by-step evaluation, starting with individual features and progressing to a holistic view of the dataset. Key statistical indices were identified, and the report culminates in a detailed cluster analysis.

* More comprehensive report is avalable in the project folder within `report.docx`.

## Contact
Let me know if there are any specific details you’d like to adjust or additional sections you want to include!  
* **Email**: kivancgordu@hotmail.com
* **Version**: 1.0.0
* **Date**: 22-06-2024


