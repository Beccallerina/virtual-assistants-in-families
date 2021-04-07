# Companion Material

## About this Webpage 
On this website, you can find the companion material for the paper "Virtual Assistants in Families. A Cross-Sectional Online-Survey Study to Understand Families’ Decisions to Use Virtual Assistants in the Home." This paper reports on the first study conducted as part of project Rosie using the following research question for guidance: *How do individual characteristics of families with young children influence their intention formation to continue using virtual assistants in the family home?*
This website is produced directly from the project’s github repository. 

## About Project Rosie
Project Rosie is set to study in depth how families with young children (aged 3 - 8 years) use and eventually trust virtual assistants installed on smart speakers, like Google Home Nest or Amazon Echo, in their home. 

## Preregistration
[Here](https://osf.io/pmwud/?view_only=aaa1b70f0f75468388c8f50e2fed508f) you can find the anonymous prergistratration plan for the first study of project Rosie looking into families' individual characteristics that potentially influence their decision to use a vitual assistant in their home. Please also see the respective amendment for changes made in the final study compared to the original preregistration. 

## Analyses
In what follows, you can find the analysis steps and essential R code that was used to answer the study's research question. 

### Data Cleaning
We started by filtering valid responses from familiesw ith at least one child between 3-8 years. We proceeded by recoding certain values of/variables to pepare for analyses.
```R

   #filtering valid responses 
   
    rosie_dataset_renamed_families_complete <- dplyr::filter(rosie_dataset_renamed, Child_Gender != 0 & STATUS == 1)
   
   #recoding values of/variables FoPersU, SHL, and ICU to prepare for subsequent analyses
  
    #Frequency of personal use - FoPersU (Q5 GA_Freq) --> relevant for smart speakers are items: GA_Freq_8-11
    #Here, we computed the mean for each participant on their answers to the frequency of smart speaker usage to get an indicator for their previous experience 
    #(the higher this value the higher the FoPersU; scale from 1-6)
    library(fame)
    rosie_dataset_renamed_families_complete$FoPersU <- rowMeans(rosie_dataset_renamed_families_complete[, 36:39], na.rm = T)
    is.numeric(rosie_dataset_renamed_families_complete$FoPersU)
  
    #Smart-Household-Level - SHL (Q6 IoT_Usage_9 - 24) 
    #Here, we counted the number of smart-devices each family owns, so the number of selected items 
    #(the higher the number the higher the SHL)
    rosie_dataset_renamed_families_complete[, 10:25] <- sapply(rosie_dataset_renamed_families_complete[, 10:25], as.numeric)
    rosie_dataset_renamed_families_complete$SHL <- rosie_dataset_renamed_families_complete$IoT_Usage_9+
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
  
    #ICU
    #We asked as our DV how the families assume their usage to look like in the near future (TAM_ICU_1 myself, TAM_ICU_2 with my child, TAM_ICU_3 child individually)
    #We also asked how the families' usage has looked like until now (SS_cousage_1: samen met uw kind smart speaker without display, SS_cousage_2: samen met uw kind smart speaker with display, SS_childusage_1: uw kind zelfstandig without display, SS_childusage_2: uw kind zelfstandig with display)
        
        #Here, we computed the mean for each participant on their answers to the four questions 
        #(we only need to know the level of co-usage and individual child usage, and not whether this was with a smart speaker with or without display) 
        #(the higher the score the stronger the usage; scale from 1-6)
    
        #SS_cousage_1 & 2  
        rosie_dataset_renamed_families_complete$ICU_togetherwithchild <- rowMeans(rosie_dataset_renamed_families_complete[, 68:69], na.rm = T)
        is.numeric(rosie_dataset_renamed_families_complete$ICU_togetherwithchild)
        rosie_dataset_renamed_families_complete$ICU_togetherwithchild
        
        #SS_childusage_1 & 2
        rosie_dataset_renamed_families_complete$ICU_childindividually <- rowMeans(rosie_dataset_renamed_families_complete[, 70:71], na.rm = T)
        is.numeric(rosie_dataset_renamed_families_complete$ICU_childindividually)
        rosie_dataset_renamed_families_complete$ICU_childindividually
        
        #Based on this information we can also calculate how many parents have used the virtual assistant only by themselves and 
        #neither together with their child nor having let their child use it independently
        rosie_dataset_renamed_families_complete$current_usage <- ifelse(rosie_dataset_renamed_families_complete$ICU_togetherwithchild == 1 &
                                                                           rosie_dataset_renamed_families_complete$ICU_childindividually == 1, 1, 2)
        #1 = parent only
        #2 = with child
          
```


### Missingness
Then, we proceeded with identifying any missingness in the dataset.
```R
  
  #Where are missing values?
  complete.cases(rosie)
  summary(rosie)
  options(max.print=1000000)
 
  #plotting the missing values for variables relevant for LCA 
  names(rosie)
  rosie_LCArelevant <- rosie[,-c(2:55, 68:72, 78:100, 109, 116:118)] 
  View(rosie_LCArelevant)
  library(VIM)
  aggr(rosie_LCArelevant)
  missingness_LCA <- aggr(rosie_LCArelevant)
  missingness_LCA 
  summary(missingness_LCA)
  # >> no missingness
  
  #plotting the missing values for variables relevant for SEM later to identify their pattern
  rosie_SEMrelevant <- rosie[,-c(2:81, 101:115)]
  View(rosie_SEMrelevant)
  library(VIM)
  aggr(rosie_SEMrelevant)
  missingness_SEM <- aggr(rosie_SEMrelevant)
  missingness_SEM
  summary(missingness_SEM)
  #only 1 missing value in ICU_childindividually but this does not impact the SEM in any way
  
        #inspecting this row
        rosie[74,] 
        # >> due to an error in the survey system this participant has NAs for SS_childusage 
  ```

### Measurement Validity
We checked for measurment validity of all existing multi-item scales (i.e., *Technology Trust, Internet Literacy, Child Temperament, Child Parasocial Attachment, Parental Media-Mediation Style, TAM-Perceived Ease of Use, TAM-Perceived Usefulness, TAM-Enjoyment, TAM-Subjective Norm*) by performing a Confirmatory Factor Analysis and by calculating Cronbach's alpha. In the following example code is shown for the variable *Internet Literacy*. This code was applied to the remaining variables likewise, always depending on whether outliers were found or not and whether the factor structure was confirmed or not.

```R

 #package for CFA
  library(lavaan)
  
```
 #### Confirmatory Factor Analysis for all model variables built up of two or more items
  
  ```R
  
       #IL >> 5 items
            #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                standardized_IL <- scale(rosie[,c(101:105)]) 
                outliers_IL <- colSums(abs(standardized_IL)>=3, na.rm = T) 
                outliers_IL
                #IL_1 IL_2 IL_3 IL_4 IL_5 
                  #3    2    2    0    0
                  #For IL_1: Where are those outliers exactly? In what rows?
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
                  
                  #For IL_2: Where are those outliers exactly? In what rows?
                  library(outliers)
                  outlier_scores_IL_2 <- scores(rosie$IL_2)
                  is_outlier_IL_2 <- outlier_scores_IL_2 > 3 | outlier_scores_IL_2 < -3
                  #add a column with info whether the refund_value is an outlier
                  rosie$is_outlier_IL_2 <- is_outlier_IL_2
                  #look at plot
                  library(ggplot2)
                  ggplot(rosie, aes(IL_2)) +
                    geom_boxplot() +
                    coord_flip() +
                    facet_wrap(~is_outlier_IL_2)
                  #create a dataframe with only outliers
                  outlier_IL_2_df <- rosie[outlier_scores_IL_2 > 3| outlier_scores_IL_2 < -3, ]
                  #take a peek
                  head(outlier_IL_2_df) # >> outliers lay in observations 7, 74
                  
                  #For IL_3: Where are those outliers exactly? In what rows?
                  library(outliers)
                  outlier_scores_IL_3 <- scores(rosie$IL_3)
                  is_outlier_IL_3 <- outlier_scores_IL_3 > 3 | outlier_scores_IL_3 < -3
                  #add a column with info whether the refund_value is an outlier
                  rosie$is_outlier_IL_3 <- is_outlier_IL_3
                  #look at plot
                  library(ggplot2)
                  ggplot(rosie, aes(IL_3)) +
                    geom_boxplot() +
                    coord_flip() +
                    facet_wrap(~is_outlier_IL_3)
                  #create a dataframe with only outliers
                  outlier_IL_3_df <- rosie[outlier_scores_IL_3 > 3| outlier_scores_IL_3 < -3, ]
                  #take a peek
                  head(outlier_IL_3_df) # >> outliers lay in observations 7, 74
          
          # >> IL_1 = highly positively skewed, fewer returns in its tail than normal (kurtosis), 3 outliers in row 50, 74, 92
          # >> IL_2 = highly positively skewed, fewer returns in its tail than normal (kurtosis), 2 outliers in row 7, 74
          # >> IL_3 = highly positively skewed, fewer returns in its tail than normal (kurtosis), 2 outliers in row 7, 74
          # >> IL_4 = highly positively skewed, fewer returns in its tail than normal (kurtosis), no outliers
          # >> IL_5 = moderately positively skewed, fewer returns in its tail than normal (kurtosis), no outliers
          
          #Step 1: correlations
          round(cor(rosie[,101:105]),2) 
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,101:105]),2) 

          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1i  <- ' f  =~ IL_1 + IL_2 + IL_3 + IL_4 + IL_5'
          onefac5items_IL <- cfa(m1i, data=rosie,std.lv=TRUE) 
          summary(onefac5items_IL,fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .000 NOT > .05, CFI = .957 > 0.95, TLI = .914 > 0.90 and RMSEA = .142 NOT < 0.10 >> NOT SO CONVINCING
        
          modindices(onefac5items_IL, sort=T) #IL_1 ~~ IL_3 >> 19.963
          
            #to check whether there is actually a different underlying factor structure in this scale, we run an EFA
                
            library(psych)
            library(GPArotation)
                
            #creating a subset with the variables relevant for this EFA
            IL <- c("IL_1", "IL_2", "IL_3", "IL_4", "IL_5")
            IL
            IL_EFA_df <- rosie[IL]
                
            #parallel analysis to get number of factors
            parallel2 <- fa.parallel(IL_EFA_df, fm = 'minres', fa = 'fa') #suggests 1 factor, but since the previous model fit and modindices give reason to believe that a one-factor structure is not optimal, 
            #we compare it to a two-factor model
                
            #factor analysis for rotation (first using oblique rotation to check whether factors correlate with each other)
            IL_2factors <- fa(IL_EFA_df,nfactors = 2,rotate = 'oblimin',fm='minres') #and indeed, factors seem to correlate with each other, so oblique rotation is better here
            IL_2factors
            print(IL_2factors)
                
                #determine cut-off value of loadings .3
                print(IL_2factors$loadings,cutoff = 0.3)
                #Loadings:
                #  MR2    MR1   
                #IL_1         0.530   #Items 1 and 3 seem to load together, which is in accordance with the modindices above
                #IL_2  0.589       
                #IL_3         0.983
                #IL_4  0.906       
                #IL_5  0.601       
                
                #                 MR2   MR1
                #SS loadings    1.594 1.330
                #Proportion Var 0.319 0.266
                #Cumulative Var 0.319 0.585
                
                #look at it visually
                fa.diagram(IL_2factors)
                
                # >> The root means the square of residuals (RMSR) is 0. This is acceptable as this value should be closer to 0. 
                # >> The root mean square error of approximation (RMSEA) is 0. This shows good model fit as it is below 0.05. 
                # >> The Tucker-Lewis Index (TLI) is 1.024. This is an acceptable value considering it’s over 0.9.
                
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
                # >> fit index criteria: Chi-Square = .228 > .05, CFI = .996 > 0.95, TLI = .991 > 0.90 and RMSEA = .047 < 0.10 #VERY NICE
   
  ```    
      
  #### Extract factor scores
  
  ```R
  
          #predicting factor scores of all CFAs
                onefac3items_TTfitPredict <- as.data.frame(predict(onefac3items_TT))
                twofac5items_ILfitPredict <- as.data.frame(predict(twofac5items_IL))
                twofac5items_Child_ParasocialfitPredict <- as.data.frame(predict(twofac5items_Child_Parasocial))
                threefac2items_PMMSfitPredict <- as.data.frame(predict(threefac2items_PMMS)) 
                onefac4items_TAM_PeoUfitPredict <- as.data.frame(predict(onefac4items_TAM_PEoU))
                onefac4items_TAM_PUfitPredict <- as.data.frame(predict(onefac4items_TAM_PU))
                onefac4items_TAM_EfitPredict <- as.data.frame(predict(onefac4items_TAM_E))
                onefac3items_TAM_SNfitPredict <- as.data.frame(predict(onefac3items_TAM_SN))
    
          #adding to rosie-dataset
                rosie_fscores <- cbind(rosie, onefac3items_TTfitPredict, twofac5items_ILfitPredict, twofac5items_Child_ParasocialfitPredict,
                                       threefac2items_PMMSfitPredict, onefac4items_TAM_PeoUfitPredict, onefac4items_TAM_PUfitPredict,  onefac4items_TAM_EfitPredict,
                                       onefac3items_TAM_SNfitPredict, onefac3items_TAM_ICUfitPredict)
                                       
 ```
        
    
  #### Cronbach's Alpha
  
  ```R
         #Dispositional: 
          
             TT <- rosie[, c(106:108)]
             psych::alpha(TT) ### --> 0.77

             Child_Parasocial <- rosie[, c(73:77)]
             psych::alpha(Child_Parasocial) ### --> 0.83
                        
             IL <- rosie[, c(101:105)]
             psych::alpha(IL) ### --> 0.86

          #Developmental: NONE
          
          #Social: 
          
             PMMS <- rosie[, c(62:67)]
             psych::alpha(PMMS) ### --> 0.76
  
          #TAM: 
          
             TAM_PEoU <- rosie[, c(82:85)]
             psych::alpha(TAM_PEoU) ### --> 0.87
             
             TAM_PU <- rosie[, c(86:89)]
             psych::alpha(TAM_PU) ### --> 0.92

             TAM_E <- rosie[, c(90:93)]
             psych::alpha(TAM_E) ### --> 0.9

             TAM_SN <- rosie[, c(95:97)]
             psych::alpha(TAM_SN) ### --> 0.87

 
 ```
 
### Descriptives
Once we evaluated measurement validity, we computed descriptive statistics to describe our sample and to provide necessary information (i.e., correlation matrix) for replication attempts.

```R

#packages for descriptives
  library(pastecs)
  library(psych)

   describe(rosie_fscores)
   psych::describeBy(rosie_fscores, group = "GSL")
   # 1 = male, 2 = female

   #getting correlations matrix for TAM-variables
   round(cor(rosie_fscores[,c(139:143, 98:100)]),2)
 
   #pairwise correlations all in one scatterplot matrix
   library(car)
   scatterplotMatrix(~TAM_PEoU_f+TAM_PU_f+TAM_E_f+TAM_SN_f+TAM_IMG+TAM_ICU_f, data = rosie_fscores)
         
   #for better visual overview 
   library(devtools)
   devtools::install_github("laresbernardo/lares")
   library(lares)

         corr_cross(rosie_fscores[,c(139:143)], # name of dataset
                    max_pvalue = 0.05, # display only significant correlations (at 5% level)
                    top = 20 # display top 10 couples of variables (by correlation coefficient)
         )
 ```

### Preregistered Analyses
The following section shows the code used to perform our preregistered analyses, Latent Class Analysis and Structural Modelling.

#### Latent Class Analysis: Individual differencs (along DSMM)

Since LCA using poLCA package only allows categorical indicators, we converted all continuous variables into categorical ones. This way we also facilitate interpretation of classes.
   
##### How to meaningfully categorize?
   
###### Dispositional: 
       * GSL >> already categorical
       * SOCIALEKLASSE2016 >> already categorical
       * TT >> 3 items >> median split method because of conceptual understanding of the scale
       * IL >> 5 items (information + navigation) >> median split method because conceptual understanding of the scale
       * FoPersU >> convert into irregular vs. regular (based on weekly answer option as the cut-off)
       * Child_Gender > already categorical
       * Child_Temp (Extraversion, Negative_Affectivity, Effortful_Control) >> scale ranged from -3 over 0 to +3, so since conceptually everything < 0 is a more or less clear "no", we categorize this way: ≤ 3 = 1, ≥ 4 = 2 
       * Child_Parasocial >> 5 items two factors (anthropomorphism & parasocial_relationship) >> median split method because conceptual understanding of the scale
       
###### Developmental:
       * LFT >> mean-split
       * Child_Age >> age group "pre-schoolers 3-5 years, age group "schoolkids" 6-8 years, which means 1-3 = 1 and 4-6 = 2
       
###### Social: 
       * PMMS >> 6 items (restsMed & negacMed & posacMed) >> modal split method because of conceptual understanding of the scale
       * household composition >> built up of Child_Nr and PERSONEN >> convert both items into factors
       * smart-household-level >> median split method because of conceptual understanding of the scale (sticking with number of devices instead of frequency)

##### Running the LCA

```R

library(poLCA) 
   LCAmodel <- cbind(GSL,
                        SOCIALEKLASSE2016,
                        TT_LCAcategory_orig,
                        IL_navigation_LCAcategory_orig,
                        IL_information_LCAcategory_orig,
                        FoPersU_f_LCA,
                        Child_Gender,
                        Temp_Extraversion_f,
                        Temp_Negative_Affectivity_f,
                        Temp_Effortful_Control_f,
                        Child_Parasocial_anthropomorphism_LCAcategory_orig,
                        Child_Parasocial_pararela_LCAcategory_orig,
                        LFT_f,
                        Child_Age_f,
                        PMMS_restrMed_LCAcategory_orig,
                        PMMS_negacMed_LCAcategory_orig,
                        PMMS_posacMed_LCAcategory_orig,
                        current_usage,
                        Child_Nr_f,
                        PERSONEN_f,
                        SHL_f)~1

   
   LCAmodel2 <- poLCA(LCAmodel, data=rosie_fscores, nclass=2, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
   
   LCAmodel3 <- poLCA(LCAmodel, data=rosie_fscores, nclass=3, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
  
   LCAmodel4 <- poLCA(LCAmodel, data=rosie_fscores, nclass=4, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
   
   LCAmodel5 <- poLCA(LCAmodel, data=rosie_fscores, nclass=5, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
   
   LCAmodel6 <- poLCA(LCAmodel, data=rosie_fscores, nclass=6, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
 
```

##### Evaluating and interpreting LCA

```R

# https://statistics.ohlsen-web.de/latent-class-analysis-polca/ 
   # Since we do not have a solid theoretical assumption of the number of unobserved sub-populations (aka family types)
   # we take an exploratory approach and compare multiple models (2-6 classes) against each other. 
   # If choosing this approach, one can decide to take the model that has the most plausible interpretation. 
   # Additionally one could compare the different solutions by BIC or AIC information criteria. 
   # BIC is preferred over AIC in latent class models. 
   # A smaller BIC is better than a bigger BIC. 

        # >> 2-class model has lowest BIC
   
# https://www.tandfonline.com/doi/full/10.1080/10705510701575396
   
        # >> 3-class model has lowest aBIC (which is preferred for categorical variables and small sample sizes)
   
   
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6015948/pdf/atm-06-07-119.pdf (for visualizations)
   
   # getting other fit indices in a table
   tab.modfit<-data.frame(matrix(rep(999,6),nrow=1))
   names(tab.modfit)<-c("log-likelihood",
                          "resid. df","BIC",
                          "aBIC","cAIC","likelihood-ratio")
   
   tab.modfit
   
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
                           (1 + log(get(paste("LCAmodel",i,sep=""))$N))
                       ))
   }
   tab.modfit<-round(tab.modfit[-1,],2)
   tab.modfit$Nclass<-2:6
   
   tab.modfit
 
   
   #visualize model fit 
         # convert table into long format
         library("forcats")
         tab.modfit$Nclass <-as.factor(tab.modfit$Nclass)
         tab.modfit
         results2<-tidyr::gather(tab.modfit,label,value,1:6)
         results2
   
         # pass long-format table on to ggplot
         library(ggplot2)
         fit.plot<-ggplot(results2) +
           geom_point(aes(x=Nclass,y=value),size=2) +
           geom_line(aes(Nclass, value, group = 1)) +
           theme_bw()+
           labs(x = "Number of classes", y="Index values", title = "") +
           facet_grid(label ~. ,scales = "free") +
           theme_bw(base_size = 10, base_family = "") +
           theme(panel.grid.major.x = element_blank() ,
                 panel.grid.major.y = element_line(colour="grey",
                                                   size=0.3),
                 legend.title = element_text(size = 10, face = 'bold'),
                 axis.text = element_text(size = 12),
                 axis.title = element_text(size = 12),
                 legend.text= element_text(size=10),
                 axis.line = element_line(colour = "black"))
         fit.plot
         
         
    #extract 3-class solution and save in twoclass object (https://osf.io/vec6s/)
       set.seed(123)
       threeclass=poLCA(LCAmodel, data=rosie_fscores, nclass=3, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
       
       #output predicted classes from selected model so that we can use it in subsequent analyses:
       rosie_fscores$fam_class3=threeclass$predclass
        
       
     #descriptives along classes to get means 
     
        library(psych)
          psych::describeBy(rosie_fscores, group = "fam_class3")
          # 1 = LSM, 2 = ILS, 3 = LLY
          
```

#### Structural Equation Modelling: Technology acceptance (along TAM + U&G)

```R

#check multivariate normality
       library(QuantPsyc)
       #for rosie dataset including extracted factor scores of SEM variables
       mult.norm(rosie_fscores[c(82:100)])$mult.test #all TAM core variables
       
             # >> Since both p-values are less than .05, we reject the null hypothesis of the test. 
             #Thus, we have evidence to say that the SEM-variables in our dataset do not follow a multivariate distribution.
             # >> Together with the non-normality detected earlier, we will run our SEM analyses using bottstrapping.
       
       
 #install.packages("lavaan", dependencies = T)
      library(lavaan)
      
    
 ### 3-class model with 3DVs ##########################
        
        rosiesTAM_3classes3DVs <- '

        #measurement model
          PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
          PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
          E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
          SN =~ 1*TAM_SN_1 + TAM_SN_2 + TAM_SN_3
        #regressions
          PEoU ~ fam_class3
          PU ~ fam_class3 + PEoU
          E ~ fam_class3
          TAM_IMG ~ fam_class3
          SN ~ fam_class3
          TAM_ICU_1 ~ PEoU + PU + E + TAM_IMG + SN
          TAM_ICU_2 ~ PEoU + PU + E + TAM_IMG + SN
          TAM_ICU_3 ~ PEoU + PU + E + TAM_IMG + SN
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
          TAM_SN_1 ~~ TAM_SN_1
          TAM_SN_2 ~~ TAM_SN_2
          TAM_SN_3 ~~ TAM_SN_3
          TAM_ICU_1 ~~ TAM_ICU_1
          TAM_ICU_2 ~~ TAM_ICU_2
          TAM_ICU_3 ~~ TAM_ICU_3
          TAM_IMG ~~ TAM_IMG
          PEoU ~~ PEoU
          PU ~~ PU
          E ~~ E
          SN ~~ SN
          TAM_ICU_1 ~~ TAM_ICU_2
          TAM_ICU_1 ~~ TAM_ICU_3
          TAM_ICU_2 ~~ TAM_ICU_3
          fam_class3 ~~ fam_class3

        '
        
        #fit the model
        rosiesTAM_3classes3DVs_fit <- lavaan(rosiesTAM_3classes3DVs, data = rosie_fscores)
        
        #print summary
        summary(rosiesTAM_3classes3DVs_fit, standardized = T, fit.measures = T)
        
        #bootstrap model
        rosiesTAM_3classes3DVs_fit_boostrapped_se <- sem(rosiesTAM_3classes3DVs, data = rosie_fscores,se = "bootstrap", bootstrap = 1000) 
        summary(rosiesTAM_3classes3DVs_fit_boostrapped_se, fit.measures = TRUE) 
        parameterEstimates(rosiesTAM_3classes3DVs_fit_boostrapped_se, 
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
        
  
        #TAM_SN significantly predicts fam_class3 so we need to run some post-hoc tests to find out where the difference(s) is/are
        
        install.packages("ggpubr")
        library("ggpubr")
        ggboxplot(rosie_fscores, x = "fam_class3", y = "TAM_SN_1", 
                  color = "fam_class3", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                  ylab = "Subjective norm 1", xlab = "Family Type")
        
        ggboxplot(rosie_fscores, x = "fam_class3", y = "TAM_SN_2", 
                  color = "fam_class3", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                  ylab = "Subjective norm 2", xlab = "Family Type")
        
        ggboxplot(rosie_fscores, x = "fam_class3", y = "TAM_SN_3", 
                  color = "fam_class3", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                  ylab = "Subjective norm 3", xlab = "Family Type")
        
        ggboxplot(rosie_fscores, x = "fam_class3", y = "TAM_SN_f", 
                  color = "fam_class3", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
                  ylab = "Subjective norm", xlab = "Family Type")
        
        
        anova <- aov(TAM_SN_f ~ fam_class3, data = rosie_fscores)
        summary(anova)
        
                 # Which pairs of groups differ?
                 TukeyHSD(anova)

                 # $fam_class3
                 #           diff        lwr       upr     p adj
                 # 2-1 0.82702193  0.2527527 1.4012912 0.0023548
                 # 3-1 0.87265195  0.2162131 1.5290908 0.0055509
                 # 3-2 0.04563002 -0.6143875 0.7056476 0.9853926

                 ## >> There are significant group differences between family types 1 and 2 as well as between 1 and 3, with parents belonging
                 ## >> to type 1 perceiving lower social norms than parents belonging to family type 2 and 3.
        
        
        # Alternative non-parametric test
        kruskal.test(TAM_SN_f ~ fam_class3, data = rosie_fscores)
        # Kruskal-Wallis rank sum test
        # 
        # data:  TAM_SN_f by fam_class3
        # Kruskal-Wallis chi-squared = 12.698, df = 2, p-value = 0.001749
        
```
