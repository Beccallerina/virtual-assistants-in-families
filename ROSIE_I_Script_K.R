
#---------------------------------------------------#
### ROSIE STUDY I (FYP) SCRIPT ######################
#---------------------------------------------------#

#----------------------------------------#
### PRE-SETTING ##########################
#----------------------------------------#

 #setting the working directory
 setwd('/Users/rebeccawald/Desktop/ROSIE_surfdrive/Project ROSIE/Study_1/Analysis/Datasets/HumaneAIROSIE')
  
 #setting coding scheme
 options(contrasts = c("contr.sum", "contr.poly"))
  
 #setting scientific writings
 options(scipen = 20)
  
 #reading data file
 library(foreign)
 data <- read.spss('244408473_clientfile.sav', to.data.frame=TRUE, use.value.labels = FALSE)
 # View(data)
  
 #list of available packages in this R-version
 av <- available.packages(filters=list())
 
 #citations of packages
 citation("lavaan") #Yves Rosseel (2012). lavaan: An R Package for Structural Equation Modeling. Journal of Statistical Software, 48(2), 1-36. URL http://www.jstatsoft.org/v48/i02/.
 citation("psych") #Revelle, W. (2020) psych: Procedures for Personality and Psychological Research, Northwestern University, Evanston, Illinois, USA, https://CRAN.R-project.org/package=psych Version = 2.0.12,.
 citation("poLCA") #Drew A. Linzer, Jeffrey B. Lewis (2011). poLCA: An R Package for Polytomous Variable Latent Class Analysis. Journal of Statistical Software, 42(10), 1-29. URL http://www.jstatsoft.org/v42/i10/.
 citation("semPlot") #Sacha Epskamp (2019). semPlot: Path Diagrams and Visual Analysis of Various SEM Packages' Output. R package version 1.1.2. https://CRAN.R-project.org/package=semPlot
 citation("QuantPsyc") #Thomas D. Fletcher (2012). QuantPsyc: Quantitative Psychology Tools. R package version 1.5. https://CRAN.R-project.org/package=QuantPsyc
 
 #get loaded versions of packages
print(sessionInfo())
 
#----------------------------------------------------------------------------------------------------------------#    
 
#--------------------------------------------#
### DATA MANAGEMENT ##########################
#--------------------------------------------#

#------------------------------# 
  #Merging datasets
  #Getting overview
  #Identifying Rosie target group
  #Data cleaning
  #Inspecting missingness
#------------------------------#  
  

#-------------------------------------------------------------#
### Only if needed: MERGING DATASETS ##########################
#-------------------------------------------------------------#
  
  #***If we end up merging datasets:
  
  #mcombining Kantar data and DigsocSurvey data together
  #We can use the rbind() function to stack data frames. Make sure the number of 
  #columns match. Also, the names and classes of values being joined must match.
  #Here we stack the first, the second and then the first again:
  #rbind(Kantar, DigSocAdopters)
  #View(data_all) 
  
#----------------------------------------------------------------------#
#       CONTINUE WITH COMBINED DATASET IF APPLICABLE
 
 
#---------------------------------------------#
### GETTING OVERVIEW ##########################
#---------------------------------------------#

  #getting variable names and index numbers of total dataset
  names(data)

 #--> For Rosie we will only need the following variables: 
      #Q4 IoT_Usage >> selection out of 25 options
      #Q5 GA_Freq (for previous experience) >> selection out of 11 options
      #Q6 IoT_Freq (for smart-household-level) >> selection out of 16 options
      #Q8 Child_Nr >> 1
      #Q28 Child_Age >> 1
      #Q29 Child_Gender >> 1
      #Q30 Child_Temp >> 3 items
      #Q31 PMMS >> 6 items
      #Q11 SS_co_usage >> 1 bzw. 2 (with and without display)
      #Q42 SS_child_usage >> 1 bzw. 2 (with and without display)
      #Q12 Incorporation >> 1 
      #Q32 Child_Parasocial >> 5 items
      #Q13 Location >> 1
      #Q14 Early_Adopter >> 1
      #Q15 Conversion >> 1
      #Q17 TAM_PEoU >> 4
      #Q18 TAM_PU >> 4
      #Q19 TAM_E >> 4
      #Q20 TAM_SS >> 1
      #Q21 TAM_SI >> 3
      #Q22 TAM_UI >> 3 
      #Q25 IL >> 5 items
      #Q26 TT >> 3 items
      #STATUS
      #PERSONEN (for household size)
      #SOCIALEKLASSE2016 (for SES) 
      #GSL (for parent gender)
      #LFT (for parent age)
 
  #removing variables that we do not need for Rosie analyses (other researchers' variables of interest)
   rosie_dataset <- data[,-c(2:16, 42:54, 56:67, 69:80, 108:120, 138:149, 157:168, 190, 199:291, 294:305, 307:309, 313:325)]
   # View(rosie_dataset)
   
   #getting variable names and index numbers of reduced dataset
   names(rosie_dataset)

#----------------------------------------------------------------------#
#       CONTINUE WITH REDUCED DATASET
   
   
#-----------------------------------------------#
### RENAMING VARIABLES ##########################
#-----------------------------------------------#
   
   #renaming variables
   library(dplyr)
   rosie_dataset_renamed <- dplyr::rename(rosie_dataset, c('IoT_Usage_1' = 'Q401', 
                                                           'IoT_Usage_2' = 'Q402',
                                                           'IoT_Usage_3' = 'Q403', 
                                                           'IoT_Usage_4' = 'Q404',
                                                           'IoT_Usage_5' = 'Q405', 
                                                           'IoT_Usage_6' = 'Q406',
                                                           'IoT_Usage_7' = 'Q407', 
                                                           'IoT_Usage_8' = 'Q408',
                                                           'IoT_Usage_9' = 'Q409', 
                                                           'IoT_Usage_10' = 'Q410',
                                                           'IoT_Usage_11' = 'Q411', 
                                                           'IoT_Usage_12' = 'Q412',
                                                           'IoT_Usage_13' = 'Q413',
                                                           'IoT_Usage_14' = 'Q414',
                                                           'IoT_Usage_15' = 'Q415',
                                                           'IoT_Usage_16' = 'Q416',
                                                           'IoT_Usage_17' = 'Q417',
                                                           'IoT_Usage_18' = 'Q418',
                                                           'IoT_Usage_19' = 'Q419',
                                                           'IoT_Usage_20' = 'Q420',
                                                           'IoT_Usage_21' = 'Q421',
                                                           'IoT_Usage_22' = 'Q422',
                                                           'IoT_Usage_23' = 'Q423',
                                                           'IoT_Usage_24' = 'Q424',
                                                           'IoT_Usage_25' = 'Q425',
                                                           'IoT_Usage_other' = 'Q4_7',
                                                           'GA_Freq_1' = 'Q5_1',
                                                           'GA_Freq_2' = 'Q5_2',
                                                           'GA_Freq_3' = 'Q5_3',
                                                           'GA_Freq_4' = 'Q5_4',
                                                           'GA_Freq_5' = 'Q5_5',
                                                           'GA_Freq_6' = 'Q5_6',
                                                           'GA_Freq_7' = 'Q5_7',
                                                           'GA_Freq_8' = 'Q5_8',
                                                           'GA_Freq_9' = 'Q5_9',
                                                           'GA_Freq_10' = 'Q5_10',
                                                           'GA_Freq_11' = 'Q5_11',
                                                           'IoT_Freq_1' = 'Q6_1',
                                                           'IoT_Freq_2' = 'Q6_2',
                                                           'IoT_Freq_3' = 'Q6_3',
                                                           'IoT_Freq_4' = 'Q6_4',
                                                           'IoT_Freq_5' = 'Q6_5',
                                                           'IoT_Freq_6' = 'Q6_6',
                                                           'IoT_Freq_7' = 'Q6_7',
                                                           'IoT_Freq_8' = 'Q6_8',
                                                           'IoT_Freq_9' = 'Q6_9',
                                                           'IoT_Freq_10' = 'Q6_10',
                                                           'IoT_Freq_11' = 'Q6_11',
                                                           'IoT_Freq_12' = 'Q6_12',
                                                           'IoT_Freq_13' = 'Q6_13',
                                                           'IoT_Freq_14' = 'Q6_14',
                                                           'IoT_Freq_15' = 'Q6_15',
                                                           'IoT_Freq_16' = 'Q6_16',
                                                           'Child_Nr' = 'Q8',
                                                           'Child_Age' = 'Q28',
                                                           'Child_Gender' = 'Q29',
                                                           'Child_Temp_1' = 'Q30_1',
                                                           'Child_Temp_2' = 'Q30_2',
                                                           'Child_Temp_3' = 'Q30_3',
                                                           'PMMS_1' = 'Q31_1',
                                                           'PMMS_2' = 'Q31_2',
                                                           'PMMS_3' = 'Q31_3',
                                                           'PMMS_4' = 'Q31_4',
                                                           'PMMS_5' = 'Q31_5',
                                                           'PMMS_6' = 'Q31_6',
                                                           'SS_cousage_1' = 'Q11_1',
                                                           'SS_cousage_2' = 'Q11_2',
                                                           'SS_childusage_1' = 'Q42_1',
                                                           'SS_childusage_2' = 'Q42_2',
                                                           'Incorporation' = 'Q12',
                                                           'Child_Parasocial_1' = 'Q32_1',
                                                           'Child_Parasocial_2' = 'Q32_2',
                                                           'Child_Parasocial_3' = 'Q32_3',
                                                           'Child_Parasocial_4' = 'Q32_4',
                                                           'Child_Parasocial_5' = 'Q32_5',
                                                           'Location' = 'Q13',
                                                           'Early_Adopter' = 'Q14',
                                                           'Conversion' = 'Q15',
                                                           'TAM_PEoU_1' = 'Q17_1',
                                                           'TAM_PEoU_2' = 'Q17_2',
                                                           'TAM_PEoU_3' = 'Q17_3',
                                                           'TAM_PEoU_4' = 'Q17_4',
                                                           'TAM_PU_1' = 'Q18_1',
                                                           'TAM_PU_2' = 'Q18_2',
                                                           'TAM_PU_3' = 'Q18_3',
                                                           'TAM_PU_4' = 'Q18_4',
                                                           'TAM_E_1' = 'Q19_1',
                                                           'TAM_E_2' = 'Q19_2',
                                                           'TAM_E_3' = 'Q19_3',
                                                           'TAM_E_4' = 'Q19_4',
                                                           'TAM_SS' = 'Q20',
                                                           'TAM_SI_1' = 'Q21_1',
                                                           'TAM_SI_2' = 'Q21_2',
                                                           'TAM_SI_3' = 'Q21_3',
                                                           'TAM_UI_1' = 'Q22_1',
                                                           'TAM_UI_2' = 'Q22_2',
                                                           'TAM_UI_3' = 'Q22_3',
                                                           'IL_1' = 'Q25_1',
                                                           'IL_2' = 'Q25_2',
                                                           'IL_3' = 'Q25_3',
                                                           'IL_4' = 'Q25_4',
                                                           'IL_5' = 'Q25_5',
                                                           'TT_1' = 'Q26_1',
                                                           'TT_2' = 'Q26_2',
                                                           'TT_3' = 'Q26_3'))
   
   #to check
   # View(rosie_dataset_renamed)
   names(rosie_dataset_renamed)
   
#-----------------------------------------------#
### ROSIE TARGET GROUP ##########################
#-----------------------------------------------#
   
   #filtering responses for Rosie target group (in total: 224 responses, completes: 183)
   library(dplyr)
   ?dplyr::filter
   rosie_dataset_renamed_families_complete <- dplyr::filter(rosie_dataset_renamed, Child_Gender != 0 & STATUS == 1)
   #View(rosie_dataset_renamed_families_complete)
   
#----------------------------------------------------------------------#
#       CONTINUE WITH FILTERED DATASET
   
#------------------------------------------#
### DATA CLEANING ##########################
#------------------------------------------#
  
  #make sure the following variables are coded as explicit factors:
    #Child_Gender
    #SOCIALEKLASSE2016 (for SES) 
    #STATUS (complete or screened-out)
    #GSL (parent gender)
   rosie_dataset_renamed_families_complete$Child_Gender <- as.factor(rosie_dataset_renamed_families_complete$Child_Gender)
   rosie_dataset_renamed_families_complete$SOCIALEKLASSE2016 <- as.factor(rosie_dataset_renamed_families_complete$SOCIALEKLASSE2016)
   rosie_dataset_renamed_families_complete$STATUS <- as.factor(rosie_dataset_renamed_families_complete$STATUS)
   rosie_dataset_renamed_families_complete$GSL <- as.factor(rosie_dataset_renamed_families_complete$GSL)

   
  #recoding values of variables
    #Frequency of personal use - FoPersU (Q5 GA_Freq) --> relevant for smart speakers are items: GA_Freq_8-11
    #Here, we computed the mean for each participant on their answers to the frequency of smart speaker usage to get an indicator for their previous experience 
    #(the higher this value the higher the FoPersU; scale from 1-6)
    library(fame)
    rosie_dataset_renamed_families_complete$FoPersU <- rowMeans(rosie_dataset_renamed_families_complete[, 36:39], na.rm = T)
    is.numeric(rosie_dataset_renamed_families_complete$FoPersU)
    # View(rosie_dataset_renamed_families_complete)
    
  
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
    # View(rosie_dataset_renamed_families_complete)
  
  #UI
      #We asked as our DV how the families assume their usage to look like in the near future (TAM_UI_1 myself, TAM_UI_2 with my child, TAM_UI_3 child individually)
      #We also asked how the families' usage has looked like until now (SS_cousage_1: samen met uw kind smart speaker without display, SS_cousage_2: samen met uw kind smart speaker with display, SS_childusage_1: uw kind zelfstandig without display, SS_childusage_2: uw kind zelfstandig with display)
        
        #Here, we computed the mean for each participant on their answers to the four questions 
        #(we only need to know the level of co-usage and individual child usage, and not whether this was with a smart speaker with or without display) 
        #(the higher the score the stronger the usage; scale from 1-6)
    
        #SS_cousage_1 & 2  
        rosie_dataset_renamed_families_complete$UI_togetherwithchild <- rowMeans(rosie_dataset_renamed_families_complete[, 68:69], na.rm = T)
        is.numeric(rosie_dataset_renamed_families_complete$UI_togetherwithchild)
        rosie_dataset_renamed_families_complete$UI_togetherwithchild
        # View(rosie_dataset_renamed_families_complete)
        
        #SS_childusage_1 & 2
        rosie_dataset_renamed_families_complete$UI_childindividually <- rowMeans(rosie_dataset_renamed_families_complete[, 70:71], na.rm = T)
        is.numeric(rosie_dataset_renamed_families_complete$UI_childindividually)
        rosie_dataset_renamed_families_complete$UI_childindividually
        # View(rosie_dataset_renamed_families_complete)
        
        #Based on this information we can also calculate how many parents have used the virtual assistant only by themselves and 
        #neither together with their child nor having let their child use it independently
        rosie_dataset_renamed_families_complete$current_usage <- ifelse(rosie_dataset_renamed_families_complete$UI_togetherwithchild == 1 &
                                                                           rosie_dataset_renamed_families_complete$UI_childindividually == 1, 1, 2)
        #1 = parent only
        #2 = with child
          
        # View(rosie_dataset_renamed_families_complete)
        
        summary(rosie_dataset_renamed_families_complete[,c(117:119)]) #there seems to be one NA in UI_childindividually, this is row 74 (in R) = pp 888, this was due to a fault in the survey programming
        
          #inspecting this 1 NA further  
          #create new subset df 
          rosie_UI <- rosie_dataset_renamed_families_complete[,c(117:119, 98:100)]
          #View(rosie_UI)
          
          #and now remove missing values
          rosie_UI_noNA <- na.omit(rosie_UI)
          # View(rosie_UI_noNA)
        
          #correlating the control variables UI_togetherwithchild & UI_childindividually with the DVs TAM_UI_1 myself, TAM_UI_2 with my child, TAM_UI_3 child individually
            round(cor(rosie_UI_noNA), 2)
            #                       UI_togetherwithchild UI_childindividually UI_parentonly TAM_UI_1 TAM_UI_2 TAM_UI_3
            # UI_togetherwithchild                  1.00                ! 0.78        ! -0.64     -0.05    ! 0.45    ! 0.36
            # UI_childindividually                  0.78                  1.00        ! -0.55     -0.10    ! 0.43    ! 0.40
            # UI_parentonly                        -0.64                 -0.55           1.00      0.07    !-0.42     -0.29
            # TAM_UI_1                             -0.05                 -0.10           0.07      1.00     -0.04      0.06
            # TAM_UI_2                              0.45                  0.43          -0.42     -0.04      1.00      0.58
            # TAM_UI_3                              0.36                  0.40          -0.29      0.06      0.58      1.00
            
            # >> reveals:
            #parents who have used the smart speaker together with the child are likely to have let the child use it individually as well (.78)
            #parents who have used the smart speaker together with the child are unlikely to intend to use it only by themselves (-.64)
            #parents who have let their child use the smart speaker independently are unlikely to intend to use it only by themselves (-.55)
            #parents who intend to use the smart speaker together with their child are likely to have used it together with their child (.45) or by the child individually already
            #parents who intend to use the smart speaker together with their child are unlikely to have used it only by themselves so far (-.42)
            #parents who intend to let their used use the smart speaker independently are likely to have allowed this (.40) or have used it together with their child already (.36)
            # >> co-usage and child-individual usage seem to go mostly hand-in-hand
            
#----------------------------------------------------------------------#
#       CONTINUE WITH CLEANED DATASET
  
  # View(rosie_dataset_renamed_families_complete)
  
  #restarting dataset naming
  rosie <- rosie_dataset_renamed_families_complete
  View(rosie)
  names(rosie)
  
#---------------------------------------------------#
### INSPECTING MISSINGNESS ##########################
#---------------------------------------------------#
  
  #Where are missing values?
  complete.cases(rosie)
  ?complete.cases
  summary(rosie)
  options(max.print=1000000)
 
  #plotting the missing values for variables relevant for LCA 
  names(rosie)
  rosie_LCArelevant <- rosie[,-c(2:55, 68:72, 78:100, 109, 116:118)] 
  # View(rosie_LCArelevant)
  library(VIM)
  aggr(rosie_LCArelevant)
  missingness_LCA <- aggr(rosie_LCArelevant)
  missingness_LCA 
  summary(missingness_LCA)
  # >> no missingness
  
  #plotting the missing values for variables relevant for SEM later to identify their pattern
  rosie_SEMrelevant <- rosie[,-c(2:81, 101:119)]
  #View(rosie_SEMrelevant)
  library(VIM)
  aggr(rosie_SEMrelevant)
  missingness_SEM <- aggr(rosie_SEMrelevant)
  missingness_SEM
  summary(missingness_SEM)
  #>> no missingness

#----------------------------------------------------------------------------------------------------------------#
  
