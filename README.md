# About this Webpage (anonymous for peer-review process)
On this website, you can find the companion material for the paper "Virtual Assistants in Families. A Cross-Sectional Online-Survey Study to Understand Families’ Decisions to Use Virtual Assistants in the Home." This paper reports on the first study conducted as part of project Rosie using the following research question for guidance: *How do individual characteristics of families influence their decision to use virtual assistants in their home?*
This website is produced directly from the project’s github repository. 

## About Project Rosie
Project Rosie is set to study in depth how families with young children (aged 3 - 8 years) adopt, use, and eventually trust virtual assistants that are installed on smart speakers, like Google Home Nest or Amazon Echo, in their home. 

## Preregistration
[Here](https://osf.io/pmwud/?view_only=aaa1b70f0f75468388c8f50e2fed508f) you can find the prergistratration plan for the first study of project Rosie looking into families' individual characteristics that potentially influence their decision to use a vitual assistant in their home. Please also see the respective amendment for any changes made in the final study compared to the original preregistration. 

## Analyses
In what follows, you can find the analysis steps and respective R code that was used to answer the research question. 

### Data Cleaning
```R

   #filtering valid responses from families with at least one child between 3-8 years
   
    rosie_dataset_renamed_families_complete <- dplyr::filter(rosie_dataset_renamed, Child_Gender != 0 & STATUS == 1)
       View(rosie_dataset_renamed_families_complete)
   
   #recoding values of variables
  
    #Frequency of personal use - FoPersU (Q5 GA_Freq) --> relevant for smart speakers are items: GA_Freq_8-11
    #Here, we computed the mean for each participant on their answers to the frequency of smart speaker usage to get an indicator for their previous experience 
    #(the higher this value the higher the FoPersU; scale from 1-6)
    library(fame)
    rosie_dataset_renamed_families_complete$FoPersU <- rowMeans(rosie_dataset_renamed_families_complete[, 36:39], na.rm = T)
    is.numeric(rosie_dataset_renamed_families_complete$FoPersU)
    View(rosie_dataset_renamed_families_complete)
  
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
    View(rosie_dataset_renamed_families_complete)
  
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
        View(rosie_dataset_renamed_families_complete)
        
        #SS_childusage_1 & 2
        rosie_dataset_renamed_families_complete$ICU_childindividually <- rowMeans(rosie_dataset_renamed_families_complete[, 70:71], na.rm = T)
        is.numeric(rosie_dataset_renamed_families_complete$ICU_childindividually)
        rosie_dataset_renamed_families_complete$ICU_childindividually
        View(rosie_dataset_renamed_families_complete)
        
        #Based on this information we can also calculate how many parents have used the virtual assistant only by themselves and 
        #neither together with their child nor having let their child use it independently
        rosie_dataset_renamed_families_complete$current_usage <- ifelse(rosie_dataset_renamed_families_complete$ICU_togetherwithchild == 1 &
                                                                           rosie_dataset_renamed_families_complete$ICU_childindividually == 1, 1, 2)
        #1 = parent only
        #2 = with child
          
```


### Missingness
```R

  #Where are missing values?
  complete.cases(rosie)
  ?complete.cases
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
        # >> for some reason this participant has NAs for SS_childusage ***Most likely due to a survey system error***
  ```

### Measurement Validity
```R

 #package for CFA
  library(lavaan)
  
```
  ## 1) Confirmatory Factor Analysis for all model variables built up of two or more items
  ```R
  
    #TAM_IMG and TAM_ICU only consist of one item and were therefore excluded here
  
    #Dispositional: 
      #TT >> 3 items
            #checking for univariate outliers (+/- 3 SDs from the mean) 
                standardized_TT <- scale(rosie[,c(106:108)]) 
                outliers_TT <- colSums(abs(standardized_TT)>=3, na.rm = T) 
                outliers_TT
                #TT_1 TT_2 TT_3 
                #0    0    3
                  #For TT_3: Where are those outliers exactly? In what rows?
                  ??scores
                  library(outliers)
                  outlier_scores_TT_3 <- scores(rosie$TT_3)
                  is_outlier_TT_3 <- outlier_scores_TT_3 > 3 | outlier_scores_TT_3 < -3
                  #add a column with info whether the refund_value is an outlier
                  rosie$is_outlier_TT_3 <- is_outlier_TT_3
                  #look at plot
                  library(ggplot2)
                  ggplot(rosie, aes(TT_3)) +
                    geom_boxplot() +
                    coord_flip() +
                    facet_wrap(~is_outlier_TT_3)
                  #create a dataframe with only outliers
                  outlier_TT_3_df <- rosie[outlier_scores_TT_3 > 3| outlier_scores_TT_3 < -3, ]
                  #take a peek
                  head(outlier_TT_3_df) # >> outliers lay in observations 33, 64, 158
          
          # >> TT_1 = fairly symmetrical (skew), fewer returns in its tail than normal (kurtosis), no outliers
          # >> TT_2 = fairly symmetrical (skew), fewer returns in its tail than normal (kurtosis), no outliers
          # >> TT_3 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), 3 outliers in row 33, 64, 158
          
          #Step 1: correlations
          round(cor(rosie[,106:108]), 2)

          #Step 2: variance-covariance matrix
          round(cov(rosie[,106:108]), 2) 
 
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1a  <- ' TT_f  =~ TT_1 + TT_2 + TT_3' 
          onefac3items_TT <- cfa(m1a, data=rosie) 
          summary(onefac3items_TT, fit.measures=TRUE, standardized=TRUE) # >> Seems like a "just" identified model. Wait and see for testing whole measurement model in SEM.
          # >> fit index criteria: Chi-Square = / because 0 df just identified, CFI = 1 > 0.95, TLI = 1 > 0.90 and RMSEA = 0 < 0.10
          
          
    
       #IL >> 5 items
            #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                standardized_IL <- scale(rosie[,c(101:105)]) 
                outliers_IL <- colSums(abs(standardized_IL)>=3, na.rm = T) 
                outliers_IL
                #IL_1 IL_2 IL_3 IL_4 IL_5 
                  #3    2    2    0    0
                  #For IL_1: Where are those outliers exactly? In what rows?
                  ??scores
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
                  ??scores
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
                  ??scores
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
            View(IL_EFA_df)
                
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
                
                
                
         #Child_Temp >> 3 items
            #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                standardized_Child_Temp <- scale(rosie[,c(59:61)]) 
                outliers_Child_Temp <- colSums(abs(standardized_Child_Temp)>=3, na.rm = T) 
                outliers_Child_Temp
                #Child_Temp_1 Child_Temp_2 Child_Temp_3 
                #0            0            0 
                
                # >> Child_Temp_1 = negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers
                # >> Child_Temp_2 = fairly symmetrical (skew), fewer returns in its tail than normal (kurtosis), no outliers
                # >> Child_Temp_3 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers
          
          #Step 1: correlations
          round(cor(rosie[,59:61]), 2) # >> Here, it seems running a CFA does not really make much sense due to the extremely low correlations. I guess that is due to the adjusted dense scale?
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,59:61]), 2) 
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1b  <- ' f  =~ Child_Temp_1 + Child_Temp_2 + Child_Temp_3' 
          onefac3items_Child_Temp <- cfa(m1b, data=rosie) 
          summary(onefac3items_Child_Temp, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = / because 0 df just identified, CFI = 1 > 0.95, TLI = 1 > 0.90 and RMSEA p-value = NA???? < 0.10
  
              #After inspecting the fit indices and revising the scale, we conclude that each Child_temp item does not per se represent an item that in total measure temperament.
              #Instead, each item represent a separate temperament type and therefore we recode each item into a separate variable with which we proceed.
          
                  #renaming Child_Temp items along original single-item Temperament Scale by Sleddens et al. (2012)
                  library(dplyr)
                  rosie <- dplyr::rename(rosie, c('Child_Temp_Extraversion' = 'Child_Temp_1',
                                         'Child_Temp_Negative_Affectivity' = 'Child_Temp_2',
                                         'Child_Temp_Effortful_Control' = 'Child_Temp_3'))
    
          
          
         #Child_Parasocial >> 5 items
              #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                standardized_Child_Parasocial <- scale(rosie[,c(73:77)]) 
                outliers_Child_Parasocial <- colSums(abs(standardized_Child_Parasocial)>=3, na.rm = T) 
                outliers_Child_Parasocial
                #Child_Parasocial_1 Child_Parasocial_2 Child_Parasocial_3 Child_Parasocial_4 Child_Parasocial_5 
                #0                  0                  0                  3                  3 
                  #For Child_Parasocial_4: Where are those outliers exactly? In what rows?
                  ??scores
                  library(outliers)
                  outlier_scores_Child_Parasocial_4 <- scores(rosie$Child_Parasocial_4)
                  is_outlier_Child_Parasocial_4 <- outlier_scores_Child_Parasocial_4 > 3 | outlier_scores_Child_Parasocial_4 < -3
                  #add a column with info whether the refund_value is an outlier
                  rosie$is_outlier_Child_Parasocial_4 <- is_outlier_Child_Parasocial_4
                  #look at plot
                  library(ggplot2)
                  ggplot(rosie, aes(Child_Parasocial_4)) +
                    geom_boxplot() +
                    coord_flip() +
                    facet_wrap(~is_outlier_Child_Parasocial_4)
                  #create a dataframe with only outliers
                  outlier_Child_Parasocial_4_df <- rosie[outlier_scores_Child_Parasocial_4 > 3| outlier_scores_Child_Parasocial_4 < -3, ]
                  #take a peek
                  head(outlier_Child_Parasocial_4_df) # >> outliers lay in observations 8, 74, 79
                    
                  #For Child_Parasocial_5: Where are those outliers exactly? In what rows?
                  ??scores
                  library(outliers)
                  outlier_scores_Child_Parasocial_5 <- scores(rosie$Child_Parasocial_5)
                  is_outlier_Child_Parasocial_5 <- outlier_scores_Child_Parasocial_5 > 3 | outlier_scores_Child_Parasocial_5 < -3
                  #add a column with info whether the refund_value is an outlier
                  rosie$is_outlier_Child_Parasocial_5 <- is_outlier_Child_Parasocial_5
                  #look at plot
                  library(ggplot2)
                  ggplot(rosie, aes(Child_Parasocial_5)) +
                    geom_boxplot() +
                    coord_flip() +
                    facet_wrap(~is_outlier_Child_Parasocial_5)
                  #create a dataframe with only outliers
                  outlier_Child_Parasocial_5_df <- rosie[outlier_scores_Child_Parasocial_5 > 3| outlier_scores_Child_Parasocial_5 < -3, ]
                  #take a peek
                  head(outlier_Child_Parasocial_5_df) # >> outliers lay in observations 8, 74, 79
                  
                # >> Child_Parasocial_1 = moderately positively skewed, fewer returns in its tail than normal (kurtosis), no outliers
                # >> Child_Parasocial_2 = fairly symmetrical (skew), fewer returns in its tail than normal (kurtosis), no outliers
                # >> Child_Parasocial_3 = faily symmetrical (skew), fewer returns in its tail than normal (kurtosis), no outliers
                # >> Child_Parasocial_4 = highly positively skewed, fewer returns in its tail than normal (kurtosis), 3 outliers in row 8, 74, 79 #After inspection I do not see a reason why we should remove those.
                # >> Child_Parasocial_5 = highly positively skewed, fewer returns in its tail than normal (kurtosis), 3 outliers in row 8, 74, 79 #After inspection I do not see a reason why we should remove those.
          
          #Step 1: correlations
          round(cor(rosie[,73:77]), 2) 
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,73:77]), 2)
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1c  <- ' f  =~ Child_Parasocial_1 + Child_Parasocial_2 + Child_Parasocial_3 + Child_Parasocial_4 + Child_Parasocial_5'
          onefac5items_Child_Parasocial <- cfa(m1c, data=rosie, std.lv=TRUE) 
          summary(onefac5items_Child_Parasocial, fit.measures=TRUE, standardized=TRUE) 
          # >> fit index criteria: Chi-Square = .002 NOT > .05, CFI = .969 > 0.95, TLI = .938 > 0.90 and RMSEA = .123 NOT < 0.10
          
          modindices(onefac5items_Child_Parasocial, sort=T) #Child_Parasocial_2 ~~ Child_Parasocial_3 >> 12.436 
          
              #to check whether there is actually a different underlying factor structure in this scale, we run an EFA
              
                library(psych)
                library(GPArotation)
          
                #creating a subset with the variables relevant for this EFA
                Child_Parasocial <- c("Child_Parasocial_1", "Child_Parasocial_2", "Child_Parasocial_3", "Child_Parasocial_4", "Child_Parasocial_5")
                Child_Parasocial
                Child_Parasocial_EFA_df <- rosie[Child_Parasocial]
                View(Child_Parasocial_EFA_df)
                
                #parallel analysis to get number of factors
                parallel1 <- fa.parallel(Child_Parasocial_EFA_df, fm = 'minres', fa = 'fa') #suggests 2 factors, which corresponds to the bad model fit and modindices results above
                
                #factor analysis for rotation (first using oblique rotation to check whether factors correlate with each other)
                fa(Child_Parasocial_EFA_df,nfactors = 2,rotate = 'oblimin',fm='minres') #and indeed, factors seem to correlate with each other, so oblique rotation is better here
                Child_Parasocial_2factors
                print(Child_Parasocial_2factors)
                
                    #determine cut-off value of loadings .3
                    print(Child_Parasocial_2factors$loadings,cutoff = 0.3)
                    #Loadings:
                    #                      MR1    MR2   
                    #Child_Parasocial_1  0.594       
                    #Child_Parasocial_2         0.595   #Items 2 and 3 seem to load together, which is in accordance with the modindices above
                    #Child_Parasocial_3         0.703
                    #Child_Parasocial_4  0.968       
                    #Child_Parasocial_5  0.839       
                    
                    #                 MR1   MR2
                    #SS loadings    2.019 0.916
                    #Proportion Var 0.404 0.183
                    #Cumulative Var 0.404 0.587

          
                    #look at it visually
                    fa.diagram(Child_Parasocial_2factors)
                    
                    # >> The root means the square of residuals (RMSR) is 0. This is acceptable as this value should be closer to 0. 
                    # >> The root mean square error of approximation (RMSEA) is 0. This shows good model fit as it is below 0.05. 
                    # >> The Tucker-Lewis Index (TLI) is 1.021. This is an acceptable value considering it’s over 0.9.
                    
                    #naming factors
                    # >> Factor 1 holding items 1, 4, and 5 => anthropomorphism
                    # >> Factor 2 holding items 2 and 3 => parasocial relationship
                    
                        #now that we identified 2 factors, we confirm this through a 2-factor CFA again
                    
                        #Step 3 revised: two-factor CFA
                        #two factors with one time 3 and one time 2 items, default marker method
                        m2c  <- ' anthropomorphism  =~ Child_Parasocial_1 + Child_Parasocial_4 + Child_Parasocial_5 
                          parasocial_relationship =~ Child_Parasocial_2 + Child_Parasocial_3' 
                        twofac5items_Child_Parasocial <- cfa(m2c, data=rosie, std.lv=TRUE) 
                        summary(twofac5items_Child_Parasocial, fit.measures=TRUE, standardized=TRUE) 
                        # >> fit index criteria: Chi-Square = .192 > .05, CFI = .995 > 0.95, TLI = .988 > 0.90 and RMSEA = .053 < 0.10 #VERY NICE
                    
                    
                    
                    
    #Developmental: NONE
  
  
  
    #Social: 
      #PMMS >> 6 items
            #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                standardized_PMMS <- scale(rosie[,c(62:67)]) 
                outliers_PMMS <- colSums(abs(standardized_PMMS)>=3, na.rm = T) 
                outliers_PMMS
                #PMMS_1 PMMS_2 PMMS_3 PMMS_4 PMMS_5 PMMS_6 
                #0      0      0      6      0      0
                  
              # >> PMMS_1 = fairly symmetrical (skew), fewer returns in its tail than normal (kurtosis), no outliers
              # >> PMMS_2 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers
              # >> PMMS_3 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers
              # >> PMMS_4 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), 6 outliers
              # >> PMMS_5 = fairly symmetrical (skew), fewer returns in its tail than normal (kurtosis), no outliers
              # >> PMMS_6 = fairly symmetrical (skew), fewer returns in its tail than normal (kurtosis), no outliers
          
                #For PMMS_4: Where are those outliers exactly? In what rows?
                ??scores
                library(outliers)
                outlier_scores_PMMS_4 <- scores(rosie$PMMS_4)
                is_outlier_PMMS_4 <- outlier_scores_PMMS_4 > 3 | outlier_scores_PMMS_4 < -3
                #add a column with info whether the refund_value is an outlier
                rosie$is_outlier_PMMS_4 <- is_outlier_PMMS_4
                #look at plot
                library(ggplot2)
                ggplot(rosie, aes(PMMS_4)) +
                  geom_boxplot() +
                  coord_flip() +
                  facet_wrap(~is_outlier_PMMS_4)
                #create a dataframe with only outliers
                outlier_PMMS_4_df <- rosie[outlier_scores_PMMS_4 > 3| outlier_scores_PMMS_4 < -3, ]
                #take a peek
                head(outlier_PMMS_4_df) # >> outliers lay in observations 12, 32, 37, 99, 127, 170
                
          #Step 1: correlations
          round(cor(rosie[,62:67]), 2) 
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,62:67]), 2) 
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1d  <- ' f  =~ PMMS_1 + PMMS_2 + PMMS_3 + PMMS_4 + PMMS_5 + PMMS_6'
          onefac6items_PMMS <- cfa(m1d, data=rosie, std.lv=TRUE) 
          summary(onefac6items_PMMS, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .00 NOT > .05, CFI = .689 NOT > 0.95, TLI = .483 NOT > 0.90 and RMSEA = .241 < 0.10 
          #>> This bad fit could be an indicator for the actual three factor scale corresponding to the original scale structure.
          
          #Step 4: three-factor CFA
          #two items per factor, default marker method
          m2d <- ' restrMed  =~ PMMS_1 + PMMS_2 
              negacMed =~ PMMS_3 + PMMS_5 
              posacMed   =~ PMMS_4 + PMMS_6'
          threefac2items_PMMS <- cfa(m2d, data=rosie, std.lv=TRUE) 
          summary(threefac2items_PMMS, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .028 NOT > .05, CFI = .974 > 0.95, TLI = .934 > 0.90 and RMSEA = .086 < 0.10 >> Much better fit
          
  
  
  
    #TAM: 
      #TAM_PEoU >> 4 items
            #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                standardized_TAM_PEoU <- scale(rosie[,c(82:85)]) 
                outliers_TAM_PEoU <- colSums(abs(standardized_TAM_PEoU)>=3, na.rm = T) 
                outliers_TAM_PEoU
                #TAM_PEoU_1 TAM_PEoU_2 TAM_PEoU_3 TAM_PEoU_4 
                #3          0          3          0
                  #For TAM_PEoU_1: Where are those outliers exactly? In what rows?
                  ??scores
                  library(outliers)
                  outlier_scores_TAM_PEoU_1 <- scores(rosie$TAM_PEoU_1)
                  is_outlier_TAM_PEoU_1 <- outlier_scores_TAM_PEoU_1 > 3 | outlier_scores_TAM_PEoU_1 < -3
                  #add a column with info whether the refund_value is an outlier
                  rosie$is_outlier_TAM_PEoU_1 <- is_outlier_TAM_PEoU_1
                  #look at plot
                  library(ggplot2)
                  ggplot(rosie, aes(TAM_PEoU_1)) +
                    geom_boxplot() +
                    coord_flip() +
                    facet_wrap(~is_outlier_TAM_PEoU_1)
                  #create a dataframe with only outliers
                  outlier_TAM_PEoU_1_df <- rosie[outlier_scores_TAM_PEoU_1 > 3| outlier_scores_TAM_PEoU_1 < -3, ]
                  #take a peek
                  head(outlier_TAM_PEoU_1_df) # >> outliers lay in observations 32, 37, 105
                  
                  #For TAM_PEoU_3: Where are those outliers exactly? In what rows?
                  ??scores
                  library(outliers)
                  outlier_scores_TAM_PEoU_3 <- scores(rosie$TAM_PEoU_3)
                  is_outlier_TAM_PEoU_3 <- outlier_scores_TAM_PEoU_3 > 3 | outlier_scores_TAM_PEoU_3 < -3
                  #add a column with info whether the refund_value is an outlier
                  rosie$is_outlier_TAM_PEoU_3 <- is_outlier_TAM_PEoU_3
                  #look at plot
                  library(ggplot2)
                  ggplot(rosie, aes(TAM_PEoU_3)) +
                    geom_boxplot() +
                    coord_flip() +
                    facet_wrap(~is_outlier_TAM_PEoU_3)
                  #create a dataframe with only outliers
                  outlier_TAM_PEoU_3_df <- rosie[outlier_scores_TAM_PEoU_3 > 3| outlier_scores_TAM_PEoU_3 < -3, ]
                  #take a peek
                  head(outlier_TAM_PEoU_3_df) # >> outliers lay in observations 32, 70, 105
          
          # >> TAM_PEoU_1 = highly negatively skewed, fewer returns in its tail than normal (kurtosis), 3 outliers in row 32, 37, 105 #After inspection I do not see a reason why we should remove those.
          # >> TAM_PEoU_2 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers
          # >> TAM_PEoU_3 = highly negatively skewed, fewer returns in its tail than normal (kurtosis), 3 outliers in row 32, 70, 105 #After inspection I do not see a reason why we should remove those.
          # >> TAM_PEoU_4 = highly negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers 
          
          #Step 1: correlations
          round(cor(rosie[,82:85]), 2) 
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,82:85]), 2) 
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1e  <- ' TAM_PEoU_f  =~ TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4'
          onefac4items_TAM_PEoU <- cfa(m1e, data=rosie, std.lv=TRUE) 
          summary(onefac4items_TAM_PEoU, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .861 > .05, CFI = 1 > 0.95, TLI = 1.012 > 0.90 and RMSEA  = 0 < 0.10 >> VERY NICE
          
          
          
          
      #TAM_PU >> 4 items
               #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                standardized_TAM_PU <- scale(rosie[,c(86:89)]) 
                outliers_TAM_PU <- colSums(abs(standardized_TAM_PU)>=3, na.rm = T) 
                outliers_TAM_PU
                #TAM_PU_1 TAM_PU_2 TAM_PU_3 TAM_PU_4 
                #0        0        0        0 
          
          # >> TAM_PU_1 = fairly summetrical (skew), fewer returns in its tail than normal (kurtosis), no outliers
          # >> TAM_PU_2 = fairly summetrical (skew), fewer returns in its tail than normal (kurtosis), no outliers
          # >> TAM_PU_3 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers
          # >> TAM_PU_4 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers 
                
          #Step 1: correlations
          round(cor(rosie[,86:89]), 2) 
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,86:89]), 2) 
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1f  <- ' TAM_PU_f  =~ TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4'
          onefac4items_TAM_PU <- cfa(m1f, data=rosie, std.lv=TRUE) 
          summary(onefac4items_TAM_PU, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .234 > .05, CFI = .998 > 0.95, TLI = .995 > 0.90 and RMSEA = .050 < 0.10 >> VERY NICE
          
          
          
          
      #TAM_E >> 4 items
            #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                standardized_TAM_E <- scale(rosie[,c(90:93)]) 
                outliers_TAM_E <- colSums(abs(standardized_TAM_E)>=3, na.rm = T) 
                outliers_TAM_E
                #TAM_E_1 TAM_E_2 TAM_E_3 TAM_E_4 
                #0       5       6       0
                  #For TAM_E_2: Where are those outliers exactly? In what rows?
                  ??scores
                  library(outliers)
                  outlier_scores_TAM_E_2 <- scores(rosie$TAM_E_2)
                  is_outlier_TAM_E_2 <- outlier_scores_TAM_E_2 > 3 | outlier_scores_TAM_E_2 < -3
                  #add a column with info whether the refund_value is an outlier
                  rosie$is_outlier_TAM_E_2 <- is_outlier_TAM_E_2
                  #look at plot
                  library(ggplot2)
                  ggplot(rosie, aes(TAM_E_2)) +
                    geom_boxplot() +
                    coord_flip() +
                    facet_wrap(~is_outlier_TAM_E_2)
                  #create a dataframe with only outliers
                  outlier_TAM_E_2_df <- rosie[outlier_scores_TAM_E_2 > 3| outlier_scores_TAM_E_2 < -3, ]
                  #take a peek
                  head(outlier_TAM_E_2_df) # >> outliers lay in observations 70, 90, 105, 159, 164
                  
                  #For TAM_E_3: Where are those outliers exactly? In what rows?
                  ??scores
                  library(outliers)
                  outlier_scores_TAM_E_3 <- scores(rosie$TAM_E_3)
                  is_outlier_TAM_E_3 <- outlier_scores_TAM_E_3 > 3 | outlier_scores_TAM_E_3 < -3
                  #add a column with info whether the refund_value is an outlier
                  rosie$is_outlier_TAM_E_3 <- is_outlier_TAM_E_3
                  #look at plot
                  library(ggplot2)
                  ggplot(rosie, aes(TAM_E_3)) +
                    geom_boxplot() +
                    coord_flip() +
                    facet_wrap(~is_outlier_TAM_E_3)
                  #create a dataframe with only outliers
                  outlier_TAM_E_3_df <- rosie[outlier_scores_TAM_E_3 > 3| outlier_scores_TAM_E_3 < -3, ]
                  #take a peek
                  head(outlier_TAM_E_3_df) # >> outliers lay in observations 14, 37, 90, 105, 159, 164
          
          # >> TAM_E_1 = highly negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers
          # >> TAM_E_2 = highly negatively skewed, fewer returns in its tail than normal (kurtosis), 5 outliers in row 70, 90, 105, 159, 164 #After inspection I do not see a reason why we should remove those.
          # >> TAM_E_3 = highly negatively skewed, fewer returns in its tail than normal (kurtosis), 6 outliers in row 14, 37, 90, 105, 159, 164 #After inspection I do not see a reason why we should remove those.
          # >> TAM_E_4 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers 
          
          #Step 1: correlations
          round(cor(rosie[,90:93]),2) 
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,90:93]),2)
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1g  <- ' TAM_E_f  =~ TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4'
          onefac4items_TAM_E <- cfa(m1g, data=rosie,std.lv=TRUE) 
          summary(onefac4items_TAM_E, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .058 > .05, CFI = .993 > 0.95, TLI = .979 > 0.90 and RMSEA = .100 < 0.10 >> NICE
          
          
          
          
      #TAM_SN >> 3 items
            #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                standardized_TAM_SN <- scale(rosie[,c(95:97)]) 
                outliers_TAM_SN <- colSums(abs(standardized_TAM_SN)>=3, na.rm = T) 
                outliers_TAM_SN
                #TAM_SN_1 TAM_SN_2 TAM_SN_3 
                #0        0        0 
              
          #Step 1: correlations
          round(cor(rosie[,95:97]),2) 
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,95:97]),2) 
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1h  <- ' TAM_SN_f  =~ TAM_SN_1 + TAM_SN_2 + TAM_SN_3 '
          onefac3items_TAM_SN <- cfa(m1h, data=rosie) 
          summary(onefac3items_TAM_SN, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = 0 > .05, CFI = 1 > 0.95, TLI = 1 > 0.90 and RMSEA = 0 < 0.10 >> AGAIN, problematic because just identified        
          
              #to double check this structure let's run an EFA
              
              library(psych)
              library(GPArotation)
              
              #creating a subset with the variables relevant for this EFA
              SN <- c("TAM_SN_1", "TAM_SN_2", "TAM_SN_3")
              SN
              SN_EFA_df <- rosie[SN]
              View(SN_EFA_df)
              
              #parallel analysis to get number of factors
              parallel4 <- fa.parallel(SN_EFA_df, fm = 'minres', fa = 'fa') #suggests 1 factor, so we'll stick with CFA
          
          
          
          
      (#TAM_ICU >> 3 items)
           #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
              standardized_TAM_ICU <- scale(rosie[,c(98:100)]) 
              outliers_TAM_ICU <- colSums(abs(standardized_TAM_ICU)>=3, na.rm = T) 
              outliers_TAM_ICU
              #TAM_ICU_1 TAM_ICU_2 TAM_ICU_3 
              #0         5         0
              
              #For TAM_E_3: Where are those outliers exactly? In what rows?
              ??scores
              library(outliers)
              outlier_scores_TAM_ICU_2 <- scores(rosie$TAM_ICU_2)
              is_outlier_TAM_ICU_2 <- outlier_scores_TAM_ICU_2 > 3 | outlier_scores_TAM_ICU_2 < -3
              #add a column with info whether the refund_value is an outlier
              rosie$is_outlier_TAM_ICU_2 <- is_outlier_TAM_ICU_2
              #look at plot
              library(ggplot2)
              ggplot(rosie, aes(TAM_ICU_2) +
                geom_boxplot() +
                coord_flip() +
                facet_wrap(~is_outlier_TAM_ICU_2)
              #create a dataframe with only outliers
              outlier_TAM_ICU_2_df <- rosie[outlier_scores_TAM_ICU_2 > 3 | outlier_scores_TAM_ICU_2 < -3, ]
              #take a peek
              head(outlier_TAM_ICU_2_df) # >> outliers lay in observations 37, 68, 90, 159, 170
              
              # >> TAM_ICU_1 = fairly summetrical (skew), fewer returns in its tail than normal (kurtosis), no outliers
              # >> TAM_ICU_2 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), 5 outliers
              # >> TAM_ICU_3 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers
          
          #Step 1: correlations
          round(cor(rosie[,98:100]), 2) 
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,98:100]), 2) 
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1r  <- ' TAM_ICU_f  =~ TAM_ICU_1 + TAM_ICU_2 + TAM_ICU_3'
          onefac3items_TAM_ICU <- cfa(m1r, data=rosie, std.lv=TRUE) 
          summary(onefac3items_TAM_ICU, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .091 > .05, CFI = .999 > 0.95, TLI = 1.00 > 0.90 and RMSEA = 0 < 0.10 >> VERY NICE BUT I HAVE A WEIRD GUT FEELING BECAUSE OF THE NAs FOR SEs
          
                #to double check this structure let's run an EFA
          
                library(psych)
                library(GPArotation)
                
                #creating a subset with the variables relevant for this EFA
                ICU <- c("TAM_ICU_1", "TAM_ICU_2", "TAM_ICU_3")
                ICU
                ICU_EFA_df <- rosie[ICU]
                View(ICU_EFA_df)
                
                #parallel analysis to get number of factors
                parallel3 <- fa.parallel(ICU_EFA_df, fm = 'minres', fa = 'fa') #suggests 2 factors 
                
                #factor analysis for rotation (first using oblique rotation to check whether factors correlate with each other)
                ICU_2factors <- fa(ICU_EFA_df,nfactors = 2,rotate = 'oblimin',fm='minres') #factors do not seem to correlate with each other, so orthogonal rotation is better here
                ICU_2factors
                print(ICU_2factors)
                
                      ICU_2factors_var <- fa(ICU_EFA_df,nfactors = 2,rotate = 'varimax',fm='minres') 
                      ICU_2factors_var
                      print(ICU_2factors_var)
                
                      #determine cut-off value of loadings .3
                      print(ICU_2factors_var$loadings,cutoff = 0.3)
                      #Loadings:
                      #  MR1    MR2   
                      #TAM_ICU_1         0.337
                      #TAM_ICU_2  0.776       
                      #TAM_ICU_3  0.770       
                      
                      #MR1   MR2
                      #SS loadings    1.196 0.156
                      #Proportion Var 0.399 0.052
                      #Cumulative Var 0.399 0.450
                      
                      #look at it visually
                      fa.diagram(ICU_2factors_var)
                      
                      # >> The root means the square of residuals (RMSR) is 0. This is acceptable as this value should be closer to 0. 
                      # >> The Tucker-Lewis Index (TLI) is 1.041. This is an acceptable value considering it’s over 0.9.
                      
                      #the two emerging factors:
                      # >> Factor 1 holding item 1 => parent only usage
                      # >> Factor 2 holding items 2 and 3 => child (co)usage
                      
                      #confirming this with a CFA is problematic because one factor is defined by just one item and, thus, the model will not be identified
                      #but this supports the correlation results for the ICU levels and the fact that we distinguish between used by parents only vs. used by child in any way (variable: current usage)
                      
         
  ```    
      
  ## 2) Extract factor scores
  
  ```R
  
         #summary of all CFA models 
                    # onefac3items_TT
                    # twofac5items_IL
                    # twofac5items_Child_Parasocial
                    # threefac2items_PMMS
                    # onefac4items_TAM_PeoU
                    # onefac4items_TAM_PU
                    # onefac4items_TAM_E
                    # onefac3items_TAM_SN
                    (# onefac3items_TAM_ICU)
                
          #predicting factor scores of all CFA models
                onefac3items_TTfitPredict <- as.data.frame(predict(onefac3items_TT))
                twofac5items_ILfitPredict <- as.data.frame(predict(twofac5items_IL))
                twofac5items_Child_ParasocialfitPredict <- as.data.frame(predict(twofac5items_Child_Parasocial))
                threefac2items_PMMSfitPredict <- as.data.frame(predict(threefac2items_PMMS)) 
                onefac4items_TAM_PeoUfitPredict <- as.data.frame(predict(onefac4items_TAM_PEoU))
                onefac4items_TAM_PUfitPredict <- as.data.frame(predict(onefac4items_TAM_PU))
                onefac4items_TAM_EfitPredict <- as.data.frame(predict(onefac4items_TAM_E))
                onefac3items_TAM_SNfitPredict <- as.data.frame(predict(onefac3items_TAM_SN))
                onefac3items_TAM_ICUfitPredict <- as.data.frame(predict(onefac3items_TAM_ICU))

                
          #adding to rosie-dataset
                rosie_fscores <- cbind(rosie, onefac3items_TTfitPredict, twofac5items_ILfitPredict, twofac5items_Child_ParasocialfitPredict,
                                       threefac2items_PMMSfitPredict, onefac4items_TAM_PeoUfitPredict, onefac4items_TAM_PUfitPredict,  onefac4items_TAM_EfitPredict,
                                       onefac3items_TAM_SNfitPredict, onefac3items_TAM_ICUfitPredict)
                                       
 ```
        
    
  ## 3) Cronbach's Alpha
  
  ```R
         #Dispositional: 
          
             #Q26 TT >> 3 items
             TT <- rosie[, c(106:108)]
             psych::alpha(TT) ### --> 0.77

             #Q32 Child_Parasocial >> 5 items
             Child_Parasocial <- rosie[, c(73:77)]
             psych::alpha(Child_Parasocial) ### --> 0.83
                        
             #Q25 IL >> 5 items
             IL <- rosie[, c(101:105)]
             psych::alpha(IL) ### --> 0.86

          #Developmental: NONE
          
          #Social: 
          
             #Q31 PMMS >> 6 items 
             PMMS <- rosie[, c(62:67)]
             psych::alpha(PMMS) ### --> 0.76
  
          #TAM: 
          
             #Q17 TAM_PEoU >> 4
             TAM_PEoU <- rosie[, c(82:85)]
             psych::alpha(TAM_PEoU) ### --> 0.87

             #Q18 TAM_PU >> 4
             TAM_PU <- rosie[, c(86:89)]
             psych::alpha(TAM_PU) ### --> 0.92

             #Q19 TAM_E >> 4
             TAM_E <- rosie[, c(90:93)]
             psych::alpha(TAM_E) ### --> 0.9

             #Q21 TAM_SN >> 3
             TAM_SN <- rosie[, c(95:97)]
             psych::alpha(TAM_SN, keys = c(1, -1, -1)) ### --> 0.68

             #Q22 TAM_ICU >> 3 
             TAM_ICU <- rosie[, c(98:100)]
             psych::alpha(TAM_ICU) ### --> 0.43
 
 ```
 
### Descriptives

```R

#packages for descriptives
  library(pastecs)
  library(psych)

   describe(rosie_fscores)
   psych::describeBy(rosie_fscores, group = "GSL")
   # 1 = male, 2 = female

   #getting correlations matrix for TAM-variables
   round(cor(rosie_fscores[,c(139:143)]),2)
   #            TAM_PEoU_f TAM_PU_f TAM_E_f TAM_SN_f TAM_ICU_f
   # TAM_PEoU_f       1.00     0.44    0.63     0.15      0.09
   # TAM_PU_f         0.44     1.00    0.58     0.40      0.11
   # TAM_E_f          0.63     0.58    1.00     0.25      0.02
   # TAM_SN_f         0.15     0.40    0.25     1.00      0.07
   # TAM_ICU_f        0.09     0.11    0.02     0.07      1.00
   
   
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

#### Latent Class Analysis: Individual differencs (DSMM)

#### Structural Equation Modelling: Technology acceptance (TAM + U&G)

### Exploratory Analyses
