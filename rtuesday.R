
### Question 2
### Phyloseq


Using phyloseq, create a phyloseq object. this will comprise the OTU abundance, taxonomy(provided in the .txt file) and sample data(provided in the .csv file)

```{r}
otuTable <- read.table("otu_table")  #Importing the OTU table
otuTable
```

```{r}
taxaTable <- read.table("taxa_table") #Importing the Taxa table
taxaTable
```


```{r}
dim(otuTable)
```

```{r}
dim(taxaTable)
```

```{r}
class(otuTable)
```

```{r}
class(taxaTable)
```

```{r}
#Converting the Taxa and OTU Table into a Matrix
mtaxaTable <- as.matrix(taxaTable)
motuTable <- as.matrix(otuTable)

class(mtaxaTable)
class(motuTable)
```

```{r}
#Data Cleansing. This is done to have consistent data across all the matrices
#This will involve making sure that the OTU/taxa row names match. Currently they dont as taxa have a trailing ";"

#rownames(mtaxaTable)[rownames(mtaxaTable) == "4333897;"] = "4333897"

head(mtaxaTable, n=1)
tnames <- rownames(mtaxaTable)  #Extract rownames from the matrix
ntnames <- gsub(x = tnames, pattern = ";", replacement = "")  #Remove the ; from the extracted rownames
#ntnames
rownames(mtaxaTable) <- ntnames  #Set the new rownames
head(mtaxaTable, n=1)

```

```{r}
library(phyloseq)
library(ggplot2)

#Tell phyloseq to load them into a phyloseq object
OTU = otu_table(motuTable, taxa_are_rows = TRUE)
TAX = tax_table(mtaxaTable)

#OTU
#TAX

#Generating the phyloseq object
physeq = phyloseq(OTU, TAX)
physeq

#Plotting the phyloseq
plot_bar(physeq, fill = "Family.")
```

### Question 3. 
Generate Alpha diversity plots and ordination plots. Examine any observed patterns by delivery mode, gender and disease status

```{r}

plot_richness(physeq)  #Default plot produced by the plot_richness function

```


##### 3.1. To observe patterns across variables, we need to merge the sample data into the phyloseq object.

```{r}
library(tibble)
s_data <- column_to_rownames(data, var="Sample_ID")
s_data <- sample_data(s_data)
#s_data

mergedPhyseq = merge_phyloseq(physeq, s_data)
mergedPhyseq
```

#### 3.2. Alpha diversity comparison between the gender in cases and control
```{r}
plot_richness(mergedPhyseq, x ="Case_Control", color="Delivery_Route")

```
#### 3.3. Alpha diversity comparison between the Gender and Case Control

```{r}
plot_richness(mergedPhyseq, x ="Case_Control", color="Gender")

```
#### 3.4. Alpha diversity comparison between the Age and Case Control

```{r}
plot_richness(mergedPhyseq, x ="Case_Control", color="Age_at_Collection")

```
