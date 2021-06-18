
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
 data <- read.spss('244408473_Virtual assistant_Rosie.sav', to.data.frame=TRUE, use.value.labels = FALSE)
 #View(data)
  
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
   rosie_dataset <- data[,-c(4:16, 42:54, 56:67, 69:80, 109:120, 138:149, 157:168, 199:291, 294:305, 307:309, 313:325, 328:329)]
   #View(rosie_dataset)
   
   #getting variable names and index numbers of reduced dataset
   names(rosie_dataset)

#----------------------------------------------------------------------#
#       CONTINUE WITH REDUCED DATASET
   
   
#-----------------------------------------------#
### RENAMING VARIABLES ##########################
#-----------------------------------------------#
   
   #renaming variables
   library(dplyr)
   rosie_dataset_renamed <- dplyr::rename(rosie_dataset, c('pp_ID' = 'INTNR',
                                                           'Duration' = 'INTTIME',
                                                           'Dateandtime' = 'STIME',
                                                           'IoT_Usage_1' = 'IoT_Usage_01', 
                                                           'IoT_Usage_2' = 'IoT_Usage_02',
                                                           'IoT_Usage_3' = 'IoT_Usage_03', 
                                                           'IoT_Usage_4' = 'IoT_Usage_04',
                                                           'IoT_Usage_5' = 'IoT_Usage_05', 
                                                           'IoT_Usage_6' = 'IoT_Usage_06',
                                                           'IoT_Usage_7' = 'IoT_Usage_07', 
                                                           'IoT_Usage_8' = 'IoT_Usage_08',
                                                           'IoT_Usage_9' = 'IoT_Usage_09', 
                                                           'IoT_Usage_10' = 'IoT_Usage_10',
                                                           'IoT_Usage_11' = 'IoT_Usage_11', 
                                                           'IoT_Usage_12' = 'IoT_Usage_12',
                                                           'IoT_Usage_13' = 'IoT_Usage_13',
                                                           'IoT_Usage_14' = 'IoT_Usage_14',
                                                           'IoT_Usage_15' = 'IoT_Usage_15',
                                                           'IoT_Usage_16' = 'IoT_Usage_16',
                                                           'IoT_Usage_17' = 'IoT_Usage_17',
                                                           'IoT_Usage_18' = 'IoT_Usage_18',
                                                           'IoT_Usage_19' = 'IoT_Usage_19',
                                                           'IoT_Usage_20' = 'IoT_Usage_20',
                                                           'IoT_Usage_21' = 'IoT_Usage_21',
                                                           'IoT_Usage_22' = 'IoT_Usage_22',
                                                           'IoT_Usage_23' = 'IoT_Usage_23',
                                                           'IoT_Usage_24' = 'IoT_Usage_24',
                                                           'IoT_Usage_25' = 'IoT_Usage_25',
                                                           'IoT_Usage_otherI' = 'IoT_Usage_07_open',
                                                           'IoT_Usage_otherII' = 'IoT_Usage_96_open',
                                                           'GA_Freq_1' = 'GA_Freq_01',
                                                           'GA_Freq_2' = 'GA_Freq_02',
                                                           'GA_Freq_3' = 'GA_Freq_03',
                                                           'GA_Freq_4' = 'GA_Freq_04',
                                                           'GA_Freq_5' = 'GA_Freq_05',
                                                           'GA_Freq_6' = 'GA_Freq_06',
                                                           'GA_Freq_7' = 'GA_Freq_07',
                                                           'GA_Freq_8' = 'GA_Freq_08',
                                                           'GA_Freq_9' = 'GA_Freq_09',
                                                           'GA_Freq_10' = 'GA_Freq_10',
                                                           'GA_Freq_11' = 'GA_Freq_11',
                                                           'IoT_Freq_1' = 'GA_IoT_Freq_01',
                                                           'IoT_Freq_2' = 'GA_IoT_Freq_02',
                                                           'IoT_Freq_3' = 'GA_IoT_Freq_03',
                                                           'IoT_Freq_4' = 'GA_IoT_Freq_04',
                                                           'IoT_Freq_5' = 'GA_IoT_Freq_05',
                                                           'IoT_Freq_6' = 'GA_IoT_Freq_06',
                                                           'IoT_Freq_7' = 'GA_IoT_Freq_07',
                                                           'IoT_Freq_8' = 'GA_IoT_Freq_08',
                                                           'IoT_Freq_9' = 'GA_IoT_Freq_09',
                                                           'IoT_Freq_10' = 'GA_IoT_Freq_10',
                                                           'IoT_Freq_11' = 'GA_IoT_Freq_11',
                                                           'IoT_Freq_12' = 'GA_IoT_Freq_12',
                                                           'IoT_Freq_13' = 'GA_IoT_Freq_13',
                                                           'IoT_Freq_14' = 'GA_IoT_Freq_14',
                                                           'IoT_Freq_15' = 'GA_IoT_Freq_15',
                                                           'IoT_Freq_16' = 'GA_IoT_Freq_16',
                                                           'GA_Usage_Open' = 'GA_Usage_Open',
                                                           'Child_Nr' = 'Child_nr',
                                                           'Child_Age' = 'Child_age',
                                                           'Child_Gender' = 'Child_gender',
                                                           'Child_Temp_1' = 'Child_temp_01',
                                                           'Child_Temp_2' = 'Child_temp_02',
                                                           'Child_Temp_3' = 'Child_temp_03',
                                                           'PMMS_1' = 'Child_PMMS_01',
                                                           'PMMS_2' = 'Child_PMMS_02',
                                                           'PMMS_3' = 'Child_PMMS_03',
                                                           'PMMS_4' = 'Child_PMMS_04',
                                                           'PMMS_5' = 'Child_PMMS_05',
                                                           'PMMS_6' = 'Child_PMMS_06',
                                                           'SS_cousage_1' = 'GA_Freq_samenmetkind_01',
                                                           'SS_cousage_2' = 'GA_Freq_samenmetkind_02',
                                                           'SS_childusage_1' = 'GA_Freq_kind_01',
                                                           'SS_childusage_2' = 'GA_Freq_kind_02',
                                                           'Incorporation' = 'GA_Usage_kind_Open',
                                                           'Child_Parasocial_1' = 'Parasocial_01',
                                                           'Child_Parasocial_2' = 'Parasocial_02',
                                                           'Child_Parasocial_3' = 'Parasocial_03',
                                                           'Child_Parasocial_4' = 'Parasocial_04',
                                                           'Child_Parasocial_5' = 'Parasocial_05',
                                                           'Location' = 'GA_Location',
                                                           'Location_other' = 'GA_Location_anders',
                                                           'Early_Adopter' = 'Early_adopters',
                                                           'Conversion' = 'GA_Conversion',
                                                           'TAM_PEoU_1' = 'TAM_PEoU_01',
                                                           'TAM_PEoU_2' = 'TAM_PEoU_02',
                                                           'TAM_PEoU_3' = 'TAM_PEoU_03',
                                                           'TAM_PEoU_4' = 'TAM_PEoU_04',
                                                           'TAM_PU_1' = 'TAM_PU_01',
                                                           'TAM_PU_2' = 'TAM_PU_02',
                                                           'TAM_PU_3' = 'TAM_PU_03',
                                                           'TAM_PU_4' = 'TAM_PU_04',
                                                           'TAM_E_1' = 'TAM_E_01',
                                                           'TAM_E_2' = 'TAM_E_02',
                                                           'TAM_E_3' = 'TAM_E_03',
                                                           'TAM_E_4' = 'TAM_E_04',
                                                           'TAM_SS' = 'TAM_IMG',
                                                           'TAM_SI_1' = 'TAM_SN_01',
                                                           'TAM_SI_2' = 'TAM_SN_02',
                                                           'TAM_SI_3' = 'TAM_SN_03',
                                                           'TAM_UI_1' = 'TAM_ICU_01',
                                                           'TAM_UI_2' = 'TAM_ICU_02',
                                                           'TAM_UI_3' = 'TAM_ICU_03',
                                                           'ATTENTION_CHECK' = 'ATTENTION_CHECK',
                                                           'IL_1' = 'IL_01',
                                                           'IL_2' = 'IL_02',
                                                           'IL_3' = 'IL_03',
                                                           'IL_4' = 'IL_04',
                                                           'IL_5' = 'IL_05',
                                                           'TT_1' = 'TT_01',
                                                           'TT_2' = 'TT_02',
                                                           'TT_3' = 'TT_03',
                                                           'STATUS' = 'STATUS',
                                                           'PERSONEN' = 'PERSONEN',
                                                           'GEMGROOTTE' = 'GEMGROOTTE',
                                                           'SOCIALEKLASSE2016' = 'SOCIALEKLASSE2016',
                                                           'GSL' = 'GSL',
                                                           'LFT' = 'LFT',
                                                           'Weight' = 'Weight',
                                                           'WeightK' = 'WeightK'))
   
   #to check
   #View(rosie_dataset_renamed)
   names(rosie_dataset_renamed)
   
#-----------------------------------------------#
### ROSIE TARGET GROUP ##########################
#-----------------------------------------------#
   
   #how many participants failed the attention check?
   names(rosie)
   library(dplyr)
   rosie_dataset_renamed_families <- dplyr::filter(rosie_dataset_renamed, Child_Nr != 1)
   
   source("http://pcwww.liv.ac.uk/~william/R/crosstab.r")
   crosstab(rosie_dataset_renamed_families, row.vars = "ATTENTION_CHECK", type = "row.pct")
   # ATTENTION_CHECK      %
   # 1   4.31
   # 2   0.27
   # 3   0.81
   # 4   4.04
   # 5   2.96
   # 6   5.39
   # 7  82.21
   # Sum 100.00
   
        ### --> 17.78 % of families failed the attention check
   
   crosstab(rosie_dataset_renamed_families, row.vars = "ATTENTION_CHECK", type = "f")
   # ATTENTION_CHECK Count
   # 1    16
   # 2     1
   # 3     3
   # 4    15
   # 5    11
   # 6    20
   # 7   305
   # Sum   371
   
        ### --> 66 (17.78%) families failed the attention check
   
   
   #filtering responses for Rosie target group (in total: 371 responses, completes: 305)
   library(dplyr)
   rosie_dataset_renamed_families_complete <- dplyr::filter(rosie_dataset_renamed, Child_Nr != 1 & STATUS == 1)
   #View(rosie_dataset_renamed_families_complete)
   names(rosie_dataset_renamed_families_complete)
   
   
#----------------------------------------------------------------------#
#       CONTINUE WITH FILTERED DATASET
   
#------------------------------------------#
### DATA CLEANING ##########################
#------------------------------------------#
  
  # #make sure the following variables are coded as explicit factors:
  #   #Child_Gender
  #   #SOCIALEKLASSE2016 (for SES) 
  #   #STATUS (complete or screened-out)
  #   #GSL (parent gender)
  #  rosie_dataset_renamed_families_complete$Child_Gender <- as.factor(rosie_dataset_renamed_families_complete$Child_Gender)
  #  rosie_dataset_renamed_families_complete$SOCIALEKLASSE2016 <- as.factor(rosie_dataset_renamed_families_complete$SOCIALEKLASSE2016)
  #  rosie_dataset_renamed_families_complete$STATUS <- as.factor(rosie_dataset_renamed_families_complete$STATUS)
  #  rosie_dataset_renamed_families_complete$GSL <- as.factor(rosie_dataset_renamed_families_complete$GSL)

   
  #recoding values of variables
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
  
  #UI
      #We asked as our DV how the families assume their usage to look like in the near future (TAM_UI_1 myself, TAM_UI_2 with my child, TAM_UI_3 child individually)
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
          
        # View(rosie_dataset_renamed_families_complete)
        
        
            
#----------------------------------------------------------------------#
#       CONTINUE WITH CLEANED DATASET
  
  # View(rosie_dataset_renamed_families_complete)
  
  #restarting dataset naming
  rosie <- rosie_dataset_renamed_families_complete
  #View(rosie)
  names(rosie)
  
#---------------------------------------------------#
### INSPECTING MISSINGNESS ##########################
#---------------------------------------------------#
  
  # checking for missingness in each variable
  summary(rosie) 
  #there seems to be one NA in UI_childindividually => this is row 74 (in R) = pp 888, this was due to a fault in the survey programming
  
        #inspecting this 1 NA further  
        #create new subset data frame 
        rosie_UI <- rosie[,c(123:125, 101:103)]
        #View(rosie_UI)

        #and now remove missing values
        rosie_UI_noNA <- na.omit(rosie_UI)
        # View(rosie_UI_noNA)
        
        #correlating the control variables UI_togetherwithchild & UI_childindividually with the DVs TAM_UI_1 myself, TAM_UI_2 with my child, TAM_UI_3 child individually
        round(cor(rosie_UI_noNA), 2)
        #                      UI_togetherwithchild UI_childindividually current_usage TAM_UI_1 TAM_UI_2 TAM_UI_3
        # UI_togetherwithchild                 1.00                 0.70          0.66    -0.04     0.43     0.32
        # UI_childindividually                 0.70                 1.00          0.55    -0.06     0.41     0.37
        # current_usage                        0.66                 0.55          1.00    -0.05     0.40     0.29
        # TAM_UI_1                            -0.04                -0.06         -0.05     1.00     0.01    -0.02
        # TAM_UI_2                             0.43                 0.41          0.40     0.01     1.00     0.58
        # TAM_UI_3                             0.32                 0.37          0.29    -0.02     0.58     1.00
        
        # >> co-usage and child-individual usage seem to go mostly hand-in-hand
        

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

#----------------------------------------------------------------------------------------------------------------#
  
#------------------------------------------------------#
### CHECKING MEASUREMENTMENTS ##########################
#------------------------------------------------------#
  

