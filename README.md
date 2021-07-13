# Companion Material

## About this Webpage 
On this website, you can find the statistical companion material for the paper *Virtual Assistants in the Family Home. Understanding Parents’ Motivations to Use Virtual Assistants with Their Child(dren)*. The main research aim of this study was *to disentangle (1) different types of families with (2) different motivations for (3) different forms of VA-usage (i.e., parent only VA-use, VA-co-use, child independent VA-use)*. 

## Analyses
In what follows, you can find an overview of the main analysis steps with respective R code. 

Please note:

1: The full R script can be found on [OSF](https://osf.io/629b7/?view_only=1cd5e3d4d5ab49e782da6f14de972b0c). 

2: The data set used for the analyses was named 'rosie'.

### Data Cleaning
We started by filtering out variables that belonged to the joint research project not of interest for Rosie specifically.
```R

   rosie_dataset <- data[,-c(4:16, 42:54, 56:67, 69:80, 109:120, 138:149, 157:168, 199:291, 294:305, 307:309, 313:325, 328:329)]
   
```
We proceeded by filtering for valid responses from families with at least one child between 3-8 years (e.g., failed attention check = unvalid).
```R

   #filtering responses for Rosie target group (in total: 371 responses, completes: 305)
   library(dplyr)
   rosie_dataset_renamed_families_complete <- dplyr::filter(rosie_dataset_renamed, Child_Nr != 1 & STATUS == 1)
```
Then, we recoded certain (values of) variables to pepare for subsequent analyses.
```R
   #recoding values of/variables FoPersU, SHL, and ICU to prepare for subsequent analyses

      #Frequency of personal use - FoPersU (GA_Freq_8-11)
      #Here, we computed the mean for each participant on their answers to the frequency of smart speaker usage to get an indicator for their previous experience 
      #(the higher this value the higher the FoPersU; scale from 1-6)
      library(fame)
      rosie_dataset_renamed_families_complete$FoPersU <- rowMeans(rosie_dataset_renamed_families_complete[, 38:41], na.rm = T)
      is.numeric(rosie_dataset_renamed_families_complete$FoPersU)
      #View(rosie_dataset_renamed_families_complete)


      #Smart-Household-Level - SHL (IoT_Usage_8 - 24) 
      #Here, we counted the number of smart-devices each family owns, so the number of selected items (the higher the number the higher the SHL)
      rosie_dataset_renamed_families_complete[, 11:27] <- sapply(rosie_dataset_renamed_families_complete[, 11:27], as.numeric)
      rosie_dataset_renamed_families_complete$SHL <- rosie_dataset_renamed_families_complete$IoT_Usage_8+
        rosie_dataset_renamed_families_complete$IoT_Usage_9+
        rosie_dataset_renamed_families_complete$IoT_Usage_10+
        rosie_dataset_renamed_families_complete$IoT_Usage_11+
        rosie_dataset_renamed_families_complete$IoT_Usage_12+
        rosie_dataset_renamed_families_complete$IoT_Usage_13+
        rosie_dataset_renamed_families_complete$IoT_Usage_14+
        rosie_dataset_renamed_families_complete$IoT_Usage_15+
        rosie_dataset_renamed_families_complete$IoT_Usage_16+
        rosie_dataset_renamed_families_complete$IoT_Usage_17+
        rosie_dataset_renamed_families_complete$IoT_Usage_18+
        rosie_dataset_renamed_families_complete$IoT_Usage_19+
        rosie_dataset_renamed_families_complete$IoT_Usage_20+
        rosie_dataset_renamed_families_complete$IoT_Usage_21+
        rosie_dataset_renamed_families_complete$IoT_Usage_22+
        rosie_dataset_renamed_families_complete$IoT_Usage_23+
        rosie_dataset_renamed_families_complete$IoT_Usage_24
      is.numeric(rosie_dataset_renamed_families_complete$SHL)
      # View(rosie_dataset_renamed_families_complete)

      #Use Intention
      #We asked as our DV how the families assume their usage to look like in the near future (TAM_UI_1 myself, TAM_UI_2 with my child, TAM_UI_3 child      individually)
      #We also asked how the families' usage has looked like until now (SS_cousage_1: samen met uw kind smart speaker without display, SS_cousage_2: samen met uw kind smart speaker with display, SS_childusage_1: uw kind zelfstandig without display, SS_childusage_2: uw kind zelfstandig with display)

      #Here, we computed the mean for each participant on their answers to the four questions 
      #(we only need to know the level of co-usage and individual child usage, and not whether this was with a smart speaker with or without display) 
      #(the higher the score the stronger the usage; scale from 1-6)

      #SS_cousage_1 & 2  
      rosie_dataset_renamed_families_complete$UI_togetherwithchild <- rowMeans(rosie_dataset_renamed_families_complete[, 71:72], na.rm = T)
      is.numeric(rosie_dataset_renamed_families_complete$UI_togetherwithchild)
      rosie_dataset_renamed_families_complete$UI_togetherwithchild
      # View(rosie_dataset_renamed_families_complete)

      #SS_childusage_1 & 2
      rosie_dataset_renamed_families_complete$UI_childindividually <- rowMeans(rosie_dataset_renamed_families_complete[, 73:74], na.rm = T)
      is.numeric(rosie_dataset_renamed_families_complete$UI_childindividually)
      rosie_dataset_renamed_families_complete$UI_childindividually
      # View(rosie_dataset_renamed_families_complete)

      #Based on this information we can also calculate how many parents have used the virtual assistant only by themselves and 
      #neither together with their child nor having let their child use it independently
      rosie_dataset_renamed_families_complete$current_usage <- ifelse(rosie_dataset_renamed_families_complete$UI_togetherwithchild == 1 &
                                                                        rosie_dataset_renamed_families_complete$UI_childindividually == 1, 1, 2)
      #1 = parent only
      #2 = with child
       
    #restarting dataset naming
   rosie <- rosie_dataset_renamed_families_complete
   
```


### Missingness
Then, we proceeded with identifying any missingness in the dataset.
```R
  
  #Where are missing values?
   summary(rosie) 
   #there seems to be one NA in UI_childindividually => this is row 74 (in R) = pp 888, this was due to a fault in the survey programming

   #plotting the missing values for variables relevant for LCA 
   names(rosie)
   rosie_LCArelevant <- rosie[,-c(1:58, 71:75, 81:105, 113, 115, 119:120, 123:124)] 
   # View(rosie_LCArelevant)
   library(VIM)
   aggr(rosie_LCArelevant)
   missingness_LCA <- aggr(rosie_LCArelevant)
   missingness_LCA 
   summary(missingness_LCA)
   # >> no missingness

   #plotting the missing values for variables relevant for SEM later to identify their pattern
   rosie_SEMrelevant <- rosie[,-c(1:84, 104:125)]
   #View(rosie_SEMrelevant)
   library(VIM)
   aggr(rosie_SEMrelevant)
   missingness_SEM <- aggr(rosie_SEMrelevant)
   missingness_SEM
   summary(missingness_SEM)
   #>> no missingness
  
  ```

### Measurement Validity
We checked for measurment validity of all existing multi-item scales (i.e., *Technology Trust, Internet Literacy, Child Temperament, Child Parasocial Attachment, Parental Media-Mediation Style, TAM-Perceived Ease of Use, TAM-Perceived Usefulness, TAM-Enjoyment, TAM-Subjective Norm*) by performing Confirmatory Factor Analysis and by calculating Cronbach's alpha. 

```R

 #package for CFA
  library(lavaan)
  
```
 #### Descriptives and Confirmatory Factor Analysis (CFA) for all model variables built up of two or more items
The following code shown for the variable *Internet Literacy* serves as an example. This code was applied to the remaining milti-item scale DSMM-variables with adjustements made depending on whether outliers were found or not and whether the factor structure was confirmed or not.
  ```R
  
       ### IL >> 5 items #########################      

         #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
         #visually
         boxplot(rosie$IL_1)
         boxplot(rosie$IL_2) 
         boxplot(rosie$IL_3)
         boxplot(rosie$IL_4) 
         boxplot(rosie$IL_5) 
         hist(rosie$IL_1) 
         hist(rosie$IL_2) 
         hist(rosie$IL_3) 
         hist(rosie$IL_4) 
         hist(rosie$IL_5) 
         densityplot(rosie$IL_1)
         densityplot(rosie$IL_2)
         densityplot(rosie$IL_3)
         densityplot(rosie$IL_4)
         densityplot(rosie$IL_5)

         #numerically 
         #standardize a variable and count the number of cases with values greater or less than 3
         standardized_IL <- scale(rosie[,c(105:109)]) 
         outliers_IL <- colSums(abs(standardized_IL)>=3, na.rm = T) 
         outliers_IL

         Where are those outliers exactly? In what rows?
         library(outliers)
         outlier_scores_IL_1  <- scores(rosie$IL_1 )
         is_outlier_IL_1  <- outlier_scores_IL_1  > 3 | outlier_scores_IL_1  < -3
         #add a column with info whether the refund_value is an outlier
         rosie$is_outlier_IL_1  <- is_outlier_IL_1 
         #look at plot
         library(ggplot2)
         ggplot(rosie, aes(IL_1 )) +
           geom_boxplot() +
           coord_flip() +
           facet_wrap(~is_outlier_IL_1 )
         #create a dataframe with only outliers
         outlier_IL_1_df <- rosie[outlier_scores_IL_1  > 3| outlier_scores_IL_1  < -3, ]
         #take a peek
         head(outlier_IL_1_df) # >> outliers lay in observations 50, 74, 92

         #Step 1: correlations
         #The function cor specifies the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
         round(cor(rosie[,105:109]),2) 

         #Step 2: variance-covariance matrix
         round(cov(rosie[,105:109]),2) 

         #Step 3: one-factor CFA
         #one factor three items, default marker method
         m1i  <- ' f  =~ IL_1 + IL_2 + IL_3 + IL_4 + IL_5'
         onefac5items_IL <- cfa(m1i, data=rosie,std.lv=TRUE) 
         summary(onefac5items_IL,fit.measures=TRUE, standardized=TRUE)
       
         modindices(onefac5items_IL, sort=T) #IL_1 ~~ IL_3 
         # so, to check whether there is actually a different underlying factor structure in this scale, we run an EFA

         library(psych)
         library(GPArotation)

         #creating a subset with the variables relevant for this EFA
         IL <- c("IL_1", "IL_2", "IL_3", "IL_4", "IL_5")
         IL
         IL_EFA_df <- rosie[IL]
         # View(IL_EFA_df)

         #parallel analysis to get number of factors
         parallel2 <- fa.parallel(IL_EFA_df, fm = 'minres', fa = 'fa') #suggests indeed 2 factors

         #factor analysis for rotation (first using oblique rotation to check whether factors correlate with each other)
         IL_2factors <- fa(IL_EFA_df,nfactors = 2,rotate = 'oblimin',fm='minres') #and indeed, factors seem to correlate with each other, so oblique rotation is better here
         IL_2factors
         print(IL_2factors)

         #determine cut-off value of loadings .3
         print(IL_2factors$loadings,cutoff = 0.3)

         #look at it visually
         fa.diagram(IL_2factors)


         #naming factors
         # >> Factor 1 holding items 2, 4, and 5 => navigation
         # >> Factor 2 holding items 1 and 3 => information

         #now that we identified 2 factors, we confirm this through a 2-factor CFA again

         #Step 3 revised: two-factor CFA
         #two factors with one time 3 and one time 2 items, default marker method
         m2i  <- ' navigation  =~ IL_2 + IL_4 + IL_5 
                                         information =~ IL_1 + IL_3' 
         twofac5items_IL <- cfa(m2i, data=rosie, std.lv=TRUE) 
         summary(twofac5items_IL, fit.measures=TRUE, standardized=TRUE) 
 
  ```    
      
  #### Extracting factor scores
  
  ```R
  
          #predicting factor scores of all CFA models
            onefac3items_TTfitPredict <- as.data.frame(predict(onefac3items_TT))
            twofac5items_ILfitPredict <- as.data.frame(predict(twofac5items_IL))
            twofac5items_Child_ParasocialfitPredict <- as.data.frame(predict(twofac5items_Child_Parasocial))
            threefac2items_PMMSfitPredict <- as.data.frame(predict(threefac2items_PMMS)) 
            onefac4items_TAM_PeoUfitPredict <- as.data.frame(predict(onefac4items_TAM_PEoU))
            onefac4items_TAM_PUfitPredict <- as.data.frame(predict(onefac4items_TAM_PU))
            onefac4items_TAM_EfitPredict <- as.data.frame(predict(onefac4items_TAM_E))
            onefac3items_TAM_SIfitPredict <- as.data.frame(predict(onefac3items_TAM_SI))

            #adding to rosie-dataset
            rosie_fscores <- cbind(rosie, onefac3items_TTfitPredict, twofac5items_ILfitPredict, twofac5items_Child_ParasocialfitPredict,
                                   threefac2items_PMMSfitPredict, onefac4items_TAM_PeoUfitPredict, onefac4items_TAM_PUfitPredict,  onefac4items_TAM_EfitPredict,
                                   onefac3items_TAM_SIfitPredict) 
                         
            #removing unnecessary added variables from descriptives (from outliers)
            rosie_fscores <- rosie_fscores[,-c(126:134)]

 ```
        
    
  #### Calculating Cronbach's Alpha
  
  ```R
         #DSMM-Dispositional: 

            #TT >> 3 items
            TT <- rosie[, c(110:112)]
            psych::alpha(TT)

            #IL >> 5 items
            IL <- rosie[, c(105:109)]
            psych::alpha(IL) 

            #Child_Parasocial >> 5 items
            Child_Parasocial <- rosie[, c(76:80)]
            psych::alpha(Child_Parasocial) 

         #DSMM-Developmental: NONE

         #DSMM-Social: 

            #PMMS >> 6 items 
            PMMS <- rosie[, c(65:70)]
            psych::alpha(PMMS) 


         #TAM: 

            #TAM_PEoU >> 4
            TAM_PEoU <- rosie[, c(85:88)]
            psych::alpha(TAM_PEoU) 

            #TAM_PU >> 4
            TAM_PU <- rosie[, c(89:92)]
            psych::alpha(TAM_PU) 

            #TAM_E >> 4
            TAM_E <- rosie[, c(93:96)]
            psych::alpha(TAM_E)

            #TAM_SI >> 3
            TAM_SI <- rosie[, c(98:100)]
            psych::alpha(TAM_SI) 

 
 ```
 
### More descriptives
Once we evaluated measurement validity, we computed additional descriptive statistics to describe our sample and to provide necessary information (i.e., correlation matrix) for replication attempts.

```R

#packages for descriptives
  library(pastecs)
  library(psych)

   #get percentages of social classes
   source("http://pcwww.liv.ac.uk/~william/R/crosstab.r")
   crosstab(rosie_fscores, row.vars = "SOCIALEKLASSE2016", type = "row.pct")

   #checking household numbers
   crosstab(rosie_fscores, row.vars = "PERSONEN", type = "row.pct")
      # >> This is concerning, there should not be a household with only 1 person
  
   #assign all 1s in the variable PERSONEN to the 2s because there cannot be a 1-person household for a parent+young child (mistake by survey company/participants)
   rosie_fscores$PERSONEN[rosie_fscores$PERSONEN == 1] <- 2
   #check if this worked
   crosstab(rosie_fscores, row.vars = "PERSONEN", type = "f")
   crosstab(rosie_fscores, row.vars = "PERSONEN", type = "row.pct")

   crosstab(rosie_fscores, row.vars = "Child_Nr", type = "row.pct")

   #check for potential ceiling effect on DV-levels
   describe(rosie_fscores$TAM_UI_1)
   hist(rosie_fscores$TAM_UI_1)

   describe(rosie_fscores$TAM_UI_2)
   hist(rosie_fscores$TAM_UI_2)
   densityplot(rosie_fscores$TAM_UI_2)

   describe(rosie_fscores$TAM_UI_3)
   hist(rosie_fscores$TAM_UI_3)
   densityplot(rosie_fscores$TAM_UI_3)
   ##>> no reason to believe in a ceiling effect
   

   #getting correlations matrix for TAM-variables
   require(Hmisc)
   x <- as.matrix(rosie_fscores[,c(134:136, 97, 137, 101:103)])
   correlation_matrix<-rcorr(x, type="pearson")
   R <- correlation_matrix$r 
   R
   p <- correlation_matrix$P
   p

   #pairwise correlations all in one scatterplot matrix
   library(car)
   scatterplotMatrix(~TAM_PEoU_f+TAM_PU_f+TAM_E_f+TAM_SS+TAM_SI_f+TAM_UI_1+TAM_UI_2+TAM_UI_3, data = rosie_fscores)

   #for better visual overview 
   library(devtools)
   #devtools::install_github("laresbernardo/lares")
   library(lares)

   corr_cross(rosie_fscores[,c(134:136, 97, 137, 101:103)], 
              max_pvalue = 0.05, 
              top = 20 
   )

 ```

### Preregistered Analyses
The following section shows the code used to perform our preregistered analyses, i.e., Latent Class Analysis and Structural Modelling.

#### Latent Class Analysis: Individual differences (along first proposition of DSMM)

The poLCA package required categorical indicators, which is why we converted all continuous variables into categorical ones. This facilitated interpretation of classes.
   
##### How to meaningfully categorize?

###### Dispositional variables: 
```R
      # GSL >> as.factor
      rosie_fscores$PGender_f <- as.factor(rosie_fscores$GSL)
      # SOCIALEKLASSE2016 >> as.factor
      rosie_fscores$SES_f <- as.factor(rosie_fscores$SOCIALEKLASSE2016)
      # TT >> 3 items >> median split method because of conceptual understanding of the scale
      # IL >> 5 items (information + navigation) >> median split method because conceptual understanding of the scale
      # FoPersU >> convert into irregular vs. regular (based on '2-3 times a month' answer option as the cut-off)
      # Child_Gender > as.factor
      rosie_fscores$CGender_f <- as.factor(rosie_fscores$Child_Gender)
      # Child_Temp (Extraversion, Negative_Affectivity, Effortful_Control) >> scale ranged from -3 over 0 to +3, so since conceptually everything < 0 is a more or less clear "no", we categorize this way: ≤ 3 = 1, ≥ 4 = 2 
      # Child_Parasocial >> 5 items two factors (anthropomorphism & parasocial_relationship) >> median split method because conceptual understanding of the scale
 ```
###### Developmental variables:
```R
      # LFT >> mean-split
      # Child_Age >> age group "pre-schoolers 3-5 years, age group "schoolkids" 6-8 years, which means 1-3 = 1 and 4-6 = 2
 ```
###### Social variables: 
```R
      # PMMS >> 6 items (restsMed & negacMed & posacMed) >> modal split method because of conceptual understanding of the scale
      # current usage >> already categorical (from data cleaning)
      rosie_fscores$current_usage_f <- as.factor(rosie_fscores$current_usage)
      # household composition >> built up of Child_Nr and PERSONEN >> convert both items into factors
      rosie_fscores$Child_Nr_f <- as.factor(rosie_fscores$Child_Nr)
      rosie_fscores$HS_f <- as.factor(rosie_fscores$PERSONEN)
      # smart-household-level >> median split method because of conceptual understanding of the scale (sticking with number of devices instead of frequency)
 ```
###### Categorization applied:
```R
      # - TT
      #original scale using average sum scores
      library(fame)
      rosie_fscores$TT_avgsum <- rowMeans(rosie_fscores[, c(110:112)], na.rm = T)
      is.numeric(rosie_fscores$TT_avgsum)
      # View(rosie_fscores$TT_avgsum)

      #median split method
      rosie_fscores$TT_LCAcategory_orig[rosie_fscores$TT_avgsum<=median(rosie_fscores$TT_avgsum)] = 1
      rosie_fscores$TT_LCAcategory_orig[rosie_fscores$TT_avgsum>median(rosie_fscores$TT_avgsum)] = 2
      rosie_fscores$TT_f <- as.factor(rosie_fscores$TT_LCAcategory_orig)


      # - IL
      #original scale using average sum scores
      #navigation (items 2 + 4 + 5)
      library(fame)
      rosie_fscores$IL_navigation_avgsum <- rowMeans(rosie_fscores[, c(106, 108:109)], na.rm = T)
      is.numeric(rosie_fscores$IL_navigation_avgsum)
      # View(rosie_fscores$IL_navigation_avgsum)

      #median split method !!! Note: Since items were formulated negatively, lower scores indicate higher literacy, so numbers for categories are switched
      rosie_fscores$IL_navigation_LCAcategory_orig[rosie_fscores$IL_navigation_avgsum<=median(rosie_fscores$IL_navigation_avgsum)] = 2
      rosie_fscores$IL_navigation_LCAcategory_orig[rosie_fscores$IL_navigation_avgsum>median(rosie_fscores$IL_navigation_avgsum)] = 1
      rosie_fscores$IL_nav_f <- as.factor(rosie_fscores$IL_navigation_LCAcategory_orig)


      #information (items 1 + 3)
      rosie_fscores$IL_information_avgsum <- rowMeans(rosie_fscores[, c(105, 107)], na.rm = T)
      is.numeric(rosie_fscores$IL_information_avgsum)
      # View(rosie_fscores$IL_information_avgsum)

      #median split method !!! Note: Since items were formulated negatively, lower scores indicate higher literacy, so numbers for categories are switched
      rosie_fscores$IL_information_LCAcategory_orig[rosie_fscores$IL_information_avgsum<=median(rosie_fscores$IL_information_avgsum)] = 2
      rosie_fscores$IL_information_LCAcategory_orig[rosie_fscores$IL_information_avgsum>median(rosie_fscores$IL_information_avgsum)] = 1
      rosie_fscores$IL_info_f <- as.factor(rosie_fscores$IL_information_LCAcategory_orig)


      # - FoPersU
      rosie_fscores$FoPersU_f_LCA[rosie_fscores$FoPersU<=2] = 1
      rosie_fscores$FoPersU_f_LCA[rosie_fscores$FoPersU>2] = 2
      rosie_fscores$FoPersU_f <-  as.factor(rosie_fscores$FoPersU_f_LCA)

      # - Child_Temp
      rosie_fscores$Temp_Extraversion_f[rosie_fscores$Child_Temp_Extraversion<=3] = 1
      rosie_fscores$Temp_Extraversion_f[rosie_fscores$Child_Temp_Extraversion>=4] = 2
      rosie_fscores$Temp_Ex_f <- as.factor(rosie_fscores$Temp_Extraversion_f)

      rosie_fscores$Temp_Negative_Affectivity_f[rosie_fscores$Child_Temp_Negative_Affectivity<=3] = 1
      rosie_fscores$Temp_Negative_Affectivity_f[rosie_fscores$Child_Temp_Negative_Affectivity>=4] = 2
      rosie_fscores$Temp_NegAf_f <- as.factor(rosie_fscores$Temp_Negative_Affectivity_f)

      rosie_fscores$Temp_Effortful_Control_f[rosie_fscores$Child_Temp_Effortful_Control<=3] = 1
      rosie_fscores$Temp_Effortful_Control_f[rosie_fscores$Child_Temp_Effortful_Control>=4] = 2
      rosie_fscores$Temp_EfCon_f <- as.factor(rosie_fscores$Temp_Effortful_Control_f)


      # - Child_Parasocial
      #original scale using average sum scores
      #anthropomorphism (items 1 + 4 + 5)
      library(fame)
      rosie_fscores$Child_Parasocial_anthropomorphism_avgsum <- rowMeans(rosie_fscores[, c(76, 79:80)], na.rm = T)
      is.numeric(rosie_fscores$Child_Parasocial_anthropomorphism_avgsum)
      # View(rosie_fscores$Child_Parasocial_anthropomorphism_avgsum)

      #median split method
      rosie_fscores$Child_Parasocial_anthropomorphism_LCAcategory_orig[rosie_fscores$Child_Parasocial_anthropomorphism_avgsum<=median(rosie_fscores$Child_Parasocial_anthropomorphism_avgsum)] = 1
      rosie_fscores$Child_Parasocial_anthropomorphism_LCAcategory_orig[rosie_fscores$Child_Parasocial_anthropomorphism_avgsum>median(rosie_fscores$Child_Parasocial_anthropomorphism_avgsum)] = 2
      rosie_fscores$Child_Parasocial_anthro_f <- as.factor(rosie_fscores$Child_Parasocial_anthropomorphism_LCAcategory_orig)


      #parasocial relationship (items 2 + 3)
      rosie_fscores$Child_Parasocial_pararela_avgsum <- rowMeans(rosie_fscores[, c(77:78)], na.rm = T)
      is.numeric(rosie_fscores$Child_Parasocial_pararela_avgsum)
      # View(rosie_fscores$Child_Parasocial_pararela_avgsum)

      #median split method
      rosie_fscores$Child_Parasocial_pararela_LCAcategory_orig[rosie_fscores$Child_Parasocial_pararela_avgsum<=median(rosie_fscores$Child_Parasocial_pararela_avgsum)] = 1
      rosie_fscores$Child_Parasocial_pararela_LCAcategory_orig[rosie_fscores$Child_Parasocial_pararela_avgsum>median(rosie_fscores$Child_Parasocial_pararela_avgsum)] = 2
      rosie_fscores$Child_Parasocial_pararela_f <- as.factor(rosie_fscores$Child_Parasocial_pararela_LCAcategory_orig)


      # - LFT
      rosie_fscores$LFT_f[rosie_fscores$LFT<=mean(rosie$LFT)] = 1
      rosie_fscores$LFT_f[rosie_fscores$LFT>mean(rosie$LFT)] = 2
      rosie_fscores$PAge_f <- as.factor(rosie_fscores$LFT_f)


      # - Child_Age
      rosie_fscores$Child_Age_f[rosie_fscores$Child_Age<=3] = 1 
      rosie_fscores$Child_Age_f[rosie_fscores$Child_Age>=4] = 2
      rosie_fscores$CAge_f <- as.factor(rosie_fscores$Child_Age_f)


      # - PMMS
      #creating mode function
      getmode <- function(v) {
        uniqv <- unique(v)
        uniqv[which.max(tabulate(match(v, uniqv)))]
      }

      #create the vector with numbers
      v <- rosie_fscores

      #original scale using average sum scores ≤ 2 = 1 (nooit), > 2 & < 4 = 2 (soms), == 4 = 3 (vaak)
      #restrMed (items 1+2)
      library(fame)
      rosie_fscores$PMMS_restrMed_avgsum <- rowMeans(rosie_fscores[, c(65:66)], na.rm = T)
      is.numeric(rosie_fscores$PMMS_restrMed_avgsum)
      # View(rosie_fscores$PMMS_restrMed_avgsum)

      #modal split method
      rosie_fscores$PMMS_restrMed_LCAcategory_orig[rosie_fscores$PMMS_restrMed_avgsum<=getmode(rosie_fscores$PMMS_restrMed_avgsum)] = 1
      rosie_fscores$PMMS_restrMed_LCAcategory_orig[rosie_fscores$PMMS_restrMed_avgsum>getmode(rosie_fscores$PMMS_restrMed_avgsum)] = 2
      rosie_fscores$PMMS_restrMed_f <- as.factor(rosie_fscores$PMMS_restrMed_LCAcategory_orig)


      #negacMed (items 3+5)
      rosie_fscores$PMMS_negacMed_avgsum <- rowMeans(rosie_fscores[, c(67, 69)], na.rm = T)
      is.numeric(rosie_fscores$PMMS_negacMed_avgsum)
      # View(rosie_fscores$PMMS_negacMed_avgsum)

      #modal split method
      rosie_fscores$PMMS_negacMed_LCAcategory_orig[rosie_fscores$PMMS_negacMed_avgsum<=getmode(rosie_fscores$PMMS_negacMed_avgsum)] = 1
      rosie_fscores$PMMS_negacMed_LCAcategory_orig[rosie_fscores$PMMS_negacMed_avgsum>getmode(rosie_fscores$PMMS_negacMed_avgsum)] = 2
      rosie_fscores$PMMS_negacMed_f <- as.factor(rosie_fscores$PMMS_negacMed_LCAcategory_orig)


      #posacMed (items 4+6)
      rosie_fscores$PMMS_posacMed_avgsum <- rowMeans(rosie_fscores[, c(68, 70)], na.rm = T)
      is.numeric(rosie_fscores$PMMS_posacMed_avgsum)
      # View(rosie_fscores$PMMS_posacMed_avgsum)

      #modal split method
      rosie_fscores$PMMS_posacMed_LCAcategory_orig[rosie_fscores$PMMS_posacMed_avgsum<=getmode(rosie_fscores$PMMS_posacMed_avgsum)] = 1
      rosie_fscores$PMMS_posacMed_LCAcategory_orig[rosie_fscores$PMMS_posacMed_avgsum>getmode(rosie_fscores$PMMS_posacMed_avgsum)] = 2
      rosie_fscores$PMMS_posacMed_f <- as.factor(rosie_fscores$PMMS_posacMed_LCAcategory_orig)


      # - smart-household-level
      rosie_fscores$SHL_f[rosie_fscores$SHL<=median(rosie_fscores$SHL)] = 1
      rosie_fscores$SHL_f[rosie_fscores$SHL>median(rosie_fscores$SHL)] = 2
      rosie_fscores$smHouse_f <- as.factor(rosie_fscores$SHL_f)


      #check if all new factors are included in the dataset
      View(rosie_fscores)
      names(rosie_fscores)


      #removing unnecessary added variables from categorization pocedure 
      rosie_fscores <- rosie_fscores[,-c(145, 147, 150, 161, 164, 171, 174, 177)]
      View(rosie_fscores)
      names(rosie_fscores)
 ```
##### Running the LCA

```R

   library(poLCA) 
   LCAmodel <- cbind(PGender_f,
                     SES_f,
                     CGender_f,
                     current_usage_f,
                     Child_Nr_f,
                     HS_f,
                     TT_f,
                     IL_nav_f,
                     IL_info_f,
                     FoPersU_f,
                     Temp_Ex_f,
                     Temp_NegAf_f,
                     Temp_EfCon_f,
                     Child_Parasocial_anthro_f,
                     Child_Parasocial_pararela_f,
                     PAge_f,
                     CAge_f,
                     PMMS_restrMed_f,
                     PMMS_negacMed_f,
                     PMMS_posacMed_f,
                     smHouse_f)~1


   set.seed(123)
   LCAmodel2 <- poLCA(LCAmodel, data=rosie_fscores, nclass=2, maxiter = 1000, nrep = 10, graphs=TRUE, na.rm=TRUE)

   set.seed(123)
   LCAmodel3 <- poLCA(LCAmodel, data=rosie_fscores, nclass=3, maxiter = 1000, nrep = 10, graphs=TRUE, na.rm=TRUE)

   set.seed(123)
   LCAmodel4 <- poLCA(LCAmodel, data=rosie_fscores, nclass=4, maxiter = 1000, nrep = 10, graphs=TRUE, na.rm=TRUE)

   set.seed(123)
   LCAmodel5 <- poLCA(LCAmodel, data=rosie_fscores, nclass=5, maxiter = 1000, nrep = 10, graphs=TRUE, na.rm=TRUE)

   set.seed(123)
   LCAmodel6 <- poLCA(LCAmodel, data=rosie_fscores, nclass=6, maxiter = 1000, nrep = 10, graphs=TRUE, na.rm=TRUE) 

   set.seed(123)
   LCAmodel7 <- poLCA(LCAmodel, data=rosie_fscores, nclass=7, maxiter = 1000, nrep = 10, graphs=TRUE, na.rm=TRUE) 

 
```

##### Evaluating and interpreting the LCA result

###### Visualization
```R

   # https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6015948/pdf/atm-06-07-119.pdf (for visualizations)

   # getting fit indices in a table
   summary(LCAmodel3)

   tab.modfit<-data.frame(matrix(rep(999,6),nrow=1))
   names(tab.modfit)<-c("log-likelihood",
                        "resid. df","BIC",
                        "aBIC","cAIC","likelihood-ratio")

   tab.modfit

   set.seed(123)
   for(i in 2:6){
     tab.modfit<-rbind(tab.modfit,
                       c(get(paste("LCAmodel",i,sep=""))$llik,
                         get(paste("LCAmodel",i,sep=""))$resid.df,
                         get(paste("LCAmodel",i,sep=""))$bic,
                         (-2*get(paste("LCAmodel",i,sep=""))$llik) +
                           ((log((get(paste("LCAmodel",i,sep=""))$N + 2)/24)) *  
                              get(paste("LCAmodel",i,sep=""))$npar),
                         (-2*get(paste("LCAmodel",i,sep=""))$llik) +
                           get(paste("LCAmodel",i,sep=""))$npar *
                           (1 + log(get(paste("LCAmodel",i,sep=""))$N)),
                         get(paste("LCAmodel",i,sep=""))$Gsq
                       ))
   }
   tab.modfit<-round(tab.modfit[-1,],2)
   tab.modfit$Nclass<-2:6


   tab.modfit
 
   
   # visualize fit indices per LCA model 
   # convert table into long format
   library("forcats")
   tab.modfit$Nclass <-as.factor(tab.modfit$Nclass)
   tab.modfit
   results2<-tidyr::gather(tab.modfit,label,value,2:6)
   results2

   # pass long-format table on to ggplot
   library(ggplot2)
   fit.plot<-ggplot(results2) +
     geom_point(aes(x=Nclass,y=value),size=1) +
     geom_line(aes(Nclass, value, group = 1)) +
     theme_bw()+
     labs(x = "Number of classes", y="Index values", title = "") +
     facet_grid(label ~. ,scales = "free") +
     theme_bw(base_size = 8, base_family = "") +
     theme(panel.grid.major.x = element_blank() ,
           panel.grid.major.y = element_line(colour="grey",
                                             size=0.3),
           legend.title = element_text(size = 8, face = 'bold'),
           axis.text = element_text(size = 8),
           axis.title = element_text(size = 8),
           legend.text= element_text(size=8),
           axis.line = element_line(colour = "black"))
   fit.plot
         
         
   # taking closer look at each model solution by looking at the class probabilities (https://statistics.ohlsen-web.de/latent-class-analysis-polca/)
   library(ggplot2)

   #4-class model
   lcmodel4 <- reshape2::melt(LCAmodel4$probs, level=2)
   zp3 <- ggplot(lcmodel4,aes(x = L2, y = value, fill = as.factor(Var2)))
   zp3 <- zp3 + geom_bar(stat = "identity", position = "stack")
   zp3 <- zp3 + facet_grid(Var1 ~ .) 
   zp3 <- zp3 + scale_fill_brewer(type="seq", palette="Greys") +theme_bw()
   zp3 <- zp3 + labs(x = "LCA Indicators",y="Class probability", fill ="Categories")
   zp3 <- zp3 + theme( axis.text.y=element_blank(),
                       axis.text.x=element_text(angle=90, vjust=1, hjust=0.2),
                       axis.ticks.y=element_blank(),                    
                       panel.grid.major.y=element_blank())
   zp3 <- zp3 + guides(fill = guide_legend(reverse=TRUE))
   print(zp3)

```
###### Extracting LCA-4-class solution
   
```R
   #extract 4-class solution and save in fourclass object (https://osf.io/vec6s/)
   library(poLCA)
   set.seed(123)
   fourclass=poLCA(LCAmodel, data=rosie_fscores, nclass=4, maxiter = 1000, nrep = 10, graphs=TRUE, na.rm=TRUE)

   #output predicted classes from selected model so that we can use it in subsequent analyses:
   rosie_fscores$fam_class4=fourclass$predclass

   #View(rosie_fscores)

   rosie_fscores$fam_class4 <- as.factor(rosie_fscores$fam_class4)
```
###### Recoding 4-class-solution variables into dummies for subsequent SEM
   
```R
   rosie_fscores$fam_class4_1 <- ifelse(rosie_fscores$fam_class4 == "1", 1, 0) 
   rosie_fscores$fam_class4_2 <- ifelse(rosie_fscores$fam_class4 == "2", 1, 0)
   rosie_fscores$fam_class4_3 <- ifelse(rosie_fscores$fam_class4 == "3", 1, 0) 
   rosie_fscores$fam_class4_4 <- ifelse(rosie_fscores$fam_class4 == "4", 1, 0) 

   rosie_fscores$fam_class4_1 <- as.factor(rosie_fscores$fam_class4_1)   
   rosie_fscores$fam_class4_2 <- as.factor(rosie_fscores$fam_class4_2)
   rosie_fscores$fam_class4_3 <- as.factor(rosie_fscores$fam_class4_3)
   rosie_fscores$fam_class4_4 <- as.factor(rosie_fscores$fam_class4_4)

   View(rosie_fscores)
```          
###### MANOVA to test for significant differences between classes

```R
   rosie_fscores$PGender_num <- as.numeric(rosie_fscores$PGender_f)
   rosie_fscores$SES_num <- as.numeric(rosie_fscores$SES_f)

   Y <- cbind(rosie_fscores$PGender_num,rosie_fscores$SES_num,rosie_fscores$TT_avgsum, rosie_fscores$IL_information_avgsum, rosie_fscores$IL_navigation_avgsum, rosie_fscores$FoPersU, rosie_fscores$CGender_num, rosie_fscores$Child_Temp_Extraversion, rosie_fscores$Child_Temp_Negative_Affectivity, 
              rosie_fscores$Child_Temp_Effortful_Control, rosie_fscores$Child_Parasocial_anthropomorphism_avgsum, rosie_fscores$Child_Parasocial_pararela_avgsum, rosie_fscores$LFT, rosie_fscores$Child_Age, rosie_fscores$PMMS_restrMed_avgsum, 
              rosie_fscores$PMMS_negacMed_avgsum, rosie_fscores$PMMS_posacMed_avgsum, rosie_fscores$current_usage, rosie_fscores$Child_Nr, rosie_fscores$PERSONEN, rosie_fscores$SHL)
   Y <- as.matrix(Y)
   fit <- manova(Y ~ rosie_fscores$fam_class4)
   summary(fit, test="Pillai")
   summary.aov(fit)

```
#### Structural Equation Modelling: Technology acceptance (along TAM + U&G)

```R

   #check multivariate normality
   library(QuantPsyc)
   #for rosie dataset including extracted factor scores of SEM variables
   mult.norm(rosie_fscores[c(85:103)])$mult.test 


  #install.packages("lavaan", dependencies = T)
  library(lavaan)
      
 
   # Testing final structural model (see detailed R script for separate test of measurement model, improvement, and step-wise structural-model modifications)

      #first, we need to set the dummy coded family classes as numeric to be able to put it in our SEM
      rosie_fscores$fam_class4_1_num <- as.numeric(rosie_fscores$fam_class4_1)
      rosie_fscores$fam_class4_2_num <- as.numeric(rosie_fscores$fam_class4_2)
      rosie_fscores$fam_class4_3_num <- as.numeric(rosie_fscores$fam_class4_3)
      rosie_fscores$fam_class4_4_num <- as.numeric(rosie_fscores$fam_class4_4)


      #then, we perform the SEM with the dummy/treatment coded family type variables: type 1 as reference level  
      rosiesTAM_3DVs_fam_class4_1 <- '

            #measurement model
              PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_3 + TAM_PEoU_4 
              PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
              E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 
              SI =~ 1*TAM_SI_1 + TAM_SI_2 
            #regressions
              PEoU ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num
              PU ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num + PEoU
              E ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num
              TAM_SS ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num
              SI ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num
              TAM_UI_1 ~ PEoU + PU + E + TAM_SS + SI
              TAM_UI_2 ~ PEoU + PU + E + TAM_SS + SI
              TAM_UI_3 ~ PEoU + PU + E + TAM_SS + SI
            #residual variances
              TAM_PEoU_1 ~~ TAM_PEoU_1
              TAM_PEoU_3 ~~ TAM_PEoU_3
              TAM_PEoU_4 ~~ TAM_PEoU_4
              TAM_PU_1 ~~ TAM_PU_1
              TAM_PU_2 ~~ TAM_PU_2
              TAM_PU_3 ~~ TAM_PU_3
              TAM_PU_4 ~~ TAM_PU_4
              TAM_E_1 ~~ TAM_E_1
              TAM_E_2 ~~ TAM_E_2
              TAM_E_3 ~~ TAM_E_3
              TAM_SI_1 ~~ TAM_SI_1
              TAM_SI_2 ~~ TAM_SI_2
              TAM_UI_1 ~~ TAM_UI_1
              TAM_UI_2 ~~ TAM_UI_2
              TAM_UI_3 ~~ TAM_UI_3
              TAM_SS ~~ TAM_SS
              PEoU ~~ PEoU
              PU ~~ PU
              E ~~ E
              SI ~~ SI
              fam_class4_2_num ~~ fam_class4_2_num
              fam_class4_3_num ~~ fam_class4_3_num
              fam_class4_4_num ~~ fam_class4_4_num
            '

      #fit the model
      rosiesTAM_3DVs_fam_class4_1_fit <- lavaan(rosiesTAM_3DVs_fam_class4_1, data = rosie_fscores) 

      #print summary
      summary(rosiesTAM_3DVs_fam_class4_1_fit, standardized = T, fit.measures = T)
          
    
```

### Exploratyory Analyses
The following section shows the code used to perform further exploratory analyses.

#### How do the family types directly relate to our DVs?

```R
   #MANOVA 

   Z <- cbind(rosie_fscores$TAM_UI_1,rosie_fscores$TAM_UI_2,rosie_fscores$TAM_UI_3)
   Z <- as.matrix(Z)
   fit_DVs <- manova(Z ~ rosie_fscores$fam_class4)
   summary(fit_DVs, test="Pillai")
   summary.aov(fit_DVs)

```

#### How does TAM+U&G framework unfold separately without the family typology?

```R
   #SEM
   
   rosiesTAM_only <- '

         #measurement model
           PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
           PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
           E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
           SI =~ 1*TAM_SI_1 + TAM_SI_2 + TAM_SI_3
         #regressions
           PU ~ PEoU + E
           E ~  PEoU
           TAM_SS ~ SI
           SI ~ PU
           TAM_UI_1 ~ PEoU + PU + E + TAM_SS + SI
           TAM_UI_2 ~ PEoU + PU + E + TAM_SS + SI 
           TAM_UI_3 ~ PEoU + PU + E + TAM_SS + SI 
         #residual variances
           TAM_PEoU_1 ~~ TAM_PEoU_1
           TAM_PEoU_2 ~~ TAM_PEoU_2
           TAM_PEoU_3 ~~ TAM_PEoU_3
           TAM_PEoU_4 ~~ TAM_PEoU_4
           TAM_PU_1 ~~ TAM_PU_1
           TAM_PU_2 ~~ TAM_PU_2
           TAM_PU_3 ~~ TAM_PU_3
           TAM_PU_4 ~~ TAM_PU_4
           TAM_E_1 ~~ TAM_E_1
           TAM_E_2 ~~ TAM_E_2
           TAM_E_3 ~~ TAM_E_3
           TAM_E_4 ~~ TAM_E_4
           TAM_SI_1 ~~ TAM_SI_1
           TAM_SI_2 ~~ TAM_SI_2
           TAM_SI_3 ~~ TAM_SI_3
           TAM_SI_1 ~~ TAM_SI_2
           TAM_UI_1 ~~ TAM_UI_1
           TAM_UI_2 ~~ TAM_UI_2
           TAM_UI_3 ~~ TAM_UI_3
           TAM_UI_2 ~~ TAM_UI_3
           TAM_SS ~~ TAM_SS
           PEoU ~~ PEoU
           PU ~~ PU
           E ~~ E
           SI ~~ SI
           '

   #fit the model
   rosiesTAM_only_fit <- lavaan(rosiesTAM_only, data = rosie_fscores)

   #print summary
   summary(rosiesTAM_only_fit, standardized = T, fit.measures = T)

   #bootstrap model
   rosiesTAM_only_fit_boostrapped_se <- sem(rosiesTAM_only_fit, data = rosie_fscores,se = "bootstrap", bootstrap = 1000)
   summary(rosiesTAM_only_fit_boostrapped_se, fit.measures = TRUE)
   parameterEstimates(rosiesTAM_only_fit_boostrapped_se,
                      se = TRUE, zstat = TRUE, pvalue = TRUE, ci = TRUE,
                      standardized = FALSE,
                      fmi = FALSE, level = 0.95, boot.ci.type = "norm",
                      cov.std = TRUE, fmi.options = list(),
                      rsquare = FALSE,
                      remove.system.eq = TRUE, remove.eq = TRUE,
                      remove.ineq = TRUE, remove.def = FALSE,
                      remove.nonfree = FALSE,
                      add.attributes = FALSE,
                      output = "data.frame", header = FALSE)
                   
```