#------------------------------------------------------#
### CHECKING MEASUREMENTMENTS ##########################
#------------------------------------------------------#
  
  #-------------------------------------------------------------------------------------#
  #1) Confirmatory Factor Analysis for all model variables built up of two or more items
    #TAM_SS and TAM_UI only consist of one item and were therefore excluded here
  
    #Dispositional: 
      #TT >> 3 items
      (#Child_Temp >> 3 items)
      #Child_Parasocial >> 5 items
    
    #Developmental: NONE
  
    #Social: 
      #PMMS >> 6 items
  
    #TAM: 
      #TAM_PEoU >> 4 items
      #TAM_PU >> 4 items
      #TAM_E >> 4 items
      #TAM_SI >> 3 items
      (#TAM_UI >> 3 items)
      #IL >> 5 items
      
  #2) Extract factor scores
        
  #3) Cronbach's Alpha
  
#-------------------------------------------------------------------------------------#
  
#---------------------------------------------------#
### 1) CFA (Measurement model)##########################
#---------------------------------------------------#
  

#Prep: Check for normality and outliers
### Criterion for judgement on skewness:
### If the skewness is between -0.5 and 0.5, the data are fairly symmetrical.
### If the skewness is between -1 and -0.5 (negatively skewed) or between 0.5 and 1(positively skewed), the data are moderately skewed.
### If the skewness is less than -1 (negatively skewed) or greater than 1 (positively skewed), the data are highly skewed.

### Criterion for judgment on kurtosis:
### A normal distribution has a kurtosis of 3, which follows from the fact that a normal distribution does have some of its mass in its tails. 
### A distribution with a kurtosis greater than 3 has more returns out in its tails than the normal.
### A distribution with kurtosis less than 3 has fewer returns in its tails than the normal.


  #https://stats.idre.ucla.edu/r/seminars/rcfa/ 
  #https://stats.idre.ucla.edu/wp-content/uploads/2020/02/cfa.r
  
  ### Historically, factor analysis is used to answer the question, how much common variance is shared among the items. 
  ### Confirmatory factor analysis borrows many of the same concepts from exploratory factor analysis 
  ### except that instead of letting the data tell us the factor structure, we pre-determine the factor structure 
  ### and verify the psychometric structure of a previously developed scale.
  ### In psychology and the social sciences, the magnitude of a correlation above 0.30 is considered a medium effect size. 
  ### The goal of factor analysis is to model the interrelationships between many items with fewer unobserved or latent variables.
  
  #operators:
  #~ predict, used for regression of observed outcome to observed predictors
  #=~ indicator, used for latent variable to observed indicator in factor analysis measurement models
  #~~ covariance
  #~1 intercept or mean (e.g., q01 ~ 1 estimates the mean of variable q01)
  #1* fixes parameter or loading to one
  #NA* frees parameter or loading (useful to override default marker method)
  #a* labels the parameter ‘a’, used for model constraints
  
  #For adequate model fit we inspect the following indices:
  # 1. Model chi-square is the chi-square statistic we obtain from the maximum likelihood statistic (in lavaan, this is known as the Test Statistic for the Model Test User Model)
  # 2. CFI is the Confirmatory Factor Index – values can range between 0 and 1 (values greater than 0.90, conservatively 0.95, indicate good fit)
  # 3. TLI Tucker Lewis Index which also ranges between 0 and 1 (if it’s greater than 1 it should be rounded to 1) with values greater than 0.90 indicating good fit. If the CFI and TLI are less than one, the CFI is always greater than the TLI.
  # 4. RMSEA is the root mean square error of approximation (the lower the better). In lavaan, you also obtain a p-value of close fit, that the RMSEA ≤ 0.05. If you reject the model, it means your model is not a close fitting model.
  # Thus, we use the following fit index criteria: Chi-Square > .05, CFI > 0.95, TLI > 0.90 and RMSEA < 0.10/0.08 (https://www.cscu.cornell.edu/news/Handouts/SEM_fit.pdf)
     
  #for descriptives
  library(pastecs)
  library(psych)
  #for CFA
  library(lavaan)
  
        #Dispositional: 
  
          ### TT >> 3 items ##########################
          
            #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                #visually
                library(lattice)
                boxplot(rosie$TT_1)
                boxplot(rosie$TT_2)
                boxplot(rosie$TT_3)
                hist(rosie$TT_1)  
                hist(rosie$TT_2)
                hist(rosie$TT_3)
                densityplot(rosie$TT_1)
                densityplot(rosie$TT_2)
                densityplot(rosie$TT_3)
                
                #numerically 
                #standardize a variable and count the number of cases with values greater or less than 3
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
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,106:108]), 2)
          #     TT_1 TT_2 TT_3
          #TT_1 1.00 0.67 0.44
          #TT_2 0.67 1.00 0.49
          #TT_3 0.44 0.49 1.00
  
          #Step 2: variance-covariance matrix
          round(cov(rosie[,106:108]), 2) 
          #     TT_1 TT_2 TT_3
          #TT_1 2.17 1.39 0.79
          #TT_2 1.39 1.98 0.84
          #TT_3 0.79 0.84 1.50
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1a  <- ' TT_f  =~ TT_1 + TT_2 + TT_3' 
          onefac3items_TT <- cfa(m1a, data=rosie) 
          summary(onefac3items_TT, fit.measures=TRUE, standardized=TRUE) # >> Seems like a "just" identified model. Wait and see for testing whole measurement model in SEM.
          # >> fit index criteria: Chi-Square = 0 because 0 df just identified, CFI = 1 > 0.95, TLI = 1 > 0.90 and RMSEA = 0 < 0.10
    
          
          ### IL >> 5 items #########################      
          
          #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                #visually
                library(lattice)
                boxplot(rosie$IL_1)
                boxplot(rosie$IL_2) 
                boxplot(rosie$IL_3)
                boxplot(rosie$IL_4) 
                boxplot(rosie$IL_5) 
                hist(rosie$IL_1) #so not normal
                hist(rosie$IL_2) #so not normal
                hist(rosie$IL_3) #so not normal
                hist(rosie$IL_4) #so not normal
                hist(rosie$IL_5) #so not normal
                densityplot(rosie$IL_1)
                densityplot(rosie$IL_2)
                densityplot(rosie$IL_3)
                densityplot(rosie$IL_4)
                densityplot(rosie$IL_5)
                
                #numerically 
                #standardize a variable and count the number of cases with values greater or less than 3
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
          #The function cor specifies the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,101:105]),2) 
          #     IL_1 IL_2 IL_3 IL_4 IL_5
          #IL_1 1.00 0.56 0.69 0.53 0.44
          #IL_2 0.56 1.00 0.66 0.66 0.53
          #IL_3 0.69 0.66 1.00 0.56 0.50
          #IL_4 0.53 0.66 0.56 1.00 0.57
          #IL_5 0.44 0.53 0.50 0.57 1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,101:105]),2) 
          #     IL_1 IL_2 IL_3 IL_4 IL_5
          #IL_1 1.93 1.02 1.33 1.30 1.00
          #IL_2 1.02 1.69 1.19 1.51 1.11
          #IL_3 1.33 1.19 1.90 1.37 1.11
          #IL_4 1.30 1.51 1.37 3.10 1.61
          #IL_5 1.00 1.11 1.11 1.61 2.60
          
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
          # View(IL_EFA_df)
          
          #parallel analysis to get number of factors
          parallel2 <- fa.parallel(IL_EFA_df, fm = 'minres', fa = 'fa') #suggests indeed 2 factors
          
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
          
          
          
          ### Child_Temp >> 3 items ##########################
  
            #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                #visually
                library(lattice)
                boxplot(rosie$Child_Temp_1)
                boxplot(rosie$Child_Temp_2)
                boxplot(rosie$Child_Temp_3)
                hist(rosie$Child_Temp_1)  
                hist(rosie$Child_Temp_2)
                hist(rosie$Child_Temp_3)
                densityplot(rosie$Child_Temp_1)
                densityplot(rosie$Child_Temp_2)
                densityplot(rosie$Child_Temp_3)
                
                #numerically 
                #standardize a variable and count the number of cases with values greater or less than 3
                standardized_Child_Temp <- scale(rosie[,c(59:61)]) 
                outliers_Child_Temp <- colSums(abs(standardized_Child_Temp)>=3, na.rm = T) 
                outliers_Child_Temp
                #Child_Temp_1 Child_Temp_2 Child_Temp_3 
                #0            0            0 
                
                # >> Child_Temp_1 = negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers
                # >> Child_Temp_2 = fairly symmetrical (skew), fewer returns in its tail than normal (kurtosis), no outliers
                # >> Child_Temp_3 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers
          
          #Step 1: correlations
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,59:61]), 2) # >> Here, it seems running a CFA does not really make much sense due to the extremely low correlations. I guess that is due to the adjusted dense scale?
          #             Child_Temp_1 Child_Temp_2 Child_Temp_3
          #Child_Temp_1         1.00         0.03         0.14
          #Child_Temp_2         0.03         1.00        -0.04
          #Child_Temp_3         0.14        -0.04         1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,59:61]), 2) 
          #             Child_Temp_1 Child_Temp_2 Child_Temp_3
          #Child_Temp_1         2.15         0.09         0.34
          #Child_Temp_2         0.09         3.10        -0.13
          #Child_Temp_3         0.34        -0.13         2.63
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1b  <- ' f  =~ Child_Temp_1 + Child_Temp_2 + Child_Temp_3' 
          onefac3items_Child_Temp <- cfa(m1b, data=rosie) 
          summary(onefac3items_Child_Temp, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = / because 0 df just identified, CFI = 1 > 0.95, TLI = 1 > 0.90 and RMSEA p-value = NA???? < 0.10
  
              #After inspecting the fit indices and revising the scale, we confirm that each item represents a separate temperament type 
              #and therefore we recode each item into a separate variable with which we proceed.
          
                  #renaming Child_Temp items along original single-item Temperament Scale by Sleddens et al. (2012)
                  library(dplyr)
                  rosie <- dplyr::rename(rosie, c('Child_Temp_Extraversion' = 'Child_Temp_1',
                                         'Child_Temp_Negative_Affectivity' = 'Child_Temp_2',
                                         'Child_Temp_Effortful_Control' = 'Child_Temp_3'))
                  names(rosie)
          
          
          ### Child_Parasocial >> 5 items#########################
          
          #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                #visually
                library(lattice)
                boxplot(rosie$Child_Parasocial_1)
                boxplot(rosie$Child_Parasocial_2) #outlier (not confirmed numerically)
                boxplot(rosie$Child_Parasocial_3)
                boxplot(rosie$Child_Parasocial_4) #outlier (confirmed numerically)
                boxplot(rosie$Child_Parasocial_5) #outlier (confirmed numerically)
                hist(rosie$Child_Parasocial_1) #so not normal
                hist(rosie$Child_Parasocial_2)
                hist(rosie$Child_Parasocial_3) #so not normal
                hist(rosie$Child_Parasocial_4) #so not normal
                hist(rosie$Child_Parasocial_5) #so not normal
                densityplot(rosie$Child_Parasocial_1)
                densityplot(rosie$Child_Parasocial_2)
                densityplot(rosie$Child_Parasocial_3)
                densityplot(rosie$Child_Parasocial_4)
                densityplot(rosie$Child_Parasocial_5)
                
                #numerically 
                #standardize a variable and count the number of cases with values greater or less than 3
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
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,73:77]), 2) 
          #                   Child_Parasocial_1 Child_Parasocial_2 Child_Parasocial_3 Child_Parasocial_4 Child_Parasocial_5
          #Child_Parasocial_1               1.00               0.31               0.56               0.69               0.68
          #Child_Parasocial_2               0.31               1.00               0.40               0.27               0.29
          #Child_Parasocial_3               0.56               0.40               1.00               0.54               0.57
          #Child_Parasocial_4               0.69               0.27 !!            0.54               1.00               0.81
          #Child_Parasocial_5               0.68               0.29  !!           0.57               0.81               1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,73:77]), 2)
          #                   Child_Parasocial_1 Child_Parasocial_2 Child_Parasocial_3 Child_Parasocial_4 Child_Parasocial_5
          #Child_Parasocial_1               1.40               0.45               0.78               0.83               0.86
          #Child_Parasocial_2               0.45               1.48               0.58               0.33               0.38
          #Child_Parasocial_3               0.78               0.58               1.39               0.65               0.72
          #Child_Parasocial_4               0.83               0.33               0.65               1.02               0.87
          #Child_Parasocial_5               0.86               0.38               0.72               0.87               1.14
          
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
                # View(Child_Parasocial_EFA_df)
                
                #parallel analysis to get number of factors
                parallel1 <- fa.parallel(Child_Parasocial_EFA_df, fm = 'minres', fa = 'fa') #suggests 2 factors, which corresponds to the bad model fit and modindices results above
                
                #factor analysis for rotation (first using oblique rotation to check whether factors correlate with each other)
                Child_Parasocial_2factors <- fa(Child_Parasocial_EFA_df,nfactors = 2,rotate = 'oblimin',fm='minres') #and indeed, factors seem to correlate with each other, so oblique rotation is better here
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
          
          ### PMMS >> 6 items #########################
          
          #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                #visually
                library(lattice)
                boxplot(rosie$PMMS_1) 
                boxplot(rosie$PMMS_2) 
                boxplot(rosie$PMMS_3) 
                boxplot(rosie$PMMS_4) 
                boxplot(rosie$PMMS_5) 
                boxplot(rosie$PMMS_6) 
                hist(rosie$PMMS_1) 
                hist(rosie$PMMS_2) 
                hist(rosie$PMMS_3) 
                hist(rosie$PMMS_4) 
                hist(rosie$PMMS_5) 
                hist(rosie$PMMS_6)
                densityplot(rosie$PMMS_1)
                densityplot(rosie$PMMS_2)
                densityplot(rosie$PMMS_3)
                densityplot(rosie$PMMS_4)
                densityplot(rosie$PMMS_5)
                densityplot(rosie$PMMS_6)
                
                #numerically 
                #standardize a variable and count the number of cases with values greater or less than 3
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
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,62:67]), 2) 
          #       PMMS_1 PMMS_2 PMMS_3 PMMS_4 PMMS_5 PMMS_6
          #PMMS_1   1.00   0.59   0.43   0.22   0.25   0.19
          #PMMS_2   0.59   1.00   0.38   0.29   0.36   0.32
          #PMMS_3   0.43   0.38   1.00   0.23   0.59   0.23
          #PMMS_4   0.22   0.29   0.23   1.00   0.30   0.60
          #PMMS_5   0.25   0.36   0.59   0.30   1.00   0.29
          #PMMS_6   !!0.19 0.32   0.23   0.60   0.29   1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,62:67]), 2) 
          #       PMMS_1 PMMS_2 PMMS_3 PMMS_4 PMMS_5 PMMS_6
          #PMMS_1   0.61   0.43   0.29   0.13   0.19   0.12
          #PMMS_2   0.43   0.88   0.31   0.20   0.33   0.24
          #PMMS_3   0.29   0.31   0.73   0.14   0.49   0.16
          #PMMS_4   0.13   0.20   0.14   0.52   0.21   0.34
          #PMMS_5   0.19   0.33   0.49   0.21   0.94   0.22
          #PMMS_6   0.12   0.24   0.16   0.34   0.22   0.63
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1d  <- ' f  =~ PMMS_1 + PMMS_2 + PMMS_3 + PMMS_4 + PMMS_5 + PMMS_6'
          onefac6items_PMMS <- cfa(m1d, data=rosie, std.lv=TRUE) 
          summary(onefac6items_PMMS, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .00 NOT > .05, CFI = .689 NOT > 0.95, TLI = .483 NOT > 0.90 and RMSEA = .241 < 0.10 
          #>> This bad fit could be an indicator for the actual three factor scale corresponding to the original scale structure
          
          #Step 4: three-factor CFA
          #two items per factor, default marker method
          m2d <- ' restrMed  =~ PMMS_1 + PMMS_2 
              negacMed =~ PMMS_3 + PMMS_5 
              posacMed   =~ PMMS_4 + PMMS_6'
          threefac2items_PMMS <- cfa(m2d, data=rosie, std.lv=TRUE) 
          summary(threefac2items_PMMS, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .028 NOT > .05, CFI = .974 > 0.95, TLI = .934 > 0.90 and RMSEA = .086 < 0.10 >> Much better fit
          
        
          
      #TAM: 
        
          ### TAM_PEoU >> 4 items #########################
          
          #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                #visually
                library(lattice)
                boxplot(rosie$TAM_PEoU_1)
                boxplot(rosie$TAM_PEoU_2) 
                boxplot(rosie$TAM_PEoU_3)
                boxplot(rosie$TAM_PEoU_4) 
                hist(rosie$TAM_PEoU_1) 
                hist(rosie$TAM_PEoU_2)
                hist(rosie$TAM_PEoU_3) 
                hist(rosie$TAM_PEoU_4) 
                densityplot(rosie$TAM_PEoU_1)
                densityplot(rosie$TAM_PEoU_2)
                densityplot(rosie$TAM_PEoU_3)
                densityplot(rosie$TAM_PEoU_4)
                
                #numerically 
                #standardize a variable and count the number of cases with values greater or less than 3
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
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,82:85]), 2) 
          #           TAM_PEoU_1 TAM_PEoU_2 TAM_PEoU_3 TAM_PEoU_4
          #TAM_PEoU_1       1.00       0.54       0.76       0.76
          #TAM_PEoU_2       0.54       1.00       0.51       0.54
          #TAM_PEoU_3       0.76       0.51       1.00       0.74
          #TAM_PEoU_4       0.76       0.54       0.74       1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,82:85]), 2) 
          #           TAM_PEoU_1 TAM_PEoU_2 TAM_PEoU_3 TAM_PEoU_4
          #TAM_PEoU_1       1.69       1.06       1.34       1.41
          #TAM_PEoU_2       1.06       2.25       1.05       1.15
          #TAM_PEoU_3       1.34       1.05       1.87       1.44
          #TAM_PEoU_4       1.41       1.15       1.44       2.03
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1e  <- ' TAM_PEoU_f  =~ TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4'
          onefac4items_TAM_PEoU <- cfa(m1e, data=rosie, std.lv=TRUE) 
          summary(onefac4items_TAM_PEoU, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .861 > .05, CFI = 1 > 0.95, TLI = 1.012 > 0.90 and RMSEA  = 0 < 0.10 >> VERY NICE
          
          
          ### TAM_PU >> 4 items #########################
          
          #Prep: Check for normality and outliers
          ### Criterion for judgement on skewness:
          ### If the skewness is between -0.5 and 0.5, the data are fairly symmetrical.
          ### If the skewness is between -1 and -0.5 (negatively skewed) or between 0.5 and 1(positively skewed), the data are moderately skewed.
          ### If the skewness is less than -1 (negatively skewed) or greater than 1 (positively skewed), the data are highly skewed.
          
          ### Criterion for judgment on kurtosis:
          ### A normal distribution has a kurtosis of 3, which follows from the fact that a normal distribution does have some of its mass in its tails. 
          ### A distribution with a kurtosis greater than 3 has more returns out in its tails than the normal.
          ### A distribution with kurtosis less than 3 has fewer returns in its tails than the normal.
          
            #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                #visually
                library(lattice)
                boxplot(rosie$TAM_PU_1)
                boxplot(rosie$TAM_PU_2) 
                boxplot(rosie$TAM_PU_3)
                boxplot(rosie$TAM_PU_4) 
                hist(rosie$TAM_PU_1) 
                hist(rosie$TAM_PU_2)
                hist(rosie$TAM_PU_3) 
                hist(rosie$TAM_PU_4) 
                densityplot(rosie$TAM_PU_1)
                densityplot(rosie$TAM_PU_2)
                densityplot(rosie$TAM_PU_3)
                densityplot(rosie$TAM_PU_4)
                # >> very normally distributed
                
                #numerically 
                #standardize a variable and count the number of cases with values greater or less than 3
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
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,86:89]), 2) 
          #         TAM_PU_1 TAM_PU_2 TAM_PU_3 TAM_PU_4
          #TAM_PU_1     1.00     0.76     0.83     0.72
          #TAM_PU_2     0.76     1.00     0.78     0.62
          #TAM_PU_3     0.83     0.78     1.00     0.68
          #TAM_PU_4     0.72     0.62     0.68     1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,86:89]), 2) 
          #         TAM_PU_1 TAM_PU_2 TAM_PU_3 TAM_PU_4
          #TAM_PU_1     2.47     1.89     2.10     1.63
          #TAM_PU_2     1.89     2.47     1.97     1.39
          #TAM_PU_3     2.10     1.97     2.60     1.58
          #TAM_PU_4     1.63     1.39     1.58     2.07
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1f  <- ' TAM_PU_f  =~ TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4'
          onefac4items_TAM_PU <- cfa(m1f, data=rosie, std.lv=TRUE) 
          summary(onefac4items_TAM_PU, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .234 > .05, CFI = .998 > 0.95, TLI = .995 > 0.90 and RMSEA = .050 < 0.10 >> VERY NICE
          
          
          ### TAM_E >> 4 items #########################
          
          #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                #visually
                library(lattice)
                boxplot(rosie$TAM_E_1)
                boxplot(rosie$TAM_E_2) #outliers?
                boxplot(rosie$TAM_E_3) #outliers?
                boxplot(rosie$TAM_E_4) 
                hist(rosie$TAM_E_1) 
                hist(rosie$TAM_E_2)
                hist(rosie$TAM_E_3) 
                hist(rosie$TAM_E_4) 
                densityplot(rosie$TAM_E_1)
                densityplot(rosie$TAM_E_2)
                densityplot(rosie$TAM_E_3)
                densityplot(rosie$TAM_E_4)
                  
                #numerically 
                #standardize a variable and count the number of cases with values greater or less than 3
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
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,90:93]),2) 
          #        TAM_E_1 TAM_E_2 TAM_E_3 TAM_E_4
          #TAM_E_1    1.00    0.83    0.83    0.60
          #TAM_E_2    0.83    1.00    0.78    0.56
          #TAM_E_3    0.83    0.78    1.00    0.64
          #TAM_E_4    0.60    0.56    0.64    1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,90:93]),2)
          #        TAM_E_1 TAM_E_2 TAM_E_3 TAM_E_4
          #TAM_E_1    1.90    1.54    1.54    1.23
          #TAM_E_2    1.54    1.80    1.41    1.11
          #TAM_E_3    1.54    1.41    1.83    1.28
          #TAM_E_4    1.23    1.11    1.28    2.19
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1g  <- ' TAM_E_f  =~ TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4'
          onefac4items_TAM_E <- cfa(m1g, data=rosie,std.lv=TRUE) 
          summary(onefac4items_TAM_E, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .058 > .05, CFI = .993 > 0.95, TLI = .979 > 0.90 and RMSEA = .100 NOT < 0.10 but exactly that >> NICE
          
          
          ### TAM_SI >> 3 items #########################
          
          #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                #visually
                library(lattice)
                boxplot(rosie$TAM_SI_1)
                boxplot(rosie$TAM_SI_2) 
                boxplot(rosie$TAM_SI_3)
                hist(rosie$TAM_SI_1) #so not normal
                hist(rosie$TAM_SI_2) #so not normal
                hist(rosie$TAM_SI_3) #so not normal
                densityplot(rosie$TAM_SI_1)
                densityplot(rosie$TAM_SI_2)
                densityplot(rosie$TAM_SI_3)
                
                #numerically 
                #standardize a variable and count the number of cases with values greater or less than 3
                standardized_TAM_SI <- scale(rosie[,c(95:97)]) 
                outliers_TAM_SI <- colSums(abs(standardized_TAM_SI)>=3, na.rm = T) 
                outliers_TAM_SI
                #TAM_SI_1 TAM_SI_2 TAM_SI_3 
                #0        0        0 
              
          #Step 1: correlations
          #The function cor specifies the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,95:97]),2) 
          #          TAM_SI_1 TAM_SI_2 TAM_SI_3
          # TAM_SI_1     1.00     0.83     0.65
          # TAM_SI_2     0.83     1.00     0.61
          # TAM_SI_3     0.65     0.61     1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,95:97]),2) 
          #          TAM_SI_1 TAM_SI_2 TAM_SI_3
          # TAM_SI_1     2.69     2.32     1.94
          # TAM_SI_2     2.32     2.86     1.88
          # TAM_SI_3     1.94     1.88     3.31
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1h  <- ' TAM_SI_f  =~ TAM_SI_1 + TAM_SI_2 + TAM_SI_3 '
          onefac3items_TAM_SI <- cfa(m1h, data=rosie) 
          summary(onefac3items_TAM_SI, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = 0 NOT > .05, CFI = 1 > 0.95, TLI = 1 > 0.90 and RMSEA = 0 < 0.10         
          
              #to double check this structure let's run an EFA
              
              library(psych)
              library(GPArotation)
              
              #creating a subset with the variables relevant for this EFA
              SI <- c("TAM_SI_1", "TAM_SI_2", "TAM_SI_3")
              SI
              SI_EFA_df <- rosie[SI]
              # View(SI_EFA_df)
              
              #parallel analysis to get number of factors
              parallel4 <- fa.parallel(SI_EFA_df, fm = 'minres', fa = 'fa') #suggests 1 factor, so we'll stick with CFA
          
          
              
#-------------------------------------------#
####---- 2) Extracting factors scores----####
#-------------------------------------------#
                
            #Journal of Computers in human Behaviour usually reports descriptives only on demographics and does not explicitly report anything on the extracted factor scores.
                
                #summary of all CFA models 
                    # onefac3items_TT
                    # twofac5items_IL
                    # twofac5items_Child_Parasocial
                    # threefac2items_PMMS
                    # onefac4items_TAM_PeoU
                    # onefac4items_TAM_PU
                    # onefac4items_TAM_E
                    # onefac3items_TAM_SI
                    #(onefac3items_TAM_UI)
                
                #predicting factor scores of all CFA models
                onefac3items_TTfitPredict <- as.data.frame(predict(onefac3items_TT))
                twofac5items_ILfitPredict <- as.data.frame(predict(twofac5items_IL))
                twofac5items_Child_ParasocialfitPredict <- as.data.frame(predict(twofac5items_Child_Parasocial))
                threefac2items_PMMSfitPredict <- as.data.frame(predict(threefac2items_PMMS)) 
                onefac4items_TAM_PeoUfitPredict <- as.data.frame(predict(onefac4items_TAM_PEoU))
                onefac4items_TAM_PUfitPredict <- as.data.frame(predict(onefac4items_TAM_PU))
                onefac4items_TAM_EfitPredict <- as.data.frame(predict(onefac4items_TAM_E))
                onefac3items_TAM_SIfitPredict <- as.data.frame(predict(onefac3items_TAM_SI))
                #onefac3items_TAM_UIfitPredict <- as.data.frame(predict(onefac3items_TAM_UI)) #R warns about some negative variances, this corresponds to the CFA results above

                
                #adding to rosie-dataset
                rosie_fscores <- cbind(rosie, onefac3items_TTfitPredict, twofac5items_ILfitPredict, twofac5items_Child_ParasocialfitPredict,
                                       threefac2items_PMMSfitPredict, onefac4items_TAM_PeoUfitPredict, onefac4items_TAM_PUfitPredict,  onefac4items_TAM_EfitPredict,
                                       onefac3items_TAM_SIfitPredict) 
                View(rosie_fscores)
                
        
#--------------------------------------#
####---- 3) Reliability analysis----####
#--------------------------------------#
                
        #https://rpubs.com/hauselin/reliabilityanalysis
        #raw_alpha: Cronbach’s α (values ≥ .7 or .8 indicate good reliability; Kline (1999))
          
          #Dispositional: 
          
          #TT >> 3 items
          TT <- rosie[, c(106:108)]
          psych::alpha(TT) ### --> 0.77
          
          #IL >> 5 items
          IL <- rosie[, c(101:105)]
          psych::alpha(IL) ### --> 0.86
          
                # #for each factor separately
                # Information <- rosie[, c(101, 103)]
                # psych::alpha(Information) ### --> 0.82
                # 
                # Navigation <- rosie[, c(102, 104:105)]
                # psych::alpha(Navigation) ### --> 0.8
          
          #Child_Parasocial >> 5 items
          Child_Parasocial <- rosie[, c(73:77)]
          psych::alpha(Child_Parasocial) ### --> 0.83
          
                # #for each factor separately
                # Anthropomorphism <- rosie[, c(73, 76:77)]
                # psych::alpha(Anthropomorphism) ### --> 0.89
                # 
                # Parasocial_relationship <- rosie[, c(74:75)]
                # psych::alpha(Parasocial_relationship) ### --> 0.57
                
          #Developmental: NONE
          
          #Social: 
          
          #PMMS >> 6 items 
          PMMS <- rosie[, c(62:67)]
          psych::alpha(PMMS) ### --> 0.76
          
              # #for each factor separately
              # restrMed <- rosie[, c(62:63)]
              # psych::alpha(restrMed) ### --> 0.73
              # 
              # negacMed <- rosie[, c(64, 66)]
              # psych::alpha(negacMed) ### --> 0.74
              # 
              # posacMed <- rosie[, c(65:67)]
              # psych::alpha(posacMed) ### --> 0.64

          
          #TAM: 
          
          #TAM_PEoU >> 4
          TAM_PEoU <- rosie[, c(82:85)]
          psych::alpha(TAM_PEoU) ### --> 0.87
          
          #TAM_PU >> 4
          TAM_PU <- rosie[, c(86:89)]
          psych::alpha(TAM_PU) ### --> 0.92
          
          #TAM_E >> 4
          TAM_E <- rosie[, c(90:93)]
          psych::alpha(TAM_E) ### --> 0.9
          
          #TAM_SI >> 3
          TAM_SI <- rosie[, c(95:97)]
          psych::alpha(TAM_SI) ### --> 0.87
          
          # TAM_UI >> 3 
          # TAM_UI <- rosie[, c(98:100)]
          # psych::alpha(TAM_UI) ### --> 0.43
          


###----------------------------------------------------------------------------------------------------------------###  
                
#---------------------------------------------------------------------------------#
### MORE DESCRIPTIVES ON DATASET INCLUDING FACTOR SCORES ##########################
#---------------------------------------------------------------------------------#
                
   #taking a numerical look
            
   library(psych)
   describe(rosie_fscores)
                
   library(psych)
   psych::describeBy(rosie_fscores, group = "GSL")
   # 1 = male, 2 = female
   
   #get percentages of social classes
   source("http://pcwww.liv.ac.uk/~william/R/crosstab.r")
   crosstab(rosie_fscores, row.vars = "SOCIALEKLASSE2016", type = "row.pct")
   # SOCIALEKLASSE2016      %
   # 1  43.17
   # 2  32.24
   # 5   2.73
   # 3  18.03
   # 4   3.83
   # Sum 100.00
   
   #checking household numbers
   crosstab(rosie_fscores, row.vars = "PERSONEN", type = "row.pct")
   # PERSONEN      %
   # 1   3.83 >> This is concerning!
   # 2   7.65
   # 3  16.94
   # 4  53.55
   # 5  14.21
   # 6   3.83
   # Sum 100.00
 
         #assign all 1s in the variable PERSONEN to the 2s because there cannot be a 1-person household for a parent+young child (mistake by survey company/participants)
         rosie_fscores$PERSONEN[rosie_fscores$PERSONEN == 1] <- 2
         #check if this worked
         crosstab(rosie_fscores, row.vars = "PERSONEN", type = "f")
         # PERSONEN Count
         # 2    21
         # 3    31
         # 4    98
         # 5    26
         # 6     7
         # Sum   183
         crosstab(rosie_fscores, row.vars = "PERSONEN", type = "row.pct")
         # PERSONEN      %
         # 2  11.48
         # 3  16.94
         # 4  53.55
         # 5  14.21
         # 6   3.83
         # Sum 100.00
         
   crosstab(rosie_fscores, row.vars = "Child_Nr", type = "row.pct")
   # Child_Nr      %
   # 2  67.76
   # 3  29.51
   # 4   2.19
   # 5   0.55
   # Sum 100.00
   
   
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
   round(cor(rosie_fscores[,c(139:142,94, 98:100)]),2)
   #            TAM_PEoU_f TAM_PU_f TAM_E_f TAM_SI_f TAM_SS TAM_UI_1 TAM_UI_2 TAM_UI_3
   # TAM_PEoU_f       1.00     0.44    0.63     0.15  -0.02     0.06     0.36     0.29
   # TAM_PU_f         0.44     1.00    0.58     0.40   0.21     0.13     0.45     0.36
   # TAM_E_f          0.63     0.58    1.00     0.25   0.05     0.11     0.53     0.33
   # TAM_SI_f         0.15     0.40    0.25     1.00   0.26     0.22     0.20     0.20
   # TAM_SS          -0.02     0.21    0.05     0.26   1.00     0.24     0.12     0.09
   # TAM_UI_1         0.06     0.13    0.11     0.22   0.24     1.00    -0.02     0.07
   # TAM_UI_2         0.36     0.45    0.53     0.20   0.12    -0.02     1.00     0.58
   # TAM_UI_3         0.29     0.36    0.33     0.20   0.09     0.07     0.58     1.00
   
         #pairwise correlations all in one scatterplot matrix
         library(car)
         scatterplotMatrix(~TAM_PEoU_f+TAM_PU_f+TAM_E_f+TAM_SI_f+TAM_SS+TAM_UI_1+TAM_UI_2+TAM_UI_3, data = rosie_fscores)
         
         #for better visual overview 
         library(devtools)
         #devtools::install_github("laresbernardo/lares")
         library(lares)

         corr_cross(rosie_fscores[,c(139:142,94, 98:100)], 
                    max_pvalue = 0.05, 
                    top = 20 
         )
  
         
   
      
###----------------------------------------------------------------------------------------------------------------###   
   
   #--------------------------------------------------#
   ### LATENT CLASS ANALYSIS ##########################
   #--------------------------------------------------#
   
   #Which variables go in the LCA? 
   
       #Dispositional: 
       # GSL
       # SOCIALEKLASSE2016
       # TT >> 3 items
       # IL >> 5 items (information + navigation)
       # FoPersU 
       # Child_Gender
       # Child Temperament
           # Child_Temp_Extraversion
           # Child_Temp_Negative_Affectivity
           # Child_Temp_Effortful_Control 
       # Child_Parasocial >> 5 items
           # anthopomorphism
           # parasocial relationship

       
       #Developmental:
       # LFT
       # Child_Age

         
       #Social: 
       # PMMS >> 6 items
           # restr
           # negac
           # posac
       # current_usage
       # household composition 
           # Child_Nr 
           # PERSONEN
       # smart-household-level
   
   
   # !!! LCA (when using poLCA package) only allows categorical indicators, so we convert all continuous variables into categorical ones, this way we also facilitate interpretation of classes
   
   #How to meaningfully categorize?
   
       #Dispositional: 
       # GSL >> as.factor
         rosie_fscores$PGender_f <- as.factor(rosie_fscores$GSL)
       # SOCIALEKLASSE2016 >> as.factor
         rosie_fscores$SES_f <- as.factor(rosie_fscores$SOCIALEKLASSE2016)
       # TT >> 3 items >> median split method because of conceptual understanding of the scale
       # IL >> 5 items (information + navigation) >> median split method because conceptual understanding of the scale
       # FoPersU >> convert into irregular vs. regular (based on weekly answer option as the cut-off)
       # Child_Gender > as.factor
         rosie_fscores$CGender_f <- as.factor(rosie_fscores$Child_Gender)
       # Child_Temp (Extraversion, Negative_Affectivity, Effortful_Control) >> scale ranged from -3 over 0 to +3, so since conceptually everything < 0 is a more or less clear "no", we categorize this way: ≤ 3 = 1, ≥ 4 = 2 
       # Child_Parasocial >> 5 items two factors (anthropomorphism & parasocial_relationship) >> median split method because conceptual understanding of the scale
       
       #Developmental:
       # LFT >> mean-split
       # Child_Age >> age group "pre-schoolers 3-5 years, age group "schoolkids" 6-8 years, which means 1-3 = 1 and 4-6 = 2
       
       #Social: 
       # PMMS >> 6 items (restsMed & negacMed & posacMed) >> modal split method because of conceptual understanding of the scale
       # current usage >> already categorical (from data cleaning)
         rosie_fscores$current_usage_f <- as.factor(rosie_fscores$current_usage)
       # household composition >> built up of Child_Nr and PERSONEN >> convert both items into factors
         rosie_fscores$Child_Nr_f <- as.factor(rosie_fscores$Child_Nr)
         rosie_fscores$HS_f <- as.factor(rosie_fscores$PERSONEN)
       # smart-household-level >> median split method because of conceptual understanding of the scale (sticking with number of devices instead of frequency)
   
   #------------------------------------------------------#
   ### categorization ##########################
   #------------------------------------------------------#

   # - TT
       #original scale using average sum scores
       library(fame)
       rosie_fscores$TT_avgsum <- rowMeans(rosie_fscores[, c(106:108)], na.rm = T)
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
           rosie_fscores$IL_navigation_avgsum <- rowMeans(rosie_fscores[, c(102, 104:105)], na.rm = T)
           is.numeric(rosie_fscores$IL_navigation_avgsum)
           # View(rosie_fscores$IL_navigation_avgsum)
           
           #median split method !!! Note: Since items were formulated negatively, lower scores indicate higher literacy, so numbers for categories are switched
           rosie_fscores$IL_navigation_LCAcategory_orig[rosie_fscores$IL_navigation_avgsum<=median(rosie_fscores$IL_navigation_avgsum)] = 2
           rosie_fscores$IL_navigation_LCAcategory_orig[rosie_fscores$IL_navigation_avgsum>median(rosie_fscores$IL_navigation_avgsum)] = 1
           rosie_fscores$IL_nav_f <- as.factor(rosie_fscores$IL_navigation_LCAcategory_orig)
           
           #information (items 1 + 3)
           rosie_fscores$IL_information_avgsum <- rowMeans(rosie_fscores[, c(101, 103)], na.rm = T)
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
           rosie_fscores$Child_Parasocial_anthropomorphism_avgsum <- rowMeans(rosie_fscores[, c(73, 76:77)], na.rm = T)
           is.numeric(rosie_fscores$Child_Parasocial_anthropomorphism_avgsum)
           # View(rosie_fscores$Child_Parasocial_anthropomorphism_avgsum)
           
           #median split method
           rosie_fscores$Child_Parasocial_anthropomorphism_LCAcategory_orig[rosie_fscores$Child_Parasocial_anthropomorphism_avgsum<=median(rosie_fscores$Child_Parasocial_anthropomorphism_avgsum)] = 1
           rosie_fscores$Child_Parasocial_anthropomorphism_LCAcategory_orig[rosie_fscores$Child_Parasocial_anthropomorphism_avgsum>median(rosie_fscores$Child_Parasocial_anthropomorphism_avgsum)] = 2
           rosie_fscores$Child_Parasocial_anthro_f <- as.factor(rosie_fscores$Child_Parasocial_anthropomorphism_LCAcategory_orig)
           
           
           #parasocial relationship (items 2 + 3)
           rosie_fscores$Child_Parasocial_pararela_avgsum <- rowMeans(rosie_fscores[, c(74:75)], na.rm = T)
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
           rosie_fscores$PMMS_restrMed_avgsum <- rowMeans(rosie_fscores[, c(62:63)], na.rm = T)
           is.numeric(rosie_fscores$PMMS_restrMed_avgsum)
           # View(rosie_fscores$PMMS_restrMed_avgsum)
           
           #modal split method
           rosie_fscores$PMMS_restrMed_LCAcategory_orig[rosie_fscores$PMMS_restrMed_avgsum<=getmode(rosie_fscores$PMMS_restrMed_avgsum)] = 1
           rosie_fscores$PMMS_restrMed_LCAcategory_orig[rosie_fscores$PMMS_restrMed_avgsum>getmode(rosie_fscores$PMMS_restrMed_avgsum)] = 2
           rosie_fscores$PMMS_restrMed_f <- as.factor(rosie_fscores$PMMS_restrMed_LCAcategory_orig)
           
           
           #negacMed (items 3+5)
           rosie_fscores$PMMS_negacMed_avgsum <- rowMeans(rosie_fscores[, c(64, 66)], na.rm = T)
           is.numeric(rosie_fscores$PMMS_negacMed_avgsum)
           # View(rosie_fscores$PMMS_negacMed_avgsum)
           
           #modal split method
           rosie_fscores$PMMS_negacMed_LCAcategory_orig[rosie_fscores$PMMS_negacMed_avgsum<=getmode(rosie_fscores$PMMS_negacMed_avgsum)] = 1
           rosie_fscores$PMMS_negacMed_LCAcategory_orig[rosie_fscores$PMMS_negacMed_avgsum>getmode(rosie_fscores$PMMS_negacMed_avgsum)] = 2
           rosie_fscores$PMMS_negacMed_f <- as.factor(rosie_fscores$PMMS_negacMed_LCAcategory_orig)
           
           
           #posacMed (items 4+6)
           rosie_fscores$PMMS_posacMed_avgsum <- rowMeans(rosie_fscores[, c(65, 67)], na.rm = T)
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
  
   #make sure all LCA-indicators are really factors
   is.factor(rosie_fscores$PGender_f)
   is.factor(rosie_fscores$SES_f)
   is.factor(rosie_fscores$CGender_f)
   is.factor(rosie_fscores$current_usage_f)
   is.factor(rosie_fscores$Child_Nr_f)
   is.factor(rosie_fscores$HS_f)
   is.factor(rosie_fscores$TT_f)
   is.factor(rosie_fscores$IL_nav_f)
   is.factor(rosie_fscores$IL_info_f)
   is.factor(rosie_fscores$FoPersU_f)
   is.factor(rosie_fscores$Temp_Ex_f)
   is.factor(rosie_fscores$Temp_NegAf_f)
   is.factor(rosie_fscores$Temp_EfCon_f)
   is.factor(rosie_fscores$Child_Parasocial_anthro_f)
   is.factor(rosie_fscores$Child_Parasocial_pararela_f)
   is.factor(rosie_fscores$PAge_f)
   is.factor(rosie_fscores$CAge_f)
   is.factor(rosie_fscores$PMMS_restrMed_f)
   is.factor(rosie_fscores$PMMS_negacMed_f)
   is.factor(rosie_fscores$PMMS_posacMed_f)
   is.factor(rosie_fscores$smHouse_f)
             
   
   #--------------------------------------------#
   ### running the LCA ##########################
   #--------------------------------------------#
   
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
   #>> negative degrees of freedom 
   # --> ALERT: number of parameters estimated ( 209 ) exceeds number of observations ( 183 ) 
   #--> ALERT: negative degrees of freedom; respecify model 
   ### >> We will more thoroughly look into models 2-6!
  
   
   #-------------------------------------------#
   ### evaluating LCA ##########################
   #-------------------------------------------#
   
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
             #   log-likelihood resid. df     BIC    aBIC    cAIC likelihood-ratio Nclass
             # 2       -2568.87       124 5445.10 5258.24 5504.10          3231.07      2
             # 3       -2523.70        94 5511.04 5229.16 5600.04          3140.73      3
             # 4       -2487.66        64 5595.25 5218.35 5714.25          3068.64      4
             # 5       -2455.47        34 5687.16 5215.25 5836.16          3004.28      5
             # 6       -2420.92         4 5774.34 5207.41 5953.34          2935.17      6
             
   # visualize fit indices per LCA model 
               # convert table into long format
               library("forcats")
               tab.modfit$Nclass <-as.factor(tab.modfit$Nclass)
               tab.modfit
               results2<-tidyr::gather(tab.modfit,label,value,1:6)
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
               
   # enumeration judgement      
               # https://statistics.ohlsen-web.de/latent-class-analysis-polca/ 
               # Since we do not have a solid theoretical assumption of the number of unobserved sub-populations (aka family types)
               # we take an exploratory approach and compare multiple models (2-6 classes) against each other. 
               # If choosing this approach, one can decide to take the model that has the most plausible interpretation. 
               # Additionally one could compare the different solutions by BIC or AIC information criteria. 
               # BIC is preferred over AIC in latent class models. 
               # A smaller BIC is better than a bigger BIC. 
               
               # >> 2-class model has lowest BIC
               
               # https://www.tandfonline.com/doi/full/10.1080/10705510701575396
               
               # >> 6-class model has lowest aBIC (which is preferred for categorical variables and small sample sizes).
               # >> But it is not the first "dip" in the plot, the first "dip" is the 3-class model.
               # >> However, the 4-class model has an even lower aBIC than the 3-class model... 
               
               
       # taking closer look at each model solution by looking at the class probabilities (https://statistics.ohlsen-web.de/latent-class-analysis-polca/)
               library(ggplot2)
                     #2-class model
                     lcmodel2 <- reshape2::melt(LCAmodel2$probs, level=2)
                     zp1 <- ggplot(lcmodel2,aes(x = L2, y = value, fill = as.factor(Var2)))
                     zp1 <- zp1 + geom_bar(stat = "identity", position = "stack")
                     zp1 <- zp1 + facet_grid(Var1 ~ .) 
                     zp1 <- zp1 + scale_fill_brewer(type="seq", palette="Greys") +theme_bw()
                     zp1 <- zp1 + labs(x = "LCA Indicators",y="Class probability", fill ="Categories")
                     zp1 <- zp1 + theme( axis.text.y=element_blank(),
                                         axis.text.x=element_text(angle=90, vjust=0.5, hjust=0.2),
                                         axis.ticks.y=element_blank(),                    
                                         panel.grid.major.y=element_blank())
                     zp1 <- zp1 + guides(fill = guide_legend(reverse=TRUE))
                     print(zp1)
               
                     
                     #3-class model
                     lcmodel3 <- reshape2::melt(LCAmodel3$probs, level=2)
                     zp2 <- ggplot(lcmodel3,aes(x = L2, y = value, fill = as.factor(Var2)))
                     zp2 <- zp2 + geom_bar(stat = "identity", position = "stack")
                     zp2 <- zp2 + facet_grid(Var1 ~ .) 
                     zp2 <- zp2 + scale_fill_brewer(type="seq", palette="Greys") +theme_bw()
                     zp2 <- zp2 + labs(x = "LCA Indicators",y="Class probability", fill ="Categories")
                     zp2 <- zp2 + theme( axis.text.y=element_blank(),
                                         axis.text.x=element_text(angle=90, vjust=1, hjust=0.2),
                                         axis.ticks.y=element_blank(),                    
                                         panel.grid.major.y=element_blank())
                     zp2 <- zp2 + guides(fill = guide_legend(reverse=TRUE))
                     print(zp2)
                     
                     
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
                     
                     
                     #5-class model
                     lcmodel5 <- reshape2::melt(LCAmodel5$probs, level=2)
                     zp4 <- ggplot(lcmodel5,aes(x = L2, y = value, fill = as.factor(Var2)))
                     zp4 <- zp4 + geom_bar(stat = "identity", position = "stack")
                     zp4 <- zp4 + facet_grid(Var1 ~ .) 
                     zp4 <- zp4 + scale_fill_brewer(type="seq", palette="Greys") +theme_bw()
                     zp4 <- zp4 + labs(x = "LCA Indicators",y="Class probability", fill ="Categories")
                     zp4 <- zp4 + theme( axis.text.y=element_blank(),
                                         axis.text.x=element_text(angle=90, vjust=1, hjust=0.2),
                                         axis.ticks.y=element_blank(),                    
                                         panel.grid.major.y=element_blank())
                     zp4 <- zp4 + guides(fill = guide_legend(reverse=TRUE))
                     print(zp4)
               
                     
                     #6-class model
                     lcmodel6 <- reshape2::melt(LCAmodel6$probs, level=2)
                     zp5 <- ggplot(lcmodel6,aes(x = L2, y = value, fill = as.factor(Var2)))
                     zp5 <- zp5 + geom_bar(stat = "identity", position = "stack")
                     zp5 <- zp5 + facet_grid(Var1 ~ .) 
                     zp5 <- zp5 + scale_fill_brewer(type="seq", palette="Greys") +theme_bw()
                     zp5 <- zp5 + labs(x = "LCA Indicators",y="Class probability", fill ="Categories")
                     zp5 <- zp5 + theme( axis.text.y=element_blank(),
                                         axis.text.x=element_text(angle=90, vjust=1, hjust=0.2),
                                         axis.ticks.y=element_blank(),                    
                                         panel.grid.major.y=element_blank())
                     zp5 <- zp5 + guides(fill = guide_legend(reverse=TRUE))
                     print(zp5)
                    

                     
  #We proceed by extracting the LCA solutions for the 3- and 4-class model 
           
           
    #extract 3-class solution and save in twoclass object (https://osf.io/vec6s/)
       set.seed(123)
       threeclass=poLCA(LCAmodel, data=rosie_fscores, nclass=3, maxiter = 1000, nrep = 10, graphs=TRUE, na.rm=TRUE)
       
       #output predicted classes from selected model so that we can use it in subsequent analyses:
       rosie_fscores$fam_class3=threeclass$predclass
       
       #View(rosie_fscores)
       
       rosie_fscores$fam_class3 <- as.factor(rosie_fscores$fam_class3)
       
       #name the levels of the class factor using the response probabilities plot
       # levels(rosie_fscores$fam_class3)[levels(rosie_fscores$fam_class3)=="1"] <- "XXX"
       # levels(rosie_fscores$fam_class3)[levels(rosie_fscores$fam_class3)=="2"] <- "YYY"
       # levels(rosie_fscores$fam_class3)[levels(rosie_fscores$fam_class3)=="3"] <- "ZZZ"
  
       
    #extract 4-class solution and save in fourclass object (https://osf.io/vec6s/)
       set.seed(123)
       fourclass=poLCA(LCAmodel, data=rosie_fscores, nclass=4, maxiter = 1000, nrep = 10, graphs=TRUE, na.rm=TRUE)
       
       #output predicted classes from selected model so that we can use it in subsequent analyses:
       rosie_fscores$fam_class4=fourclass$predclass
       
       #View(rosie_fscores)
       
       rosie_fscores$fam_class4 <- as.factor(rosie_fscores$fam_class4)
       
    
           
  #We now recode the created fam_class variables for each model into dummy coded variables, since we need them for the SEM
       
       #for 3class solution
       rosie_fscores$fam_class3_1 <- ifelse(rosie_fscores$fam_class3 == "1", 1, 0) 
       rosie_fscores$fam_class3_2 <- ifelse(rosie_fscores$fam_class3 == "2", 1, 0) 
       rosie_fscores$fam_class3_3 <- ifelse(rosie_fscores$fam_class3 == "3", 1, 0)
       
       rosie_fscores$fam_class3_1 <- as.factor(rosie_fscores$fam_class3_1)   
       rosie_fscores$fam_class3_2 <- as.factor(rosie_fscores$fam_class3_2)
       rosie_fscores$fam_class3_2 <- as.factor(rosie_fscores$fam_class3_2)
       
       #for 4class solution
       rosie_fscores$fam_class4_1 <- ifelse(rosie_fscores$fam_class4 == "1", 1, 0) 
       rosie_fscores$fam_class4_2 <- ifelse(rosie_fscores$fam_class4 == "2", 1, 0)
       rosie_fscores$fam_class4_3 <- ifelse(rosie_fscores$fam_class4 == "3", 1, 0) 
       rosie_fscores$fam_class4_4 <- ifelse(rosie_fscores$fam_class4 == "4", 1, 0) 
       
       rosie_fscores$fam_class4_1 <- as.factor(rosie_fscores$fam_class4_1)   
       rosie_fscores$fam_class4_2 <- as.factor(rosie_fscores$fam_class4_2)
       rosie_fscores$fam_class4_3 <- as.factor(rosie_fscores$fam_class4_3)
       rosie_fscores$fam_class4_4 <- as.factor(rosie_fscores$fam_class4_4)
       
       View(rosie_fscores)
       
  #-------------------------------------------------------#
  ### descriptives along classes ##########################
  #-------------------------------------------------------#
      
        #4-class model
             #numbers
             library(psych)
             psych::describeBy(rosie_fscores, group = "fam_class4")

             
             #visualization (converting factors into numeric variables if original scale was not numeric already)
             library("ggplot2")
             rosie_fscores$PGender_num <- as.numeric(rosie_fscores$PGender_f)
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=PGender_num)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Parent Gender (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #no differences
             
             rosie_fscores$SES_num <- as.numeric(rosie_fscores$SES_f)
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=SES_num)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="SES (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #no differences
             
             rosie_fscores$CGender_num <- as.numeric(rosie_fscores$CGender_f)
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=CGender_num)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Child Gender (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #no differences
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=current_usage)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Current Usage (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #no differences
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=Child_Nr)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Number of Children (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #no differences
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=PERSONEN)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Household Size (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #class 4 is different from all, class 2 is different from 3
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=TT_avgsum)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Technology Trust (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #class 3 is different from class 1 and from class 4
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=IL_information_avgsum)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Information Internet Literacy (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #class 2 is different from all, class 1 is different from 3 and 4, 
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=IL_navigation_avgsum)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Navigation Internet Literacy (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #class 3 is different from all, class 1 & 2 are different from class 4
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=FoPersU)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Frequency of Personal Use (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #class 1 is different from class 2 and 4
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=Child_Temp_Extraversion)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Child Temperament Extraversion (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #no differences
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=Child_Temp_Negative_Affectivity)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Child Temperament Negative Affectivity (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #class 2 and 3 are different
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=Child_Temp_Effortful_Control)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Child Temperament Effortful Control (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #class 2 is different from 1 and 3
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=Child_Parasocial_anthropomorphism_avgsum)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Child Anthropomorphism (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #no differences
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=Child_Parasocial_pararela_avgsum)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Child Parasocial Relationship (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #class 1 is different from 2
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=LFT)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Parent Age (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #class 2 is different from class 1 & 3
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=Child_Age)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Child Age (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #no differences
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=PMMS_restrMed_avgsum)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Restrictive Mediation (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #class 4 is different from all
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=PMMS_negacMed_avgsum)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Negative Active Mediation (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #class 3 and 4 are different from all
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=PMMS_posacMed_avgsum)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Positive Active Mediation (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #class 4 is different from all
             
             ggplot(rosie_fscores, aes(x=factor(fam_class4), y=SHL)) + 
               geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
               geom_point(stat="summary", fun.y="mean") + 
               geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
               labs(x="Family Types", y="Smart-Household-Level (mean + 95%CI)") +
               theme_bw() +
               theme(axis.text.x=element_text(angle=45, hjust=1)) #class 1 is different from all
          
  
   #------------------------------------#
   ### ANOVAs ##########################
   #------------------------------------#             
  #We now run analyses of variances for all indicators using its original scale to see whether the family types significantly differ between each other.
             
        #for 4-class model
             
             # Compute the analysis of variance
             anova_PGender <- aov(PGender_num ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_PGender) # not significant
             # Alternative non-parametric test
             kruskal.test(PGender_num ~ fam_class4, data = rosie_fscores) #not significant
             
             
             # Compute the analysis of variance
             anova_SES <- aov(SES_num ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_SES) #significant
             # Alternative non-parametric test
             kruskal.test(SES_num ~ fam_class4, data = rosie_fscores) #significant
             
                   #Where are the differences? 
                   TukeyHSD(anova_SES)
                   # $fam_class4
                   #            diff         lwr        upr     p adj
                   # 2-1 -0.15274725 -0.71322246 0.40772796 0.8943141
                   # 3-1 -0.47792208 -1.01394971 0.05810555 0.0990675
                   # 4-1  0.05238095 -0.58543372 0.69019563 0.9965752
                   # 3-2 -0.32517483 -0.80050988 0.15016023 0.2892257
                   # 4-2  0.20512821 -0.38260077 0.79285718 0.8021301
                   # 4-3  0.53030303 -0.03415999 1.09476606 0.0739852
                   # >> No significant differences between classes according to adjusted p-values.
                   
             
                   
             # Compute the analysis of variance
             anova_TT <- aov(TT_avgsum ~ fam_class4, data = rosie_fscores)
             # Summary of the analysis
             summary(anova_TT) #significant
             # Alternative non-parametric test
             kruskal.test(TT_avgsum ~ fam_class4, data = rosie_fscores) #significant
             
                   #Where are the differences? 
                   TukeyHSD(anova_TT)
                   # $fam_class4
                   # diff         lwr         upr     p adj
                   # 2-1  0.4706960 -0.15024886  1.09164080 0.2048941
                   # 3-1  0.6789322  0.08507258  1.27279177 0.0179336
                   # 4-1 -0.2079365 -0.91456494  0.49869193 0.8709055
                   # 3-2  0.2082362 -0.31838270  0.73485511 0.7347614
                   # 4-2 -0.6786325 -1.32977148 -0.02749348 0.0374821
                   # 4-3 -0.8868687 -1.51223157 -0.26150580 0.0017546
                   # >> Significant differences between class 3-1, 4-2, and 4-3
             
                   
                   
             # Compute the analysis of variance
             anova_IL_info <- aov(IL_information_avgsum ~ fam_class4, data = rosie_fscores)
             # Summary of the analysis
             summary(anova_IL_info) #significant
             # Alternative non-parametric test
             kruskal.test(IL_information_avgsum ~ fam_class4, data = rosie_fscores) #significant
                   
                   #Where are the differences? 
                   TukeyHSD(anova_IL_info)
                   # $fam_class4
                   # diff        lwr        upr     p adj
                   # 2-1  1.00467033  0.4868705  1.5224702 0.0000070
                   # 3-1 -1.06147186 -1.5566856 -0.5662581 0.0000006
                   # 4-1 -1.03571429 -1.6249648 -0.4464637 0.0000560
                   # 3-2 -2.06614219 -2.5052846 -1.6269998 0.0000000
                   # 4-2 -2.04038462 -2.5833631 -1.4974062 0.0000000
                   # 4-3  0.02575758 -0.4957264  0.5472416 0.9992467
                   # >> Significant differences between all classes except between 3 and 4.
             
             # Compute the analysis of variance
             anova_IL_nav <- aov(IL_navigation_avgsum ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_IL_nav) #significant
             # Alternative non-parametric test
             kruskal.test(IL_navigation_avgsum ~ fam_class4, data = rosie_fscores) #significant
             
                   #Where are the differences? 
                   TukeyHSD(anova_IL_nav)
                   # $fam_class4
                   # diff         lwr        upr     p adj
                   # 2-1  0.6183150  0.07741566  1.1592144 0.0179513
                   # 3-1 -1.5825397 -2.09984534 -1.0652340 0.0000000
                   # 4-1 -0.9825397 -1.59807724 -0.3670021 0.0003102
                   # 3-2 -2.2008547 -2.65958761 -1.7421218 0.0000000
                   # 4-2 -1.6008547 -2.16805592 -1.0336535 0.0000000
                   # 4-3  0.6000000  0.05525212  1.1447479 0.0245301
                   # >> Significant differences between all classes.
             
               
                   
             # Compute the analysis of variance
             anova_FoPersU <- aov(FoPersU ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_FoPersU) #significant
             # Alternative non-parametric test
             kruskal.test(FoPersU ~ fam_class4, data = rosie_fscores) #significant
             
                   #Where are the differences? 
                   TukeyHSD(anova_FoPersU)
                   # $fam_class4
                   # diff         lwr       upr     p adj
                   # 2-1  0.92701465  0.19022649 1.6638028 0.0071679
                   # 3-1  0.66623377 -0.03841615 1.3708837 0.0712467
                   # 4-1  1.02380952  0.18535264 1.8622664 0.0097247
                   # 3-2 -0.26078089 -0.88564570 0.3640839 0.7007894
                   # 4-2  0.09679487 -0.67582048 0.8694102 0.9881161
                   # 4-3  0.35757576 -0.38445469 1.0996062 0.5961293
                   # >> Significant differences between class 1 and the rest
                       
                   
                   
             # Compute the analysis of variance
             anova_CGender <- aov(CGender_num ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_CGender) # not significant
             # Alternative non-parametric test
             kruskal.test(CGender_num ~ fam_class4, data = rosie_fscores) #not significant
                   
             
             
             # Compute the analysis of variance
             anova_CTE <- aov(Child_Temp_Extraversion ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_CTE) # not significant
             # Alternative non-parametric test
             kruskal.test(Child_Temp_Extraversion ~ fam_class4, data = rosie_fscores) #not significant
             
             
             # Compute the analysis of variance
             anova_CTNA <- aov(Child_Temp_Negative_Affectivity ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_CTNA) # significant
             # Alternative non-parametric test
             kruskal.test(Child_Temp_Negative_Affectivity ~ fam_class4, data = rosie_fscores) #significant
             
                   #Where are the differences? 
                   TukeyHSD(anova_CTNA)
                   # $fam_class4
                   # diff        lwr         upr     p adj
                   # 2-1  0.3593407 -0.6220042  1.34068549 0.7780585
                   # 3-1 -0.5683983 -1.5069374  0.37014090 0.3980565
                   # 4-1  0.1952381 -0.9215216  1.31199780 0.9688992
                   # 3-2 -0.9277389 -1.7600105 -0.09546734 0.0222350
                   # 4-2 -0.1641026 -1.1931664  0.86496131 0.9760889
                   # 4-3  0.7636364 -0.2246908  1.75196352 0.1904477
                   # >> Only significant differences between class 2 and 3
                   
             
             # Compute the analysis of variance
             anova_CTEC <- aov(Child_Temp_Effortful_Control ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_CTEC) # significant
             # Alternative non-parametric test
             kruskal.test(Child_Temp_Effortful_Control ~ fam_class4, data = rosie_fscores) #significant
             
                   #Where are the differences? 
                   TukeyHSD(anova_CTEC)
                   # $fam_class4
                   # diff          lwr        upr     p adj
                   # 2-1  1.7098901  0.845156978  2.5746232 0.0000045
                   # 3-1  0.8229437 -0.004070282  1.6499577 0.0516675
                   # 4-1  1.0380952  0.054038372  2.0221521 0.0342925
                   # 3-2 -0.8869464 -1.620320424 -0.1535723 0.0106841
                   # 4-2 -0.6717949 -1.578576670  0.2349869 0.2228063
                   # 4-3  0.2151515 -0.655734243  1.0860373 0.9186645
                   # >> Significant differences between class 1 and 2 + 4 as well as between 2 and 3 
                   
             
                   
             # Compute the analysis of variance
             anova_PA_Anthro <- aov(Child_Parasocial_anthropomorphism_avgsum ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_PA_Anthro) # significant
             # Alternative non-parametric test
             kruskal.test(Child_Parasocial_anthropomorphism_avgsum ~ fam_class4, data = rosie_fscores) #significant
                   
                   #Where are the differences? 
                   TukeyHSD(anova_PA_Anthro)   
                   # $fam_class4
                   # diff         lwr       upr     p adj
                   # 2-1  0.1483516 -0.40057235 0.6972756 0.8966236
                   # 3-1 -0.1861472 -0.71112745 0.3388331 0.7944440
                   # 4-1  0.3936508 -0.23101872 1.0183203 0.3620849
                   # 3-2 -0.3344988 -0.80003738 0.1310397 0.2476285
                   # 4-2  0.2452991 -0.33031692 0.8209152 0.6868387
                   # 4-3  0.5797980  0.02696836 1.1326276 0.0358030
                   # >> Only significant difference between class 3 and 4
                   
                   
             # Compute the analysis of variance
             anova_PA_ParaRela <- aov(Child_Parasocial_pararela_avgsum ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_PA_ParaRela) # significant
             # Alternative non-parametric test
             kruskal.test(Child_Parasocial_pararela_avgsum ~ fam_class4, data = rosie_fscores) #significant
             
                   #Where are the differences? 
                   TukeyHSD(anova_PA_ParaRela) 
                   # $fam_class4
                   # diff          lwr         upr     p adj
                   # 2-1  0.70961538  0.159567116  1.25966365 0.0054780
                   # 3-1  0.19242424 -0.333631259  0.71847974 0.7786099
                   # 4-1  0.63333333  0.007384407  1.25928226 0.0461880
                   # 3-2 -0.51719114 -0.983683178 -0.05069911 0.0232517
                   # 4-2 -0.07628205 -0.653077064  0.50051296 0.9860840
                   # 4-3  0.44090909 -0.113052803  0.99487098 0.1689749
                   # >> Only significant differences between class 1 and 2 + 4 and between class 2 and 3
                   
                   
    
                   
             # Compute the analysis of variance
             anova_PAge <- aov(LFT ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_PAge) #significant
             # Alternative non-parametric test
             kruskal.test(LFT ~ fam_class4, data = rosie_fscores) #not significant
                   
                   #Where are the differences? 
                   TukeyHSD(anova_PAge)
                   # $fam_class4
                   # diff          lwr       upr     p adj
                   # 2-1  4.2752747 -0.009451531  8.560001 0.0507416
                   # 3-1 -0.3709957 -4.468824801  3.726833 0.9954288
                   # 4-1  2.4714286 -2.404543139  7.347400 0.5549516
                   # 3-2 -4.6462704 -8.280116348 -1.012424 0.0060389
                   # 4-2 -1.8038462 -6.296922265  2.689230 0.7254977
                   # 4-3  2.8424242 -1.472788086  7.157637 0.3224246
                   # >> Significant differences only between class 2 and 3, but non-parametric test was not significant, so most likely do not trust those ANOVA results
                   
                   
                   
             # Compute the analysis of variance
             anova_CAge <- aov(Child_Age ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_CAge) #not significant
             # Alternative non-parametric test
             kruskal.test(Child_Age ~ fam_class4, data = rosie_fscores) #not significant
             
             
             
                   
             # Compute the analysis of variance
             anova_PMMSrestr <- aov(PMMS_restrMed_avgsum ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_PMMSrestr) #significant
             # Alternative non-parametric test
             kruskal.test(PMMS_restrMed_avgsum ~ fam_class4, data = rosie_fscores) #significant
             
                   #Where are the differences? 
                   TukeyHSD(anova_PMMSrestr)
                   # $fam_class4
                   # diff        lwr        upr     p adj
                   # 2-1  0.2771978 -0.1111465  0.6655421 0.2531014
                   # 3-1 -0.1240260 -0.4954310  0.2473790 0.8223666
                   # 4-1  0.8880952  0.4461636  1.3300268 0.0000030
                   # 3-2 -0.4012238 -0.7305758 -0.0718717 0.0099511
                   # 4-2  0.6108974  0.2036694  1.0181255 0.0008069
                   # 4-3  1.0121212  0.6210138  1.4032286 0.0000000
                   # >> Significant differences between all classes except between 1 and 2 + 3
                   
           
                   
                   
             # Compute the analysis of variance
             anova_PMMSnegac <- aov(PMMS_negacMed_avgsum ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_PMMSnegac) #significant
             # Alternative non-parametric test
             kruskal.test(PMMS_negacMed_avgsum ~ fam_class4, data = rosie_fscores) #significant
                   
                   #Where are the differences? 
                   TukeyHSD(anova_PMMSnegac) 
                   # $fam_class4
                   # diff        lwr        upr     p adj
                   # 2-1 -0.1060440 -0.5095470  0.2974591 0.9040072
                   # 3-1 -0.6153680 -1.0012705 -0.2294654 0.0003153
                   # 4-1  0.5452381  0.0860560  1.0044202 0.0127301
                   # 3-2 -0.5093240 -0.8515321 -0.1671159 0.0009043
                   # 4-2  0.6512821  0.2281582  1.0744059 0.0005501
                   # 4-3  1.1606061  0.7542320  1.5669801 0.0000000
                   # >> Significant differences between all classes except between class 1 and 2
                   
              
                   
             # Compute the analysis of variance
             anova_PMMSposac <- aov(PMMS_posacMed_avgsum ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_PMMSposac) #significant
             # Alternative non-parametric test
             kruskal.test(PMMS_posacMed_avgsum ~ fam_class4, data = rosie_fscores) #significant
                   
                   #Where are the differences? 
                   TukeyHSD(anova_PMMSposac) 
                   # $fam_class4
                   # diff         lwr        upr     p adj
                   # 2-1  0.3972527  0.04317840 0.75132709 0.0210654
                   # 3-1  0.1099567 -0.22867313 0.44858655 0.8342851
                   # 4-1  0.8190476  0.41611488 1.22198036 0.0000023
                   # 3-2 -0.2872960 -0.58758398 0.01299191 0.0663359
                   # 4-2  0.4217949  0.05050324 0.79308650 0.0189469
                   # 4-3  0.7090909  0.35249730 1.06568452 0.0000039
                   # >> Significant differences between all classes except between class 3 and 1 + 2 
              
                   
                   
             # Compute the analysis of variance
             anova_currentU <- aov(current_usage ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_currentU) #significant
             # Alternative non-parametric test
             kruskal.test(current_usage ~ fam_class4, data = rosie_fscores) #significant
                   
                   #Where are the differences? 
                   TukeyHSD(anova_currentU)  
                   # $fam_class4
                   # diff           lwr         upr     p adj
                   # 2-1  0.34285714  0.1585235341  0.52719075 0.0000178
                   # 3-1  0.17619048 -0.0001026138  0.35248357 0.0501948
                   # 4-1  0.27619048  0.0664208415  0.48596011 0.0043604
                   # 3-2 -0.16666667 -0.3229986930 -0.01033464 0.0316773
                   # 4-2 -0.06666667 -0.2599637140  0.12663038 0.8077565
                   # 4-3  0.10000000 -0.0856451529  0.28564515 0.5029214
                   # >> Significant differences between class 1 and all others, as well as between class 2 and 3
                
                   
                   
             # Compute the analysis of variance
             anova_CNumber <- aov(Child_Nr ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_CNumber) #not significant
             # Alternative non-parametric test
             kruskal.test(Child_Nr ~ fam_class4, data = rosie_fscores) #not significant
             
             
             
             # Compute the analysis of variance
             anova_HS <- aov(PERSONEN ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_HS) #significant
             # Alternative non-parametric test
             kruskal.test(PERSONEN ~ fam_class4, data = rosie_fscores) #significant
                   
                   #Where are the differences? 
                   TukeyHSD(anova_HS) 
                   # $fam_class4
                   # diff        lwr         upr     p adj
                   # 2-1  0.2752747 -0.2128942  0.76344362 0.4624507
                   # 3-1  0.5835498  0.1166745  1.05042506 0.0076780
                   # 4-1 -0.5952381 -1.1507690 -0.03970722 0.0304856
                   # 3-2  0.3082751 -0.1057375  0.72228764 0.2188115
                   # 4-2 -0.8705128 -1.3824195 -0.35860613 0.0001042
                   # 4-3 -1.1787879 -1.6704301 -0.68714563 0.0000000
                   # >> Significant differences between all classes except between class 2 and 1 + 3
                   
                   
                   
             # Compute the analysis of variance
             anova_SHL <- aov(SHL ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_SHL) #significant
             # Alternative non-parametric test
             kruskal.test(SHL ~ fam_class4, data = rosie_fscores) #significant
                   
                   #Where are the differences? 
                   TukeyHSD(anova_SHL) 
                   # $fam_class4
                   # diff        lwr       upr     p adj
                   # 2-1  2.2478022  1.1612090 3.3343953 0.0000015
                   # 3-1  2.1982684  1.1590718 3.2374650 0.0000008
                   # 4-1  1.9285714  0.6920403 3.1651026 0.0004488
                   # 3-2 -0.0495338 -0.9710657 0.8719981 0.9990303
                   # 4-2 -0.3192308 -1.4586608 0.8201993 0.8863612
                   # 4-3 -0.2696970 -1.3640213 0.8246274 0.9191951
                   # >> Significant differences between class 1 and the rest
                   
                   
  #LOG REG DOES NOT WORK!                 
  #We now run a logistic regression for each indicator where the plots show possible differences between the classes.
  #For this, we use the dummycoded variables.
           
        #for 4-class model 
             
             logreg_PGender_4class1<- glm(fam_class4_1 ~ PGender_f, data = rosie_fscores, family = "binomial")
             summary(logreg_PGender_4class1) #significant
             logreg_PGender_4class2<- glm(fam_class4_2 ~ PGender_f, data = rosie_fscores, family = "binomial")
             summary(logreg_PGender_4class2) #not significant
             logreg_PGender_4class3<- glm(fam_class4_3 ~ PGender_f, data = rosie_fscores, family = "binomial")
             summary(logreg_PGender_4class3) #not significant
             logreg_PGender_4class4<- glm(fam_class4_4 ~ PGender_f, data = rosie_fscores, family = "binomial")
             summary(logreg_PGender_4class4) #not significant
             
             
             logreg_SES_4class1<- glm(fam_class4_1 ~ SES_f, data = rosie_fscores, family = "binomial")
             summary(logreg_SES_4class1)
             drop1(logreg_SES_4class1, test="Chisq") #significant
             logreg_SES_4class2<- glm(fam_class4_2 ~ SES_f, data = rosie_fscores, family = "binomial")
             summary(logreg_SES_4class2)
             drop1(logreg_SES_4class2, test="Chisq") #significant
             logreg_SES_4class3<- glm(fam_class4_3 ~ SES_f, data = rosie_fscores, family = "binomial")
             summary(logreg_SES_4class3)
             drop1(logreg_SES_4class3, test="Chisq") #significant
             logreg_SES_4class4<- glm(fam_class4_4 ~ SES_f, data = rosie_fscores, family = "binomial")
             summary(logreg_SES_4class4)
             drop1(logreg_SES_4class4, test="Chisq") #not significant
             
             
             logreg_TT_4class1<- glm(fam_class4_1 ~ TT_f, data = rosie_fscores, family = "binomial")
             summary(logreg_TT_4class1) #significant
             logreg_TT_4class2<- glm(fam_class4_2 ~ TT_f, data = rosie_fscores, family = "binomial")
             summary(logreg_TT_4class2) #not significant
             logreg_TT_4class3<- glm(fam_class4_3 ~ TT_f, data = rosie_fscores, family = "binomial")
             summary(logreg_TT_4class3) #significant
             logreg_TT_4class4<- glm(fam_class4_4 ~ TT_f, data = rosie_fscores, family = "binomial")
             summary(logreg_TT_4class4) #significant
             
             
             logreg_ILinfo_4class1 <- glm(fam_class4_1 ~ IL_info_f, data = rosie_fscores, family = "binomial")
             summary(logreg_ILinfo_4class1) # not significant
             logreg_ILinfo_4class2 <- glm(fam_class4_2 ~ IL_info_f, data = rosie_fscores, family = "binomial")
             summary(logreg_ILinfo_4class2) #significant
             logreg_ILinfo_4class3 <- glm(fam_class4_3 ~ IL_info_f, data = rosie_fscores, family = "binomial")
             summary(logreg_ILinfo_4class3) # not significant
             logreg_ILinfo_4class4 <- glm(fam_class4_4 ~ IL_info_f, data = rosie_fscores, family = "binomial")
             summary(logreg_ILinfo_4class4) #not significant
             
             logreg_ILnav_4class1 <- glm(fam_class4_1 ~ IL_nav_f, data = rosie_fscores, family = "binomial")
             summary(logreg_ILnav_4class1) #significant
             logreg_ILnav_4class2 <- glm(fam_class4_2 ~ IL_nav_f, data = rosie_fscores, family = "binomial")
             summary(logreg_ILnav_4class2) #significant
             logreg_ILnav_4class3 <- glm(fam_class4_3 ~ IL_nav_f, data = rosie_fscores, family = "binomial")
             summary(logreg_ILnav_4class3) # not significant
             logreg_ILnav_4class4 <- glm(fam_class4_4 ~ IL_nav_f, data = rosie_fscores, family = "binomial")
             summary(logreg_ILnav_4class4) #not significant
             
             
             logreg_FoPersU_4class1 <- glm(fam_class4_1 ~ FoPersU_f, data = rosie_fscores, family = "binomial")
             summary(logreg_FoPersU_4class1) #significant
             logreg_FoPersU_4class2 <- glm(fam_class4_2 ~ FoPersU_f, data = rosie_fscores, family = "binomial")
             summary(logreg_FoPersU_4class2) #not significant
             logreg_FoPersU_4class3 <- glm(fam_class4_3 ~ FoPersU_f, data = rosie_fscores, family = "binomial")
             summary(logreg_FoPersU_4class3) # not significant
             logreg_FoPersU_4class4 <- glm(fam_class4_4 ~ FoPersU_f, data = rosie_fscores, family = "binomial")
             summary(logreg_FoPersU_4class4) #not significant
             
             
             logreg_Temp_EfCon_4class1 <- glm(fam_class4_1 ~ Temp_EfCon_f, data = rosie_fscores, family = "binomial")
             summary(logreg_Temp_EfCon_4class1) #significant
             logreg_Temp_EfCon_4class2 <- glm(fam_class4_2 ~ Temp_EfCon_f, data = rosie_fscores, family = "binomial")
             summary(logreg_Temp_EfCon_4class2) #not significant
             logreg_Temp_EfCon_4class3 <- glm(fam_class4_3 ~ Temp_EfCon_f, data = rosie_fscores, family = "binomial")
             summary(logreg_Temp_EfCon_4class3) #not significant
             logreg_Temp_EfCon_4class4 <- glm(fam_class4_4 ~ Temp_EfCon_f, data = rosie_fscores, family = "binomial")
             summary(logreg_Temp_EfCon_4class4) #not significant
             
             
             logreg_Child_Parasocial_pararela_4class1 <- glm(fam_class4_1 ~ Child_Parasocial_pararela_f, data = rosie_fscores, family = "binomial")
             summary(logreg_Child_Parasocial_pararela_4class1) #significant
             logreg_Child_Parasocial_pararela_4class2 <- glm(fam_class4_2 ~ Child_Parasocial_pararela_f, data = rosie_fscores, family = "binomial")
             summary(logreg_Child_Parasocial_pararela_4class2) #not significant
             logreg_Child_Parasocial_pararela_4class3 <- glm(fam_class4_3 ~ Child_Parasocial_pararela_f, data = rosie_fscores, family = "binomial")
             summary(logreg_Child_Parasocial_pararela_4class3) #not significant
             logreg_Child_Parasocial_pararela_4class4 <- glm(fam_class4_4 ~ Child_Parasocial_pararela_f, data = rosie_fscores, family = "binomial")
             summary(logreg_Child_Parasocial_pararela_4class4) #not significant
             
             
             logreg_PMMSrestr_4class1 <- glm(fam_class4_1 ~ PMMS_restrMed_f, data = rosie_fscores, family = "binomial")
             summary(logreg_PMMSrestr_4class1) #significant
             logreg_PMMSrestr_4class2 <- glm(fam_class4_2 ~ PMMS_restrMed_f, data = rosie_fscores, family = "binomial")
             summary(logreg_PMMSrestr_4class2) # not significant
             logreg_PMMSrestr_4class3 <- glm(fam_class4_3 ~ PMMS_restrMed_f, data = rosie_fscores, family = "binomial")
             summary(logreg_PMMSrestr_4class3) #significant
             logreg_PMMSrestr_4class4 <- glm(fam_class4_4 ~ PMMS_restrMed_f, data = rosie_fscores, family = "binomial")
             summary(logreg_PMMSrestr_4class4) #not significant
             
             logreg_PMMSnegac_4class1 <- glm(fam_class4_1 ~ PMMS_negacMed_f, data = rosie_fscores, family = "binomial")
             summary(logreg_PMMSnegac_4class1) #significant
             logreg_PMMSnegac_3class2 <- glm(fam_class3_2 ~ PMMS_negacMed_f, data = rosie_fscores, family = "binomial")
             summary(logreg_PMMSnegac_3class2) # not significant
             logreg_PMMSnegac_4class3 <- glm(fam_class4_3 ~ PMMS_negacMed_f, data = rosie_fscores, family = "binomial")
             summary(logreg_PMMSnegac_4class3) #significant
             logreg_PMMSnegac_4class4 <- glm(fam_class4_4 ~ PMMS_negacMed_f, data = rosie_fscores, family = "binomial")
             summary(logreg_PMMSnegac_4class4) #significant
             
             logreg_PMMSposac_4class1 <- glm(fam_class4_1 ~ PMMS_posacMed_f, data = rosie_fscores, family = "binomial")
             summary(logreg_PMMSposac_4class1) #significant
             logreg_PMMSposac_4class2 <- glm(fam_class4_2 ~ PMMS_posacMed_f, data = rosie_fscores, family = "binomial")
             summary(logreg_PMMSposac_4class2) #not significant
             logreg_PMMSposac_4class3 <- glm(fam_class4_3 ~ PMMS_posacMed_f, data = rosie_fscores, family = "binomial")
             summary(logreg_PMMSposac_4class3) #significant
             logreg_PMMSposac_4class4 <- glm(fam_class4_4 ~ PMMS_posacMed_f, data = rosie_fscores, family = "binomial")
             summary(logreg_PMMSposac_4class4) #significant
             
             
             logreg_currentU_4class1 <- glm(fam_class4_1 ~ current_usage_f, data = rosie_fscores, family = "binomial")
             summary(logreg_currentU_4class1) #significant
             logreg_currentU_4class2 <- glm(fam_class4_2 ~ current_usage_f, data = rosie_fscores, family = "binomial")
             summary(logreg_currentU_4class2) #not significant
             logreg_currentU_4class3 <- glm(fam_class4_3 ~ current_usage_f, data = rosie_fscores, family = "binomial")
             summary(logreg_currentU_4class3) #not significant
             logreg_currentU_4class4 <- glm(fam_class4_4 ~ current_usage_f, data = rosie_fscores, family = "binomial")
             summary(logreg_currentU_4class4) #not significant
             
             
             logreg_HS_4class1 <- glm(fam_class4_1 ~ HS_f, data = rosie_fscores, family = "binomial")
             summary(logreg_HS_4class1)
             drop1(logreg_HS_4class1, test="Chisq") #significant
             logreg_HS_4class2 <- glm(fam_class4_2 ~ HS_f, data = rosie_fscores, family = "binomial")
             summary(logreg_HS_4class2)
             drop1(logreg_HS_4class2, test="Chisq") #not significant
             logreg_HS_4class3 <- glm(fam_class4_3 ~ HS_f, data = rosie_fscores, family = "binomial")
             summary(logreg_HS_4class3)
             drop1(logreg_HS_4class3, test="Chisq") #significant
             logreg_HS_4class4 <- glm(fam_class4_4 ~ HS_f, data = rosie_fscores, family = "binomial")
             summary(logreg_HS_4class4)
             drop1(logreg_HS_4class4, test="Chisq") #significant
             
             
             logreg_smHouse_4class1 <- glm(fam_class4_1 ~ smHouse_f, data = rosie_fscores, family = "binomial")
             summary(logreg_smHouse_4class1) #not significant
             logreg_smHouse_4class2 <- glm(fam_class4_2 ~ smHouse_f, data = rosie_fscores, family = "binomial")
             summary(logreg_smHouse_4class2) #significant
             logreg_smHouse_4class3 <- glm(fam_class4_3 ~ smHouse_f, data = rosie_fscores, family = "binomial")
             summary(logreg_smHouse_4class3) #not significant
             logreg_smHouse_4class4 <- glm(fam_class4_4 ~ smHouse_f, data = rosie_fscores, family = "binomial")
             summary(logreg_smHouse_4class4) #not significant
             
             
             ### >>> The 4-class model is distinguished between Parent Gender (for class 1), SES, Technology Trust, 
             ###     Internet Literacy (info only for class 2, nav only for class 1 and 2), Frequency of Personal Use (only for class 1), 
             ###     Child Temperament Effortful Control (only for class 1), Child Parasocial relationship (only for class 1),
             ###     PMMS (negac & posac not for class 2), current use (only for class 1), 
             ###     Household Size (not for class 2), and Smart-Household_level (only for class 2).
             
            
             
###----------------------------------------------------------------------------------------------------------------###      
      
#----------------------------------------------------------#
### STRUCTURAL EQUATION MODELLING ##########################
#----------------------------------------------------------#
      
   #----------------------------------------------------------#
   ### SEM-power analysis/simulation ##########################
   #----------------------------------------------------------#
   
   #https://yilinandrewang.shinyapps.io/pwrSEM/ 
     
       
###----------------------------------------------------------------------------------------------------------------###
       
   #---------------------------------------------------#
   ### multivariate normality ##########################
   #---------------------------------------------------#
       
       
   #--------------------------------------------------------------------------------#   
   #Check multivariate assumptions prior to analysis
   #multivariate normality
   #multivariate outliers
   #--------------------------------------------------------------------------------# 
       
       #check multivariate normality
       library(QuantPsyc)
       #for rosie dataset including extracted factor scores of SEM variables
       mult.norm(rosie_fscores[c(82:100)])$mult.test #all TAM core variables
       # Beta-hat      kappa p-val
       # Skewness  90.82382 2770.12639     0
       # Kurtosis 475.90618   18.41431     0
       
       # >> Since both p-values are less than .05, we reject the null hypothesis of the test. 
       #Thus, we have evidence to say that the SEM-variables in our dataset do not follow a multivariate distribution.
       # >> Together with the non-normality detected earlier, we will run our SEM analyses using bottstrapping.
       
       
   #------------------------------------------------------#
   ### Testing measurement model ##########################
   #------------------------------------------------------#
   

      #install.packages("lavaan", dependencies = T)
      library(lavaan)
 
      
      #perform the analysis
        #https://benwhalley.github.io/just-enough-r/cfa.html
      
        #general functions for sem
        #sem() #for path analysis and SEM
        #cfa() #for confirmatory factor analysis
        #growth() #for latent growth curve modeling
        #lavaan() #for all models (without default parameters)
      
       
       rosiesTAM_measurement<- '

      #measurement model
        PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
        PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
        E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
        SI =~ 1*TAM_SI_1 + TAM_SI_2 + TAM_SI_3
      #residual variances
        TAM_SS ~~ TAM_SS
        PEoU ~~ PEoU
        PU ~~ PU
        E ~~ E
        SI ~~ SI
        TAM_SS ~~ PEoU
        TAM_SS ~~ PU
        TAM_SS ~~ E
        TAM_SS ~~ SI
        PEoU ~~ PU
        PEoU ~~ E
        PEoU ~~ SI
        PU ~~ E
        PU ~~ SI
        E ~~ SI
      '
       
       #fit the model
       rosiesTAM_measurement_fit <- cfa(rosiesTAM_measurement_fam_class4, data = rosie_fscores) 
       
       #print summary
       summary(rosiesTAM_measurement_fit, standardized = T, fit.measures = T)
       
       #visualize measurement model
       semPaths(rosiesTAM_measurement_fit)
       
       #check modindices
       modindices(rosiesTAM_measurement_fit, sort = TRUE)
       modificationIndices(rosiesTAM_measurement_fit, sort.=TRUE, minimum.value=3)
      
              
   #-----------------------------------------------------#
   ### Testing regression model ##########################
   #-----------------------------------------------------#
              
      #first, we need to set the dummy coded family classes as numeric to be able to put it in our SEM
      rosie_fscores$fam_class4_1_num <- as.numeric(rosie_fscores$fam_class4_1)
      rosie_fscores$fam_class4_2_num <- as.numeric(rosie_fscores$fam_class4_2)
      rosie_fscores$fam_class4_3_num <- as.numeric(rosie_fscores$fam_class4_3)
      rosie_fscores$fam_class4_4_num <- as.numeric(rosie_fscores$fam_class4_4)
      
      
      #then, we perform the SEM with the dummy/treatment coded family type variables: type 1 as reference level  
      rosiesTAM_3DVs_fam_class4_1 <- '

      #measurement model
        PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
        PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
        E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
        SI =~ 1*TAM_SI_1 + TAM_SI_2 + TAM_SI_3
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
      
      #check model improvements
      modindices(rosiesTAM_3DVs_fam_class4_1_fit, sort = TRUE)
      # selection of highest modindices:
      #                  lhs op              rhs     mi    epc sepc.lv sepc.all sepc.nox
      # 350             PEoU ~~                E 76.508  1.001   0.702    0.702    0.702
      # 368                E  ~             PEoU 76.508  0.766   0.682    0.682    0.682
      # 356             PEoU  ~                E 76.507  0.643   0.722    0.722    0.722
      # 360             PEoU  ~         TAM_UI_2 65.553  1.256   1.089    1.438    1.438
      # 369                E  ~               PU 63.309  0.570   0.670    0.670    0.670
      
      
      #adding regression path E  ~ PEoU to the model, since it is theoretically most logical that the if the PEoU is high that E is then also high
      rosiesTAM_3DVs_fam_class4_1_changeI <- '

      #measurement model
        PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
        PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
        E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
        SI =~ 1*TAM_SI_1 + TAM_SI_2 + TAM_SI_3
      #regressions
        PEoU ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num
        PU ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num + PEoU
        E ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num + PEoU
        TAM_SS ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num
        SI ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num
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
      rosiesTAM_3DVs_fam_class4_1_changeI_fit <- lavaan(rosiesTAM_3DVs_fam_class4_1_changeI, data = rosie_fscores) 
      
      #print summary
      summary(rosiesTAM_3DVs_fam_class4_1_changeI_fit, standardized = T, fit.measures = T)
      ### >> Already better model fit, but still not acceptable
      
      #check model improvements
      modindices(rosiesTAM_3DVs_fam_class4_1_changeI_fit, sort = TRUE)
      #                  lhs op              rhs     mi    epc sepc.lv sepc.all sepc.nox
      # 418 fam_class4_3_num  ~               SI 61.017 -0.617  -0.950   -1.977   -1.977
      # 415 fam_class4_3_num  ~               PU 61.014 -0.495  -0.753   -1.569   -1.569
      # 417 fam_class4_3_num  ~           TAM_SS 59.580 -0.654  -0.654   -2.633   -2.633
      # 416 fam_class4_3_num  ~                E 59.436 -0.804  -1.040   -2.167   -2.167
      # 407 fam_class4_2_num  ~           TAM_SS 53.954 -0.853  -0.853   -3.659   -3.659
      # 405 fam_class4_2_num  ~               PU 49.614 -0.510  -0.776   -1.721   -1.721
      # 414 fam_class4_3_num  ~             PEoU 47.215 -1.674  -1.899   -3.955   -3.955
      # 340         TAM_UI_2 ~~         TAM_UI_3 41.377  0.867   0.867    0.484    0.484
      # 395         TAM_UI_2  ~         TAM_UI_3 41.377  0.334   0.334    0.433    0.433
      # 400         TAM_UI_3  ~         TAM_UI_2 41.377  0.699   0.699    0.540    0.540
      # 412 fam_class4_2_num  ~ fam_class4_3_num 40.977 -0.444  -0.444   -0.473   -0.473
      # 347 fam_class4_2_num ~~ fam_class4_3_num 40.977 -0.102  -0.102   -0.473   -0.473
      # 422 fam_class4_3_num  ~ fam_class4_2_num 40.977 -0.504  -0.504   -0.473   -0.473
      # 95                PU =~         TAM_SI_3 38.353  0.423   0.644    0.355    0.355
      # 425 fam_class4_4_num  ~               PU 32.016 -0.291  -0.443   -1.195   -1.195
      # 427 fam_class4_4_num  ~           TAM_SS 30.627 -0.345  -0.345   -1.805   -1.805
      # 369                E  ~               PU 27.968  0.348   0.409    0.409    0.409
      # 353               PU ~~                E 27.968  0.486   0.470    0.470    0.470
      # 363               PU  ~                E 27.968  0.635   0.540    0.540    0.540
      
      
      #next, we add regression path PU  ~  E, since enjoyment can assumed to be especially determining the usefulness in the family environment
      rosiesTAM_3DVs_fam_class4_1_changeII <- '

      #measurement model
        PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
        PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
        E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
        SI =~ 1*TAM_SI_1 + TAM_SI_2 + TAM_SI_3
      #regressions
        PEoU ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num
        PU ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num + PEoU + E
        E ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num + PEoU
        TAM_SS ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num
        SI ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num
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
      rosiesTAM_3DVs_fam_class4_1_changeII_fit <- lavaan(rosiesTAM_3DVs_fam_class4_1_changeII, data = rosie_fscores) 
      
      #print summary
      summary(rosiesTAM_3DVs_fam_class4_1_changeII_fit, standardized = T, fit.measures = T)
      ### >> No real improvement compared to first change
      
      
      #alternative change: adding covariance between TAM_UI_2 ~~ TAM_UI_3, since we already saw that child-only and co-use go hand-in-hand
      rosiesTAM_3DVs_fam_class4_1_changeIII <- '

      #measurement model
        PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
        PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
        E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
        SI =~ 1*TAM_SI_1 + TAM_SI_2 + TAM_SI_3
      #regressions
        PEoU ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num
        PU ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num + PEoU 
        E ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num + PEoU
        TAM_SS ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num
        SI ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num
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
        TAM_UI_1 ~~ TAM_UI_1
        TAM_UI_2 ~~ TAM_UI_2
        TAM_UI_3 ~~ TAM_UI_3
        TAM_UI_2 ~~ TAM_UI_3
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
      rosiesTAM_3DVs_fam_class4_1_changeIII_fit <- lavaan(rosiesTAM_3DVs_fam_class4_1_changeIII, data = rosie_fscores) 
      
      #print summary
      summary(rosiesTAM_3DVs_fam_class4_1_changeIII_fit, standardized = T, fit.measures = T)
      ### >> Model fit improved, but still not good enough!
      
      #check model improvements
      modindices(rosiesTAM_3DVs_fam_class4_1_changeIII_fit, sort = TRUE)
      #                  lhs op              rhs     mi    epc sepc.lv sepc.all sepc.nox
      # 415 fam_class4_3_num  ~               PU 61.022 -0.497  -0.757   -1.576   -1.576
      # 418 fam_class4_3_num  ~               SI 61.015 -0.617  -0.948   -1.975   -1.975
      # 417 fam_class4_3_num  ~           TAM_SS 59.568 -0.653  -0.653   -2.633   -2.633
      # 416 fam_class4_3_num  ~                E 59.422 -0.819  -1.055   -2.197   -2.197
      # 407 fam_class4_2_num  ~           TAM_SS 53.963 -0.853  -0.853   -3.660   -3.660
      # 405 fam_class4_2_num  ~               PU 49.665 -0.512  -0.780   -1.729   -1.729
      # 414 fam_class4_3_num  ~             PEoU 47.369 -1.671  -1.900   -3.957   -3.957
      # 348 fam_class4_2_num ~~ fam_class4_3_num 40.977 -0.102  -0.102   -0.473   -0.473
      # 412 fam_class4_2_num  ~ fam_class4_3_num 40.977 -0.444  -0.444   -0.473   -0.473
      # 422 fam_class4_3_num  ~ fam_class4_2_num 40.977 -0.504  -0.504   -0.473   -0.473
      # 97                PU =~         TAM_SI_3 38.503  0.423   0.645    0.356    0.356
      # 425 fam_class4_4_num  ~               PU 32.025 -0.292  -0.444   -1.199   -1.199
      # 427 fam_class4_4_num  ~           TAM_SS 30.631 -0.345  -0.345   -1.805   -1.805
      # 406 fam_class4_2_num  ~                E 27.642 -0.719  -0.926   -2.053   -2.053
      # 424 fam_class4_4_num  ~             PEoU 27.265 -2.020  -2.297   -6.204   -6.204
      # 383               SI  ~               PU 26.800  0.439   0.434    0.434    0.434
      
      
      
      #next change: adding regression path between SI  ~   PU, since it can be assumed that a higher PU can lead to a higher perceived social influence
      rosiesTAM_3DVs_fam_class4_1_changeIV <- '

      #measurement model
        PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
        PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
        E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
        SI =~ 1*TAM_SI_1 + TAM_SI_2 + TAM_SI_3
      #regressions
        PEoU ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num
        PU ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num + PEoU 
        E ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num + PEoU
        TAM_SS ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num
        SI ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num + PU
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
        TAM_UI_1 ~~ TAM_UI_1
        TAM_UI_2 ~~ TAM_UI_2
        TAM_UI_3 ~~ TAM_UI_3
        TAM_UI_2 ~~ TAM_UI_3
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
      rosiesTAM_3DVs_fam_class4_1_changeIV_fit <- lavaan(rosiesTAM_3DVs_fam_class4_1_changeIV, data = rosie_fscores) 
      
      #print summary
      summary(rosiesTAM_3DVs_fam_class4_1_changeIV_fit, standardized = T, fit.measures = T)
      ### >> Model fit improved, but still not good enough!
      
      #check model improvements
      modindices(rosiesTAM_3DVs_fam_class4_1_changeIV_fit, sort = TRUE)
      #                  lhs op              rhs     mi    epc sepc.lv sepc.all sepc.nox
      # 418 fam_class4_3_num  ~               SI 61.106 -0.614  -0.928   -1.932   -1.932
      # 415 fam_class4_3_num  ~               PU 61.006 -0.498  -0.757   -1.576   -1.576
      # 417 fam_class4_3_num  ~           TAM_SS 59.582 -0.654  -0.654   -2.634   -2.634
      # 416 fam_class4_3_num  ~                E 59.427 -0.818  -1.054   -2.196   -2.196
      # 407 fam_class4_2_num  ~           TAM_SS 53.949 -0.853  -0.853   -3.659   -3.659
      # 405 fam_class4_2_num  ~               PU 49.675 -0.512  -0.778   -1.725   -1.725
      # 414 fam_class4_3_num  ~             PEoU 47.377 -1.672  -1.901   -3.958   -3.958
      # 98                PU =~         TAM_SI_3 42.218  0.506   0.768    0.423    0.423
      # 422 fam_class4_3_num  ~ fam_class4_2_num 40.977 -0.504  -0.504   -0.473   -0.473
      # 412 fam_class4_2_num  ~ fam_class4_3_num 40.977 -0.444  -0.444   -0.473   -0.473
      # 349 fam_class4_2_num ~~ fam_class4_3_num 40.977 -0.102  -0.102   -0.473   -0.473
      # 308         TAM_SI_1 ~~         TAM_SI_2 37.713  1.786   1.786    3.769    3.769
      # 425 fam_class4_4_num  ~               PU 32.064 -0.293  -0.444   -1.201   -1.201
      # 427 fam_class4_4_num  ~           TAM_SS 30.629 -0.345  -0.345   -1.805   -1.805
      # 406 fam_class4_2_num  ~                E 27.639 -0.718  -0.925   -2.052   -2.052
      # 424 fam_class4_4_num  ~             PEoU 27.254 -2.020  -2.296   -6.203   -6.203
      # 404 fam_class4_2_num  ~             PEoU 25.058 -1.249  -1.420   -3.148   -3.148
      # 426 fam_class4_4_num  ~                E 22.842 -0.535  -0.690   -1.863   -1.863
      # 95                PU =~          TAM_E_4 20.998  0.357   0.542    0.365    0.365
      # 351 fam_class4_3_num ~~ fam_class4_4_num 20.241 -0.059  -0.059   -0.333   -0.333
      # 433 fam_class4_4_num  ~ fam_class4_3_num 20.241 -0.256  -0.256   -0.333   -0.333
      # 423 fam_class4_3_num  ~ fam_class4_4_num 20.241 -0.431  -0.431   -0.333   -0.333
      # 109                E =~         TAM_SI_3 17.532  0.351   0.453    0.249    0.249
      # 350 fam_class4_2_num ~~ fam_class4_4_num 14.243 -0.047  -0.047   -0.279   -0.279
      # 432 fam_class4_4_num  ~ fam_class4_2_num 14.243 -0.229  -0.229   -0.279   -0.279
      # 413 fam_class4_2_num  ~ fam_class4_4_num 14.243 -0.340  -0.340   -0.279   -0.279
      # 121               SI =~          TAM_E_4 13.846  0.228   0.345    0.232    0.232
      # 106                E =~         TAM_PU_4 13.771  0.293   0.377    0.253    0.253
      # 222         TAM_PU_2 ~~          TAM_E_4 12.428  0.275   0.275    0.289    0.289
      # 257         TAM_PU_4 ~~         TAM_UI_2 12.365  0.250   0.250    0.243    0.243
      # 82              PEoU =~          TAM_E_2 11.733  0.251   0.285    0.210    0.210
      # 379           TAM_SS  ~               SI 10.917  0.334   0.505    0.261    0.261
      
      
      
      #next change: adding regression path between TAM_SS  ~   SI, since it can be assumed that a higher social influence leads to a stronger perception of a VA being a social status symbol
      rosiesTAM_3DVs_fam_class4_1_changeV <- '

      #measurement model
        PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
        PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
        E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
        SI =~ 1*TAM_SI_1 + TAM_SI_2 + TAM_SI_3
      #regressions
        PEoU ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num
        PU ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num + PEoU + E
        E ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num + PEoU
        TAM_SS ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num + SI
        SI ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num + PU
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
        TAM_UI_1 ~~ TAM_UI_1
        TAM_UI_2 ~~ TAM_UI_2
        TAM_UI_3 ~~ TAM_UI_3
        TAM_UI_2 ~~ TAM_UI_3
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
      rosiesTAM_3DVs_fam_class4_1_changeV_fit <- lavaan(rosiesTAM_3DVs_fam_class4_1_changeV, data = rosie_fscores) 
      
      #print summary
      summary(rosiesTAM_3DVs_fam_class4_1_changeV_fit, standardized = T, fit.measures = T)
      ### >> No real improvement compared to first change
      
      
      
      #bootstrap model
      rosiesTAM_3DVs_fam_class4_1_fit_boostrapped_se <- sem(rosiesTAM_3DVs_fam_class4_1, data = rosie_fscores,se = "bootstrap", bootstrap = 1000)
      summary(rosiesTAM_3DVs_fam_class4_1_fit_boostrapped_se, fit.measures = TRUE)
      parameterEstimates(rosiesTAM_3DVs_fam_class4_1_fit_boostrapped_se,
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
      
      #                 lhs op              rhs    est    se      z pvalue ci.lower ci.upper
      # 1              PEoU =~       TAM_PEoU_1  1.000 0.000     NA     NA    1.000    1.000
      # 2              PEoU =~       TAM_PEoU_2  0.797 0.091  8.756  0.000    0.616    0.973
      # 3              PEoU =~       TAM_PEoU_3  1.011 0.080 12.695  0.000    0.854    1.166
      # 4              PEoU =~       TAM_PEoU_4  1.066 0.079 13.479  0.000    0.910    1.220
      # 5                PU =~         TAM_PU_1  1.000 0.000     NA     NA    1.000    1.000
      # 6                PU =~         TAM_PU_2  0.919 0.059 15.449  0.000    0.801    1.034
      # 7                PU =~         TAM_PU_3  1.031 0.057 17.986  0.000    0.916    1.140
      # 8                PU =~         TAM_PU_4  0.774 0.067 11.615  0.000    0.646    0.907
      # 9                 E =~          TAM_E_1  1.000 0.000     NA     NA    1.000    1.000
      # 10                E =~          TAM_E_2  0.929 0.058 15.900  0.000    0.816    1.045
      # 11                E =~          TAM_E_3  0.949 0.054 17.675  0.000    0.846    1.056
      # 12                E =~          TAM_E_4  0.768 0.078  9.888  0.000    0.615    0.920
      # 13               SI =~         TAM_SI_1  1.000 0.000     NA     NA    1.000    1.000
      # 14               SI =~         TAM_SI_2  0.968 0.066 14.704  0.000    0.837    1.095
      # 15               SI =~         TAM_SI_3  0.815 0.071 11.541  0.000    0.677    0.954
      # 16             PEoU  ~ fam_class4_2_num  0.141 0.270  0.523  0.601   -0.374    0.684
      # 17             PEoU  ~ fam_class4_3_num  0.058 0.268  0.216  0.829   -0.455    0.594
      # 18             PEoU  ~ fam_class4_4_num  0.365 0.310  1.176  0.239   -0.237    0.979
      # 19               PU  ~ fam_class4_2_num  0.885 0.300  2.950  0.003    0.299    1.474
      # 20               PU  ~ fam_class4_3_num  0.592 0.287  2.064  0.039    0.026    1.151
      # 21               PU  ~ fam_class4_4_num  0.718 0.410  1.754  0.080   -0.072    1.534
      # 22               PU  ~             PEoU  0.587 0.111  5.267  0.000    0.367    0.803
      # 23                E  ~ fam_class4_2_num  0.534 0.267  2.000  0.045    0.030    1.077
      # 24                E  ~ fam_class4_3_num  0.124 0.277  0.447  0.655   -0.413    0.674
      # 25                E  ~ fam_class4_4_num  0.643 0.316  2.036  0.042    0.026    1.263
      # 26           TAM_SS  ~ fam_class4_2_num  0.838 0.423  1.979  0.048    0.011    1.671
      # 27           TAM_SS  ~ fam_class4_3_num  0.463 0.432  1.071  0.284   -0.388    1.307
      # 28           TAM_SS  ~ fam_class4_4_num  0.490 0.503  0.975  0.330   -0.493    1.479
      # 29               SI  ~ fam_class4_2_num  0.847 0.352  2.410  0.016    0.155    1.533
      # 30               SI  ~ fam_class4_3_num -0.228 0.325 -0.701  0.483   -0.881    0.392
      # 31               SI  ~ fam_class4_4_num  0.640 0.428  1.495  0.135   -0.194    1.484
      # 32         TAM_UI_1  ~             PEoU  0.029 0.140  0.204  0.839   -0.247    0.304
      # 33         TAM_UI_1  ~               PU -0.035 0.142 -0.245  0.807   -0.324    0.234
      # 34         TAM_UI_1  ~                E  0.084 0.148  0.571  0.568   -0.190    0.389
      # 35         TAM_UI_1  ~           TAM_SS  0.185 0.068  2.724  0.006    0.054    0.320
      # 36         TAM_UI_1  ~               SI  0.187 0.098  1.907  0.056    0.000    0.385
      # 37         TAM_UI_2  ~             PEoU  0.010 0.145  0.070  0.944   -0.275    0.291
      # 38         TAM_UI_2  ~               PU  0.189 0.118  1.597  0.110   -0.035    0.429
      # 39         TAM_UI_2  ~                E  0.455 0.134  3.390  0.001    0.188    0.714
      # 40         TAM_UI_2  ~           TAM_SS  0.040 0.055  0.735  0.463   -0.068    0.147
      # 41         TAM_UI_2  ~               SI  0.011 0.080  0.138  0.890   -0.142    0.173
      # 42         TAM_UI_3  ~             PEoU  0.154 0.174  0.885  0.376   -0.201    0.483
      # 43         TAM_UI_3  ~               PU  0.269 0.166  1.619  0.105   -0.051    0.601
      # 44         TAM_UI_3  ~                E  0.192 0.171  1.126  0.260   -0.141    0.529
      # 45         TAM_UI_3  ~           TAM_SS  0.019 0.071  0.267  0.790   -0.115    0.164
      # 46         TAM_UI_3  ~               SI  0.073 0.097  0.754  0.451   -0.111    0.270
      # 47       TAM_PEoU_1 ~~       TAM_PEoU_1  0.357 0.064  5.573  0.000    0.237    0.488
      # 48       TAM_PEoU_2 ~~       TAM_PEoU_2  1.401 0.272  5.144  0.000    0.881    1.948
      # 49       TAM_PEoU_3 ~~       TAM_PEoU_3  0.508 0.123  4.139  0.000    0.270    0.751
      # 50       TAM_PEoU_4 ~~       TAM_PEoU_4  0.517 0.099  5.206  0.000    0.328    0.717
      # 51         TAM_PU_1 ~~         TAM_PU_1  0.427 0.094  4.545  0.000    0.248    0.616
      # 52         TAM_PU_2 ~~         TAM_PU_2  0.739 0.134  5.493  0.000    0.480    1.007
      # 53         TAM_PU_3 ~~         TAM_PU_3  0.429 0.072  5.955  0.000    0.298    0.580
      # 54         TAM_PU_4 ~~         TAM_PU_4  0.845 0.133  6.351  0.000    0.590    1.111
      # 55          TAM_E_1 ~~          TAM_E_1  0.263 0.101  2.609  0.009    0.071    0.466
      # 56          TAM_E_2 ~~          TAM_E_2  0.390 0.155  2.514  0.012    0.092    0.701
      # 57          TAM_E_3 ~~          TAM_E_3  0.361 0.081  4.451  0.000    0.208    0.526
      # 58          TAM_E_4 ~~          TAM_E_4  1.216 0.198  6.132  0.000    0.850    1.627
      # 59         TAM_SI_1 ~~         TAM_SI_1  0.297 0.164  1.817  0.069   -0.013    0.629
      # 60         TAM_SI_2 ~~         TAM_SI_2  0.620 0.187  3.324  0.001    0.265    0.997
      # 61         TAM_SI_3 ~~         TAM_SI_3  1.717 0.280  6.128  0.000    1.177    2.275
      # 62         TAM_UI_1 ~~         TAM_UI_1  2.678 0.227 11.778  0.000    2.334    3.226
      # 63         TAM_UI_2 ~~         TAM_UI_2  1.256 0.213  5.887  0.000    0.898    1.735
      # 64         TAM_UI_3 ~~         TAM_UI_3  2.616 0.255 10.277  0.000    2.230    3.228
      # 65           TAM_SS ~~           TAM_SS  3.519 0.364  9.680  0.000    2.890    4.315
      # 66             PEoU ~~             PEoU  1.306 0.213  6.124  0.000    0.919    1.755
      # 67               PU ~~               PU  1.462 0.246  5.949  0.000    1.034    1.997
      # 68                E ~~                E  1.560 0.232  6.711  0.000    1.147    2.058
      # 69               SI ~~               SI  2.156 0.263  8.194  0.000    1.693    2.725
      # 70 fam_class4_2_num ~~ fam_class4_2_num  0.203 0.015 13.669  0.000    0.175    0.233
      # 71 fam_class4_3_num ~~ fam_class4_3_num  0.231 0.010 23.074  0.000    0.212    0.251
      # 72 fam_class4_4_num ~~ fam_class4_4_num  0.137 0.018  7.480  0.000    0.103    0.175
      # 73         TAM_UI_1 ~~         TAM_UI_2 -0.255 0.154 -1.654  0.098   -0.574    0.030
      # 74         TAM_UI_1 ~~         TAM_UI_3  0.016 0.221  0.071  0.943   -0.417    0.449
      # 75         TAM_UI_2 ~~         TAM_UI_3  0.865 0.202  4.277  0.000    0.510    1.303
      
      
      #then, we perform the SEM with the dummy/treatment coded family type variables: type 2 as reference level 
      rosiesTAM_3DVs_fam_class4_2 <- '

      #measurement model
        PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
        PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
        E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
        SI =~ 1*TAM_SI_1 + TAM_SI_2 + TAM_SI_3
      #regressions
        PEoU ~ fam_class4_1_num + fam_class4_3_num + fam_class4_4_num
        PU ~ fam_class4_1_num + fam_class4_3_num + fam_class4_4_num + PEoU
        E ~ fam_class4_1_num + fam_class4_3_num + fam_class4_4_num
        TAM_SS ~ fam_class4_1_num + fam_class4_3_num + fam_class4_4_num
        SI ~ fam_class4_1_num + fam_class4_3_num + fam_class4_4_num
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
        TAM_UI_1 ~~ TAM_UI_1
        TAM_UI_2 ~~ TAM_UI_2
        TAM_UI_3 ~~ TAM_UI_3
        TAM_SS ~~ TAM_SS
        PEoU ~~ PEoU
        PU ~~ PU
        E ~~ E
        SI ~~ SI
        fam_class4_1_num ~~ fam_class4_1_num
        fam_class4_3_num ~~ fam_class4_3_num
        fam_class4_4_num ~~ fam_class4_4_num
      '
      
      #fit the model
      rosiesTAM_3DVs_fam_class4_2_fit <- lavaan(rosiesTAM_3DVs_fam_class4_2, data = rosie_fscores) 
      
      #print summary
      summary(rosiesTAM_3DVs_fam_class4_2_fit, standardized = T, fit.measures = T)
      
      #check model improvements
      modindices(rosiesTAM_3DVs_fam_class4_2_fit, sort = TRUE)
      # selection of highest modindices:
      #                  lhs op              rhs     mi    epc sepc.lv sepc.all sepc.nox
      # 368                E  ~             PEoU 76.508  0.766   0.686    0.686    0.686
      # 350             PEoU ~~                E 76.508  1.001   0.702    0.702    0.702
      # 356             PEoU  ~                E 76.508  0.643   0.718    0.718    0.718
      # 360             PEoU  ~         TAM_UI_2 67.093  1.285   1.120    1.462    1.462
      # 369                E  ~               PU 63.320  0.570   0.642    0.642    0.642
      
      #bootstrap model
      rosiesTAM_3DVs_fam_class4_2_fit_boostrapped_se <- sem(rosiesTAM_3DVs_fam_class4_2, data = rosie_fscores,se = "bootstrap", bootstrap = 1000)
      summary(rosiesTAM_3DVs_fam_class4_2_fit_boostrapped_se, fit.measures = TRUE)
      parameterEstimates(rosiesTAM_3DVs_fam_class4_2_fit_boostrapped_se,
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
      
      # lhs op              rhs    est    se      z pvalue ci.lower ci.upper
      # 1              PEoU =~       TAM_PEoU_1  1.000 0.000     NA     NA    1.000    1.000
      # 2              PEoU =~       TAM_PEoU_2  0.797 0.082  9.671  0.000    0.637    0.960
      # 3              PEoU =~       TAM_PEoU_3  1.011 0.075 13.532  0.000    0.855    1.148
      # 4              PEoU =~       TAM_PEoU_4  1.066 0.076 13.996  0.000    0.909    1.207
      # 5                PU =~         TAM_PU_1  1.000 0.000     NA     NA    1.000    1.000
      # 6                PU =~         TAM_PU_2  0.919 0.059 15.653  0.000    0.801    1.032
      # 7                PU =~         TAM_PU_3  1.031 0.055 18.694  0.000    0.922    1.139
      # 8                PU =~         TAM_PU_4  0.774 0.069 11.192  0.000    0.638    0.909
      # 9                 E =~          TAM_E_1  1.000 0.000     NA     NA    1.000    1.000
      # 10                E =~          TAM_E_2  0.929 0.062 15.097  0.000    0.811    1.052
      # 11                E =~          TAM_E_3  0.949 0.054 17.454  0.000    0.845    1.058
      # 12                E =~          TAM_E_4  0.768 0.080  9.610  0.000    0.613    0.926
      # 13               SI =~         TAM_SI_1  1.000 0.000     NA     NA    1.000    1.000
      # 14               SI =~         TAM_SI_2  0.968 0.126  7.689  0.000    0.717    1.211
      # 15               SI =~         TAM_SI_3  0.815 0.072 11.333  0.000    0.676    0.958
      # 16             PEoU  ~ fam_class4_1_num -0.141 0.265 -0.531  0.595   -0.668    0.372
      # 17             PEoU  ~ fam_class4_3_num -0.083 0.224 -0.372  0.710   -0.529    0.350
      # 18             PEoU  ~ fam_class4_4_num  0.224 0.272  0.822  0.411   -0.318    0.749
      # 19               PU  ~ fam_class4_1_num -0.885 0.308 -2.874  0.004   -1.493   -0.286
      # 20               PU  ~ fam_class4_3_num -0.292 0.200 -1.462  0.144   -0.684    0.100
      # 21               PU  ~ fam_class4_4_num -0.167 0.357 -0.466  0.641   -0.845    0.554
      # 22               PU  ~             PEoU  0.587 0.108  5.428  0.000    0.371    0.795
      # 23                E  ~ fam_class4_1_num -0.534 0.257 -2.079  0.038   -1.042   -0.035
      # 24                E  ~ fam_class4_3_num -0.410 0.231 -1.776  0.076   -0.868    0.037
      # 25                E  ~ fam_class4_4_num  0.109 0.285  0.380  0.704   -0.460    0.659
      # 26           TAM_SS  ~ fam_class4_1_num -0.838 0.451 -1.860  0.063   -1.711    0.056
      # 27           TAM_SS  ~ fam_class4_3_num -0.375 0.338 -1.108  0.268   -1.021    0.304
      # 28           TAM_SS  ~ fam_class4_4_num -0.347 0.417 -0.833  0.405   -1.155    0.479
      # 29               SI  ~ fam_class4_1_num -0.847 0.369 -2.297  0.022   -1.597   -0.151
      # 30               SI  ~ fam_class4_3_num -1.075 0.275 -3.915  0.000   -1.641   -0.565
      # 31               SI  ~ fam_class4_4_num -0.208 0.384 -0.540  0.589   -0.954    0.552
      # 32         TAM_UI_1  ~             PEoU  0.029 0.145  0.197  0.844   -0.255    0.314
      # 33         TAM_UI_1  ~               PU -0.035 0.141 -0.247  0.805   -0.323    0.231
      # 34         TAM_UI_1  ~                E  0.084 0.144  0.587  0.557   -0.188    0.375
      # 35         TAM_UI_1  ~           TAM_SS  0.185 0.066  2.827  0.005    0.059    0.315
      # 36         TAM_UI_1  ~               SI  0.187 0.094  1.989  0.047    0.010    0.379
      # 37         TAM_UI_2  ~             PEoU  0.010 0.148  0.068  0.946   -0.291    0.290
      # 38         TAM_UI_2  ~               PU  0.189 0.119  1.591  0.112   -0.038    0.428
      # 39         TAM_UI_2  ~                E  0.455 0.134  3.407  0.001    0.196    0.720
      # 40         TAM_UI_2  ~           TAM_SS  0.040 0.057  0.712  0.476   -0.070    0.152
      # 41         TAM_UI_2  ~               SI  0.011 0.077  0.143  0.886   -0.138    0.165
      # 42         TAM_UI_3  ~             PEoU  0.154 0.174  0.888  0.374   -0.202    0.479
      # 43         TAM_UI_3  ~               PU  0.269 0.169  1.587  0.112   -0.046    0.618
      # 44         TAM_UI_3  ~                E  0.192 0.163  1.182  0.237   -0.131    0.507
      # 45         TAM_UI_3  ~           TAM_SS  0.019 0.070  0.271  0.786   -0.119    0.155
      # 46         TAM_UI_3  ~               SI  0.073 0.099  0.742  0.458   -0.116    0.271
      # 47       TAM_PEoU_1 ~~       TAM_PEoU_1  0.357 0.063  5.625  0.000    0.236    0.484
      # 48       TAM_PEoU_2 ~~       TAM_PEoU_2  1.401 0.264  5.307  0.000    0.893    1.928
      # 49       TAM_PEoU_3 ~~       TAM_PEoU_3  0.508 0.123  4.121  0.000    0.276    0.759
      # 50       TAM_PEoU_4 ~~       TAM_PEoU_4  0.517 0.095  5.456  0.000    0.341    0.713
      # 51         TAM_PU_1 ~~         TAM_PU_1  0.427 0.097  4.414  0.000    0.246    0.626
      # 52         TAM_PU_2 ~~         TAM_PU_2  0.739 0.140  5.274  0.000    0.475    1.024
      # 53         TAM_PU_3 ~~         TAM_PU_3  0.429 0.075  5.719  0.000    0.289    0.583
      # 54         TAM_PU_4 ~~         TAM_PU_4  0.845 0.132  6.388  0.000    0.601    1.119
      # 55          TAM_E_1 ~~          TAM_E_1  0.263 0.103  2.559  0.010    0.067    0.470
      # 56          TAM_E_2 ~~          TAM_E_2  0.390 0.159  2.449  0.014    0.079    0.704
      # 57          TAM_E_3 ~~          TAM_E_3  0.361 0.080  4.539  0.000    0.208    0.520
      # 58          TAM_E_4 ~~          TAM_E_4  1.216 0.210  5.791  0.000    0.818    1.642
      # 59         TAM_SI_1 ~~         TAM_SI_1  0.297 0.177  1.680  0.093   -0.049    0.645
      # 60         TAM_SI_2 ~~         TAM_SI_2  0.620 0.243  2.556  0.011    0.155    1.106
      # 61         TAM_SI_3 ~~         TAM_SI_3  1.717 0.283  6.060  0.000    1.174    2.284
      # 62         TAM_UI_1 ~~         TAM_UI_1  2.678 0.222 12.086  0.000    2.341    3.210
      # 63         TAM_UI_2 ~~         TAM_UI_2  1.256 0.209  6.004  0.000    0.900    1.720
      # 64         TAM_UI_3 ~~         TAM_UI_3  2.616 0.243 10.783  0.000    2.242    3.193
      # 65           TAM_SS ~~           TAM_SS  3.519 0.360  9.780  0.000    2.871    4.281
      # 66             PEoU ~~             PEoU  1.306 0.220  5.951  0.000    0.900    1.761
      # 67               PU ~~               PU  1.462 0.245  5.977  0.000    1.022    1.981
      # 68                E ~~                E  1.560 0.237  6.574  0.000    1.115    2.046
      # 69               SI ~~               SI  2.156 0.262  8.226  0.000    1.685    2.712
      # 70 fam_class4_1_num ~~ fam_class4_1_num  0.155 0.018  8.725  0.000    0.122    0.192
      # 71 fam_class4_3_num ~~ fam_class4_3_num  0.231 0.010 22.423  0.000    0.212    0.252
      # 72 fam_class4_4_num ~~ fam_class4_4_num  0.137 0.019  7.335  0.000    0.100    0.174
      # 73         TAM_UI_1 ~~         TAM_UI_2 -0.255 0.155 -1.650  0.099   -0.577    0.029
      # 74         TAM_UI_1 ~~         TAM_UI_3  0.016 0.227  0.069  0.945   -0.431    0.457
      # 75         TAM_UI_2 ~~         TAM_UI_3  0.865 0.194  4.452  0.000    0.517    1.279
     
      
      #then, we perform the SEM with the dummy/treatment coded family type variables: type 3 as reference level  
      rosiesTAM_3DVs_fam_class4_3 <- '

      #measurement model
        PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
        PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
        E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
        SI =~ 1*TAM_SI_1 + TAM_SI_2 + TAM_SI_3
      #regressions
        PEoU ~ fam_class4_1_num + fam_class4_2_num + fam_class4_4_num
        PU ~ fam_class4_1_num + fam_class4_2_num + fam_class4_4_num + PEoU
        E ~ fam_class4_1_num + fam_class4_2_num + fam_class4_4_num
        TAM_SS ~ fam_class4_1_num + fam_class4_2_num + fam_class4_4_num
        SI ~ fam_class4_1_num + fam_class4_2_num + fam_class4_4_num
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
        TAM_UI_1 ~~ TAM_UI_1
        TAM_UI_2 ~~ TAM_UI_2
        TAM_UI_3 ~~ TAM_UI_3
        TAM_SS ~~ TAM_SS
        PEoU ~~ PEoU
        PU ~~ PU
        E ~~ E
        SI ~~ SI
        fam_class4_1_num ~~ fam_class4_1_num
        fam_class4_2_num ~~ fam_class4_2_num
        fam_class4_4_num ~~ fam_class4_4_num
      '
      
      #fit the model
      rosiesTAM_3DVs_fam_class4_3_fit <- lavaan(rosiesTAM_3DVs_fam_class4_3, data = rosie_fscores) 
      
      #print summary
      summary(rosiesTAM_3DVs_fam_class4_3_fit, standardized = T, fit.measures = T)
      
      #check model improvements
      modindices(rosiesTAM_3DVs_fam_class4_3_fit, sort = TRUE)
      # selection of highest modindices:
      #                  lhs op              rhs     mi    epc sepc.lv sepc.all sepc.nox
      # 356             PEoU  ~                E 76.508  0.643   0.715    0.715    0.715
      # 368                E  ~             PEoU 76.508  0.766   0.689    0.689    0.689
      # 350             PEoU ~~                E 76.508  1.001   0.702    0.702    0.702
      # 360             PEoU  ~         TAM_UI_2 66.564  1.275   1.110    1.441    1.441
      # 369                E  ~               PU 63.323  0.570   0.633    0.633    0.633
      
      #bootstrap model
      rosiesTAM_3DVs_fam_class4_3_fit_boostrapped_se <- sem(rosiesTAM_3DVs_fam_class4_3, data = rosie_fscores,se = "bootstrap", bootstrap = 1000)
      summary(rosiesTAM_3DVs_fam_class4_3_fit_boostrapped_se, fit.measures = TRUE)
      parameterEstimates(rosiesTAM_3DVs_fam_class4_3_fit_boostrapped_se,
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
      
      # lhs op              rhs    est    se      z pvalue ci.lower ci.upper
      # 1              PEoU =~       TAM_PEoU_1  1.000 0.000     NA     NA    1.000    1.000
      # 2              PEoU =~       TAM_PEoU_2  0.797 0.087  9.198  0.000    0.626    0.966
      # 3              PEoU =~       TAM_PEoU_3  1.011 0.077 13.189  0.000    0.853    1.153
      # 4              PEoU =~       TAM_PEoU_4  1.066 0.076 14.057  0.000    0.913    1.210
      # 5                PU =~         TAM_PU_1  1.000 0.000     NA     NA    1.000    1.000
      # 6                PU =~         TAM_PU_2  0.919 0.058 15.766  0.000    0.805    1.033
      # 7                PU =~         TAM_PU_3  1.031 0.055 18.739  0.000    0.920    1.136
      # 8                PU =~         TAM_PU_4  0.774 0.069 11.159  0.000    0.637    0.909
      # 9                 E =~          TAM_E_1  1.000 0.000     NA     NA    1.000    1.000
      # 10                E =~          TAM_E_2  0.929 0.058 16.047  0.000    0.813    1.039
      # 11                E =~          TAM_E_3  0.949 0.054 17.486  0.000    0.849    1.061
      # 12                E =~          TAM_E_4  0.768 0.078  9.852  0.000    0.621    0.927
      # 13               SI =~         TAM_SI_1  1.000 0.000     NA     NA    1.000    1.000
      # 14               SI =~         TAM_SI_2  0.968 0.064 15.178  0.000    0.839    1.089
      # 15               SI =~         TAM_SI_3  0.815 0.070 11.579  0.000    0.676    0.952
      # 16             PEoU  ~ fam_class4_1_num -0.058 0.268 -0.216  0.829   -0.579    0.470
      # 17             PEoU  ~ fam_class4_2_num  0.083 0.224  0.372  0.710   -0.355    0.523
      # 18             PEoU  ~ fam_class4_4_num  0.307 0.260  1.183  0.237   -0.207    0.810
      # 19               PU  ~ fam_class4_1_num -0.592 0.301 -1.968  0.049   -1.185   -0.005
      # 20               PU  ~ fam_class4_2_num  0.292 0.212  1.378  0.168   -0.122    0.710
      # 21               PU  ~ fam_class4_4_num  0.126 0.338  0.372  0.710   -0.528    0.798
      # 22               PU  ~             PEoU  0.587 0.108  5.433  0.000    0.373    0.796
      # 23                E  ~ fam_class4_1_num -0.124 0.274 -0.453  0.651   -0.649    0.424
      # 24                E  ~ fam_class4_2_num  0.410 0.247  1.663  0.096   -0.063    0.904
      # 25                E  ~ fam_class4_4_num  0.519 0.310  1.676  0.094   -0.087    1.126
      # 26           TAM_SS  ~ fam_class4_1_num -0.463 0.429 -1.079  0.280   -1.292    0.391
      # 27           TAM_SS  ~ fam_class4_2_num  0.375 0.344  1.090  0.276   -0.292    1.055
      # 28           TAM_SS  ~ fam_class4_4_num  0.027 0.404  0.067  0.946   -0.767    0.818
      # 29               SI  ~ fam_class4_1_num  0.228 0.315  0.723  0.469   -0.369    0.864
      # 30               SI  ~ fam_class4_2_num  1.075 0.286  3.765  0.000    0.533    1.653
      # 31               SI  ~ fam_class4_4_num  0.867 0.360  2.411  0.016    0.186    1.597
      # 32         TAM_UI_1  ~             PEoU  0.029 0.138  0.206  0.836   -0.245    0.297
      # 33         TAM_UI_1  ~               PU -0.035 0.149 -0.233  0.815   -0.336    0.249
      # 34         TAM_UI_1  ~                E  0.084 0.148  0.570  0.569   -0.195    0.385
      # 35         TAM_UI_1  ~           TAM_SS  0.185 0.069  2.679  0.007    0.048    0.319
      # 36         TAM_UI_1  ~               SI  0.187 0.098  1.907  0.056    0.001    0.386
      # 37         TAM_UI_2  ~             PEoU  0.010 0.145  0.070  0.945   -0.273    0.295
      # 38         TAM_UI_2  ~               PU  0.189 0.122  1.556  0.120   -0.042    0.434
      # 39         TAM_UI_2  ~                E  0.455 0.134  3.386  0.001    0.188    0.715
      # 40         TAM_UI_2  ~           TAM_SS  0.040 0.055  0.728  0.467   -0.064    0.154
      # 41         TAM_UI_2  ~               SI  0.011 0.078  0.142  0.887   -0.139    0.167
      # 42         TAM_UI_3  ~             PEoU  0.154 0.163  0.946  0.344   -0.172    0.468
      # 43         TAM_UI_3  ~               PU  0.269 0.180  1.495  0.135   -0.085    0.620
      # 44         TAM_UI_3  ~                E  0.192 0.170  1.130  0.258   -0.135    0.532
      # 45         TAM_UI_3  ~           TAM_SS  0.019 0.071  0.267  0.789   -0.112    0.167
      # 46         TAM_UI_3  ~               SI  0.073 0.096  0.763  0.446   -0.110    0.266
      # 47       TAM_PEoU_1 ~~       TAM_PEoU_1  0.357 0.063  5.673  0.000    0.239    0.486
      # 48       TAM_PEoU_2 ~~       TAM_PEoU_2  1.401 0.268  5.233  0.000    0.901    1.950
      # 49       TAM_PEoU_3 ~~       TAM_PEoU_3  0.508 0.116  4.377  0.000    0.298    0.752
      # 50       TAM_PEoU_4 ~~       TAM_PEoU_4  0.517 0.095  5.426  0.000    0.344    0.718
      # 51         TAM_PU_1 ~~         TAM_PU_1  0.427 0.095  4.493  0.000    0.248    0.621
      # 52         TAM_PU_2 ~~         TAM_PU_2  0.739 0.144  5.116  0.000    0.462    1.028
      # 53         TAM_PU_3 ~~         TAM_PU_3  0.429 0.074  5.833  0.000    0.294    0.582
      # 54         TAM_PU_4 ~~         TAM_PU_4  0.845 0.143  5.897  0.000    0.575    1.136
      # 55          TAM_E_1 ~~          TAM_E_1  0.263 0.096  2.737  0.006    0.090    0.467
      # 56          TAM_E_2 ~~          TAM_E_2  0.390 0.153  2.550  0.011    0.113    0.713
      # 57          TAM_E_3 ~~          TAM_E_3  0.361 0.082  4.406  0.000    0.197    0.518
      # 58          TAM_E_4 ~~          TAM_E_4  1.216 0.210  5.797  0.000    0.815    1.637
      # 59         TAM_SI_1 ~~         TAM_SI_1  0.297 0.171  1.734  0.083   -0.032    0.640
      # 60         TAM_SI_2 ~~         TAM_SI_2  0.620 0.179  3.458  0.001    0.288    0.991
      # 61         TAM_SI_3 ~~         TAM_SI_3  1.717 0.290  5.927  0.000    1.167    2.302
      # 62         TAM_UI_1 ~~         TAM_UI_1  2.678 0.228 11.728  0.000    2.342    3.237
      # 63         TAM_UI_2 ~~         TAM_UI_2  1.256 0.219  5.732  0.000    0.898    1.757
      # 64         TAM_UI_3 ~~         TAM_UI_3  2.616 0.262  9.984  0.000    2.223    3.250
      # 65           TAM_SS ~~           TAM_SS  3.519 0.360  9.779  0.000    2.883    4.294
      # 66             PEoU ~~             PEoU  1.306 0.214  6.102  0.000    0.912    1.751
      # 67               PU ~~               PU  1.462 0.239  6.123  0.000    1.042    1.978
      # 68                E ~~                E  1.560 0.230  6.790  0.000    1.128    2.029
      # 69               SI ~~               SI  2.156 0.258  8.365  0.000    1.692    2.702
      # 70 fam_class4_1_num ~~ fam_class4_1_num  0.155 0.018  8.480  0.000    0.120    0.191
      # 71 fam_class4_2_num ~~ fam_class4_2_num  0.203 0.014 14.132  0.000    0.176    0.232
      # 72 fam_class4_4_num ~~ fam_class4_4_num  0.137 0.018  7.532  0.000    0.103    0.174
      # 73         TAM_UI_1 ~~         TAM_UI_2 -0.255 0.155 -1.643  0.100   -0.589    0.019
      # 74         TAM_UI_1 ~~         TAM_UI_3  0.016 0.219  0.072  0.943   -0.437    0.422
      # 75         TAM_UI_2 ~~         TAM_UI_3  0.865 0.204  4.251  0.000    0.515    1.313
      
      
      #then, we perform the SEM with the dummy/treatment coded family type variables: type 4 as reference level  
      rosiesTAM_3DVs_fam_class4_4 <- '

      #measurement model
        PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
        PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
        E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
        SI =~ 1*TAM_SI_1 + TAM_SI_2 + TAM_SI_3
      #regressions
        PEoU ~ fam_class4_1_num + fam_class4_2_num + fam_class4_3_num
        PU ~ fam_class4_1_num + fam_class4_2_num + fam_class4_3_num + PEoU
        E ~ fam_class4_1_num + fam_class4_2_num + fam_class4_3_num
        TAM_SS ~ fam_class4_1_num + fam_class4_2_num + fam_class4_3_num
        SI ~ fam_class4_1_num + fam_class4_2_num + fam_class4_3_num
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
        TAM_UI_1 ~~ TAM_UI_1
        TAM_UI_2 ~~ TAM_UI_2
        TAM_UI_3 ~~ TAM_UI_3
        TAM_SS ~~ TAM_SS
        PEoU ~~ PEoU
        PU ~~ PU
        E ~~ E
        SI ~~ SI
        fam_class4_1_num ~~ fam_class4_1_num
        fam_class4_2_num ~~ fam_class4_2_num
        fam_class4_3_num ~~ fam_class4_3_num
      '
      
      #fit the model
      rosiesTAM_3DVs_fam_class4_4_fit <- lavaan(rosiesTAM_3DVs_fam_class4_4, data = rosie_fscores) 
      
      #print summary
      summary(rosiesTAM_3DVs_fam_class4_4_fit, standardized = T, fit.measures = T)
      
      #check model improvements
      modindices(rosiesTAM_3DVs_fam_class4_4_fit, sort = TRUE)
      # selection of highest modindices:
      #                  lhs op              rhs     mi    epc sepc.lv sepc.all sepc.nox
      # 368                E  ~             PEoU 76.505  0.766   0.687    0.687    0.687
      # 350             PEoU ~~                E 76.504  1.001   0.702    0.702    0.702
      # 356             PEoU  ~                E 76.504  0.643   0.717    0.717    0.717
      # 369                E  ~               PU 63.318  0.570   0.631    0.631    0.631
      # 360             PEoU  ~         TAM_UI_2 60.494  1.159   0.994    1.302    1.302
      
      #bootstrap model
      rosiesTAM_3DVs_fam_class4_4_fit_boostrapped_se <- sem(rosiesTAM_3DVs_fam_class4_4, data = rosie_fscores,se = "bootstrap", bootstrap = 1000)
      summary(rosiesTAM_3DVs_fam_class4_4_fit_boostrapped_se, fit.measures = TRUE)
      parameterEstimates(rosiesTAM_3DVs_fam_class4_4_fit_boostrapped_se,
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
      
      #                 lhs op              rhs    est    se      z pvalue ci.lower ci.upper
      # 1              PEoU =~       TAM_PEoU_1  1.000 0.000     NA     NA    1.000    1.000
      # 2              PEoU =~       TAM_PEoU_2  0.797 0.086  9.214  0.000    0.630    0.969
      # 3              PEoU =~       TAM_PEoU_3  1.011 0.076 13.264  0.000    0.861    1.160
      # 4              PEoU =~       TAM_PEoU_4  1.066 0.077 13.911  0.000    0.915    1.215
      # 5                PU =~         TAM_PU_1  1.000 0.000     NA     NA    1.000    1.000
      # 6                PU =~         TAM_PU_2  0.919 0.057 16.006  0.000    0.807    1.032
      # 7                PU =~         TAM_PU_3  1.031 0.054 18.992  0.000    0.922    1.134
      # 8                PU =~         TAM_PU_4  0.774 0.067 11.608  0.000    0.641    0.902
      # 9                 E =~          TAM_E_1  1.000 0.000     NA     NA    1.000    1.000
      # 10                E =~          TAM_E_2  0.929 0.062 14.952  0.000    0.813    1.056
      # 11                E =~          TAM_E_3  0.949 0.053 17.846  0.000    0.845    1.053
      # 12                E =~          TAM_E_4  0.768 0.078  9.857  0.000    0.612    0.917
      # 13               SI =~         TAM_SI_1  1.000 0.000     NA     NA    1.000    1.000
      # 14               SI =~         TAM_SI_2  0.968 0.063 15.431  0.000    0.843    1.089
      # 15               SI =~         TAM_SI_3  0.815 0.070 11.646  0.000    0.672    0.947
      # 16             PEoU  ~ fam_class4_1_num -0.365 0.297 -1.227  0.220   -0.923    0.242
      # 17             PEoU  ~ fam_class4_2_num -0.224 0.263 -0.850  0.395   -0.736    0.296
      # 18             PEoU  ~ fam_class4_3_num -0.307 0.258 -1.190  0.234   -0.801    0.210
      # 19               PU  ~ fam_class4_1_num -0.718 0.417 -1.721  0.085   -1.551    0.085
      # 20               PU  ~ fam_class4_2_num  0.167 0.332  0.501  0.616   -0.493    0.809
      # 21               PU  ~ fam_class4_3_num -0.126 0.334 -0.377  0.706   -0.798    0.510
      # 22               PU  ~             PEoU  0.587 0.109  5.376  0.000    0.366    0.794
      # 23                E  ~ fam_class4_1_num -0.643 0.317 -2.025  0.043   -1.226    0.018
      # 24                E  ~ fam_class4_2_num -0.109 0.299 -0.363  0.716   -0.675    0.497
      # 25                E  ~ fam_class4_3_num -0.519 0.299 -1.736  0.083   -1.094    0.078
      # 26           TAM_SS  ~ fam_class4_1_num -0.490 0.494 -0.993  0.321   -1.487    0.450
      # 27           TAM_SS  ~ fam_class4_2_num  0.347 0.407  0.853  0.394   -0.451    1.146
      # 28           TAM_SS  ~ fam_class4_3_num -0.027 0.420 -0.065  0.948   -0.854    0.794
      # 29               SI  ~ fam_class4_1_num -0.640 0.417 -1.534  0.125   -1.464    0.171
      # 30               SI  ~ fam_class4_2_num  0.208 0.370  0.561  0.575   -0.517    0.933
      # 31               SI  ~ fam_class4_3_num -0.867 0.361 -2.403  0.016   -1.579   -0.164
      # 32         TAM_UI_1  ~             PEoU  0.029 0.142  0.201  0.841   -0.257    0.301
      # 33         TAM_UI_1  ~               PU -0.035 0.147 -0.237  0.813   -0.334    0.243
      # 34         TAM_UI_1  ~                E  0.084 0.154  0.547  0.585   -0.202    0.402
      # 35         TAM_UI_1  ~           TAM_SS  0.185 0.067  2.752  0.006    0.051    0.315
      # 36         TAM_UI_1  ~               SI  0.187 0.098  1.902  0.057   -0.001    0.385
      # 37         TAM_UI_2  ~             PEoU  0.010 0.141  0.071  0.943   -0.279    0.274
      # 38         TAM_UI_2  ~               PU  0.189 0.116  1.635  0.102   -0.022    0.432
      # 39         TAM_UI_2  ~                E  0.455 0.133  3.425  0.001    0.191    0.712
      # 40         TAM_UI_2  ~           TAM_SS  0.040 0.057  0.713  0.476   -0.068    0.154
      # 41         TAM_UI_2  ~               SI  0.011 0.078  0.142  0.887   -0.143    0.162
      # 42         TAM_UI_3  ~             PEoU  0.154 0.171  0.901  0.367   -0.205    0.466
      # 43         TAM_UI_3  ~               PU  0.269 0.170  1.585  0.113   -0.046    0.619
      # 44         TAM_UI_3  ~                E  0.192 0.166  1.161  0.245   -0.131    0.518
      # 45         TAM_UI_3  ~           TAM_SS  0.019 0.073  0.262  0.793   -0.119    0.165
      # 46         TAM_UI_3  ~               SI  0.073 0.098  0.748  0.454   -0.114    0.270
      # 47       TAM_PEoU_1 ~~       TAM_PEoU_1  0.357 0.065  5.509  0.000    0.236    0.490
      # 48       TAM_PEoU_2 ~~       TAM_PEoU_2  1.401 0.263  5.331  0.000    0.888    1.918
      # 49       TAM_PEoU_3 ~~       TAM_PEoU_3  0.508 0.121  4.188  0.000    0.274    0.749
      # 50       TAM_PEoU_4 ~~       TAM_PEoU_4  0.517 0.101  5.144  0.000    0.324    0.719
      # 51         TAM_PU_1 ~~         TAM_PU_1  0.427 0.094  4.540  0.000    0.248    0.616
      # 52         TAM_PU_2 ~~         TAM_PU_2  0.739 0.138  5.343  0.000    0.473    1.015
      # 53         TAM_PU_3 ~~         TAM_PU_3  0.429 0.074  5.825  0.000    0.292    0.581
      # 54         TAM_PU_4 ~~         TAM_PU_4  0.845 0.134  6.292  0.000    0.597    1.123
      # 55          TAM_E_1 ~~          TAM_E_1  0.263 0.106  2.485  0.013    0.063    0.478
      # 56          TAM_E_2 ~~          TAM_E_2  0.390 0.164  2.387  0.017    0.068    0.709
      # 57          TAM_E_3 ~~          TAM_E_3  0.361 0.080  4.527  0.000    0.210    0.523
      # 58          TAM_E_4 ~~          TAM_E_4  1.216 0.204  5.973  0.000    0.849    1.647
      # 59         TAM_SI_1 ~~         TAM_SI_1  0.297 0.162  1.837  0.066   -0.018    0.617
      # 60         TAM_SI_2 ~~         TAM_SI_2  0.620 0.175  3.553  0.000    0.287    0.971
      # 61         TAM_SI_3 ~~         TAM_SI_3  1.717 0.279  6.152  0.000    1.203    2.297
      # 62         TAM_UI_1 ~~         TAM_UI_1  2.678 0.220 12.153  0.000    2.349    3.213
      # 63         TAM_UI_2 ~~         TAM_UI_2  1.256 0.210  5.984  0.000    0.900    1.723
      # 64         TAM_UI_3 ~~         TAM_UI_3  2.616 0.267  9.810  0.000    2.202    3.248
      # 65           TAM_SS ~~           TAM_SS  3.519 0.354  9.943  0.000    2.916    4.304
      # 66             PEoU ~~             PEoU  1.306 0.221  5.916  0.000    0.897    1.763
      # 67               PU ~~               PU  1.462 0.239  6.108  0.000    1.057    1.995
      # 68                E ~~                E  1.560 0.238  6.545  0.000    1.128    2.063
      # 69               SI ~~               SI  2.156 0.249  8.649  0.000    1.720    2.697
      # 70 fam_class4_1_num ~~ fam_class4_1_num  0.155 0.018  8.374  0.000    0.120    0.193
      # 71 fam_class4_2_num ~~ fam_class4_2_num  0.203 0.014 14.305  0.000    0.176    0.232
      # 72 fam_class4_3_num ~~ fam_class4_3_num  0.231 0.010 22.597  0.000    0.212    0.252
      # 73         TAM_UI_1 ~~         TAM_UI_2 -0.255 0.154 -1.655  0.098   -0.577    0.027
      # 74         TAM_UI_1 ~~         TAM_UI_3  0.016 0.221  0.071  0.943   -0.430    0.437
      # 75         TAM_UI_2 ~~         TAM_UI_3  0.865 0.205  4.215  0.000    0.495    1.299
###----------------------------------------------------------------------------------------------------------------###
          
#------------------------------------------------------#
### Final model visualization ##########################
#-----------------------------------------------------#
          
### SemPaths Model Visualization ###
       
    library(semPlot)
    semPaths(rosiesTAM_3DVs_fam_class4_fit, what = "col", "std", layout = "tree", rotation = 2, 
             intercepts = F, residuals = F, curve = 2, nCharNodes = 0,
             edge.label.cex = 1, edge.color = "black", sizeMan = 10, sizeMan2 = 5)
    title("Structural Equation Model")
    
    #OR using https://cran.r-project.org/web/packages/tidySEM/vignettes/Plotting_graphs.html 
    
    library(tidySEM)
    graph_sem(model = rosiesTAM_3DVs_fam_class4_fit)
    
#########  :) Script run until here #################
    
    #von Flo
    emf(file = "sent.score.monat.emf", width = 13, height = 9,
        bg = "transparent", fg = "black", pointsize = 12,
        family = "Arial", coordDPI = 300)
    sentiment_score_monate_grafik
    dev.off()

    
###----------------------------------------------------------------------------------------------------------------###
    
#------------------------------------------------#
### Exploratory Analyses ##########################
#------------------------------------------------#  
    
    
  ### see how the family types directly relate to our DVs ##########################
    # Compute the analysis of variance
    anova_UI_1 <- aov(TAM_UI_1 ~ fam_class4, data = rosie_fscores) #not significant
    # Summary of the analysis
    summary(anova_UI_1) #not significant
    # Alternative non-parametric test
    kruskal.test(TAM_UI_1 ~ fam_class4, data = rosie_fscores) #not significant
    
    ### >> Family types do not differ in their use intention.

    
    # Compute the analysis of variance
    anova_UI_2 <- aov(TAM_UI_2 ~ fam_class4, data = rosie_fscores) 
    # Summary of the analysis
    summary(anova_UI_2) #significant
    # Alternative non-parametric test
    kruskal.test(TAM_UI_2 ~ fam_class4, data = rosie_fscores) #significant
    
        #Where are the differences? 
        TukeyHSD(anova_UI_2)
        # $fam_class4
        #           diff         lwr       upr     p adj
        # 2-1  0.7483516 -0.01513748 1.5118408 0.0570068 
        # 3-1  0.2926407 -0.43754551 1.0228269 0.7265694
        # 4-1  0.9047619  0.03591961 1.7736042 0.0377129 *
        # 3-2 -0.4557110 -1.10322068 0.1917988 0.2649373
        # 4-2  0.1564103 -0.64420443 0.9570249 0.9574220
        # 4-3  0.6121212 -0.15680019 1.3810426 0.1688352
        # >> Only significant difference between class 1 and 4 
        
        #Checking out mean plot
        ggplot(rosie_fscores, aes(x=factor(fam_class4), y=TAM_UI_2)) + 
          geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
          geom_point(stat="summary", fun.y="mean") + 
          geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
          labs(x="Family Types", y="Co-Usage Intention (mean + 95%CI)") +
          theme_bw() +
          theme(axis.text.x=element_text(angle=45, hjust=1)) 
    
        ### >> Family types 1 and 4 significantly differ in their co-usage intention, 
        ###    with class 4 (mediators) with greater co-usage intention, which makes sense!
        
        
    # Compute the analysis of variance
    anova_UI_3 <- aov(TAM_UI_3 ~ fam_class4, data = rosie_fscores) 
    # Summary of the analysis
    summary(anova_UI_3) #significant
    # Alternative non-parametric test
    kruskal.test(TAM_UI_3 ~ fam_class4, data = rosie_fscores) #significant
    
          #Where are the differences? 
          TukeyHSD(anova_UI_3)
          # $fam_class4
          # diff         lwr       upr     p adj
          # 2-1  0.9412088 -0.05022595 1.9326435 0.0695303
          # 3-1  0.3112554 -0.63693356 1.2594444 0.8297393
          # 4-1  1.0476190 -0.08062287 2.1758610 0.0792016
          # 3-2 -0.6299534 -1.47078215 0.2108754 0.2139714
          # 4-2  0.1064103 -0.93323417 1.1460547 0.9934332
          # 4-3  0.7363636 -0.26212522 1.7348525 0.2264496
          # >> No significant differences when adjusting for multiple testing. 
          
          #Checking out mean plot
          ggplot(rosie_fscores, aes(x=factor(fam_class4), y=TAM_UI_3)) + 
            geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
            geom_point(stat="summary", fun.y="mean") + 
            geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
            labs(x="Family Types", y="Co-Usage Intention (mean + 95%CI)") +
            theme_bw() +
            theme(axis.text.x=element_text(angle=45, hjust=1)) 
          
          ### >> Family types do not differ in their use intention.
    
    
  

  ### only TAM, separately from family typology ##########################
    rosiesTAM_only <- '

        #measurement model
          PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
          PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
          E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
          SI =~ 1*TAM_SI_1 + TAM_SI_2 + TAM_SI_3
        #regressions
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
          TAM_UI_1 ~~ TAM_UI_1
          TAM_UI_2 ~~ TAM_UI_2
          TAM_UI_3 ~~ TAM_UI_3
          TAM_SS ~~ TAM_SS
          PEoU ~~ PEoU
          PU ~~ PU
          E ~~ E
          SI ~~ SI
          TAM_UI_1 ~~ TAM_UI_2
          TAM_UI_1 ~~ TAM_UI_3
          TAM_UI_2 ~~ TAM_UI_3

        '
    
    #fit the model
    rosiesTAM_only_fit <- lavaan(rosiesTAM_only, data = rosie_fscores)
    
    #print summary
    summary(rosiesTAM_only_fit, standardized = T, fit.measures = T)
    
    ### >> Model fit is still not acceptable, so it's not the family types that add that much complexity!
    
###----------------------------------------------------------------------------------------------------------------###  
    