### 1) CFA (Measurement model)##########################


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
  library(lattice)
  library(pastecs)
  library(psych)
  #for CFA
  library(lavaan)
  
        #Dispositional: 
  
          ### TT >> 3 items ##########################
          
            #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                #visually
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
                standardized_TT <- scale(rosie[,c(110:112)]) 
                outliers_TT <- colSums(abs(standardized_TT)>=3, na.rm = T) 
                outliers_TT
                #TT_1 TT_2 TT_3 
                #0    0    0
                  
          
          #Step 1: correlations
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,110:112]), 2)
          #      TT_1 TT_2 TT_3
          # TT_1 1.00 0.68 0.43
          # TT_2 0.68 1.00 0.49
          # TT_3 0.43 0.49 1.00
  
          #Step 2: variance-covariance matrix
          round(cov(rosie[,110:112]), 2) 
          #      TT_1 TT_2 TT_3
          # TT_1 2.33 1.53 0.85
          # TT_2 1.53 2.15 0.94
          # TT_3 0.85 0.94 1.68
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1a  <- ' TT_f  =~ TT_1 + TT_2 + TT_3' 
          onefac3items_TT <- cfa(m1a, data=rosie) 
          summary(onefac3items_TT, fit.measures=TRUE, standardized=TRUE) # >> Seems like a "just" identified model. Wait and see for testing whole measurement model in SEM.
          # >> fit index criteria: Chi-Square = 0 because 0 df just identified, CFI = 1 > 0.95, TLI = 1 > 0.90 and RMSEA = 0 < 0.10
    
          
          ### IL >> 5 items #########################      
          
          #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                #visually
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
                standardized_IL <- scale(rosie[,c(105:109)]) 
                outliers_IL <- colSums(abs(standardized_IL)>=3, na.rm = T) 
                outliers_IL
                # IL_1 IL_2 IL_3 IL_4 IL_5 
                # 3    4    2    0    0
                
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
                      outlier_scores_IL_2 <- scores(rosie$IL_2)
                      is_outlier_IL_2 <- outlier_scores_IL_2 > 3 | outlier_scores_IL_2 < -3
                      #add a column with info whether the refund_value is an outlier
                      rosie$is_outlier_IL_2 <- is_outlier_IL_2
                      #look at plot
                      ggplot(rosie, aes(IL_2)) +
                        geom_boxplot() +
                        coord_flip() +
                        facet_wrap(~is_outlier_IL_2)
                      #create a dataframe with only outliers
                      outlier_IL_2_df <- rosie[outlier_scores_IL_2 > 3| outlier_scores_IL_2 < -3, ]
                      #take a peek
                      head(outlier_IL_2_df) # >> outliers lay in observations 7, 74, 213, 285
                      
                      #For IL_3: Where are those outliers exactly? In what rows?
                      outlier_scores_IL_3 <- scores(rosie$IL_3)
                      is_outlier_IL_3 <- outlier_scores_IL_3 > 3 | outlier_scores_IL_3 < -3
                      #add a column with info whether the refund_value is an outlier
                      rosie$is_outlier_IL_3 <- is_outlier_IL_3
                      #look at plot
                      ggplot(rosie, aes(IL_3)) +
                        geom_boxplot() +
                        coord_flip() +
                        facet_wrap(~is_outlier_IL_3)
                      #create a dataframe with only outliers
                      outlier_IL_3_df <- rosie[outlier_scores_IL_3 > 3| outlier_scores_IL_3 < -3, ]
                      #take a peek
                      head(outlier_IL_3_df) # >> outliers lay in observations 7, 74
                
          
          #Step 1: correlations
          #The function cor specifies the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,105:109]),2) 
          #      IL_1 IL_2 IL_3 IL_4 IL_5
          # IL_1 1.00 0.56 0.67 0.52 0.49
          # IL_2 0.56 1.00 0.60 0.66 0.53
          # IL_3 0.67 0.60 1.00 0.58 0.53
          # IL_4 0.52 0.66 0.58 1.00 0.59
          # IL_5 0.49 0.53 0.53 0.59 1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,105:109]),2) 
          #      IL_1 IL_2 IL_3 IL_4 IL_5
          # IL_1 2.07 0.98 1.38 1.27 1.11
          # IL_2 0.98 1.49 1.05 1.36 1.03
          # IL_3 1.38 1.05 2.05 1.40 1.19
          # IL_4 1.27 1.36 1.40 2.86 1.56
          # IL_5 1.11 1.03 1.19 1.56 2.49
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1i  <- ' f  =~ IL_1 + IL_2 + IL_3 + IL_4 + IL_5'
          onefac5items_IL <- cfa(m1i, data=rosie,std.lv=TRUE) 
          summary(onefac5items_IL,fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .000 NOT > .05, CFI = .965 > 0.95, TLI = .929 > 0.90 and RMSEA = .128 NOT < 0.10 >> NOT SO CONVINCING
          
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
          # Loadings:
          #         MR1    MR2   
          # IL_1  0.826       
          # IL_2  0.316  0.506    #Items 1 and 3 seem to load together, which is in accordance with the modindices above (.316 can be ignored since it is so close to the cut-off value)
          # IL_3  0.795       
          # IL_4         0.921
          # IL_5         0.466
          # 
          #                  MR1   MR2
          # SS loadings    1.483 1.325
          # Proportion Var 0.297 0.265
          # Cumulative Var 0.297 0.562
          
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
          # >> fit index criteria: Chi-Square = .313 > .05, CFI = .999 > 0.95, TLI = .997 > 0.90 and RMSEA = .025 < 0.10 #VERY NICE
          
          
          
          ### Child_Temp >> 3 items ##########################
  
            #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                #visually
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
                standardized_Child_Temp <- scale(rosie[,c(62:64)]) 
                outliers_Child_Temp <- colSums(abs(standardized_Child_Temp)>=3, na.rm = T) 
                outliers_Child_Temp
                # Child_Temp_1 Child_Temp_2 Child_Temp_3 
                # 3            0            0
                
                      #For Child_Temp_1: Where are those outliers exactly? In what rows?
                      library(outliers)
                      outlier_scores_CTemp_1  <- scores(rosie$Child_Temp_1 )
                      is_outlier_CTemp_1  <- outlier_scores_CTemp_1  > 3 | outlier_scores_CTemp_1  < -3
                      #add a column with info whether the refund_value is an outlier
                      rosie$is_outlier_CTemp_1  <- is_outlier_CTemp_1 
                      #look at plot
                      library(ggplot2)
                      ggplot(rosie, aes(Child_Temp_1 )) +
                        geom_boxplot() +
                        coord_flip() +
                        facet_wrap(~is_outlier_CTemp_1 )
                      #create a dataframe with only outliers
                      outlier_CTemp_1_df <- rosie[outlier_scores_CTemp_1  > 3| outlier_scores_CTemp_1  < -3, ]
                      #take a peek
                      head(outlier_CTemp_1_df) # >> outliers lay in observations 153, 156, 287
                      
          
          #Step 1: correlations
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,62:64]), 2) # >> Here, it seems running a CFA does not really make much sense due to the extremely low correlations, which makes sense
                                       #    because each item represents construct on its own.
          #                           Child_Temp_2 Child_Temp_3
          # Child_Temp_1         1.00            0         0.17
          # Child_Temp_2         0.00            1         0.00
          # Child_Temp_3         0.17            0         1.00
          
                  #renaming Child_Temp items along original single-item Temperament Scale by Sleddens et al. (2012)
                  library(dplyr)
                  rosie <- dplyr::rename(rosie, c('Child_Temp_Extraversion' = 'Child_Temp_1',
                                         'Child_Temp_Negative_Affectivity' = 'Child_Temp_2',
                                         'Child_Temp_Effortful_Control' = 'Child_Temp_3'))
                  names(rosie)
          
          
          ### Child_Parasocial >> 5 items#########################
          
          #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                #visually
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
                standardized_Child_Parasocial <- scale(rosie[,c(76:80)]) 
                outliers_Child_Parasocial <- colSums(abs(standardized_Child_Parasocial)>=3, na.rm = T) 
                outliers_Child_Parasocial
                # Child_Parasocial_1 Child_Parasocial_2 Child_Parasocial_3 Child_Parasocial_4 Child_Parasocial_5 
                # 0                  0                  0                  5                  0 
                
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
                      head(outlier_Child_Parasocial_4_df) # >> outliers lay in observations 8, 74, 79, 253, 271
                        
          
          #Step 1: correlations
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,76:80]), 2) 
          #                    Child_Parasocial_1 Child_Parasocial_2 Child_Parasocial_3 Child_Parasocial_4 Child_Parasocial_5
          # Child_Parasocial_1               1.00               0.30               0.56               0.67               0.70
          # Child_Parasocial_2               0.30               1.00               0.34               0.27               0.29
          # Child_Parasocial_3               0.56               0.34               1.00               0.53               0.57
          # Child_Parasocial_4               0.67               0.27               0.53               1.00               0.80
          # Child_Parasocial_5               0.70               0.29               0.57               0.80               1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,76:80]), 2)
          #                    Child_Parasocial_1 Child_Parasocial_2 Child_Parasocial_3 Child_Parasocial_4 Child_Parasocial_5
          # Child_Parasocial_1               1.41               0.43               0.79               0.83               0.89
          # Child_Parasocial_2               0.43               1.42               0.48               0.33               0.36
          # Child_Parasocial_3               0.79               0.48               1.39               0.65               0.72
          # Child_Parasocial_4               0.83               0.33               0.65               1.07               0.89
          # Child_Parasocial_5               0.89               0.36               0.72               0.89               1.16
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1c  <- ' f  =~ Child_Parasocial_1 + Child_Parasocial_2 + Child_Parasocial_3 + Child_Parasocial_4 + Child_Parasocial_5'
          onefac5items_Child_Parasocial <- cfa(m1c, data=rosie, std.lv=TRUE) 
          summary(onefac5items_Child_Parasocial, fit.measures=TRUE, standardized=TRUE) 
          # >> fit index criteria: Chi-Square = .001 NOT > .05, CFI = .980 > 0.95, TLI = .960 > 0.90 and RMSEA = .098 < 0.10 #REASONS FOR LIGHT CONCERN
          
          modindices(onefac5items_Child_Parasocial, sort=T) #Child_Parasocial_4 ~~ Child_Parasocial_5 14.360
          
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
                    # Loadings:
                    #   MR1    MR2   
                    # Child_Parasocial_1  0.538       
                    # Child_Parasocial_2         0.502  #Items 2 and 3 seem to load together as well as items 1, 4, and 5 which is in accordance with the modindices above
                    # Child_Parasocial_3         0.737
                    # Child_Parasocial_4  0.923       
                    # Child_Parasocial_5  0.888       
                    # 
                    # MR1   MR2
                    # SS loadings    1.937 0.888
                    # Proportion Var 0.387 0.178
                    # Cumulative Var 0.387 0.565
                   

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
                        # >> fit index criteria: Chi-Square = .048 STILL NOT BUT CLOSE > .05, CFI = .992 > 0.95, TLI = .981 > 0.90 and RMSEA = .068 < 0.10 #IMPROVEMENT
                    
                    
        #Developmental: NONE
        
          
        #Social: 
          
          ### PMMS >> 6 items #########################
          
          #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                #visually
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
                standardized_PMMS <- scale(rosie[,c(65:70)]) 
                outliers_PMMS <- colSums(abs(standardized_PMMS)>=3, na.rm = T) 
                outliers_PMMS
                # PMMS_1 PMMS_2 PMMS_3 PMMS_4 PMMS_5 PMMS_6 
                # 0      0      0     10      0      0
          
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
                      #View(outlier_PMMS_4_df)
                      head(outlier_PMMS_4_df) # >> outliers lay in observations 12, 32, 37, 99, 127, 170, 240, 247, 290, 296
                
          #Step 1: correlations
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,65:70]), 2) 
          #        PMMS_1 PMMS_2 PMMS_3 PMMS_4 PMMS_5 PMMS_6  # quite a bunch of low correlations...
          # PMMS_1   1.00   0.60   0.45   0.19   0.31   0.23
          # PMMS_2   0.60   1.00   0.43   0.20   0.36   0.30
          # PMMS_3   0.45   0.43   1.00   0.20   0.59   0.24
          # PMMS_4   0.19   0.20   0.20   1.00   0.27   0.60
          # PMMS_5   0.31   0.36   0.59   0.27   1.00   0.28
          # PMMS_6   0.23   0.30   0.24   0.60   0.28   1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,65:70]), 2) 
          #        PMMS_1 PMMS_2 PMMS_3 PMMS_4 PMMS_5 PMMS_6
          # PMMS_1   0.64   0.45   0.32   0.11   0.25   0.15
          # PMMS_2   0.45   0.88   0.36   0.14   0.34   0.23
          # PMMS_3   0.32   0.36   0.77   0.13   0.52   0.17
          # PMMS_4   0.11   0.14   0.13   0.54   0.20   0.36
          # PMMS_5   0.25   0.34   0.52   0.20   1.02   0.23
          # PMMS_6   0.15   0.23   0.17   0.36   0.23   0.68
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1d  <- ' f  =~ PMMS_1 + PMMS_2 + PMMS_3 + PMMS_4 + PMMS_5 + PMMS_6'
          onefac6items_PMMS <- cfa(m1d, data=rosie, std.lv=TRUE) 
          summary(onefac6items_PMMS, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .00 NOT > .05, CFI = .703 NOT > 0.95, TLI = .505 NOT > 0.90 and RMSEA = .238 < 0.10 
          #>> This bad fit could be an indicator for the actual three factor scale corresponding to the original scale structure
          
          #Step 4: three-factor CFA
          #two items per factor, default marker method
          m2d <- ' restrMed  =~ PMMS_1 + PMMS_2 
              negacMed =~ PMMS_3 + PMMS_5 
              posacMed   =~ PMMS_4 + PMMS_6'
          threefac2items_PMMS <- cfa(m2d, data=rosie, std.lv=TRUE) 
          summary(threefac2items_PMMS, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .066 > .05, CFI = .989 > 0.95, TLI = .972 > 0.90 and RMSEA = .056 < 0.10 >> VERY NICE
          
        
          
      #TAM: 
        
          ### TAM_PEoU >> 4 items #########################
          
          #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                #visually
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
                standardized_TAM_PEoU <- scale(rosie[,c(85:88)]) 
                outliers_TAM_PEoU <- colSums(abs(standardized_TAM_PEoU)>=3, na.rm = T) 
                outliers_TAM_PEoU
                # TAM_PEoU_1 TAM_PEoU_2 TAM_PEoU_3 TAM_PEoU_4 
                # 0          0          5          0
                      
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
                      head(outlier_TAM_PEoU_3_df) # >> outliers lay in observations 32, 70, 105, 201, 205
          
      
          #Step 1: correlations
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,85:88]), 2) 
          #            TAM_PEoU_1 TAM_PEoU_2 TAM_PEoU_3 TAM_PEoU_4
          # TAM_PEoU_1       1.00       0.60       0.77       0.73
          # TAM_PEoU_2       0.60       1.00       0.60       0.59
          # TAM_PEoU_3       0.77       0.60       1.00       0.76
          # TAM_PEoU_4       0.73       0.59       0.76       1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,85:88]), 2) 
          #            TAM_PEoU_1 TAM_PEoU_2 TAM_PEoU_3 TAM_PEoU_4
          # TAM_PEoU_1       1.96       1.29       1.52       1.49
          # TAM_PEoU_2       1.29       2.40       1.32       1.33
          # TAM_PEoU_3       1.52       1.32       2.00       1.56
          # TAM_PEoU_4       1.49       1.33       1.56       2.10
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1e  <- ' TAM_PEoU_f  =~ TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4'
          onefac4items_TAM_PEoU <- cfa(m1e, data=rosie, std.lv=TRUE) 
          summary(onefac4items_TAM_PEoU, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .867 > .05, CFI = 1 > 0.95, TLI = 1.007 > 0.90 and RMSEA  = 0 < 0.10 >> VERY NICE
          
          
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
                # >> fairly normally distributed
                
                #numerically 
                #standardize a variable and count the number of cases with values greater or less than 3
                standardized_TAM_PU <- scale(rosie[,c(89:92)]) 
                outliers_TAM_PU <- colSums(abs(standardized_TAM_PU)>=3, na.rm = T) 
                outliers_TAM_PU
                #TAM_PU_1 TAM_PU_2 TAM_PU_3 TAM_PU_4 
                #0        0        0        0 

                
          #Step 1: correlations
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,89:92]), 2) 
          #          TAM_PU_1 TAM_PU_2 TAM_PU_3 TAM_PU_4
          # TAM_PU_1     1.00     0.73     0.79     0.71
          # TAM_PU_2     0.73     1.00     0.77     0.61
          # TAM_PU_3     0.79     0.77     1.00     0.69
          # TAM_PU_4     0.71     0.61     0.69     1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,89:92]), 2) 
          #          TAM_PU_1 TAM_PU_2 TAM_PU_3 TAM_PU_4
          # TAM_PU_1     2.31     1.70     1.92     1.53
          # TAM_PU_2     1.70     2.36     1.89     1.32
          # TAM_PU_3     1.92     1.89     2.58     1.56
          # TAM_PU_4     1.53     1.32     1.56     2.01
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1f  <- ' TAM_PU_f  =~ TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4'
          onefac4items_TAM_PU <- cfa(m1f, data=rosie, std.lv=TRUE) 
          summary(onefac4items_TAM_PU, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .014 > .05, CFI = .992 > 0.95, TLI = .976 > 0.90 and RMSEA = .104 < 0.10 >> SLIGHTLY CONCERNING
          
          modindices(onefac4items_TAM_PU, sort=T) # TAM_PU_2 ~~ TAM_PU_3 8.080  & TAM_PU_1 ~~ TAM_PU_4 8.080
          
          #to check whether there is actually a different underlying factor structure in this scale, we run an EFA
          
          library(psych)
          library(GPArotation)
          
          #creating a subset with the variables relevant for this EFA
          TAM_PU <- c("TAM_PU_1", "TAM_PU_2", "TAM_PU_3", "TAM_PU_4")
          TAM_PU
          TAM_PU_EFA_df <- rosie[TAM_PU]
          # View(TAM_PU_EFA_df)
          
          #parallel analysis to get number of factors
          parallel1 <- fa.parallel(TAM_PU_EFA_df, fm = 'minres', fa = 'fa') #suggests indeed 1 factor 
          
          
          
          ### TAM_E >> 4 items #########################
          
          #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                #visually
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
                standardized_TAM_E <- scale(rosie[,c(93:96)]) 
                outliers_TAM_E <- colSums(abs(standardized_TAM_E)>=3, na.rm = T) 
                outliers_TAM_E
                # TAM_E_1 TAM_E_2 TAM_E_3 TAM_E_4 
                # 0       8       8       0 
                
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
                      head(outlier_TAM_E_2_df) # >> outliers lay in observations 70, 90, 105, 159, 164, 201, 211, 283
                      #View(outlier_TAM_E_2_df)
                      
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
                      head(outlier_TAM_E_3_df) # >> outliers lay in observations 14, 37, 90, 105, 159, 164, 211, 283
                      #View(outlier_TAM_E_3_df)
          
  
          #Step 1: correlations
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,93:96]),2) 
          #         TAM_E_1 TAM_E_2 TAM_E_3 TAM_E_4
          # TAM_E_1    1.00    0.86    0.82    0.64
          # TAM_E_2    0.86    1.00    0.78    0.59
          # TAM_E_3    0.82    0.78    1.00    0.62
          # TAM_E_4    0.64    0.59    0.62    1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,93:96]),2)
          #         TAM_E_1 TAM_E_2 TAM_E_3 TAM_E_4
          # TAM_E_1    1.94    1.63    1.53    1.39
          # TAM_E_2    1.63    1.86    1.42    1.27
          # TAM_E_3    1.53    1.42    1.78    1.30
          # TAM_E_4    1.39    1.27    1.30    2.45
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1g  <- ' TAM_E_f  =~ TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4'
          onefac4items_TAM_E <- cfa(m1g, data=rosie,std.lv=TRUE) 
          summary(onefac4items_TAM_E, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .163 > .05, CFI = .998 > 0.95, TLI = .995 > 0.90 and RMSEA = .052  < 0.10 >> VERY NICE
          
          
          ### TAM_SI >> 3 items #########################
          
          #checking for univariate outliers (+/- 3 SDs from the mean) for each of the three variables showing the reading assessments 
                #visually
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
                standardized_TAM_SI <- scale(rosie[,c(98:100)]) 
                outliers_TAM_SI <- colSums(abs(standardized_TAM_SI)>=3, na.rm = T) 
                outliers_TAM_SI
                #TAM_SI_1 TAM_SI_2 TAM_SI_3 
                #0        0        0 
              
          #Step 1: correlations
          #The function cor specifies the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,98:100]),2) 
          #          TAM_SI_1 TAM_SI_2 TAM_SI_3
          # TAM_SI_1     1.00     0.76     0.64
          # TAM_SI_2     0.76     1.00     0.55
          # TAM_SI_3     0.64     0.55     1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,98:100]),2) 
          #          TAM_SI_1 TAM_SI_2 TAM_SI_3
          # TAM_SI_1     2.52     1.97     1.86
          # TAM_SI_2     1.97     2.68     1.65
          # TAM_SI_3     1.86     1.65     3.34
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1h  <- ' TAM_SI_f  =~ TAM_SI_1 + TAM_SI_2 + TAM_SI_3 '
          onefac3items_TAM_SI <- cfa(m1h, data=rosie) 
          summary(onefac3items_TAM_SI, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = 0 NOT > .05, CFI = 1 > 0.95, TLI = 1 > 0.90 and RMSEA = 0 < 0.10 >> Good except for Chi-Square      
          
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
          
          
              

####---- 2) Extracting factors scores----####

                
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
                #View(rosie_fscores)
                names(rosie_fscores)
                
                #removing unnecessary added variables from descriptives (for outliers)
                rosie_fscores <- rosie_fscores[,-c(126:134)]
                View(rosie_fscores)
                
        

####---- 3) Reliability analysis----####

                
        #https://rpubs.com/hauselin/reliabilityanalysis
        #raw_alpha: Cronbach’s α (values ≥ .7 or .8 indicate good reliability; Kline (1999))
          
          #Dispositional: 
          
          #TT >> 3 items
          TT <- rosie[, c(110:112)]
          psych::alpha(TT) ### --> 0.78
          
          #IL >> 5 items
          IL <- rosie[, c(105:109)]
          psych::alpha(IL) ### --> 0.87
          
          #Child_Parasocial >> 5 items
          Child_Parasocial <- rosie[, c(76:80)]
          psych::alpha(Child_Parasocial) ### --> 0.83
                
          #Developmental: NONE
          
          #Social: 
          
          #PMMS >> 6 items 
          PMMS <- rosie[, c(65:70)]
          psych::alpha(PMMS) ### --> 0.76
          
          
          #TAM: 
          
          #TAM_PEoU >> 4
          TAM_PEoU <- rosie[, c(85:88)]
          psych::alpha(TAM_PEoU) ### --> 0.89
          
          #TAM_PU >> 4
          TAM_PU <- rosie[, c(89:92)]
          psych::alpha(TAM_PU) ### --> 0.91
          
          #TAM_E >> 4
          TAM_E <- rosie[, c(93:96)]
          psych::alpha(TAM_E) ### --> 0.91
          
          #TAM_SI >> 3
          TAM_SI <- rosie[, c(98:100)]
          psych::alpha(TAM_SI) ### --> 0.84


###----------------------------------------------------------------------------------------------------------------###  
                
#---------------------------------------------------------------------------------#
### MORE DESCRIPTIVES ON DATASET INCLUDING FACTOR SCORES ##########################
#---------------------------------------------------------------------------------#
                
   #taking a numerical look
            
   library(psych)
   describe(rosie_fscores)
                
   library(psych)
   options(max.print=100000)
   psych::describeBy(rosie_fscores, group = "GSL")
   # 1 = male, 2 = female
   
   #get percentages of social classes
   source("http://pcwww.liv.ac.uk/~william/R/crosstab.r")
   crosstab(rosie_fscores, row.vars = "SOCIALEKLASSE2016", type = "row.pct")
   # SOCIALEKLASSE2016      %
   # 1  41.64
   # 2  31.80
   # 3  19.02
   # 4   4.92
   # 5   2.62
   # Sum 100.00
   
   #checking household numbers
   crosstab(rosie_fscores, row.vars = "PERSONEN", type = "row.pct")
   # PERSONEN      %
   # 1   3.61        # >> This is concerning, there should not be a household with only 1 person
   # 2   6.89
   # 3  20.66
   # 4  50.49
   # 5  14.75
   # 6   3.61
   # Sum 100.00
 
         #assign all 1s in the variable PERSONEN to the 2s because there cannot be a 1-person household for a parent+young child (mistake by survey company/participants)
         rosie_fscores$PERSONEN[rosie_fscores$PERSONEN == 1] <- 2
         #check if this worked
         crosstab(rosie_fscores, row.vars = "PERSONEN", type = "f")
         # PERSONEN Count
         # 2    32
         # 3    63
         # 4   154
         # 5    45
         # 6    11
         # Sum   305
         crosstab(rosie_fscores, row.vars = "PERSONEN", type = "row.pct")
         # PERSONEN      %
         # 2  10.49
         # 3  20.66
         # 4  50.49
         # 5  14.75
         # 6   3.61
         # Sum 100.00
         
   crosstab(rosie_fscores, row.vars = "Child_Nr", type = "row.pct")
   # Child_Nr      %
   # 2  68.85
   # 3  29.18
   # 4   1.64
   # 5   0.33
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
   
  
   names(rosie_fscores)
   
   #getting correlations matrix for TAM-variables
   require(Hmisc)
   x <- as.matrix(rosie_fscores[,c(134:136, 97, 137, 101:103)])
   correlation_matrix<-rcorr(x, type="pearson")
   R <- correlation_matrix$r 
   R
 
   #            TAM_PEoU_f TAM_PU_f TAM_E_f TAM_SS TAM_SI_f TAM_UI_1 TAM_UI_2 TAM_UI_3
   # TAM_PEoU_f       1.00     0.42    0.60  -0.02     0.13     0.08     0.38     0.27
   # TAM_PU_f         0.42     1.00    0.60   0.20     0.41     0.12     0.48     0.38
   # TAM_E_f          0.60     0.60    1.00   0.09     0.24     0.10     0.56     0.34
   # TAM_SS          -0.02     0.20    0.09   1.00     0.28     0.14     0.15     0.13
   # TAM_SI_f         0.13     0.41    0.24   0.28     1.00     0.20     0.19     0.19
   # TAM_UI_1         0.08     0.12    0.10   0.14     0.20     1.00     0.02    -0.01
   # TAM_UI_2         0.38     0.48    0.56   0.15     0.19     0.02     1.00     0.58
   # TAM_UI_3         0.27     0.38    0.34   0.13     0.19    -0.01     0.58     1.00
   
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
names(rosie_fscores)
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
   
   
   #removing unnecessary added variables from categorization pocedure (for outliers)
   rosie_fscores <- rosie_fscores[,-c(145, 147, 150, 161, 164, 171, 174, 177)]
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
   #ALERT: iterations finished, MAXIMUM LIKELIHOOD NOT FOUND 
   
   set.seed(123)
   LCAmodel8 <- poLCA(LCAmodel, data=rosie_fscores, nclass=8, maxiter = 1000, nrep = 10, graphs=FALSE, na.rm=TRUE) 
   #>> model still converges, but class distributions get so small that it does not make sense to continue
  
   
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
             # 2       -4310.10       246 8957.69 8770.57 9016.69          5130.80      2
             # 3       -4249.65       216 9008.40 8726.13 9097.40          5009.90      3
             # 4       -4201.28       186 9083.28 8705.87 9202.28          4913.18      4
             # 5       -4167.42       156 9187.18 8714.62 9336.18          4845.46      5
             # 6       -4131.98       126 9287.90 8720.20 9466.90          4774.57      6
             
             
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
               
               # >> 4-class model has lowest aBIC (which is preferred for categorical variables and small sample sizes).
               
               
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
                     
                     
                     
  #We proceed by extracting the LCA solutions for the 4-class model 
           
    #extract 4-class solution and save in fourclass object (https://osf.io/vec6s/)
       library(poLCA)
       set.seed(123)
       fourclass=poLCA(LCAmodel, data=rosie_fscores, nclass=4, maxiter = 1000, nrep = 10, graphs=TRUE, na.rm=TRUE)
       
       #output predicted classes from selected model so that we can use it in subsequent analyses:
       rosie_fscores$fam_class4=fourclass$predclass
       
       #View(rosie_fscores)
       
       rosie_fscores$fam_class4 <- as.factor(rosie_fscores$fam_class4)
       
    
           
  #We now recode the created fam_class variables for each model into dummy coded variables, since we need them for the SEM
       
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
      
       library(psych)
       psych::describeBy(rosie_fscores, group = "fam_class4")
          
  
   #---------------------------------------------------------#
   ### differences between families ##########################
   #---------------------------------------------------------#             
  
  #MANOVA 
       rosie_fscores$PGender_num <- as.numeric(rosie_fscores$PGender_f)
       rosie_fscores$SES_num <- as.numeric(rosie_fscores$SES_f)
       
       Y <- cbind(rosie_fscores$PGender_num,rosie_fscores$SES_num,rosie_fscores$TT_avgsum, rosie_fscores$IL_information_avgsum, rosie_fscores$IL_navigation_avgsum, rosie_fscores$FoPersU, rosie_fscores$CGender_num, rosie_fscores$Child_Temp_Extraversion, rosie_fscores$Child_Temp_Negative_Affectivity, 
                  rosie_fscores$Child_Temp_Effortful_Control, rosie_fscores$Child_Parasocial_anthropomorphism_avgsum, rosie_fscores$Child_Parasocial_pararela_avgsum, rosie_fscores$LFT, rosie_fscores$Child_Age, rosie_fscores$PMMS_restrMed_avgsum, 
                  rosie_fscores$PMMS_negacMed_avgsum, rosie_fscores$PMMS_posacMed_avgsum, rosie_fscores$current_usage, rosie_fscores$Child_Nr, rosie_fscores$PERSONEN, rosie_fscores$SHL)
       Y <- as.matrix(Y)
       fit <- manova(Y ~ rosie_fscores$fam_class4)
       summary(fit, test="Pillai")
       summary.aov(fit)
       
       # >> All significant except for: Child Gender (response 7), Child Temperament Extraversion (response 8),  Child Parasocial Attachment (response 11 + 12),
       #    and Child Number (response 19).
       
  #We now run separate analyses of variances for all indicators using their original scale to see which of the family types significantly differ between each other.
             
             # Compute the analysis of variance
             rosie_fscores$PGender_num <- as.numeric(rosie_fscores$PGender_f)
             anova_PGender <- aov(PGender_num ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_PGender) # significant
             # Alternative non-parametric test
             kruskal.test(PGender_num ~ fam_class4, data = rosie_fscores) # significant
             
                   #Where are the differences? 
                   TukeyHSD(anova_PGender)
                   # $fam_class4
                   #            diff        lwr          upr     p adj
                   # 2-1 -0.49473684 -0.6841863 -0.305287434 0.0000000
                   # 3-1 -0.65048544 -0.8371555 -0.463815388 0.0000000
                   # 4-1 -0.70000000 -0.9190989 -0.480901125 0.0000000
                   # 3-2 -0.15574859 -0.3165993  0.005102073 0.0616929 !
                   # 4-2 -0.20526316 -0.4028272 -0.007699124 0.0382493
                   # 4-3 -0.04951456 -0.2444150  0.145385864 0.9132693 !
                   
                   library("ggplot2")
                   ggplot(rosie_fscores, aes(x=factor(fam_class4), y=PGender_num)) + 
                     geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
                     geom_point(stat="summary", fun.y="mean") + 
                     geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
                     labs(x="Family Types", y="Parent Gender (mean + 95%CI)") +
                     theme_bw() +
                     theme(axis.text.x=element_text(angle=45, hjust=1)) 
                   
                   # >> There are significant differences except between classes 3 and 2 and between 3 and 4.
             
             
                   
             # Compute the analysis of variance
             rosie_fscores$SES_num <- as.numeric(rosie_fscores$SES_f)
             anova_SES <- aov(SES_num ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_SES) #significant
             # Alternative non-parametric test
             kruskal.test(SES_num ~ fam_class4, data = rosie_fscores) #significant
             
                   #Where are the differences? 
                   TukeyHSD(anova_SES)
                   # $fam_class4
                   #            diff        lwr         upr     p adj
                   # 2-1 -0.44912281 -0.8655586 -0.03268706 0.0288367
                   # 3-1 -0.97666496 -1.3869913 -0.56633863 0.0000000
                   # 4-1 -0.43122807 -0.9128374  0.05038127 0.0972900 !
                   # 3-2 -0.52754216 -0.8811140 -0.17397036 0.0008134
                   # 4-2  0.01789474 -0.4163781  0.45216754 0.9995675 !
                   # 4-3  0.54543689  0.1170191  0.97385473 0.0061557
                   
                   ggplot(rosie_fscores, aes(x=factor(fam_class4), y=SES_num)) + 
                     geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
                     geom_point(stat="summary", fun.y="mean") + 
                     geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
                     labs(x="Family Types", y="SES (mean + 95%CI)") +
                     theme_bw() +
                     theme(axis.text.x=element_text(angle=45, hjust=1)) 
                   
                   # >> Significant differences between all classes except between classes 1 and 4 and between 2 and 4.
                   
             
                   
             # Compute the analysis of variance
             anova_TT <- aov(TT_avgsum ~ fam_class4, data = rosie_fscores)
             # Summary of the analysis
             summary(anova_TT) #significant
             # Alternative non-parametric test
             kruskal.test(TT_avgsum ~ fam_class4, data = rosie_fscores) #significant
             
                   #Where are the differences? 
                   TukeyHSD(anova_TT)
                   # $fam_class4
                   #           diff         lwr        upr     p adj
                   # 2-1  0.1532164 -0.35352534  0.6599581 0.8629898 !
                   # 3-1  0.5343780  0.03507057  1.0336855 0.0306163
                   # 4-1 -0.1309942 -0.71704265  0.4550543 0.9387849 !
                   # 3-2  0.3811616 -0.04908380  0.8114071 0.1029306 !
                   # 4-2 -0.2842105 -0.81265735  0.2442363 0.5069447 !
                   # 4-3 -0.6653722 -1.18669434 -0.1440500 0.0059903
                   
                   ggplot(rosie_fscores, aes(x=factor(fam_class4), y=TT_avgsum)) + 
                     geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
                     geom_point(stat="summary", fun.y="mean") + 
                     geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
                     labs(x="Family Types", y="Technology Trust (mean + 95%CI)") +
                     theme_bw() +
                     theme(axis.text.x=element_text(angle=45, hjust=1)) 
                   
                   # >> Significant differences only between classes 1 and 3 and between 3 and 4.
             
                   
                   
             # Compute the analysis of variance
             anova_IL_info <- aov(IL_information_avgsum ~ fam_class4, data = rosie_fscores)
             # Summary of the analysis
             summary(anova_IL_info) #significant
             # Alternative non-parametric test
             kruskal.test(IL_information_avgsum ~ fam_class4, data = rosie_fscores) #significant
                   
                   #Where are the differences? 
                   TukeyHSD(anova_IL_info)
                   # $fam_class4
                   #           diff        lwr        upr     p adj
                   # 2-1  1.0421053  0.5848014  1.4994092 0.0000001
                   # 3-1 -0.8886050 -1.3391999 -0.4380101 0.0000037
                   # 4-1 -0.2057895 -0.7346630  0.3230840 0.7464687 !
                   # 3-2 -1.9307103 -2.3189809 -1.5424397 0.0000000
                   # 4-2 -1.2478947 -1.7247862 -0.7710033 0.0000000
                   # 4-3  0.6828155  0.2123536  1.1532774 0.0012110
                   
                   ggplot(rosie_fscores, aes(x=factor(fam_class4), y=IL_information_avgsum)) + 
                     geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
                     geom_point(stat="summary", fun.y="mean") + 
                     geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
                     labs(x="Family Types", y="Information Internet Literacy (mean + 95%CI)") +
                     theme_bw() +
                     theme(axis.text.x=element_text(angle=45, hjust=1))
                   
                   # >> Significant differences between all classes except between class 1 and 4.
             
                   
                   
             # Compute the analysis of variance
             anova_IL_nav <- aov(IL_navigation_avgsum ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_IL_nav) #significant
             # Alternative non-parametric test
             kruskal.test(IL_navigation_avgsum ~ fam_class4, data = rosie_fscores) #significant
             
                   #Where are the differences? 
                   TukeyHSD(anova_IL_nav)
                   # $fam_class4
                   #           diff        lwr        upr     p adj
                   # 2-1  1.2959064  0.8615343  1.7302785 0.0000000
                   # 3-1 -0.6718333 -1.0998329 -0.2438338 0.0003703
                   # 4-1  0.3029240 -0.1994288  0.8052768 0.4044372 !
                   # 3-2 -1.9677397 -2.3365403 -1.5989392 0.0000000
                   # 4-2 -0.9929825 -1.4459599 -0.5400050 0.0000002
                   # 4-3  0.9747573  0.5278870  1.4216276 0.0000002
                   
                   ggplot(rosie_fscores, aes(x=factor(fam_class4), y=IL_navigation_avgsum)) + 
                     geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
                     geom_point(stat="summary", fun.y="mean") + 
                     geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
                     labs(x="Family Types", y="Navigation Internet Literacy (mean + 95%CI)") +
                     theme_bw() +
                     theme(axis.text.x=element_text(angle=45, hjust=1)) 
                   
                   # >> Significant differences between all classes except between class 1 and 4.
               
                   
             # Compute the analysis of variance
             anova_FoPersU <- aov(FoPersU ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_FoPersU) #significant
             # Alternative non-parametric test
             kruskal.test(FoPersU ~ fam_class4, data = rosie_fscores) #significant
             
                   #Where are the differences? 
                   TukeyHSD(anova_FoPersU)
                   # $fam_class4
                   #           diff         lwr       upr     p adj
                   # 2-1  0.2432749 -0.29896620 0.7855159 0.6531387 !
                   # 3-1  0.1096349 -0.42465106 0.6439209 0.9517132 !
                   # 4-1  0.7976608  0.17055722 1.4247644 0.0062175
                   # 3-2 -0.1336399 -0.59402582 0.3267460 0.8766581 !
                   # 4-2  0.5543860 -0.01108073 1.1198527 0.0569795 !
                   # 4-3  0.6880259  0.13018296 1.2458688 0.0086116
                       
                   ggplot(rosie_fscores, aes(x=factor(fam_class4), y=FoPersU)) + 
                     geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
                     geom_point(stat="summary", fun.y="mean") + 
                     geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
                     labs(x="Family Types", y="Frequency of Personal Use (mean + 95%CI)") +
                     theme_bw() +
                     theme(axis.text.x=element_text(angle=45, hjust=1))
                   
                   # >> Significant differences only between classes 1 and 4 and 3 and 4.
                   
                   
                   
             # # Compute the analysis of variance
             # rosie_fscores$CGender_num <- as.numeric(rosie_fscores$CGender_f)
             # anova_CGender <- aov(CGender_num ~ fam_class4, data = rosie_fscores) 
             # # Summary of the analysis
             # summary(anova_CGender) # not significant
             # # Alternative non-parametric test
             # kruskal.test(CGender_num ~ fam_class4, data = rosie_fscores) #not significant
             # 
             # ggplot(rosie_fscores, aes(x=factor(fam_class4), y=CGender_num)) + 
             #   geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
             #   geom_point(stat="summary", fun.y="mean") + 
             #   geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
             #   labs(x="Family Types", y="Child Gender (mean + 95%CI)") +
             #   theme_bw() +
             #   theme(axis.text.x=element_text(angle=45, hjust=1)) 
             # 
             # # >> No significant differences between classes.
             
             
             
             # # Compute the analysis of variance
             # anova_CTE <- aov(Child_Temp_Extraversion ~ fam_class4, data = rosie_fscores) 
             # # Summary of the analysis
             # summary(anova_CTE) # not significant
             # # Alternative non-parametric test
             # kruskal.test(Child_Temp_Extraversion ~ fam_class4, data = rosie_fscores) #not significant
             # 
             # ggplot(rosie_fscores, aes(x=factor(fam_class4), y=Child_Temp_Extraversion)) + 
             #   geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
             #   geom_point(stat="summary", fun.y="mean") + 
             #   geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
             #   labs(x="Family Types", y="Child Temperament Extraversion (mean + 95%CI)") +
             #   theme_bw() +
             #   theme(axis.text.x=element_text(angle=45, hjust=1))
             # 
             # # >> No significant differences between classes.
             
             
             
             # Compute the analysis of variance
             anova_CTNA <- aov(Child_Temp_Negative_Affectivity ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_CTNA) # significant
             # Alternative non-parametric test
             kruskal.test(Child_Temp_Negative_Affectivity ~ fam_class4, data = rosie_fscores) # not significant
             
                   #Where are the differences? 
                   TukeyHSD(anova_CTNA)
                   # $fam_class4
                   # diff         lwr        upr     p adj
                   # 2-1  0.1087719 -0.61342113 0.83096499 0.9799633 !
                   # 3-1 -0.4166241 -1.12822205 0.29497388 0.4312234 !
                   # 4-1  0.3392982 -0.49592044 1.17451694 0.7204073 !
                   # 3-2 -0.5253960 -1.13856888 0.08777685 0.1218580 !
                   # 4-2  0.2305263 -0.52260021 0.98365284 0.8586197 !
                   # 4-3  0.7559223  0.01294965 1.49889501 0.0444125
                   
                   ggplot(rosie_fscores, aes(x=factor(fam_class4), y=Child_Temp_Negative_Affectivity)) + 
                     geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
                     geom_point(stat="summary", fun.y="mean") + 
                     geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
                     labs(x="Family Types", y="Child Temperament Negative Affectivity (mean + 95%CI)") +
                     theme_bw() +
                     theme(axis.text.x=element_text(angle=45, hjust=1))
                   
                   # >> Only significant difference between class 3 and 4.
                   
             
                   
             # Compute the analysis of variance
             anova_CTEC <- aov(Child_Temp_Effortful_Control ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_CTEC) # significant
             # Alternative non-parametric test
             kruskal.test(Child_Temp_Effortful_Control ~ fam_class4, data = rosie_fscores) #significant
             
                   #Where are the differences? 
                   TukeyHSD(anova_CTEC)
                   # $fam_class4
                   #           diff        lwr         upr     p adj
                   # 2-1 -0.7824561 -1.4650183 -0.09989401 0.0173185
                   # 3-1 -0.5660024 -1.2385508  0.10654607 0.1328218 !
                   # 4-1 -0.2856140 -1.0749994  0.50377136 0.7861980 !
                   # 3-2  0.2164538 -0.3630708  0.79597827 0.7694837 !
                   # 4-2  0.4968421 -0.2149560  1.20864021 0.2737865 !
                   # 4-3  0.2803883 -0.4218131  0.98258981 0.7310585 !
                   
                   ggplot(rosie_fscores, aes(x=factor(fam_class4), y=Child_Temp_Effortful_Control)) + 
                     geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
                     geom_point(stat="summary", fun.y="mean") + 
                     geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
                     labs(x="Family Types", y="Child Temperament Effortful Control (mean + 95%CI)") +
                     theme_bw() +
                     theme(axis.text.x=element_text(angle=45, hjust=1)) 
                   
                   # >> Only significant difference between class 1 and 2. 
                   
             
                   
             # # Compute the analysis of variance
             # anova_PA_Anthro <- aov(Child_Parasocial_anthropomorphism_avgsum ~ fam_class4, data = rosie_fscores) 
             # # Summary of the analysis
             # summary(anova_PA_Anthro) # not significant
             # # Alternative non-parametric test
             # kruskal.test(Child_Parasocial_anthropomorphism_avgsum ~ fam_class4, data = rosie_fscores) # not significant
             #       
             # ggplot(rosie_fscores, aes(x=factor(fam_class4), y=Child_Parasocial_anthropomorphism_avgsum)) + 
             #   geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
             #   geom_point(stat="summary", fun.y="mean") + 
             #   geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
             #   labs(x="Family Types", y="Child Anthropomorphism (mean + 95%CI)") +
             #   theme_bw() +
             #   theme(axis.text.x=element_text(angle=45, hjust=1))
             # 
             # # >> No significant differences between classes.
                   
                   
             
             # # Compute the analysis of variance
             # anova_PA_ParaRela <- aov(Child_Parasocial_pararela_avgsum ~ fam_class4, data = rosie_fscores) 
             # # Summary of the analysis
             # summary(anova_PA_ParaRela) # significant
             # # Alternative non-parametric test
             # kruskal.test(Child_Parasocial_pararela_avgsum ~ fam_class4, data = rosie_fscores) #significant
             # 
             # ggplot(rosie_fscores, aes(x=factor(fam_class4), y=Child_Parasocial_pararela_avgsum)) + 
             #   geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
             #   geom_point(stat="summary", fun.y="mean") + 
             #   geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
             #   labs(x="Family Types", y="Child Parasocial Relationship (mean + 95%CI)") +
             #   theme_bw() +
             #   theme(axis.text.x=element_text(angle=45, hjust=1)) 
             # 
             # # >> No significant differences between classes.
    
                   
             # Compute the analysis of variance
             anova_PAge <- aov(LFT ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_PAge) #significant
             # Alternative non-parametric test
             kruskal.test(LFT ~ fam_class4, data = rosie_fscores) #significant
                   
                   #Where are the differences? 
                   TukeyHSD(anova_PAge)
                   # $fam_class4
                   # diff        lwr        upr     p adj
                   # 2-1  7.8982456  5.0585522 10.7379391 0.0000000
                   # 3-1  4.8981434  2.1001103  7.6961765 0.0000519
                   # 4-1  8.6319298  5.3478148 11.9160448 0.0000000
                   # 3-2 -3.0001022 -5.4111237 -0.5890807 0.0078586
                   # 4-2  0.7336842 -2.2276409  3.6950093 0.9189363 !
                   # 4-3  3.7337864  0.8123866  6.6551862 0.0059002
                   
                   ggplot(rosie_fscores, aes(x=factor(fam_class4), y=LFT)) + 
                     geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
                     geom_point(stat="summary", fun.y="mean") + 
                     geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
                     labs(x="Family Types", y="Parent Age (mean + 95%CI)") +
                     theme_bw() +
                     theme(axis.text.x=element_text(angle=45, hjust=1))
                   
                   # >> Significant differences between all classes except between classes 2 and 4.
                   
                   
                   
             # Compute the analysis of variance
             anova_CAge <- aov(Child_Age ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_CAge) #significant
             # Alternative non-parametric test
             kruskal.test(Child_Age ~ fam_class4, data = rosie_fscores) #significant
             
                   #Where are the differences? 
                   TukeyHSD(anova_CAge)
                   # $fam_class4
                   #           diff        lwr       upr     p adj
                   # 2-1  0.9473684  0.2003941 1.6943428 0.0064174
                   # 3-1  0.8390393  0.1030237 1.5750550 0.0181925
                   # 4-1  1.2326316  0.3687533 2.0965099 0.0015320
                   # 3-2 -0.1083291 -0.7425423 0.5258842 0.9712430 !
                   # 4-2  0.2852632 -0.4937061 1.0642324 0.7799762 !
                   # 4-3  0.3935922 -0.3748748 1.1620592 0.5488679 !
                   
                   ggplot(rosie_fscores, aes(x=factor(fam_class4), y=Child_Age)) + 
                     geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
                     geom_point(stat="summary", fun.y="mean") + 
                     geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
                     labs(x="Family Types", y="Child Age (mean + 95%CI)") +
                     theme_bw() +
                     theme(axis.text.x=element_text(angle=45, hjust=1))
                   
                   # >> Significant differences between classes 1 and 2, between 1 and 3, and between 1 and 4.
             
             
             
                   
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
                   # 2-1 -0.24035088 -0.5503059 0.06960415 0.1890274 !
                   # 3-1 -0.21188895 -0.5172967 0.09351882 0.2789952 !
                   # 4-1  0.62859649  0.2701325 0.98706052 0.0000501
                   # 3-2  0.02846193 -0.2347032 0.29162704 0.9923741 !
                   # 4-2  0.86894737  0.5457161 1.19217860 0.0000000
                   # 4-3  0.84048544  0.5216121 1.15935879 0.0000000
                   
                   ggplot(rosie_fscores, aes(x=factor(fam_class4), y=PMMS_restrMed_avgsum)) + 
                     geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
                     geom_point(stat="summary", fun.y="mean") + 
                     geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
                     labs(x="Family Types", y="Restrictive Mediation (mean + 95%CI)") +
                     theme_bw() +
                     theme(axis.text.x=element_text(angle=45, hjust=1)) 
                   
                   # >> Significant differences between classes 1 and 4, between 2 and 4, and between 3 and 4.
                   
           
                   
                   
             # Compute the analysis of variance
             anova_PMMSnegac <- aov(PMMS_negacMed_avgsum ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_PMMSnegac) #significant
             # Alternative non-parametric test
             kruskal.test(PMMS_negacMed_avgsum ~ fam_class4, data = rosie_fscores) #significant
                   
                   #Where are the differences? 
                   TukeyHSD(anova_PMMSnegac) 
                   # $fam_class4
                   # diff        lwr         upr     p adj
                   # 2-1 -0.1982456 -0.5222961  0.12580486 0.3913172 !
                   # 3-1 -0.3674842 -0.6867807 -0.04818783 0.0167157
                   # 4-1  0.7728070  0.3980416  1.14757247 0.0000012
                   # 3-2 -0.1692386 -0.4443714  0.10589411 0.3863633 !
                   # 4-2  0.9710526  0.6331222  1.30898305 0.0000000
                   # 4-3  1.1402913  0.8069169  1.47366562 0.0000000
                   
                   ggplot(rosie_fscores, aes(x=factor(fam_class4), y=PMMS_negacMed_avgsum)) + 
                     geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
                     geom_point(stat="summary", fun.y="mean") + 
                     geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
                     labs(x="Family Types", y="Negative Active Mediation (mean + 95%CI)") +
                     theme_bw() +
                     theme(axis.text.x=element_text(angle=45, hjust=1))
                   
                   # >> Significant differences between all classes except between classes 1 and 2, and classes 2 and 3.
                   
              
                   
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
                   # 2-1 -0.3596491 -0.63431805 -0.0849802 0.0044935
                   # 3-1 -0.4644013 -0.73504063 -0.1937620 0.0000767
                   # 4-1  0.3466667  0.02901113  0.6643222 0.0262481
                   # 3-2 -0.1047522 -0.33795786  0.1284535 0.6522690 !
                   # 4-2  0.7063158  0.41988206  0.9927495 0.0000000
                   # 4-3  0.8110680  0.52849600  1.0936399 0.0000000
                   
                   ggplot(rosie_fscores, aes(x=factor(fam_class4), y=PMMS_posacMed_avgsum)) + 
                     geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
                     geom_point(stat="summary", fun.y="mean") + 
                     geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
                     labs(x="Family Types", y="Positive Active Mediation (mean + 95%CI)") +
                     theme_bw() +
                     theme(axis.text.x=element_text(angle=45, hjust=1))
                   
                   # >> Significant differences between all classes except between class 2 and 3. 
              
                   
                   
             # Compute the analysis of variance
             anova_currentU <- aov(current_usage ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_currentU) #significant
             # Alternative non-parametric test
             kruskal.test(current_usage ~ fam_class4, data = rosie_fscores) #significant
                   
                   #Where are the differences? 
                   TukeyHSD(anova_currentU)  
                   # $fam_class4
                   # diff         lwr        upr     p adj
                   # 2-1  0.03157895 -0.12075605 0.18391395 0.9503215 !
                   # 3-1 -0.05569750 -0.20579763 0.09440264 0.7730029 !
                   # 4-1  0.11789474 -0.05828120 0.29407067 0.3105317 !
                   # 3-2 -0.08727644 -0.21661539 0.04206250 0.3031797 !
                   # 4-2  0.08631579 -0.07254412 0.24517570 0.4979964 !
                   # 4-3  0.17359223  0.01687411 0.33031036 0.0232481
                   
                   
                   ggplot(rosie_fscores, aes(x=factor(fam_class4), y=current_usage)) + 
                     geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
                     geom_point(stat="summary", fun.y="mean") + 
                     geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
                     labs(x="Family Types", y="Current Usage (mean + 95%CI)") +
                     theme_bw() +
                     theme(axis.text.x=element_text(angle=45, hjust=1))
                   
                   # >> Significant difference only between classes 3 and 4.
                
                   
                   
             # # Compute the analysis of variance
             # anova_CNumber <- aov(Child_Nr ~ fam_class4, data = rosie_fscores) 
             # # Summary of the analysis
             # summary(anova_CNumber) #not significant
             # # Alternative non-parametric test
             # kruskal.test(Child_Nr ~ fam_class4, data = rosie_fscores) #not significant
             # 
             # ggplot(rosie_fscores, aes(x=factor(fam_class4), y=Child_Nr)) + 
             #   geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
             #   geom_point(stat="summary", fun.y="mean") + 
             #   geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
             #   labs(x="Family Types", y="Number of Children (mean + 95%CI)") +
             #   theme_bw() +
             #   theme(axis.text.x=element_text(angle=45, hjust=1)) 
             # 
             # # >> No significant differences between classes.
             
             
             
             # Compute the analysis of variance
             anova_HS <- aov(PERSONEN ~ fam_class4, data = rosie_fscores) 
             # Summary of the analysis
             summary(anova_HS) #significant
             # Alternative non-parametric test
             kruskal.test(PERSONEN ~ fam_class4, data = rosie_fscores) #significant
                   
                   #Where are the differences? 
                   TukeyHSD(anova_HS) 
                   # $fam_class4
                   # diff        lwr        upr     p adj
                   # 2-1  0.6070175  0.2385085  0.9755265 0.0001631
                   # 3-1  0.7615398  0.3984371  1.1246425 0.0000007
                   # 4-1 -0.2835088 -0.7096907  0.1426731 0.3157871 !
                   # 3-2  0.1545222 -0.1583577  0.4674022 0.5790136 !
                   # 4-2 -0.8905263 -1.2748195 -0.5062331 0.0000000
                   # 4-3 -1.0450485 -1.4241606 -0.6659365 0.0000000
                   
                   
                   ggplot(rosie_fscores, aes(x=factor(fam_class4), y=PERSONEN)) + 
                     geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
                     geom_point(stat="summary", fun.y="mean") + 
                     geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
                     labs(x="Family Types", y="Household Size (mean + 95%CI)") +
                     theme_bw() +
                     theme(axis.text.x=element_text(angle=45, hjust=1))
                   
                   # >> Significant differences between all classes except between classes 1 and 4, and 2 and 3.
                   
                   
                   
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
                   # 2-1 0.5684211 -0.3583865 1.4952286 0.3890358 !
                   # 3-1 0.7460399 -0.1671707 1.6592504 0.1520677 !
                   # 4-1 1.2852632  0.2134072 2.3571191 0.0114064
                   # 3-2 0.1776188 -0.6092805 0.9645181 0.9371133 !
                   # 4-2 0.7168421 -0.2496630 1.6833473 0.2234310 !
                   # 4-3 0.5392233 -0.4142512 1.4926978 0.4624575 !
                   
                   ggplot(rosie_fscores, aes(x=factor(fam_class4), y=SHL)) + 
                     geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
                     geom_point(stat="summary", fun.y="mean") + 
                     geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
                     labs(x="Family Types", y="Smart-Household-Level (mean + 95%CI)") +
                     theme_bw() +
                     theme(axis.text.x=element_text(angle=45, hjust=1))
                   
                   # >> Significant difference only between classes 1 and 4.
       
                   
                    
       # >> All significant except for: Child Gender,  Child Temperament Extraversio,  Child Parasocial Attachment,
       #    and Child Number, which corresponds with MANOVA result.
                   
                   
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

       #check multivariate normality
       library(QuantPsyc)
       #for rosie dataset including extracted factor scores of SEM variables
       mult.norm(rosie_fscores[c(85:103)])$mult.test #all TAM core variables + family dummies
       # Beta-hat      kappa p-val
       # Skewness  65.84992 3347.37088     0
       # Kurtosis 492.25785   28.82729     0
       
       # >> Since both p-values are less than .05, we reject the null hypothesis of the test. 
       #    Thus, we have evidence to say that the SEM-variables in our dataset do not follow a multivariate distribution.
       #    Together with the non-normality detected earlier, we will run our SEM analyses using bottstrapping.
       
       
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
       rosiesTAM_measurement_fit <- cfa(rosiesTAM_measurement, data = rosie_fscores) 
       
       #print summary
       summary(rosiesTAM_measurement_fit, standardized = T, fit.measures = T)
       
            ### --> Chi-Square statistic = 314.457, p = 0.00, CFI = .938, RMSEA = .087, SRMR = .079
       
       #visualize measurement model
       #install.packages("semPlot")
       library(semPlot)
       semPaths(rosiesTAM_measurement_fit)
       
       
       
       #since TAM_PEoU_2 and TAM_E_4 explain less than .70 of the variance in the latent variable, they are removed and model fit is inspected again
       rosiesTAM_measurement_2<- '

      #measurement model
        PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_3 + TAM_PEoU_4
        PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
        E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 
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
       rosiesTAM_measurement_2_fit <- cfa(rosiesTAM_measurement_2, data = rosie_fscores) 
       
       #print summary
       summary(rosiesTAM_measurement_2_fit, standardized = T, fit.measures = T)
       
             ### --> Chi-Square statistic = 233.701, p = 0.00, CFI = .947, RMSEA = .089, SRMR = .072
             # No significant difference in the model fit, Chi-square goes down though... 
       
       
       #check modindices, but in order to get the output we need to drop the observed variable TAM_SS, because it prevents the code from running
       
             rosiesTAM_measurement_adjusted<- '
      
            #measurement model
              PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
              PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
              E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
              SI =~ 1*TAM_SI_1 + TAM_SI_2 + TAM_SI_3
            #residual variances
              PEoU ~~ PEoU
              PU ~~ PU
              E ~~ E
              SI ~~ SI
              PEoU ~~ PU
              PEoU ~~ E
              PEoU ~~ SI
              PU ~~ E
              PU ~~ SI
              E ~~ SI
            '
             
             #fit the model
             rosiesTAM_measurement_adjusted_fit <- cfa(rosiesTAM_measurement_adjusted, data = rosie_fscores) 
             
             #print summary
             summary(rosiesTAM_measurement_adjusted_fit, standardized = T, fit.measures = T) #model fit is rarely improved
                  
                  ### --> Chi-Square statistic = 299.727, p = 0.00, CFI = .938, RMSEA = .092, SRMR = .083
             
             #now check modindices
             modindices(rosiesTAM_measurement_adjusted_fit, sort = TRUE) 
             
                  ### --> seems like adding covariance between TAM_SI_1 and TAM_SI_2 could be a meaningful addition CHECK OUT FOR JOURNAL SUBMISSION
             
             
                   rosiesTAM_measurement_2_try<- '
      
                    #measurement model
                      PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_3 + TAM_PEoU_4
                      PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
                      E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 
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
                      TAM_SI_1 ~~ TAM_SI_2
                      PEoU ~~ PU
                      PEoU ~~ E
                      PEoU ~~ SI
                      PU ~~ E
                      PU ~~ SI
                      E ~~ SI
                    '
                   
                   #fit the model
                   rosiesTAM_measurement_2_try_fit <- cfa(rosiesTAM_measurement_2_try, data = rosie_fscores) 
                   
                   #print summary
                   summary(rosiesTAM_measurement_2_try_fit, standardized = T, fit.measures = T)
                   
                   # lavaan 0.6-8 ended normally after 53 iterations
                   # 
                   # Estimator                                         ML
                   # Optimization method                           NLMINB
                   # Number of model parameters                        38
                   # 
                   # Number of observations                           305
                   # 
                   # Model Test User Model:
                   #   
                   #   Test statistic                               160.179
                   # Degrees of freedom                                67
                   # P-value (Chi-square)                           0.000
                   # 
                   # Model Test Baseline Model:
                   #   
                   #   Test statistic                              3210.065
                   # Degrees of freedom                                91
                   # P-value                                        0.000
                   # 
                   # User Model versus Baseline Model:
                   #   
                   #   Comparative Fit Index (CFI)                    0.970
                   # Tucker-Lewis Index (TLI)                       0.959
                   # 
                   # Loglikelihood and Information Criteria:
                   #   
                   #   Loglikelihood user model (H0)              -6322.716
                   # Loglikelihood unrestricted model (H1)      -6242.626
                   # 
                   # Akaike (AIC)                               12721.432
                   # Bayesian (BIC)                             12862.804
                   # Sample-size adjusted Bayesian (BIC)        12742.286
                   # 
                   # Root Mean Square Error of Approximation:
                   #   
                   #   RMSEA                                          0.068
                   # 90 Percent confidence interval - lower         0.054
                   # 90 Percent confidence interval - upper         0.081
                   # P-value RMSEA <= 0.05                          0.017
                   # 
                   # Standardized Root Mean Square Residual:
                   #   
                   #   SRMR                                           0.042
                   # 
                   # Parameter Estimates:
                   #   
                   #   Standard errors                             Standard
                   # Information                                 Expected
                   # Information saturated (h1) model          Structured
                   # 
                   # Latent Variables:
                   #   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
                   # PEoU =~                                                               
                   #   TAM_PEoU_1        1.000                               1.204    0.861
                   # TAM_PEoU_3        1.050    0.053   19.814    0.000    1.264    0.895
                   # TAM_PEoU_4        1.018    0.055   18.456    0.000    1.227    0.848
                   # PU =~                                                                 
                   #   TAM_PU_1          1.000                               1.339    0.882
                   # TAM_PU_2          0.938    0.050   18.632    0.000    1.257    0.820
                   # TAM_PU_3          1.077    0.049   22.109    0.000    1.442    0.900
                   # TAM_PU_4          0.830    0.048   17.295    0.000    1.112    0.785
                   # E =~                                                                  
                   #   TAM_E_1           1.000                               1.304    0.939
                   # TAM_E_2           0.961    0.035   27.740    0.000    1.253    0.919
                   # TAM_E_3           0.880    0.038   23.413    0.000    1.147    0.860
                   # SI =~                                                                 
                   #   TAM_SI_1          1.000                               1.014    0.640
                   # TAM_SI_2          0.888    0.061   14.523    0.000    0.900    0.551
                   # TAM_SI_3          1.802    0.197    9.153    0.000    1.827    1.001
                   # 
                   # Covariances:
                   #   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
                   # PEoU ~~                                                               
                   #   TAM_SS           -0.046    0.142   -0.326    0.744   -0.038   -0.020
                   # PU ~~                                                                 
                   #   TAM_SS            0.541    0.160    3.378    0.001    0.404    0.207
                   # E ~~                                                                  
                   #   TAM_SS            0.235    0.151    1.556    0.120    0.180    0.092
                   # SI ~~                                                                 
                   #   TAM_SS            0.511    0.130    3.936    0.000    0.503    0.258
                   # .TAM_SI_1 ~~                                                           
                   #   .TAM_SI_2          1.046    0.137    7.659    0.000    1.046    0.629
                   # PEoU ~~                                                               
                   #   PU                0.760    0.115    6.622    0.000    0.471    0.471
                   # E                 1.054    0.121    8.729    0.000    0.672    0.672
                   # SI                0.317    0.084    3.777    0.000    0.259    0.259
                   # PU ~~                                                                 
                   #   E                 1.124    0.131    8.610    0.000    0.644    0.644
                   # SI                0.855    0.135    6.325    0.000    0.630    0.630
                   # E ~~                                                                  
                   #   SI                0.514    0.101    5.091    0.000    0.389    0.389
                   # 
                   # Variances:
                   #                Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
                   # TAM_SS            3.820    0.309   12.349    0.000    3.820    1.000
                   # PEoU              1.450    0.159    9.131    0.000    1.000    1.000
                   # PU                1.793    0.187    9.610    0.000    1.000    1.000
                   # E                 1.700    0.158   10.747    0.000    1.000    1.000
                   # SI                1.029    0.186    5.533    0.000    1.000    1.000
                   # .TAM_PEoU_1        0.506    0.059    8.565    0.000    0.506    0.259
                   # .TAM_PEoU_3        0.399    0.056    7.118    0.000    0.399    0.200
                   # .TAM_PEoU_4        0.590    0.065    9.015    0.000    0.590    0.282
                   # .TAM_PU_1          0.512    0.058    8.785    0.000    0.512    0.222
                   # .TAM_PU_2          0.771    0.075   10.306    0.000    0.771    0.328
                   # .TAM_PU_3          0.489    0.061    8.042    0.000    0.489    0.190
                   # .TAM_PU_4          0.768    0.071   10.755    0.000    0.768    0.383
                   # .TAM_E_1           0.230    0.036    6.401    0.000    0.230    0.119
                   # .TAM_E_2           0.288    0.037    7.772    0.000    0.288    0.155
                   # .TAM_E_3           0.463    0.046   10.139    0.000    0.463    0.260
                   # .TAM_SI_1          1.483    0.148    9.988    0.000    1.483    0.590
                   # .TAM_SI_2          1.864    0.166   11.241    0.000    1.864    0.697
                   # .TAM_SI_3         -0.009    0.283   -0.033    0.974   -0.009   -0.003
                   
                   
                   ### --> Estimation did not run properly due to negative variances! 
                   ### --> This step should not be trusted, hence measurement model should rather not be changed.

      
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
      
            ### --> Chi-Square statistic = 834.594, p = 0.00, CFI = .793, RMSEA = .135, SRMR = .191
      
      #check model improvements
      modindices(rosiesTAM_3DVs_fam_class4_1_fit, sort = TRUE)
      
      
      ### Change I ##########################
      # --> adding regression path E  ~ PEoU to the model, since it is theoretically most logical that the if the PEoU is high that E is then also high
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
      
            ### >> Already better model fit, Chi-Square statistic does not go down, other indices improve, but model is still not acceptable
      
      #check model improvements
      modindices(rosiesTAM_3DVs_fam_class4_1_changeI_fit, sort = TRUE)
      
      
      ### Change II ##########################
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
      
            ### >> Further improvement, Chi-Square goes down, but model is still not acceptable.
      
      #check model improvements
      modindices(rosiesTAM_3DVs_fam_class4_1_changeII_fit, sort = TRUE)
      
      
      ### Change III ##########################
      #adding covariance between TAM_UI_2 ~~ TAM_UI_3, since we already saw that child-only and co-use go hand-in-hand
      rosiesTAM_3DVs_fam_class4_1_changeIII <- '

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
      
            ### >> Model fit improved, Chi-Square goes further down a bit, but still not good enough!
      
      #check model improvements
      modindices(rosiesTAM_3DVs_fam_class4_1_changeIII_fit, sort = TRUE)
  
      
      ### Change IV ##########################
      #next change: adding regression path between PU  ~  SI, since it can be assumed that a higher SI can lead to a higher perceived PU.
      rosiesTAM_3DVs_fam_class4_1_changeIV <- '

      #measurement model
        PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
        PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
        E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
        SI =~ 1*TAM_SI_1 + TAM_SI_2 + TAM_SI_3
      #regressions
        PEoU ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num
        PU ~ fam_class4_2_num + fam_class4_3_num + fam_class4_4_num + PEoU + E + SI
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
      rosiesTAM_3DVs_fam_class4_1_changeIV_fit <- lavaan(rosiesTAM_3DVs_fam_class4_1_changeIV, data = rosie_fscores) 
      
      #print summary
      summary(rosiesTAM_3DVs_fam_class4_1_changeIV_fit, standardized = T, fit.measures = T)
      
            ### >> Model fit improved, Chi-Square statistic goes down a bit more, but model is still not good enough!
      
      #check model improvements
      modindices(rosiesTAM_3DVs_fam_class4_1_changeIV_fit, sort = TRUE)
      
      
      ### Change V ##########################
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
      
            ### >> Model fit improved, Chi-Square goes further down, but model is still not good enough.
      
      #check model improvements
      modindices(rosiesTAM_3DVs_fam_class4_1_changeV_fit, sort = TRUE)
      
      
      ### Change VI ##########################
      #next change: adding covariance between TAM_SI_1 ~~ TAM_SI_2, since those items both relate to the perceived social influence, while item 3 refers to active social influence (advising others to get a VA)
      rosiesTAM_3DVs_fam_class4_1_changeVI <- '

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
        fam_class4_2_num ~~ fam_class4_2_num
        fam_class4_3_num ~~ fam_class4_3_num
        fam_class4_4_num ~~ fam_class4_4_num
      '
      
      #fit the model
      rosiesTAM_3DVs_fam_class4_1_changeVI_fit <- lavaan(rosiesTAM_3DVs_fam_class4_1_changeVI, data = rosie_fscores) 
      
      #print summary
      summary(rosiesTAM_3DVs_fam_class4_1_changeVI_fit, standardized = T, fit.measures = T)
      
            ### >> Model fit improved, Chi-Square goes further down, but model is still not good enough.
      
      #check model improvements
      modindices(rosiesTAM_3DVs_fam_class4_1_changeVI_fit, sort = TRUE)
      #nothing else makes sense to add...
      
      
      #bootstrap model
      rosiesTAM_3DVs_fam_class4_1_changeVI_fit_boostrapped_se <- sem(rosiesTAM_3DVs_fam_class4_1_changeVI_fit, data = rosie_fscores,se = "bootstrap", bootstrap = 1000)
      summary(rosiesTAM_3DVs_fam_class4_1_changeVI_fit_boostrapped_se, fit.measures = TRUE)
      parameterEstimates(rosiesTAM_3DVs_fam_class4_1_changeVI_fit_boostrapped_se,
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
      # 2              PEoU =~       TAM_PEoU_2  0.868 0.066 13.069  0.000    0.742    1.002
      # 3              PEoU =~       TAM_PEoU_3  1.045 0.058 17.993  0.000    0.931    1.159
      # 4              PEoU =~       TAM_PEoU_4  1.018 0.062 16.430  0.000    0.895    1.138
      # 5                PU =~         TAM_PU_1  1.000 0.000     NA     NA    1.000    1.000
      # 6                PU =~         TAM_PU_2  0.938 0.047 20.039  0.000    0.845    1.029
      # 7                PU =~         TAM_PU_3  1.076 0.043 25.042  0.000    0.992    1.161
      # 8                PU =~         TAM_PU_4  0.829 0.052 15.943  0.000    0.729    0.933
      # 9                 E =~          TAM_E_1  1.000 0.000     NA     NA    1.000    1.000
      # 10                E =~          TAM_E_2  0.961 0.037 25.857  0.000    0.888    1.033
      # 11                E =~          TAM_E_3  0.891 0.042 21.321  0.000    0.807    0.971
      # 12                E =~          TAM_E_4  0.823 0.052 15.816  0.000    0.723    0.927
      # 13               SI =~         TAM_SI_1  1.000 0.000     NA     NA    1.000    1.000
      # 14               SI =~         TAM_SI_2  0.890 0.068 13.082  0.000    0.755    1.022
      # 15               SI =~         TAM_SI_3  1.689 0.223  7.561  0.000    1.225    2.101
      # 16             PEoU  ~ fam_class4_2_num -0.218 0.199 -1.094  0.274   -0.606    0.175
      # 17             PEoU  ~ fam_class4_3_num -0.166 0.218 -0.762  0.446   -0.594    0.261
      # 18             PEoU  ~ fam_class4_4_num -0.007 0.242 -0.029  0.977   -0.493    0.455
      # 19               PU  ~ fam_class4_2_num  0.196 0.179  1.095  0.274   -0.153    0.550
      # 20               PU  ~ fam_class4_3_num  0.051 0.173  0.297  0.766   -0.284    0.394
      # 21               PU  ~ fam_class4_4_num  0.059 0.275  0.215  0.829   -0.487    0.591
      # 22               PU  ~             PEoU  0.066 0.083  0.796  0.426   -0.096    0.230
      # 23               PU  ~                E  0.636 0.085  7.441  0.000    0.470    0.805 ***
      # 24                E  ~ fam_class4_2_num  0.396 0.214  1.851  0.064   -0.019    0.820
      # 25                E  ~ fam_class4_3_num  0.073 0.205  0.354  0.723   -0.328    0.476
      # 26                E  ~ fam_class4_4_num  0.760 0.228  3.331  0.001    0.328    1.222 ***
      # 27                E  ~             PEoU  0.706 0.090  7.876  0.000    0.528    0.880 ***
      # 28           TAM_SS  ~ fam_class4_2_num  0.032 0.297  0.108  0.914   -0.547    0.618
      # 29           TAM_SS  ~ fam_class4_3_num  0.142 0.314  0.453  0.651   -0.477    0.754
      # 30           TAM_SS  ~ fam_class4_4_num  0.841 0.401  2.096  0.036    0.061    1.633 ***
      # 31           TAM_SS  ~               SI  0.482 0.117  4.110  0.000    0.248    0.708 ***
      # 32               SI  ~ fam_class4_2_num -0.050 0.153 -0.326  0.745   -0.343    0.257
      # 33               SI  ~ fam_class4_3_num -0.281 0.158 -1.779  0.075   -0.590    0.030
      # 34               SI  ~ fam_class4_4_num  0.056 0.185  0.305  0.760   -0.298    0.426
      # 35               SI  ~               PU  0.493 0.064  7.747  0.000    0.368    0.617 ***
      # 36         TAM_UI_1  ~             PEoU  0.062 0.117  0.530  0.596   -0.171    0.288
      # 37         TAM_UI_1  ~               PU  0.005 0.171  0.029  0.977   -0.323    0.347
      # 38         TAM_UI_1  ~                E  0.031 0.156  0.198  0.843   -0.274    0.337
      # 39         TAM_UI_1  ~           TAM_SS  0.106 0.057  1.852  0.064   -0.007    0.218
      # 40         TAM_UI_1  ~               SI  0.173 0.175  0.989  0.323   -0.181    0.507
      # 41         TAM_UI_2  ~             PEoU  0.015 0.091  0.162  0.871   -0.161    0.197
      # 42         TAM_UI_2  ~               PU  0.212 0.109  1.946  0.052   -0.004    0.422
      # 43         TAM_UI_2  ~                E  0.482 0.110  4.401  0.000    0.263    0.693 ***
      # 44         TAM_UI_2  ~           TAM_SS  0.048 0.043  1.136  0.256   -0.036    0.131
      # 45         TAM_UI_2  ~               SI -0.031 0.110 -0.285  0.776   -0.240    0.190
      # 46         TAM_UI_3  ~             PEoU  0.113 0.121  0.937  0.349   -0.120    0.354
      # 47         TAM_UI_3  ~               PU  0.322 0.154  2.091  0.037    0.013    0.616 ***
      # 48         TAM_UI_3  ~                E  0.191 0.147  1.301  0.193   -0.094    0.481
      # 49         TAM_UI_3  ~           TAM_SS  0.062 0.055  1.126  0.260   -0.045    0.170
      # 50         TAM_UI_3  ~               SI  0.056 0.144  0.392  0.695   -0.218    0.347
      # 51       TAM_PEoU_1 ~~       TAM_PEoU_1  0.498 0.083  6.022  0.000    0.343    0.667
      # 52       TAM_PEoU_2 ~~       TAM_PEoU_2  1.295 0.193  6.697  0.000    0.909    1.667
      # 53       TAM_PEoU_3 ~~       TAM_PEoU_3  0.402 0.081  4.939  0.000    0.245    0.564
      # 54       TAM_PEoU_4 ~~       TAM_PEoU_4  0.582 0.079  7.402  0.000    0.434    0.743
      # 55         TAM_PU_1 ~~         TAM_PU_1  0.509 0.072  7.037  0.000    0.372    0.656
      # 56         TAM_PU_2 ~~         TAM_PU_2  0.769 0.099  7.764  0.000    0.584    0.973
      # 57         TAM_PU_3 ~~         TAM_PU_3  0.489 0.073  6.732  0.000    0.353    0.638
      # 58         TAM_PU_4 ~~         TAM_PU_4  0.769 0.091  8.495  0.000    0.598    0.953
      # 59          TAM_E_1 ~~          TAM_E_1  0.244 0.060  4.065  0.000    0.127    0.363
      # 60          TAM_E_2 ~~          TAM_E_2  0.301 0.104  2.908  0.004    0.102    0.508
      # 61          TAM_E_3 ~~          TAM_E_3  0.440 0.066  6.646  0.000    0.314    0.573
      # 62          TAM_E_4 ~~          TAM_E_4  1.297 0.157  8.266  0.000    0.998    1.613
      # 63         TAM_SI_1 ~~         TAM_SI_1  1.416 0.176  8.058  0.000    1.085    1.774
      # 64         TAM_SI_2 ~~         TAM_SI_2  1.808 0.188  9.620  0.000    1.459    2.195
      # 65         TAM_SI_3 ~~         TAM_SI_3  0.202 0.282  0.716  0.474   -0.327    0.780
      # 66         TAM_SI_1 ~~         TAM_SI_2  0.984 0.168  5.859  0.000    0.668    1.327
      # 67         TAM_UI_1 ~~         TAM_UI_1  3.179 0.192 16.542  0.000    2.887    3.640
      # 68         TAM_UI_2 ~~         TAM_UI_2  1.242 0.164  7.553  0.000    0.959    1.603
      # 69         TAM_UI_3 ~~         TAM_UI_3  2.790 0.221 12.631  0.000    2.413    3.279
      # 70         TAM_UI_2 ~~         TAM_UI_3  0.880 0.164  5.374  0.000    0.584    1.226
      # 71           TAM_SS ~~           TAM_SS  3.449 0.321 10.751  0.000    2.877    4.135
      # 72             PEoU ~~             PEoU  1.450 0.188  7.734  0.000    1.097    1.832
      # 73               PU ~~               PU  1.010 0.156  6.457  0.000    0.720    1.333
      # 74                E ~~                E  0.884 0.130  6.780  0.000    0.645    1.156
      # 75               SI ~~               SI  0.624 0.116  5.357  0.000    0.403    0.859
      # 76 fam_class4_2_num ~~ fam_class4_2_num  0.214 0.010 20.593  0.000    0.195    0.236
      # 77 fam_class4_3_num ~~ fam_class4_3_num  0.224 0.009 25.950  0.000    0.208    0.241
      # 78 fam_class4_4_num ~~ fam_class4_4_num  0.137 0.015  9.451  0.000    0.109    0.166
      
      
    
  ### Influence of family type ##########################  
  #To answer RQ2 (a, b, c, d, e) we run the SEM again with swapped our reference levels for the family types 
      
      #type 2 as reference level 
      rosiesTAM_fam_class4_2 <- '

      #measurement model
        PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
        PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
        E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
        SI =~ 1*TAM_SI_1 + TAM_SI_2 + TAM_SI_3
      #regressions
        PEoU ~ fam_class4_1_num + fam_class4_3_num + fam_class4_4_num
        PU ~ fam_class4_1_num + fam_class4_3_num + fam_class4_4_num + PEoU + E
        E ~ fam_class4_1_num + fam_class4_3_num + fam_class4_4_num + PEoU
        TAM_SS ~ fam_class4_1_num + fam_class4_3_num + fam_class4_4_num + SI
        SI ~ fam_class4_1_num + fam_class4_3_num + fam_class4_4_num + PU
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
        fam_class4_1_num ~~ fam_class4_1_num
        fam_class4_3_num ~~ fam_class4_3_num
        fam_class4_4_num ~~ fam_class4_4_num
      '
      
      #fit the model
      rosiesTAM_fam_class4_2_fit <- lavaan(rosiesTAM_fam_class4_2, data = rosie_fscores) 
      
      #print summary
      summary(rosiesTAM_fam_class4_2_fit, standardized = T, fit.measures = T)
      
      
      #bootstrap model
      rosiesTAM_fam_class4_2_fit_boostrapped_se <- sem(rosiesTAM_fam_class4_2, data = rosie_fscores,se = "bootstrap", bootstrap = 1000)
      summary(rosiesTAM_fam_class4_2_fit_boostrapped_se, fit.measures = TRUE)
      parameterEstimates(rosiesTAM_fam_class4_2_fit_boostrapped_se,
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
      # 2              PEoU =~       TAM_PEoU_2  0.868 0.064 13.644  0.000    0.744    0.993
      # 3              PEoU =~       TAM_PEoU_3  1.045 0.059 17.572  0.000    0.927    1.160
      # 4              PEoU =~       TAM_PEoU_4  1.018 0.060 16.829  0.000    0.899    1.136
      # 5                PU =~         TAM_PU_1  1.000 0.000     NA     NA    1.000    1.000
      # 6                PU =~         TAM_PU_2  0.938 0.051 18.388  0.000    0.836    1.036
      # 7                PU =~         TAM_PU_3  1.076 0.044 24.432  0.000    0.988    1.161
      # 8                PU =~         TAM_PU_4  0.829 0.054 15.467  0.000    0.726    0.936
      # 9                 E =~          TAM_E_1  1.000 0.000     NA     NA    1.000    1.000
      # 10                E =~          TAM_E_2  0.961 0.039 24.785  0.000    0.884    1.036
      # 11                E =~          TAM_E_3  0.891 0.040 22.114  0.000    0.814    0.972
      # 12                E =~          TAM_E_4  0.823 0.054 15.303  0.000    0.720    0.931
      # 13               SI =~         TAM_SI_1  1.000 0.000     NA     NA    1.000    1.000
      # 14               SI =~         TAM_SI_2  0.890 0.068 12.990  0.000    0.755    1.023
      # 15               SI =~         TAM_SI_3  1.688 0.227  7.430  0.000    1.215    2.106
      # 16             PEoU  ~ fam_class4_1_num  0.218 0.193  1.131  0.258   -0.166    0.589
      # 17             PEoU  ~ fam_class4_3_num  0.052 0.176  0.293  0.769   -0.294    0.397
      # 18             PEoU  ~ fam_class4_4_num  0.211 0.230  0.917  0.359   -0.248    0.655
      # 19               PU  ~ fam_class4_1_num -0.196 0.170 -1.150  0.250   -0.533    0.135
      # 20               PU  ~ fam_class4_3_num -0.145 0.135 -1.072  0.284   -0.405    0.124
      # 21               PU  ~ fam_class4_4_num -0.137 0.248 -0.553  0.580   -0.611    0.360
      # 22               PU  ~             PEoU  0.066 0.088  0.749  0.454   -0.108    0.238
      # 23               PU  ~                E  0.636 0.087  7.353  0.000    0.467    0.806 ***
      # 24                E  ~ fam_class4_1_num -0.395 0.204 -1.935  0.053   -0.783    0.018
      # 25                E  ~ fam_class4_3_num -0.323 0.131 -2.464  0.014   -0.584   -0.070 ***
      # 26                E  ~ fam_class4_4_num  0.364 0.157  2.321  0.020    0.060    0.676 ***
      # 27                E  ~             PEoU  0.706 0.088  8.039  0.000    0.531    0.875 ***
      # 28           TAM_SS  ~ fam_class4_1_num -0.032 0.285 -0.112  0.911   -0.577    0.539
      # 29           TAM_SS  ~ fam_class4_3_num  0.110 0.271  0.407  0.684   -0.415    0.648
      # 30           TAM_SS  ~ fam_class4_4_num  0.809 0.363  2.231  0.026    0.101    1.522 ***
      # 31           TAM_SS  ~               SI  0.482 0.123  3.928  0.000    0.243    0.724 ***
      # 32               SI  ~ fam_class4_1_num  0.049 0.153  0.324  0.746   -0.250    0.350
      # 33               SI  ~ fam_class4_3_num -0.232 0.126 -1.835  0.066   -0.486    0.009
      # 34               SI  ~ fam_class4_4_num  0.106 0.159  0.670  0.503   -0.211    0.412
      # 35               SI  ~               PU  0.493 0.063  7.771  0.000    0.369    0.618 ***
      # 36         TAM_UI_1  ~             PEoU  0.059 0.122  0.489  0.625   -0.181    0.296
      # 37         TAM_UI_1  ~               PU  0.009 0.159  0.060  0.952   -0.298    0.324
      # 38         TAM_UI_1  ~                E  0.034 0.152  0.222  0.824   -0.256    0.339
      # 39         TAM_UI_1  ~           TAM_SS  0.106 0.058  1.836  0.066   -0.007    0.219
      # 40         TAM_UI_1  ~               SI  0.169 0.168  1.010  0.312   -0.169    0.489
      # 41         TAM_UI_2  ~             PEoU  0.015 0.094  0.161  0.872   -0.173    0.196
      # 42         TAM_UI_2  ~               PU  0.211 0.108  1.959  0.050    0.005    0.427
      # 43         TAM_UI_2  ~                E  0.482 0.111  4.344  0.000    0.264    0.700 ***
      # 44         TAM_UI_2  ~           TAM_SS  0.048 0.041  1.173  0.241   -0.032    0.129
      # 45         TAM_UI_2  ~               SI -0.030 0.105 -0.289  0.773   -0.243    0.170
      # 46         TAM_UI_3  ~             PEoU  0.114 0.122  0.930  0.352   -0.128    0.352
      # 47         TAM_UI_3  ~               PU  0.321 0.147  2.184  0.029    0.038    0.614 ***
      # 48         TAM_UI_3  ~                E  0.191 0.141  1.348  0.178   -0.090    0.465
      # 49         TAM_UI_3  ~           TAM_SS  0.062 0.054  1.146  0.252   -0.043    0.168
      # 50         TAM_UI_3  ~               SI  0.058 0.141  0.412  0.680   -0.215    0.337
      # 51       TAM_PEoU_1 ~~       TAM_PEoU_1  0.498 0.081  6.113  0.000    0.345    0.664
      # 52       TAM_PEoU_2 ~~       TAM_PEoU_2  1.295 0.184  7.042  0.000    0.939    1.660
      # 53       TAM_PEoU_3 ~~       TAM_PEoU_3  0.402 0.081  4.977  0.000    0.247    0.564
      # 54       TAM_PEoU_4 ~~       TAM_PEoU_4  0.582 0.080  7.236  0.000    0.429    0.745
      # 55         TAM_PU_1 ~~         TAM_PU_1  0.509 0.069  7.343  0.000    0.378    0.650
      # 56         TAM_PU_2 ~~         TAM_PU_2  0.768 0.102  7.493  0.000    0.574    0.975
      # 57         TAM_PU_3 ~~         TAM_PU_3  0.489 0.069  7.065  0.000    0.361    0.633
      # 58         TAM_PU_4 ~~         TAM_PU_4  0.769 0.093  8.273  0.000    0.590    0.955
      # 59          TAM_E_1 ~~          TAM_E_1  0.244 0.061  4.015  0.000    0.132    0.371
      # 60          TAM_E_2 ~~          TAM_E_2  0.301 0.098  3.061  0.002    0.115    0.500
      # 61          TAM_E_3 ~~          TAM_E_3  0.440 0.066  6.654  0.000    0.315    0.574
      # 62          TAM_E_4 ~~          TAM_E_4  1.297 0.158  8.205  0.000    0.993    1.613
      # 63         TAM_SI_1 ~~         TAM_SI_1  1.415 0.175  8.068  0.000    1.089    1.777
      # 64         TAM_SI_2 ~~         TAM_SI_2  1.807 0.185  9.746  0.000    1.467    2.194
      # 65         TAM_SI_3 ~~         TAM_SI_3  0.204 0.271  0.754  0.451   -0.302    0.758
      # 66         TAM_SI_1 ~~         TAM_SI_2  0.984 0.166  5.943  0.000    0.674    1.323
      # 67         TAM_UI_1 ~~         TAM_UI_1  3.178 0.185 17.143  0.000    2.908    3.635
      # 68         TAM_UI_2 ~~         TAM_UI_2  1.242 0.164  7.587  0.000    0.956    1.597
      # 69         TAM_UI_3 ~~         TAM_UI_3  2.790 0.220 12.673  0.000    2.426    3.289
      # 70         TAM_UI_2 ~~         TAM_UI_3  0.880 0.155  5.671  0.000    0.596    1.204
      # 71           TAM_SS ~~           TAM_SS  3.448 0.316 10.924  0.000    2.875    4.112
      # 72             PEoU ~~             PEoU  1.450 0.182  7.975  0.000    1.116    1.829
      # 73               PU ~~               PU  1.010 0.157  6.423  0.000    0.722    1.338
      # 74                E ~~                E  0.884 0.132  6.708  0.000    0.656    1.173
      # 75               SI ~~               SI  0.624 0.121  5.177  0.000    0.398    0.871
      # 76 fam_class4_1_num ~~ fam_class4_1_num  0.152 0.014 11.070  0.000    0.126    0.180
      # 77 fam_class4_3_num ~~ fam_class4_3_num  0.224 0.009 24.540  0.000    0.206    0.242
      # 78 fam_class4_4_num ~~ fam_class4_4_num  0.137 0.014  9.810  0.000    0.110    0.165
      # 79         TAM_UI_1 ~~         TAM_UI_2 -0.149 0.130 -1.146  0.252   -0.405    0.105
      # 80         TAM_UI_1 ~~         TAM_UI_3 -0.246 0.199 -1.238  0.216   -0.640    0.139
     
      
      #type 3 as reference level  
      rosiesTAM_fam_class4_3 <- '
      
      #measurement model
        PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
        PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
        E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
        SI =~ 1*TAM_SI_1 + TAM_SI_2 + TAM_SI_3
      #regressions
        PEoU ~ fam_class4_1_num + fam_class4_2_num + fam_class4_4_num
        PU ~ fam_class4_1_num + fam_class4_2_num + fam_class4_4_num + PEoU + E
        E ~ fam_class4_1_num + fam_class4_2_num + fam_class4_4_num + PEoU
        TAM_SS ~ fam_class4_1_num + fam_class4_2_num + fam_class4_4_num + SI
        SI ~ fam_class4_1_num + fam_class4_2_num + fam_class4_4_num + PU
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
        fam_class4_1_num ~~ fam_class4_1_num
        fam_class4_2_num ~~ fam_class4_2_num
        fam_class4_4_num ~~ fam_class4_4_num
      '
      
      #fit the model
      rosiesTAM_fam_class4_3_fit <- lavaan(rosiesTAM_fam_class4_3, data = rosie_fscores) 
      
      #print summary
      summary(rosiesTAM_fam_class4_3_fit, standardized = T, fit.measures = T)
      
      #bootstrap model
      rosiesTAM_fam_class4_3_fit_boostrapped_se <- sem(rosiesTAM_fam_class4_3_fit, data = rosie_fscores,se = "bootstrap", bootstrap = 1000)
      summary(rosiesTAM_fam_class4_3_fit_boostrapped_se, fit.measures = TRUE)
      parameterEstimates(rosiesTAM_fam_class4_3_fit_boostrapped_se,
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
      # 2              PEoU =~       TAM_PEoU_2  0.868 0.067 12.996  0.000    0.741    1.003
      # 3              PEoU =~       TAM_PEoU_3  1.045 0.057 18.294  0.000    0.933    1.157
      # 4              PEoU =~       TAM_PEoU_4  1.018 0.060 16.847  0.000    0.898    1.134
      # 5                PU =~         TAM_PU_1  1.000 0.000     NA     NA    1.000    1.000
      # 6                PU =~         TAM_PU_2  0.938 0.050 18.742  0.000    0.840    1.036
      # 7                PU =~         TAM_PU_3  1.076 0.043 24.947  0.000    0.989    1.158
      # 8                PU =~         TAM_PU_4  0.829 0.054 15.256  0.000    0.722    0.935
      # 9                 E =~          TAM_E_1  1.000 0.000     NA     NA    1.000    1.000
      # 10                E =~          TAM_E_2  0.961 0.036 26.562  0.000    0.890    1.032
      # 11                E =~          TAM_E_3  0.891 0.041 21.927  0.000    0.813    0.972
      # 12                E =~          TAM_E_4  0.823 0.054 15.212  0.000    0.718    0.930
      # 13               SI =~         TAM_SI_1  1.000 0.000     NA     NA    1.000    1.000
      # 14               SI =~         TAM_SI_2  0.890 0.069 12.862  0.000    0.753    1.024
      # 15               SI =~         TAM_SI_3  1.689 0.224  7.529  0.000    1.220    2.100
      # 16             PEoU  ~ fam_class4_1_num  0.166 0.201  0.826  0.409   -0.232    0.557
      # 17             PEoU  ~ fam_class4_2_num -0.052 0.180 -0.287  0.774   -0.408    0.297
      # 18             PEoU  ~ fam_class4_4_num  0.159 0.236  0.674  0.500   -0.311    0.615
      # 19               PU  ~ fam_class4_1_num -0.051 0.182 -0.283  0.777   -0.416    0.296
      # 20               PU  ~ fam_class4_2_num  0.145 0.142  1.022  0.307   -0.137    0.418
      # 21               PU  ~ fam_class4_4_num  0.008 0.260  0.030  0.976   -0.498    0.520
      # 22               PU  ~             PEoU  0.066 0.087  0.762  0.446   -0.101    0.240
      # 23               PU  ~                E  0.636 0.087  7.335  0.000    0.464    0.804 ***
      # 24                E  ~ fam_class4_1_num -0.073 0.218 -0.333  0.739   -0.490    0.366
      # 25                E  ~ fam_class4_2_num  0.323 0.133  2.423  0.015    0.073    0.595 ***
      # 26                E  ~ fam_class4_4_num  0.687 0.160  4.285  0.000    0.380    1.009 ***
      # 27                E  ~             PEoU  0.706 0.085  8.310  0.000    0.535    0.868 ***
      # 28           TAM_SS  ~ fam_class4_1_num -0.142 0.313 -0.454  0.650   -0.739    0.490
      # 29           TAM_SS  ~ fam_class4_2_num -0.110 0.271 -0.406  0.685   -0.632    0.431
      # 30           TAM_SS  ~ fam_class4_4_num  0.699 0.364  1.921  0.055    0.000    1.425
      # 31           TAM_SS  ~               SI  0.482 0.117  4.108  0.000    0.250    0.710 ***
      # 32               SI  ~ fam_class4_1_num  0.281 0.155  1.817  0.069   -0.029    0.578
      # 33               SI  ~ fam_class4_2_num  0.231 0.131  1.767  0.077   -0.033    0.480
      # 34               SI  ~ fam_class4_4_num  0.337 0.169  1.993  0.046   -0.001    0.663 ***
      # 35               SI  ~               PU  0.493 0.061  8.082  0.000    0.375    0.614 ***
      # 36         TAM_UI_1  ~             PEoU  0.062 0.124  0.502  0.616   -0.182    0.302
      # 37         TAM_UI_1  ~               PU  0.005 0.163  0.030  0.976   -0.319    0.319
      # 38         TAM_UI_1  ~                E  0.031 0.155  0.199  0.842   -0.264    0.345
      # 39         TAM_UI_1  ~           TAM_SS  0.106 0.056  1.905  0.057   -0.003    0.216
      # 40         TAM_UI_1  ~               SI  0.173 0.167  1.037  0.300   -0.153    0.503
      # 41         TAM_UI_2  ~             PEoU  0.015 0.090  0.164  0.869   -0.158    0.195
      # 42         TAM_UI_2  ~               PU  0.212 0.106  1.996  0.046    0.012    0.427
      # 43         TAM_UI_2  ~                E  0.482 0.107  4.500  0.000    0.266    0.687 ***
      # 44         TAM_UI_2  ~           TAM_SS  0.048 0.042  1.151  0.250   -0.032    0.133
      # 45         TAM_UI_2  ~               SI -0.031 0.110 -0.285  0.775   -0.248    0.182
      # 46         TAM_UI_3  ~             PEoU  0.113 0.118  0.964  0.335   -0.121    0.340
      # 47         TAM_UI_3  ~               PU  0.322 0.154  2.086  0.037    0.025    0.630 ***
      # 48         TAM_UI_3  ~                E  0.191 0.142  1.344  0.179   -0.087    0.469
      # 49         TAM_UI_3  ~           TAM_SS  0.062 0.054  1.155  0.248   -0.042    0.168
      # 50         TAM_UI_3  ~               SI  0.056 0.149  0.378  0.705   -0.233    0.352
      # 51       TAM_PEoU_1 ~~       TAM_PEoU_1  0.498 0.080  6.231  0.000    0.349    0.662
      # 52       TAM_PEoU_2 ~~       TAM_PEoU_2  1.295 0.189  6.855  0.000    0.928    1.669
      # 53       TAM_PEoU_3 ~~       TAM_PEoU_3  0.402 0.074  5.423  0.000    0.263    0.553
      # 54       TAM_PEoU_4 ~~       TAM_PEoU_4  0.582 0.080  7.325  0.000    0.437    0.748
      # 55         TAM_PU_1 ~~         TAM_PU_1  0.509 0.069  7.397  0.000    0.377    0.647
      # 56         TAM_PU_2 ~~         TAM_PU_2  0.769 0.098  7.859  0.000    0.580    0.964
      # 57         TAM_PU_3 ~~         TAM_PU_3  0.489 0.069  7.044  0.000    0.357    0.629
      # 58         TAM_PU_4 ~~         TAM_PU_4  0.769 0.097  7.915  0.000    0.586    0.967
      # 59          TAM_E_1 ~~          TAM_E_1  0.244 0.059  4.128  0.000    0.132    0.364
      # 60          TAM_E_2 ~~          TAM_E_2  0.301 0.094  3.214  0.001    0.127    0.494
      # 61          TAM_E_3 ~~          TAM_E_3  0.440 0.067  6.523  0.000    0.313    0.577
      # 62          TAM_E_4 ~~          TAM_E_4  1.297 0.159  8.184  0.000    0.996    1.617
      # 63         TAM_SI_1 ~~         TAM_SI_1  1.416 0.186  7.618  0.000    1.058    1.786
      # 64         TAM_SI_2 ~~         TAM_SI_2  1.808 0.185  9.751  0.000    1.456    2.183
      # 65         TAM_SI_3 ~~         TAM_SI_3  0.202 0.288  0.702  0.483   -0.320    0.808
      # 66         TAM_SI_1 ~~         TAM_SI_2  0.984 0.171  5.746  0.000    0.651    1.322
      # 67         TAM_UI_1 ~~         TAM_UI_1  3.179 0.198 16.046  0.000    2.873    3.650
      # 68         TAM_UI_2 ~~         TAM_UI_2  1.242 0.161  7.714  0.000    0.965    1.596
      # 69         TAM_UI_3 ~~         TAM_UI_3  2.790 0.225 12.417  0.000    2.412    3.292
      # 70         TAM_UI_2 ~~         TAM_UI_3  0.880 0.155  5.678  0.000    0.601    1.209
      # 71           TAM_SS ~~           TAM_SS  3.449 0.315 10.938  0.000    2.903    4.139
      # 72             PEoU ~~             PEoU  1.450 0.183  7.944  0.000    1.111    1.827
      # 73               PU ~~               PU  1.010 0.157  6.429  0.000    0.732    1.348
      # 74                E ~~                E  0.884 0.122  7.232  0.000    0.669    1.148
      # 75               SI ~~               SI  0.624 0.119  5.233  0.000    0.393    0.860
      # 76 fam_class4_1_num ~~ fam_class4_1_num  0.152 0.014 10.929  0.000    0.125    0.180
      # 77 fam_class4_2_num ~~ fam_class4_2_num  0.214 0.010 21.275  0.000    0.196    0.235
      # 78 fam_class4_4_num ~~ fam_class4_4_num  0.137 0.014  9.697  0.000    0.110    0.165
      # 
      
 
###----------------------------------------------------------------------------------------------------------------###

#--------------------------------------------------------------------------------#
### descriptives on TAM-constructs between family types ##########################
#--------------------------------------------------------------------------------#   
      
    #get average sum scores for each TAM-construct
      View(rosie_fscores)
      library(fame)
      rosie_fscores$PEoU_avgsum <- rowMeans(rosie_fscores[, c(85:88)], na.rm = T)
      is.numeric(rosie_fscores$PEoU_avgsum)
      rosie_fscores$PU_avgsum <- rowMeans(rosie_fscores[, c(89:92)], na.rm = T)
      is.numeric(rosie_fscores$PU_avgsum)
      rosie_fscores$E_avgsum <- rowMeans(rosie_fscores[, c(93:96)], na.rm = T)
      is.numeric(rosie_fscores$E_avgsum)
      rosie_fscores$SI_avgsum <- rowMeans(rosie_fscores[, c(98:100)], na.rm = T)
      is.numeric(rosie_fscores$SI_avgsum)
      
    #get descriptives per family type
      library(psych)
      psych::describeBy(rosie_fscores, group = "fam_class4")
      
###----------------------------------------------------------------------------------------------------------------###
          
#------------------------------------------------------#
### Final model visualization ##########################
#------------------------------------------------------#
          
### SemPaths Model Visualization ###
       
    library(semPlot)
    semPaths(rosiesTAM_3DVs_fam_class4_1_changeVI_fit, what = "col", "std", layout = "tree", rotation = 2, 
             intercepts = F, residuals = F, curve = 2, nCharNodes = 0,
             edge.label.cex = 1, edge.color = "black", sizeMan = 10, sizeMan2 = 5)
    title("Structural Equation Model")
    
    #OR using https://cran.r-project.org/web/packages/tidySEM/vignettes/Plotting_graphs.html 
    
    library(tidySEM)
    graph_sem(model = rosiesTAM_3DVs_fam_class4_1_changeVI_fit)
    
    #Those model visualizations are way too complex. We better visualize the final model by hand.
    
    
###----------------------------------------------------------------------------------------------------------------###
    
#-------------------------------------------------#
### EXPLORATORY ANALYSES ##########################
#-------------------------------------------------#  
    
    
  ### see how the family types directly relate to our DVs ##########################
    
    #MANOVA 

    Z <- cbind(rosie_fscores$TAM_UI_1,rosie_fscores$TAM_UI_2,rosie_fscores$TAM_UI_3)
    Z <- as.matrix(Z)
    fit_DVs <- manova(Z ~ rosie_fscores$fam_class4)
    summary(fit_DVs, test="Pillai")
    summary.aov(fit_DVs)
    
    # >> Families significantly differ in their co-usage and child independent use intentions.
    
    
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
        #            diff         lwr       upr     p adj
        # 2-1  0.30877193 -0.28547326 0.9030171 0.5366785
        # 3-1  0.05603815 -0.52948903 0.6415653 0.9946818
        # 4-1  0.96982456  0.28257801 1.6570711 0.0017774 ***
        # 3-2 -0.25273378 -0.75727342 0.2518059 0.5673979
        # 4-2  0.66105263  0.04135433 1.2807509 0.0314005 ***
        # 4-3  0.91378641  0.30244303 1.5251298 0.0007921 ***
        
        #Checking out mean plot
        ggplot(rosie_fscores, aes(x=factor(fam_class4), y=TAM_UI_2)) + 
          geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
          geom_point(stat="summary", fun.y="mean") + 
          geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
          labs(x="Family Types", y="Co-Usage Intention (mean + 95%CI)") +
          theme_bw() +
          theme(axis.text.x=element_text(angle=45, hjust=1))
    
        ### >> Family types 1 and 4 significantly differ in their co-usage intention, 
        ###    with class 4 (mediators) having a greater co-usage intention.
        
        
    # Compute the analysis of variance
    anova_UI_3 <- aov(TAM_UI_3 ~ fam_class4, data = rosie_fscores) 
    # Summary of the analysis
    summary(anova_UI_3) #significant
    # Alternative non-parametric test
    kruskal.test(TAM_UI_3 ~ fam_class4, data = rosie_fscores) #significant
    
          #Where are the differences? 
          TukeyHSD(anova_UI_3)
          # $fam_class4
          #           diff         lwr       upr     p adj
          # 2-1  0.7017544 -0.08250293 1.4860117 0.0976332
          # 3-1  0.2035428 -0.56920886 0.9762945 0.9044681
          # 4-1  1.1322807  0.22528448 2.0392769 0.0075954 ***
          # 3-2 -0.4982115 -1.16407963 0.1676565 0.2164685
          # 4-2  0.4305263 -0.38732285 1.2483755 0.5255319
          # 4-3  0.9287379  0.12191515 1.7355606 0.0166915 ***
          
          #Checking out mean plot
          ggplot(rosie_fscores, aes(x=factor(fam_class4), y=TAM_UI_3)) + 
            geom_jitter(colour="lightblue", alpha=0.5, width=0.1) +
            geom_point(stat="summary", fun.y="mean") + 
            geom_errorbar(stat="summary", fun.data="mean_se", fun.args = list(mult = 1.96), width=0) +
            labs(x="Family Types", y="Co-Usage Intention (mean + 95%CI)") +
            theme_bw() +
            theme(axis.text.x=element_text(angle=45, hjust=1)) 
          
          ### >> Family types 4 and 1, as well as 4 and 3 differ in their intention to let the child use the VA independently
          ###   with class 4 (mediators) having a greater child-independent use intention.
    
    
  

  ### only TAM, separately from family typology ##########################
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
    
    ### >> Model fit is acceptable (Chi-Suare = 0, CFI = .955, RMSEA = .065, SRMR = .055), Chi-Square statistic is also lower, 
    ###    so family types most likely add quite a bit of complexity.
    
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
    
    #            lhs op        rhs    est    se      z pvalue ci.lower ci.upper
    # 1        PEoU =~ TAM_PEoU_1  1.000 0.000     NA     NA    1.000    1.000
    # 2        PEoU =~ TAM_PEoU_2  0.868 0.065 13.335  0.000    0.741    0.996
    # 3        PEoU =~ TAM_PEoU_3  1.041 0.060 17.477  0.000    0.922    1.156
    # 4        PEoU =~ TAM_PEoU_4  1.017 0.061 16.695  0.000    0.895    1.134
    # 5          PU =~   TAM_PU_1  1.000 0.000     NA     NA    1.000    1.000
    # 6          PU =~   TAM_PU_2  0.938 0.050 18.815  0.000    0.839    1.034
    # 7          PU =~   TAM_PU_3  1.077 0.045 23.936  0.000    0.987    1.163
    # 8          PU =~   TAM_PU_4  0.830 0.053 15.789  0.000    0.727    0.933
    # 9           E =~    TAM_E_1  1.000 0.000     NA     NA    1.000    1.000
    # 10          E =~    TAM_E_2  0.963 0.036 26.832  0.000    0.892    1.032
    # 11          E =~    TAM_E_3  0.892 0.040 22.392  0.000    0.816    0.972
    # 12          E =~    TAM_E_4  0.823 0.055 15.002  0.000    0.717    0.932
    # 13         SI =~   TAM_SI_1  1.000 0.000     NA     NA    1.000    1.000
    # 14         SI =~   TAM_SI_2  0.888 0.072 12.415  0.000    0.746    1.026
    # 15         SI =~   TAM_SI_3  1.725 0.227  7.610  0.000    1.260    2.149
    # 16         PU  ~       PEoU  0.054 0.085  0.638  0.524   -0.108    0.226
    # 17         PU  ~          E  0.648 0.080  8.099  0.000    0.489    0.802 ***
    # 18          E  ~       PEoU  0.706 0.086  8.222  0.000    0.535    0.872 ***
    # 19     TAM_SS  ~         SI  0.508 0.124  4.082  0.000    0.263    0.751 ***
    # 20         SI  ~         PU  0.495 0.064  7.726  0.000    0.368    0.619 ***
    # 21   TAM_UI_1  ~       PEoU  0.058 0.119  0.486  0.627   -0.175    0.291
    # 22   TAM_UI_1  ~         PU  0.011 0.168  0.068  0.946   -0.323    0.335
    # 23   TAM_UI_1  ~          E  0.035 0.157  0.222  0.825   -0.265    0.351
    # 24   TAM_UI_1  ~     TAM_SS  0.107 0.058  1.846  0.065   -0.005    0.224
    # 25   TAM_UI_1  ~         SI  0.162 0.164  0.987  0.324   -0.173    0.471
    # 26   TAM_UI_2  ~       PEoU  0.023 0.087  0.260  0.795   -0.147    0.193
    # 27   TAM_UI_2  ~         PU  0.214 0.104  2.064  0.039    0.015    0.422 ***
    # 28   TAM_UI_2  ~          E  0.473 0.111  4.258  0.000    0.247    0.682 ***
    # 29   TAM_UI_2  ~     TAM_SS  0.049 0.040  1.219  0.223   -0.030    0.128
    # 30   TAM_UI_2  ~         SI -0.031 0.098 -0.315  0.753   -0.218    0.167
    # 31   TAM_UI_3  ~       PEoU  0.128 0.115  1.115  0.265   -0.099    0.352
    # 32   TAM_UI_3  ~         PU  0.327 0.147  2.224  0.026    0.043    0.620 ***
    # 33   TAM_UI_3  ~          E  0.174 0.143  1.223  0.221   -0.112    0.447
    # 34   TAM_UI_3  ~     TAM_SS  0.063 0.055  1.144  0.253   -0.044    0.171
    # 35   TAM_UI_3  ~         SI  0.055 0.140  0.392  0.695   -0.214    0.334
    # 36 TAM_PEoU_1 ~~ TAM_PEoU_1  0.493 0.083  5.914  0.000    0.334    0.661
    # 37 TAM_PEoU_2 ~~ TAM_PEoU_2  1.291 0.182  7.079  0.000    0.936    1.651
    # 38 TAM_PEoU_3 ~~ TAM_PEoU_3  0.410 0.080  5.127  0.000    0.257    0.570
    # 39 TAM_PEoU_4 ~~ TAM_PEoU_4  0.581 0.078  7.476  0.000    0.432    0.737
    # 40   TAM_PU_1 ~~   TAM_PU_1  0.511 0.072  7.101  0.000    0.373    0.655
    # 41   TAM_PU_2 ~~   TAM_PU_2  0.771 0.098  7.851  0.000    0.582    0.967
    # 42   TAM_PU_3 ~~   TAM_PU_3  0.489 0.069  7.121  0.000    0.358    0.627
    # 43   TAM_PU_4 ~~   TAM_PU_4  0.766 0.089  8.560  0.000    0.596    0.947
    # 44    TAM_E_1 ~~    TAM_E_1  0.247 0.060  4.127  0.000    0.130    0.364
    # 45    TAM_E_2 ~~    TAM_E_2  0.297 0.098  3.017  0.003    0.109    0.494
    # 46    TAM_E_3 ~~    TAM_E_3  0.441 0.066  6.711  0.000    0.312    0.569
    # 47    TAM_E_4 ~~    TAM_E_4  1.298 0.154  8.405  0.000    0.995    1.601
    # 48   TAM_SI_1 ~~   TAM_SI_1  1.438 0.174  8.265  0.000    1.115    1.797
    # 49   TAM_SI_2 ~~   TAM_SI_2  1.828 0.189  9.663  0.000    1.480    2.221
    # 50   TAM_SI_3 ~~   TAM_SI_3  0.134 0.285  0.472  0.637   -0.408    0.709
    # 51   TAM_SI_1 ~~   TAM_SI_2  1.006 0.168  5.987  0.000    0.690    1.349
    # 52   TAM_UI_1 ~~   TAM_UI_1  3.181 0.188 16.949  0.000    2.892    3.628
    # 53   TAM_UI_2 ~~   TAM_UI_2  1.245 0.160  7.765  0.000    0.970    1.599
    # 54   TAM_UI_3 ~~   TAM_UI_3  2.791 0.221 12.657  0.000    2.415    3.280
    # 55   TAM_UI_2 ~~   TAM_UI_3  0.883 0.157  5.621  0.000    0.600    1.216
    # 56     TAM_SS ~~     TAM_SS  3.543 0.323 10.957  0.000    2.925    4.193
    # 57       PEoU ~~       PEoU  1.463 0.181  8.103  0.000    1.116    1.824
    # 58         PU ~~         PU  1.011 0.153  6.607  0.000    0.727    1.327
    # 59          E ~~          E  0.953 0.133  7.182  0.000    0.705    1.225
    # 60         SI ~~         SI  0.634 0.124  5.105  0.000    0.388    0.874
    
###----------------------------------------------------------------------------------------------------------------###  
    
