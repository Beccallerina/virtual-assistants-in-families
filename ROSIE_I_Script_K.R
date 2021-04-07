
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
 #for filtering
 citation("tidyverse") #Wickham et al., (2019). Welcome to the tidyverse. Journal of Open Source Software, 4(43), 1686, https://doi.org/10.21105/joss.01686
 #for descriptives
 citation("pastecs") #Philippe Grosjean and Frederic Ibanez (2018). pastecs: Package for Analysis of Space-Time Ecological Series. R package version 1.3.21. https://CRAN.R-project.org/package=pastecs
 citation("psych") #Revelle, W. (2020) psych: Procedures for Personality and Psychological Research, Northwestern University, Evanston, Illinois, USA, https://CRAN.R-project.org/package=psych Version = 2.0.12,.
 
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
      #Q20 TAM_IMG >> 1
      #Q21 TAM_SN >> 3
      #Q22 TAM_ICU >> 3 
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
                                                           'TAM_IMG' = 'Q20',
                                                           'TAM_SN_1' = 'Q21_1',
                                                           'TAM_SN_2' = 'Q21_2',
                                                           'TAM_SN_3' = 'Q21_3',
                                                           'TAM_ICU_1' = 'Q22_1',
                                                           'TAM_ICU_2' = 'Q22_2',
                                                           'TAM_ICU_3' = 'Q22_3',
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
   # [1] "INTNR"              "IoT_Usage_1"        "IoT_Usage_2"        "IoT_Usage_3"        "IoT_Usage_4"        "IoT_Usage_5"        "IoT_Usage_6"       
   # [8] "IoT_Usage_7"        "IoT_Usage_8"        "IoT_Usage_9"        "IoT_Usage_10"       "IoT_Usage_11"       "IoT_Usage_12"       "IoT_Usage_13"      
   # [15] "IoT_Usage_14"       "IoT_Usage_15"       "IoT_Usage_16"       "IoT_Usage_17"       "IoT_Usage_18"       "IoT_Usage_19"       "IoT_Usage_20"      
   # [22] "IoT_Usage_21"       "IoT_Usage_22"       "IoT_Usage_23"       "IoT_Usage_24"       "IoT_Usage_25"       "IoT_Usage_other"    "Q4_96"             
   # [29] "GA_Freq_1"          "GA_Freq_2"          "GA_Freq_3"          "GA_Freq_4"          "GA_Freq_5"          "GA_Freq_6"          "GA_Freq_7"         
   # [36] "GA_Freq_8"          "GA_Freq_9"          "GA_Freq_10"         "GA_Freq_11"         "IoT_Freq_1"         "IoT_Freq_2"         "IoT_Freq_3"        
   # [43] "IoT_Freq_4"         "IoT_Freq_5"         "IoT_Freq_6"         "IoT_Freq_7"         "IoT_Freq_8"         "IoT_Freq_9"         "IoT_Freq_10"       
   # [50] "IoT_Freq_11"        "IoT_Freq_12"        "IoT_Freq_13"        "IoT_Freq_14"        "IoT_Freq_15"        "IoT_Freq_16"        "Child_Nr"          
   # [57] "Child_Age"          "Child_Gender"       "Child_Temp_1"       "Child_Temp_2"       "Child_Temp_3"       "PMMS_1"             "PMMS_2"            
   # [64] "PMMS_3"             "PMMS_4"             "PMMS_5"             "PMMS_6"             "SS_cousage_1"       "SS_cousage_2"       "SS_childusage_1"   
   # [71] "SS_childusage_2"    "Incorporation"      "Child_Parasocial_1" "Child_Parasocial_2" "Child_Parasocial_3" "Child_Parasocial_4" "Child_Parasocial_5"
   # [78] "Location"           "Q13_96"             "Early_Adopter"      "Conversion"         "TAM_PEoU_1"         "TAM_PEoU_2"         "TAM_PEoU_3"        
   # [85] "TAM_PEoU_4"         "TAM_PU_1"           "TAM_PU_2"           "TAM_PU_3"           "TAM_PU_4"           "TAM_E_1"            "TAM_E_2"           
   # [92] "TAM_E_3"            "TAM_E_4"            "TAM_IMG"            "TAM_SN_1"           "TAM_SN_2"           "TAM_SN_3"           "TAM_ICU_1"         
   # [99] "TAM_ICU_2"          "TAM_ICU_3"          "IL_1"               "IL_2"               "IL_3"               "IL_4"               "IL_5"              
   # [106] "TT_1"               "TT_2"               "TT_3"               "STATUS"             "PERSONEN"           "SOCIALEKLASSE2016"  "GSL"               
   # [113] "LFT" 
   
   
#-----------------------------------------------#
### ROSIE TARGET GROUP ##########################
#-----------------------------------------------#
   
   #filtering responses for Rosie target group (in total: 224 responses, completes: 183)
   ?dplyr::filter
   rosie_dataset_renamed_families_complete <- dplyr::filter(rosie_dataset_renamed, Child_Gender != 0 & STATUS == 1)
   # View(rosie_dataset_renamed_families_complete)
   
   
   hist(rosie_dataset_renamed$IoT_Usage_8)
   hist(rosie_dataset_renamed$IoT_Usage_9)
   crosstab(rosie_dataset_renamed$IoT_Usage_8)
   sum(rosie_dataset_renamed$IoT_Usage_8==1)
   library(psych)
   describe(rosie_dataset_renamed_families_complete$IoT_Usage_8)
   source("http://pcwww.liv.ac.uk/~william/R/crosstab.r")
   crosstab(rosie_dataset_renamed_families_complete, row.vars = "IoT_Usage_8", type = "f")
   crosstab(rosie_dataset_renamed_families_complete, row.vars = "IoT_Usage_9", type = "f")
   
#----------------------------------------------------------------------#
#       CONTINUE WITH FILTERED DATASET
   
#------------------------------------------#
### DATA CLEANING ##########################
#------------------------------------------#
  
  #make sure the following variables are coded as explicit factors:
    #Q29 Child_Gender
    #SOCIALEKLASSE2016 (for SES) 
    #STATUS (complete or screened-out)
    #GSL (parent gender)
   rosie_dataset_renamed_families_complete[, 58] <- sapply(rosie_dataset_renamed_families_complete[, 58], as.factor)
   rosie_dataset_renamed_families_complete[, 111] <- sapply(rosie_dataset_renamed_families_complete[, 111], as.factor)
   rosie_dataset_renamed_families_complete[, 109] <- sapply(rosie_dataset_renamed_families_complete[, 109], as.factor) 
   rosie_dataset_renamed_families_complete[, 112] <- sapply(rosie_dataset_renamed_families_complete[, 112], as.factor) 
   
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
        # View(rosie_dataset_renamed_families_complete)
        
        #SS_childusage_1 & 2
        rosie_dataset_renamed_families_complete$ICU_childindividually <- rowMeans(rosie_dataset_renamed_families_complete[, 70:71], na.rm = T)
        is.numeric(rosie_dataset_renamed_families_complete$ICU_childindividually)
        rosie_dataset_renamed_families_complete$ICU_childindividually
        # View(rosie_dataset_renamed_families_complete)
        
        #Based on this information we can also calculate how many parents have used the virtual assistant only by themselves and 
        #neither together with their child nor having let their child use it independently
        rosie_dataset_renamed_families_complete$current_usage <- ifelse(rosie_dataset_renamed_families_complete$ICU_togetherwithchild == 1 &
                                                                           rosie_dataset_renamed_families_complete$ICU_childindividually == 1, 1, 2)
        #1 = parent only
        #2 = with child
          
        # View(rosie_dataset_renamed_families_complete)
        
        summary(rosie_dataset_renamed_families_complete[,c(116:118)]) #there seems to be one NA in ICU_childindividually, this is row 74 (in R) = pp 888
        
          #inspecting this 1 NA further  
          #create new subset df 
          rosie_ICU <- rosie_dataset_renamed_families_complete[,c(116:118, 98:100)]
          # View(rosie_ICU)
          
          #and now remove missing values
          rosie_ICU_noNA <- na.omit(rosie_ICU)
          # View(rosie_ICU_noNA)
        
          #correlating the control variables ICU_togetherwithchild & ICU_childindividually with the DVs TAM_ICU_1 myself, TAM_ICU_2 with my child, TAM_ICU_3 child individually
            round(cor(rosie_ICU_noNA), 2)
            #                       ICU_togetherwithchild ICU_childindividually ICU_parentonly TAM_ICU_1 TAM_ICU_2 TAM_ICU_3
            # ICU_togetherwithchild                  1.00                ! 0.78        ! -0.64     -0.05    ! 0.45    ! 0.36
            # ICU_childindividually                  0.78                  1.00        ! -0.55     -0.10    ! 0.43    ! 0.40
            # ICU_parentonly                        -0.64                 -0.55           1.00      0.07    !-0.42     -0.29
            # TAM_ICU_1                             -0.05                 -0.10           0.07      1.00     -0.04      0.06
            # TAM_ICU_2                              0.45                  0.43          -0.42     -0.04      1.00      0.58
            # TAM_ICU_3                              0.36                  0.40          -0.29      0.06      0.58      1.00
            
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
  # [1] "INTNR"                 "IoT_Usage_1"           "IoT_Usage_2"           "IoT_Usage_3"           "IoT_Usage_4"           "IoT_Usage_5"          
  # [7] "IoT_Usage_6"           "IoT_Usage_7"           "IoT_Usage_8"           "IoT_Usage_9"           "IoT_Usage_10"          "IoT_Usage_11"         
  # [13] "IoT_Usage_12"          "IoT_Usage_13"          "IoT_Usage_14"          "IoT_Usage_15"          "IoT_Usage_16"          "IoT_Usage_17"         
  # [19] "IoT_Usage_18"          "IoT_Usage_19"          "IoT_Usage_20"          "IoT_Usage_21"          "IoT_Usage_22"          "IoT_Usage_23"         
  # [25] "IoT_Usage_24"          "IoT_Usage_25"          "IoT_Usage_other"       "Q4_96"                 "GA_Freq_1"             "GA_Freq_2"            
  # [31] "GA_Freq_3"             "GA_Freq_4"             "GA_Freq_5"             "GA_Freq_6"             "GA_Freq_7"             "GA_Freq_8"            
  # [37] "GA_Freq_9"             "GA_Freq_10"            "GA_Freq_11"            "IoT_Freq_1"            "IoT_Freq_2"            "IoT_Freq_3"           
  # [43] "IoT_Freq_4"            "IoT_Freq_5"            "IoT_Freq_6"            "IoT_Freq_7"            "IoT_Freq_8"            "IoT_Freq_9"           
  # [49] "IoT_Freq_10"           "IoT_Freq_11"           "IoT_Freq_12"           "IoT_Freq_13"           "IoT_Freq_14"           "IoT_Freq_15"          
  # [55] "IoT_Freq_16"           "Child_Nr"              "Child_Age"             "Child_Gender"          "Child_Temp_1"          "Child_Temp_2"         
  # [61] "Child_Temp_3"          "PMMS_1"                "PMMS_2"                "PMMS_3"                "PMMS_4"                "PMMS_5"               
  # [67] "PMMS_6"                "SS_cousage_1"          "SS_cousage_2"          "SS_childusage_1"       "SS_childusage_2"       "Incorporation"        
  # [73] "Child_Parasocial_1"    "Child_Parasocial_2"    "Child_Parasocial_3"    "Child_Parasocial_4"    "Child_Parasocial_5"    "Location"             
  # [79] "Q13_96"                "Early_Adopter"         "Conversion"            "TAM_PEoU_1"            "TAM_PEoU_2"            "TAM_PEoU_3"           
  # [85] "TAM_PEoU_4"            "TAM_PU_1"              "TAM_PU_2"              "TAM_PU_3"              "TAM_PU_4"              "TAM_E_1"              
  # [91] "TAM_E_2"               "TAM_E_3"               "TAM_E_4"               "TAM_IMG"               "TAM_SN_1"              "TAM_SN_2"             
  # [97] "TAM_SN_3"              "TAM_ICU_1"             "TAM_ICU_2"             "TAM_ICU_3"             "IL_1"                  "IL_2"                 
  # [103] "IL_3"                  "IL_4"                  "IL_5"                  "TT_1"                  "TT_2"                  "TT_3"                 
  # [109] "STATUS"                "PERSONEN"              "SOCIALEKLASSE2016"     "GSL"                   "LFT"                   "FoPersU"              
  # [115] "SHL"                   "ICU_togetherwithchild" "ICU_childindividually" "ICU_parentonly"

  
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
  rosie_SEMrelevant <- rosie[,-c(2:81, 101:115)]
  # View(rosie_SEMrelevant)
  library(VIM)
  aggr(rosie_SEMrelevant)
  missingness_SEM <- aggr(rosie_SEMrelevant)
  missingness_SEM
  summary(missingness_SEM)
  #only 1 missing value in ICU_childindividually but this does not impact the SEM in any way
  
        #inspecting this row
        rosie[74,] 
        # >> for some reason this participant has NAs for SS_childusage ***Most likely due to a survey system error***
  

#----------------------------------------------------------------------------------------------------------------#
  
#------------------------------------------------------#
### CHECKING MEASUREMENTMENTS ##########################
#------------------------------------------------------#
  
  #-------------------------------------------------------------------------------------#
  #1) Confirmatory Factor Analysis for all model variables built up of two or more items
    #TAM_IMG and TAM_ICU only consist of one item and were therefore excluded here
  
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
      #TAM_SN >> 3 items
      (#TAM_ICU >> 3 items)
      #IL >> 5 items
      
  #2) Extract factor scores
        
  #3) Cronbach's Alpha
  
#-------------------------------------------------------------------------------------#
  
#---------------------------------------------------#
### 1) CFA (Measurement model)##########################
#---------------------------------------------------#
  
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
          # >> fit index criteria: Chi-Square = / because 0 df just identified, CFI = 1 > 0.95, TLI = 1 > 0.90 and RMSEA = 0 < 0.10
    
          
          
          ### IL >> 5 items #########################      
          
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
          
          
          
          ### Child_Temp >> 3 items ##########################
  
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
  
              #After inspecting the fit indices and revising the scale, we conclude that each Child_temp item does not per se represent an item that in total measure temperament.
              #Instead, each item represent a separate temperament type and therefore we recode each item into a separate variable with which we proceed.
          
                  #renaming Child_Temp items along original single-item Temperament Scale by Sleddens et al. (2012)
                  library(dplyr)
                  rosie <- dplyr::rename(rosie, c('Child_Temp_Extraversion' = 'Child_Temp_1',
                                         'Child_Temp_Negative_Affectivity' = 'Child_Temp_2',
                                         'Child_Temp_Effortful_Control' = 'Child_Temp_3'))
                  names(rosie)
          
          
          ### Child_Parasocial >> 5 items#########################
          
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
          
          ### PMMS >> 6 items #########################
          
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
          # >> fit index criteria: Chi-Square = .058 > .05, CFI = .993 > 0.95, TLI = .979 > 0.90 and RMSEA = .100 < 0.10 >> NICE
          
          
          ### TAM_SN >> 3 items #########################
          
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
                boxplot(rosie$TAM_SN_1)
                boxplot(rosie$TAM_SN_2) 
                boxplot(rosie$TAM_SN_3)
                hist(rosie$TAM_SN_1) #so not normal
                hist(rosie$TAM_SN_2) #so not normal
                hist(rosie$TAM_SN_3) #so not normal
                densityplot(rosie$TAM_SN_1)
                densityplot(rosie$TAM_SN_2)
                densityplot(rosie$TAM_SN_3)
                
                #numerically 
                #standardize a variable and count the number of cases with values greater or less than 3
                standardized_TAM_SN <- scale(rosie[,c(95:97)]) 
                outliers_TAM_SN <- colSums(abs(standardized_TAM_SN)>=3, na.rm = T) 
                outliers_TAM_SN
                #TAM_SN_1 TAM_SN_2 TAM_SN_3 
                #0        0        0 
              
          #Step 1: correlations
          #The function cor specifies the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,95:97]),2) 
          #          TAM_SN_1 TAM_SN_2 TAM_SN_3
          # TAM_SN_1     1.00    -0.37    -0.27
          # TAM_SN_2    -0.37     1.00     0.61
          # TAM_SN_3    -0.27     0.61     1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,95:97]),2) 
          #          TAM_SN_1 TAM_SN_2 TAM_SN_3
          # TAM_SN_1     3.60    -1.19    -0.94
          # TAM_SN_2    -1.19     2.86     1.88
          # TAM_SN_3    -0.94     1.88     3.31
          
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
              # View(SN_EFA_df)
              
              #parallel analysis to get number of factors
              parallel4 <- fa.parallel(SN_EFA_df, fm = 'minres', fa = 'fa') #suggests 1 factor, so we'll stick with CFA
          
              
              
          ### TAM_ICU >> 3 items #########################
          
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
              boxplot(rosie$TAM_ICU_1)
              boxplot(rosie$TAM_ICU_2) 
              boxplot(rosie$TAM_ICU_3)
              hist(rosie$TAM_ICU_1) 
              hist(rosie$TAM_ICU_2)
              hist(rosie$TAM_ICU_3) 
              densityplot(rosie$TAM_ICU_1)
              densityplot(rosie$TAM_ICU_2)
              densityplot(rosie$TAM_ICU_3)
              
              #numerically 
              #standardize a variable and count the number of cases with values greater or less than 3
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
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,98:100]), 2) 
          #          TAM_ICU_1 TAM_ICU_2 TAM_ICU_3
          #TAM_ICU_1      1.00     -0.02      0.07
          #TAM_ICU_2     -0.02      1.00      0.58
          #TAM_ICU_3      0.07      0.58      1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,98:100]), 2) 
          #          TAM_ICU_1 TAM_ICU_2 TAM_ICU_3
          #TAM_ICU_1      2.97     -0.05      0.22
          #TAM_ICU_2     -0.05      1.89      1.42
          #TAM_ICU_3      0.22      1.42      3.17
          
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
                # View(ICU_EFA_df)
                
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
                      
                      #confirming this with a CFA is problematic because one factor is defined by just one item and, thus, the model will not be identified; also this scale does not represent an existing multiple-item scale
                      #but this supports the correlation results for the ICU levels and the fact that we distinguish between used by parents only vs. used by child in any way (variable: current usage)
                      
      
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
                    # onefac3items_TAM_SN
                    #(onefac3items_TAM_ICU)
                
                #predicting factor scores of all CFA models
                onefac3items_TTfitPredict <- as.data.frame(predict(onefac3items_TT))
                twofac5items_ILfitPredict <- as.data.frame(predict(twofac5items_IL))
                twofac5items_Child_ParasocialfitPredict <- as.data.frame(predict(twofac5items_Child_Parasocial))
                threefac2items_PMMSfitPredict <- as.data.frame(predict(threefac2items_PMMS)) 
                onefac4items_TAM_PeoUfitPredict <- as.data.frame(predict(onefac4items_TAM_PEoU))
                onefac4items_TAM_PUfitPredict <- as.data.frame(predict(onefac4items_TAM_PU))
                onefac4items_TAM_EfitPredict <- as.data.frame(predict(onefac4items_TAM_E))
                onefac3items_TAM_SNfitPredict <- as.data.frame(predict(onefac3items_TAM_SN))
                onefac3items_TAM_ICUfitPredict <- as.data.frame(predict(onefac3items_TAM_ICU)) #R warns about some negative variances, this corresponds to the CFA results above

                
                #adding to rosie-dataset
                rosie_fscores <- cbind(rosie, onefac3items_TTfitPredict, twofac5items_ILfitPredict, twofac5items_Child_ParasocialfitPredict,
                                       threefac2items_PMMSfitPredict, onefac4items_TAM_PeoUfitPredict, onefac4items_TAM_PUfitPredict,  onefac4items_TAM_EfitPredict,
                                       onefac3items_TAM_SNfitPredict, onefac3items_TAM_ICUfitPredict)
                View(rosie_fscores)
                
        
        #--------------------------------------#
        ####---- 3) Reliability analysis----####
        #--------------------------------------#
                
        #https://rpubs.com/hauselin/reliabilityanalysis
        #raw_alpha: Cronbach’s α (values ≥ .7 or .8 indicate good reliability; Kline (1999))
          
          #Dispositional: 
          
          #Q26 TT >> 3 items
          TT <- rosie[, c(106:108)]
          psych::alpha(TT) ### --> 0.77
          
          #Q25 IL >> 5 items
          IL <- rosie[, c(101:105)]
          psych::alpha(IL) ### --> 0.86
          
          #for each factor separately
          Information <- rosie[, c(101, 103)]
          psych::alpha(Information) ### --> 0.82
          
          Navigation <- rosie[, c(102, 104:105)]
          psych::alpha(Navigation) ### --> 0.8
          
          #Q32 Child_Parasocial >> 5 items
          Child_Parasocial <- rosie[, c(73:77)]
          psych::alpha(Child_Parasocial) ### --> 0.83
          
                # #for each factor separately
                # Anthropomorphism <- rosie[, c(73, 76:77)]
                # psych::alpha(Anthropomorphism) ### --> 0.89
                # 
                # Parasocial_relationship <- rosie[, c(74:75)]
                # psych::alpha(Parasocial_relationship) ### --> 0.57
                # 
          #Developmental: NONE
          
          #Social: 
          
          #Q31 PMMS >> 6 items 
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
          psych::alpha(TAM_SN) ### --> 0.87
          
          # #Q22 TAM_ICU >> 3 
          # TAM_ICU <- rosie[, c(98:100)]
          # psych::alpha(TAM_ICU) ### --> 0.43
          


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
                
   #specific descriptives on the different DV-levels
   hist(rosie$ICU_togetherwithchild)
   mean(rosie$ICU_togetherwithchild) # 3.34153
   describe(rosie$ICU_togetherwithchild)
   #   vars   n mean   sd median trimmed  mad min max range  skew kurtosis   se
   #X1    1 183 3.34 1.45      4    3.35 1.48   1   6     5 -0.18     -0.9 0.11
                
   hist(rosie$ICU_childindividually)
   mean(rosie$ICU_childindividually, na.rm=T) # 3.214286
   describe(rosie$ICU_childindividually, na.rm=T)
   #   vars   n mean   sd median trimmed  mad min max range  skew kurtosis   se
   #X1    1 182 3.21 1.62    3.5    3.18 2.22   1   6     5 -0.07    -1.22 0.12
  
   #check for ceiling effect on DV-levels
   describe(rosie_fscores$TAM_ICU_1)
   hist(rosie_fscores$TAM_ICU_1)
   
   describe(rosie_fscores$TAM_ICU_2)
   hist(rosie_fscores$TAM_ICU_2)
   densityplot(rosie_fscores$TAM_ICU_2)
   
   describe(rosie_fscores$TAM_ICU_3)
   hist(rosie_fscores$TAM_ICU_3)
   densityplot(rosie_fscores$TAM_ICU_3)
   
   describe(rosie_fscores$TAM_ICU_f)
   hist(rosie_fscores$TAM_ICU_f)
   
   #taking a visual look
   
   hist(rosie$TT_1) 
   hist(rosie$TT_2)
   hist(rosie$TT_3)
   hist(rosie_fscores$TT_f) #fairly normally distributed
                
   hist(rosie$FoPersU)
   
   hist(rosie$Child_Temp_Extraversion)
   hist(rosie$Child_Temp_Negative_Affectivity)
   hist(rosie$Child_Temp_Effortful_Control)
                
   hist(rosie$Child_Parasocial_1) 
   hist(rosie$Child_Parasocial_2)
   hist(rosie$Child_Parasocial_3)
   hist(rosie$Child_Parasocial_4)
   hist(rosie$Child_Parasocial_5)
   hist(rosie_fscores$anthropomorphism) #strongly positively skewed
   hist(rosie_fscores$parasocial_relationship) #positively skewed
                
   hist(rosie$PMMS_1)
   hist(rosie$PMMS_2)
   hist(rosie$PMMS_3)
   hist(rosie$PMMS_4)
   hist(rosie$PMMS_5)
   hist(rosie$PMMS_6)
   hist(rosie_fscores$restrMed) #negatively skewed
   hist(rosie_fscores$negacMed) #negatively skewed
   hist(rosie_fscores$posacMed) #negatively skewed
                
   hist(rosie$LFT) #most parents between 30-50, only very few between 60 - 80
   hist(rosie$Child_Age) #almost equally distributed, most 8-year olds
   
   hist(rosie$IL_1)
   hist(rosie$IL_2)
   hist(rosie$IL_3)
   hist(rosie$IL_4)
   hist(rosie$IL_5)
   hist(rosie_fscores$navigation)
   hist(rosie_fscores$information)
   
   hist(rosie$SHL)
  
   #getting correlations matrix for TAM-variables
   round(cor(rosie_fscores[,c(139:143, 98:100)]),2)
   #            TAM_PEoU_f TAM_PU_f TAM_E_f TAM_SN_f TAM_ICU_f TAM_ICU_1 TAM_ICU_2 TAM_ICU_3
   # TAM_PEoU_f       1.00     0.44    0.63     0.15      0.09      0.06      0.36      0.29
   # TAM_PU_f         0.44     1.00    0.58     0.40      0.11      0.13      0.45      0.36
   # TAM_E_f          0.63     0.58    1.00     0.25      0.02      0.11      0.53      0.33
   # TAM_SN_f         0.15     0.40    0.25     1.00      0.07      0.22      0.20      0.20
   # TAM_ICU_f        0.09     0.11    0.02     0.07      1.00      0.00      0.00      0.81
   # TAM_ICU_1        0.06     0.13    0.11     0.22      0.00      1.00     -0.02      0.07
   # TAM_ICU_2        0.36     0.45    0.53     0.20      0.00     -0.02      1.00      0.58
   # TAM_ICU_3        0.29     0.36    0.33     0.20      0.81      0.07      0.58      1.00
   
   
         #pairwise correlations all in one scatterplot matrix
         library(car)
         scatterplotMatrix(~TAM_PEoU_f+TAM_PU_f+TAM_E_f+TAM_SN_f+TAM_IMG+TAM_ICU_f, data = rosie_fscores)
         
         #for better visual overview 
         library(devtools)
         #devtools::install_github("laresbernardo/lares")
         library(lares)

         corr_cross(rosie_fscores[,c(139:143)], # name of dataset
                    max_pvalue = 0.05, # display only significant correlations (at 5% level)
                    top = 20 # display top 20 couples of variables (by correlation coefficient)
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
       # GSL >> already categorical
       # SOCIALEKLASSE2016 >> already categorical
       # TT >> 3 items >> median split method because of conceptual understanding of the scale
       # IL >> 5 items (information + navigation) >> median split method because conceptual understanding of the scale
       # FoPersU >> convert into irregular vs. regular (based on weekly answer option as the cut-off)
       # Child_Gender > already categorical
       # Child_Temp (Extraversion, Negative_Affectivity, Effortful_Control) >> scale ranged from -3 over 0 to +3, so since conceptually everything < 0 is a more or less clear "no", we categorize this way: ≤ 3 = 1, ≥ 4 = 2 
       # Child_Parasocial >> 5 items two factors (anthropomorphism & parasocial_relationship) >> median split method because conceptual understanding of the scale
       
       #Developmental:
       # LFT >> mean-split
       # Child_Age >> age group "pre-schoolers 3-5 years, age group "schoolkids" 6-8 years, which means 1-3 = 1 and 4-6 = 2
       
       #Social: 
       # PMMS >> 6 items (restsMed & negacMed & posacMed) >> modal split method because of conceptual understanding of the scale
       # current usage >> already categorical (from data cleaning)
       # household composition >> built up of Child_Nr and PERSONEN >> convert both items into factors
       # smart-household-level >> median split method because of conceptual understanding of the scale (sticking with number of devices instead of frequency)
   
   #------------------------------------------------------#
   ### artificial categorization ##########################
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
           
           #information (items 1 + 3)
           rosie_fscores$IL_information_avgsum <- rowMeans(rosie_fscores[, c(101, 103)], na.rm = T)
           is.numeric(rosie_fscores$IL_information_avgsum)
           # View(rosie_fscores$IL_information_avgsum)
           
           #median split method !!! Note: Since items were formulated negatively, lower scores indicate higher literacy, so numbers for categories are switched
           rosie_fscores$IL_information_LCAcategory_orig[rosie_fscores$IL_information_avgsum<=median(rosie_fscores$IL_information_avgsum)] = 2
           rosie_fscores$IL_information_LCAcategory_orig[rosie_fscores$IL_information_avgsum>median(rosie_fscores$IL_information_avgsum)] = 1
       
           
   # - FoPersU
   rosie_fscores$FoPersU_f_LCA[rosie_fscores$FoPersU<=2] = 1
   rosie_fscores$FoPersU_f_LCA[rosie_fscores$FoPersU>2] = 2
   rosie_fscores$FoPersU_f_LCA <-  as.factor(rosie_fscores$FoPersU_f_LCA)
   is.factor(rosie_fscores$FoPersU_f_LCA)
           
   # - Child_Temp
   rosie_fscores$Temp_Extraversion_f[rosie_fscores$Child_Temp_Extraversion<=3] = 1
   rosie_fscores$Temp_Extraversion_f[rosie_fscores$Child_Temp_Extraversion>=4] = 2
   
   rosie_fscores$Temp_Negative_Affectivity_f[rosie_fscores$Child_Temp_Negative_Affectivity<=3] = 1
   rosie_fscores$Temp_Negative_Affectivity_f[rosie_fscores$Child_Temp_Negative_Affectivity>=4] = 2
   
   rosie_fscores$Temp_Effortful_Control_f[rosie_fscores$Child_Temp_Effortful_Control<=3] = 1
   rosie_fscores$Temp_Effortful_Control_f[rosie_fscores$Child_Temp_Effortful_Control>=4] = 2
   
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
           
           #parasocial relationship (items 2 + 3)
           rosie_fscores$Child_Parasocial_pararela_avgsum <- rowMeans(rosie_fscores[, c(74:75)], na.rm = T)
           is.numeric(rosie_fscores$Child_Parasocial_pararela_avgsum)
           # View(rosie_fscores$Child_Parasocial_pararela_avgsum)
           
           #median split method
           rosie_fscores$Child_Parasocial_pararela_LCAcategory_orig[rosie_fscores$Child_Parasocial_pararela_avgsum<=median(rosie_fscores$Child_Parasocial_pararela_avgsum)] = 1
           rosie_fscores$Child_Parasocial_pararela_LCAcategory_orig[rosie_fscores$Child_Parasocial_pararela_avgsum>median(rosie_fscores$Child_Parasocial_pararela_avgsum)] = 2
       
   
   # - LFT
   rosie_fscores$LFT_f[rosie_fscores$LFT<=mean(rosie$LFT)] = 1
   rosie_fscores$LFT_f[rosie_fscores$LFT>mean(rosie$LFT)] = 2
           
   # - Child_Age
   rosie_fscores$Child_Age_f[rosie_fscores$Child_Age<=3] = 1 
   rosie_fscores$Child_Age_f[rosie_fscores$Child_Age>=4] = 2
   
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
           
           
           #negacMed (items 3+5)
           rosie_fscores$PMMS_negacMed_avgsum <- rowMeans(rosie_fscores[, c(64, 66)], na.rm = T)
           is.numeric(rosie_fscores$PMMS_negacMed_avgsum)
           # View(rosie_fscores$PMMS_negacMed_avgsum)
           
           #modal split method
           rosie_fscores$PMMS_negacMed_LCAcategory_orig[rosie_fscores$PMMS_negacMed_avgsum<=getmode(rosie_fscores$PMMS_negacMed_avgsum)] = 1
           rosie_fscores$PMMS_negacMed_LCAcategory_orig[rosie_fscores$PMMS_negacMed_avgsum>getmode(rosie_fscores$PMMS_negacMed_avgsum)] = 2
           
           
           #posacMed (items 4+6)
           rosie_fscores$PMMS_posacMed_avgsum <- rowMeans(rosie_fscores[, c(65, 67)], na.rm = T)
           is.numeric(rosie_fscores$PMMS_posacMed_avgsum)
           # View(rosie_fscores$PMMS_posacMed_avgsum)
           
           #modal split method
           rosie_fscores$PMMS_posacMed_LCAcategory_orig[rosie_fscores$PMMS_posacMed_avgsum<=getmode(rosie_fscores$PMMS_posacMed_avgsum)] = 1
           rosie_fscores$PMMS_posacMed_LCAcategory_orig[rosie_fscores$PMMS_posacMed_avgsum>getmode(rosie_fscores$PMMS_posacMed_avgsum)] = 2
           
                
   # - household composition
   rosie_fscores$Child_Nr_f <- as.factor(rosie_fscores$Child_Nr)
   
   rosie_fscores$PERSONEN_f <- as.factor(rosie_fscores$PERSONEN)
   
   
   View(rosie_fscores) 
   
   
   # - smart-household-level
   rosie_fscores$SHL_f[rosie_fscores$SHL<=median(rosie_fscores$SHL)] = 1
   rosie_fscores$SHL_f[rosie_fscores$SHL>median(rosie_fscores$SHL)] = 2
   
   
   #check if all new factors are included in the dataset
   View(rosie_fscores)
   names(rosie_fscores)
   # "TT_avgsum"                                         
   # [145] "TT_LCAcategory_orig"                                "IL_navigation_avgsum"                              
   # [147] "IL_navigation_LCAcategory_orig"                     "IL_information_avgsum"                             
   # [149] "IL_information_LCAcategory_orig"                    "FoPersU_f"                                         
   # [151] "Temp_Extraversion_f"                                "Temp_Negative_Affectivity_f"                       
   # [153] "Temp_Effortful_Control_f"                           "Child_Parasocial_anthropomorphism_avgsum"          
   # [155] "Child_Parasocial_anthropomorphism_LCAcategory_orig" "Child_Parasocial_pararela_avgsum"                  
   # [157] "Child_Parasocial_pararela_LCAcategory_orig"         "LFT_f"                                             
   # [159] "Child_Age_f"                                        "PMMS_restrMed_avgsum"                              
   # [161] "PMMS_restrMed_LCAcategory_orig"                     "PMMS_negacMed_avgsum"                              
   # [163] "PMMS_negacMed_LCAcategory_orig"                     "PMMS_posacMed_avgsum"                              
   # [165] "PMMS_posacMed_LCAcategory_orig"                     "Child_Nr_f"                                        
   # [167] "PERSONEN_f"                                         "SHL_f" 
   
   #--------------------------------------------#
   ### running the LCA ##########################
   #--------------------------------------------#
   
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
 
   
  
   #-------------------------------------------#
   ### evaluating LCA ##########################
   #-------------------------------------------#
   
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
    # log-likelihood resid. df     BIC    aBIC    cAIC likelihood-ratio Nclass
    #       -2582.21       122 5482.19 5289.00 5543.19          3257.74      2
    #       -2536.08        91 5551.43 5260.05 5643.43          3165.48      3
    #       -2497.36        60 5635.48 5245.92 5758.48          3088.05      4
    #       -2466.02        29 5734.30 5246.55 5888.30          3025.36      5
    #       -2446.72        -2 5857.20 5271.27 6042.20          2986.77      6
   
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
         
         
         
     # LMT - likelihood ratio test???
         library(tidyLPA)
         # null model = new model (K). alternative model = nested model (K-1)
         test = calc_lrt(LCAmodel4$N, LCAmodel4$llik, LCAmodel4$npar, 4, LCAmodel5$llik, LCAmodel5$npar, 5)
         test
       
   
         
     #extract 2-class solution and save in twoclass object (https://osf.io/vec6s/)
       set.seed(123)
       twoclass=poLCA(LCAmodel, data=rosie_fscores, nclass=2, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
       
       #output predicted classes from selected model so that we can use it in subsequent analyses:
       rosie_fscores$fam_class2=twoclass$predclass
       
       View(rosie_fscores)
       
       #name the levels of the class factor using the response probabilities plot
       # levels(rosie_fscores$fam_class2)[levels(rosie_fscores$fam_class2)=="1"] <- "XXX"
       # levels(rosie_fscores$fam_class2)[levels(rosie_fscores$fam_class2)=="2"] <- "YYY"
       
           #load function for crosstabs to see whether classes relate to the urban/rural areas
           source("http://pcwww.liv.ac.uk/~william/R/crosstab.r")
           crosstab(rosie_fscores, row.vars = "GEMGROOTTE", col.vars = "fam_class2", type = "f")
           #             fam_class2   1   2 Sum
           # GEMGROOTTE                       
           # 4                      22  42  64
           # 1                       4   9  13
           # 2                      27  32  59
           # 3                      17  25  42
           # 5                       1   4   5
           # Sum                    71 112 183
       
    #extract 3-class solution and save in twoclass object (https://osf.io/vec6s/)
       set.seed(123)
       threeclass=poLCA(LCAmodel, data=rosie_fscores, nclass=3, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
       
       #output predicted classes from selected model so that we can use it in subsequent analyses:
       rosie_fscores$fam_class3=threeclass$predclass
       
       
       View(rosie_fscores)
       
       #name the levels of the class factor using the response probabilities plot
       # levels(rosie_fscores$fam_class3)[levels(rosie_fscores$fam_class3)=="1"] <- "XXX"
       # levels(rosie_fscores$fam_class3)[levels(rosie_fscores$fam_class3)=="2"] <- "YYY"
       # levels(rosie_fscores$fam_class3)[levels(rosie_fscores$fam_class3)=="3"] <- "ZZZ"
  
   
       
  #-------------------------------------------------------#
  ### descriptives along classes ##########################
  #-------------------------------------------------------#
       
       library(psych)
       psych::describeBy(rosie_fscores, group = "fam_class3")
       # 1 = LSM, 2 = ILS, 3 = LLY
       
###----------------------------------------------------------------------------------------------------------------###      
      
#----------------------------------------------------------#
### STRUCTURAL EQUATION MODELLING ##########################
#----------------------------------------------------------#
      
   #-----------------------------------------------#
   ### SEM-power analysis ##########################
   #-----------------------------------------------#
   
   #https://yilinandrewang.shinyapps.io/pwrSEM/ 
     
   ??simsem
   #http://rstudio-pubs-static.s3.amazonaws.com/253855_164b16e3a9074cf9a6f3045cbe1f99ce.html 
   
       
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
       
   #--------------------------------#
   ### SEM ##########################
   #--------------------------------#
   

      #install.packages("lavaan", dependencies = T)
      library(lavaan)
 
      
      #perform the analysis
        #https://benwhalley.github.io/just-enough-r/cfa.html
      
        #general functions for sem
        #sem() #for path analysis and SEM
        #cfa() #for confirmatory factor analysis
        #growth() #for latent growth curve modeling
        #lavaan() #for all models (without default parameters)
      
        ### Higher Order Model in Lavaan ###
       
      # ### 2-class model with 1DV ########################## 
      #         rosiesTAM_1DV <- '
      #         
      #         #measurement model
      #           PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4 
      #           PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4 
      #           E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4 
      #           SN =~ 1*TAM_SN_1 + TAM_SN_2 + TAM_SN_3 
      #           ICU =~ 1*TAM_ICU_1 + TAM_ICU_2 + TAM_ICU_3 
      #         #regressions  
      #           PEoU ~ fam_class2  
      #           PU ~ fam_class2 + PEoU  
      #           E ~ fam_class2 
      #           TAM_IMG ~ fam_class2 
      #           SN ~ fam_class2 
      #           ICU ~ PEoU + PU + E + TAM_IMG + SN 
      #         #residual variances 
      #           TAM_PEoU_1 ~~ TAM_PEoU_1
      #           TAM_PEoU_2 ~~ TAM_PEoU_2
      #           TAM_PEoU_3 ~~ TAM_PEoU_3
      #           TAM_PEoU_4 ~~ TAM_PEoU_4
      #           TAM_PU_1 ~~ TAM_PU_1
      #           TAM_PU_2 ~~ TAM_PU_2
      #           TAM_PU_3 ~~ TAM_PU_3
      #           TAM_PU_4 ~~ TAM_PU_4
      #           TAM_E_1 ~~ TAM_E_1
      #           TAM_E_2 ~~ TAM_E_2
      #           TAM_E_3 ~~ TAM_E_3
      #           TAM_E_4 ~~ TAM_E_4
      #           TAM_SN_1 ~~ TAM_SN_1
      #           TAM_SN_2 ~~ TAM_SN_2
      #           TAM_SN_3 ~~ TAM_SN_3
      #           TAM_ICU_1 ~~ TAM_ICU_1
      #           TAM_ICU_2 ~~ TAM_ICU_2
      #           TAM_ICU_3 ~~ TAM_ICU_3
      #           TAM_IMG ~~ TAM_IMG
      #           PEoU ~~ PEoU
      #           PU ~~ PU
      #           E ~~ E
      #           SN ~~ SN
      #           ICU ~~ ICU
      #           fam_class2 ~~ fam_class2
      #         
      #         '
      #         
      #         #fit the model
      #         rosiesTAM_1DV_fit <- lavaan(rosiesTAM_1DV, data = rosie_fscores)
      #         
      #         #print summary  
      #         summary(rosiesTAM_1DV_fit, standardized = T, fit.measures = T)
      #       
      #         #bootstrap model
      #         rosiesTAM_1DV_fit_boostrapped_se <- sem(rosiesTAM_1DV, data = rosie_fscores,se = "bootstrap", bootstrap = 1000) 
      #         summary(rosiesTAM_1DV_fit_boostrapped_se, fit.measures = TRUE) 
      #         parameterEstimates(rosiesTAM_1DV_fit_boostrapped_se, 
      #                            se = TRUE, zstat = TRUE, pvalue = TRUE, ci = TRUE, 
      #                            standardized = FALSE, 
      #                            fmi = FALSE, level = 0.95, boot.ci.type = "norm", 
      #                            cov.std = TRUE, fmi.options = list(), 
      #                            rsquare = FALSE, 
      #                            remove.system.eq = TRUE, remove.eq = TRUE, 
      #                            remove.ineq = TRUE, remove.def = FALSE, 
      #                            remove.nonfree = FALSE, 
      #                            add.attributes = FALSE, 
      #                            output = "data.frame", header = FALSE)
      #         #           lhs op        rhs    est     se      z pvalue ci.lower ci.upper
      #         #          PEoU  ~ fam_class2 -0.135  0.187 -0.722  0.470   -0.484    0.250
      #         # 20         PU  ~ fam_class2 -0.105  0.190 -0.556  0.578   -0.479    0.265
      #         # 21         PU  ~       PEoU  0.601  0.109  5.500  0.000    0.398    0.826
      #         # 22          E  ~ fam_class2 -0.322  0.207 -1.554  0.120   -0.716    0.097
      #         # 23    TAM_IMG  ~ fam_class2 -0.106  0.286 -0.371  0.710   -0.651    0.471
      #         # 24         SN  ~ fam_class2 -0.781  0.225 -3.469  0.001   -1.239   -0.356
      #         # 25        ICU  ~       PEoU  0.001  0.023  0.037  0.971   -0.047    0.042
      #         # 26        ICU  ~         PU  0.005  0.028  0.183  0.854   -0.071    0.037
      #         # 27        ICU  ~          E  0.011  0.050  0.217  0.828   -0.132    0.064
      #         # 28        ICU  ~    TAM_IMG  0.001  0.011  0.090  0.928   -0.026    0.017
      #         # 29        ICU  ~         SN  0.001  0.014  0.042  0.966   -0.029    0.025
      #   
      #         
      #         
      # ### 2-class model with 3DVs ########################## 
      #         rosiesTAM_3DVs <- '
      #         
      #         #measurement model
      #           PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4 
      #           PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4 
      #           E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4 
      #           SN =~ 1*TAM_SN_1 + TAM_SN_2 + TAM_SN_3 
      #         #regressions  
      #           PEoU ~ fam_class2  
      #           PU ~ fam_class2 + PEoU  
      #           E ~ fam_class2 
      #           TAM_IMG ~ fam_class2 
      #           SN ~ fam_class2 
      #           TAM_ICU_1 ~ PEoU + PU + E + TAM_IMG + SN 
      #           TAM_ICU_2 ~ PEoU + PU + E + TAM_IMG + SN 
      #           TAM_ICU_3 ~ PEoU + PU + E + TAM_IMG + SN 
      #         #residual variances 
      #           TAM_PEoU_1 ~~ TAM_PEoU_1
      #           TAM_PEoU_2 ~~ TAM_PEoU_2
      #           TAM_PEoU_3 ~~ TAM_PEoU_3
      #           TAM_PEoU_4 ~~ TAM_PEoU_4
      #           TAM_PU_1 ~~ TAM_PU_1
      #           TAM_PU_2 ~~ TAM_PU_2
      #           TAM_PU_3 ~~ TAM_PU_3
      #           TAM_PU_4 ~~ TAM_PU_4
      #           TAM_E_1 ~~ TAM_E_1
      #           TAM_E_2 ~~ TAM_E_2
      #           TAM_E_3 ~~ TAM_E_3
      #           TAM_E_4 ~~ TAM_E_4
      #           TAM_SN_1 ~~ TAM_SN_1
      #           TAM_SN_2 ~~ TAM_SN_2
      #           TAM_SN_3 ~~ TAM_SN_3
      #           TAM_ICU_1 ~~ TAM_ICU_1
      #           TAM_ICU_2 ~~ TAM_ICU_2
      #           TAM_ICU_3 ~~ TAM_ICU_3
      #           TAM_IMG ~~ TAM_IMG
      #           PEoU ~~ PEoU
      #           PU ~~ PU
      #           E ~~ E
      #           SN ~~ SN
      #           TAM_ICU_1 ~~ TAM_ICU_2
      #           TAM_ICU_1 ~~ TAM_ICU_3
      #           TAM_ICU_2 ~~ TAM_ICU_3
      #           fam_class2 ~~ fam_class2
      #         
      #         '
      #         
      #         #fit the model
      #         rosiesTAM_3DVs_fit <- lavaan(rosiesTAM_3DVs, data = rosie_fscores)
      #         
      #         #print summary  
      #         summary(rosiesTAM_3DVs_fit, standardized = T, fit.measures = T)
      #         
      #         #bootstrap model
      #         rosiesTAM_3DVs_fit_boostrapped_se <- sem(rosiesTAM_3DVs, data = rosie_fscores,se = "bootstrap", bootstrap = 1000) 
      #         summary(rosiesTAM_3DVs_fit_boostrapped_se, fit.measures = TRUE) 
      #         parameterEstimates(rosiesTAM_3DVs_fit_boostrapped_se, 
      #                            se = TRUE, zstat = TRUE, pvalue = TRUE, ci = TRUE, 
      #                            standardized = FALSE, 
      #                            fmi = FALSE, level = 0.95, boot.ci.type = "norm", 
      #                            cov.std = TRUE, fmi.options = list(), 
      #                            rsquare = FALSE, 
      #                            remove.system.eq = TRUE, remove.eq = TRUE, 
      #                            remove.ineq = TRUE, remove.def = FALSE, 
      #                            remove.nonfree = FALSE, 
      #                            add.attributes = FALSE, 
      #                            output = "data.frame", header = FALSE)
      #         
      #         #           lhs op        rhs    est    se      z pvalue ci.lower ci.upper
      #         # 16       PEoU  ~ fam_class2  0.136 0.180  0.752  0.452   -0.223    0.484
      #         # 17         PU  ~ fam_class2  0.106 0.184  0.572  0.567   -0.270    0.453
      #         # 18         PU  ~       PEoU  0.600 0.110  5.451  0.000    0.389    0.821
      #         # 19          E  ~ fam_class2  0.321 0.196  1.634  0.102   -0.071    0.698
      #         # 20    TAM_IMG  ~ fam_class2  0.106 0.295  0.360  0.719   -0.465    0.692
      #         # 21         SN  ~ fam_class2  0.778 0.235  3.317  0.001    0.334    1.253
      #         # 22  TAM_ICU_1  ~       PEoU  0.028 0.139  0.203  0.839   -0.251    0.292
      #         # 23  TAM_ICU_1  ~         PU -0.033 0.139 -0.235  0.814   -0.306    0.239
      #         # 24  TAM_ICU_1  ~          E  0.085 0.153  0.555  0.579   -0.209    0.391
      #         # 25  TAM_ICU_1  ~    TAM_IMG  0.185 0.069  2.704  0.007    0.051    0.319
      #         # 26  TAM_ICU_1  ~         SN  0.185 0.100  1.841  0.066   -0.015    0.378
      #         # 27  TAM_ICU_2  ~       PEoU  0.012 0.142  0.082  0.934   -0.258    0.298
      #         # 28  TAM_ICU_2  ~         PU  0.186 0.115  1.614  0.106   -0.042    0.410
      #         # 29  TAM_ICU_2  ~          E  0.456 0.129  3.546  0.000    0.197    0.701
      #         # 30  TAM_ICU_2  ~    TAM_IMG  0.041 0.058  0.708  0.479   -0.070    0.157
      #         # 31  TAM_ICU_2  ~         SN  0.014 0.081  0.169  0.866   -0.136    0.180
      #         # 32  TAM_ICU_3  ~       PEoU  0.158 0.172  0.920  0.358   -0.184    0.490
      #         # 33  TAM_ICU_3  ~         PU  0.266 0.168  1.585  0.113   -0.071    0.587
      #         # 34  TAM_ICU_3  ~          E  0.191 0.167  1.141  0.254   -0.128    0.527
      #         # 35  TAM_ICU_3  ~    TAM_IMG  0.020 0.071  0.278  0.781   -0.115    0.163
      #         # 36  TAM_ICU_3  ~         SN  0.074 0.096  0.763  0.446   -0.107    0.271
      #       
      #         
      #         
      #   ### 3-class model with 1DV ##########################  
      #         #this reveals many convergence warning and model did not end normally!
      #         
      #   rosiesTAM_3classes1DV <- '
      # 
      #   #measurement model
      #     PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
      #     PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
      #     E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
      #     SN =~ 1*TAM_SN_1 + TAM_SN_2 + TAM_SN_3
      #     ICU =~ 1*TAM_ICU_1 + TAM_ICU_2 + TAM_ICU_3
      #   #regressions
      #     PEoU ~ fam_class3
      #     PU ~ fam_class3 + PEoU
      #     E ~ fam_class3
      #     TAM_IMG ~ fam_class3
      #     SN ~ fam_class3
      #     ICU ~ PEoU + PU + E + TAM_IMG + SN
      #   #residual variances
      #     TAM_PEoU_1 ~~ TAM_PEoU_1
      #     TAM_PEoU_2 ~~ TAM_PEoU_2
      #     TAM_PEoU_3 ~~ TAM_PEoU_3
      #     TAM_PEoU_4 ~~ TAM_PEoU_4
      #     TAM_PU_1 ~~ TAM_PU_1
      #     TAM_PU_2 ~~ TAM_PU_2
      #     TAM_PU_3 ~~ TAM_PU_3
      #     TAM_PU_4 ~~ TAM_PU_4
      #     TAM_E_1 ~~ TAM_E_1
      #     TAM_E_2 ~~ TAM_E_2
      #     TAM_E_3 ~~ TAM_E_3
      #     TAM_E_4 ~~ TAM_E_4
      #     TAM_SN_1 ~~ TAM_SN_1
      #     TAM_SN_2 ~~ TAM_SN_2
      #     TAM_SN_3 ~~ TAM_SN_3
      #     TAM_ICU_1 ~~ TAM_ICU_1
      #     TAM_ICU_2 ~~ TAM_ICU_2
      #     TAM_ICU_3 ~~ TAM_ICU_3
      #     TAM_IMG ~~ TAM_IMG
      #     PEoU ~~ PEoU
      #     PU ~~ PU
      #     E ~~ E
      #     SN ~~ SN
      #     ICU ~~ ICU
      #     fam_class3 ~~ fam_class3
      # 
      #   '
      # 
      #   #fit the model
      #   rosiesTAM_3classes1DV_fit <- lavaan(rosiesTAM_3classes1DV, data = rosie_fscores)
      # 
      #   #print summary
      #   summary(rosiesTAM_3classes1DV_fit, standardized = T, fit.measures = T)
      #   
      #   
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
        
  
        
        #post-hoc test needed for significant regression path of SN ~ family type
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
        
        # Compute the analysis of variance
        rosie_fscores$fam_class3 <- as.factor(rosie_fscores$fam_class3)
        anova <- aov(TAM_SN_f ~ fam_class3, data = rosie_fscores)
        # Summary of the analysis
        summary(anova)
        # Which pairs of groups differ?
        TukeyHSD(anova)
        # Tukey multiple comparisons of means
        # 95% family-wise confidence level
        # 
        # Fit: aov(formula = TAM_SN_f ~ fam_class3, data = rosie_fscores)
        # 
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
        
###----------------------------------------------------------------------------------------------------------------###
          
#------------------------------------------------#
### Model visualization ##########################
#------------------------------------------------#
          
### SemPaths Model Visualization ###
       
    library(semPlot)
    semPaths(rosiesTAM_3classes3DVs_fit, what = "col", "std", layout = "tree", rotation = 2, 
             intercepts = F, residuals = F, curve = 2, nCharNodes = 0,
             edge.label.cex = 1, edge.color = "black", sizeMan = 10, sizeMan2 = 5)
    title("TAM + U&G Structural Regression Model")
    
#########  :) Script run until here #################
    
###----------------------------------------------------------------------------------------------------------------###

    
    
    
    
    
    
    
    
#----------------------------------------------------------#
### OTHER POTENTIALLY USEFUL CODE ##########################
#----------------------------------------------------------#

      
      #testing a three factor model
      #evaluate and improve (re-specify) the factor solution in order to obtain a satisfactory factor solution
      
      ### CFA FUNCTION ###
      
      #specify the model
      t_f_model <- 'EE =~ x1 + x2 + x3 
      CY =~ x4 + x5 + x6 
      RPA =~ x7 + x8 + x9'     
      
      #fit the model
      t_f_fit <- cfa(t_f_model, data = bo)
      
      #print summary
      summary(t_f_fit, standardized = T, fit.measures = T)
      
      
      ### LAVAAN FUNCTION ###
      
      #specify the model
      t_f_model_lavaan <- 'EE  =~ 1*x1 + x2 + x3      
      CY =~ 1*x4 + x5 + x6
      RPA =~ 1*x7 + x8 + x9 
      
      #add (residual) variances
      x1~~x1
      x2~~x2
      x3~~x3
      x4~~x4
      x5~~x5
      x6~~x6
      x7~~x7
      x8~~x8
      x9~~x9
      EE~~EE
      CY~~CY
      RPA~~RPA
      
      #add covariances
      EE~~CY
      CY~~RPA
      RPA~~EE
      '
      
      #fit the model
      t_f_model_lavaan_fit <- lavaan(t_f_model_lavaan, data = bo)
      
      #print summary
      summary(t_f_model_lavaan_fit, standardized = T, fit.measures = T)
      
      
      ### Higher Order Model in Lavaan ###
      
      #specify the model
      ho_f_model_lavaan <- 'EE  =~ 1*x1 + x2 + x3      
        CY =~ 1*x4 + x5 + x6
        RPA =~ 1*x7 + x8 + x9 
        burnout =~ 1*EE + CY + RPA
    
      #add (residual) variances
      x1~~x1
      x2~~x2
      x3~~x3
      x4~~x4
      x5~~x5
      x6~~x6
      x7~~x7
      x8~~x8
      x9~~x9
      EE~~EE
      CY~~CY
      RPA~~RPA
      burnout~~burnout'
      
      #fit the model
      ho_f_model_lavaan_fit <- lavaan(ho_f_model_lavaan, data = bo)
      
      #print summary
      summary(ho_f_model_lavaan_fit, standardized = T, fit.measures = T)
      
      
      ### SEM FUNCTION ###
      
      
      #specify the model
      model <- ‘cbcIDQ ~popular + temper + sex
      cbcIAB ~popular + temper + sex
      cbcIAD ~popular + temper + y’
      #fit the model
      fit <- sem(model, data = NewpDataSet)
      #print summary
      summary(fit, standardized = T)
      
      #specify estimator and imputation strategy
      fit <- sem(model, data = Data, estimator = “MLR”, missing = “ML”)
      #add intercepts
      fit <- sem(model, data = Data, meanstructure = TRUE)
      #use bootstrapping
      fit <- sem(model, data = Data, se = ‘bootstrap’)
      fit <- sem(model, data = Data, test = ‘bootstrap’)
      
      #adjust summary
      #adding standardized estimates and R-square(s)
      summary(fit, standardized = TRUE, rsq = TRUE)
      #adding GOD indices
      summary(fit, fit.measures = TRUE)
      #adding modification indices
      summary(fit, modindices = TRUE)
      ### OR instead: depmixS4 which also allows continuous and categorical indicators https://maksimrudnev.com/2016/12/28/latent-class-analysis-in-r/#depmixS4
      
      
      ### LPA ###
      
      library(depmixS4)
      library(stats)
      
      #define model     
      #??mix
      #model_definition <- depmix(list(TT_1 ~ 1, TT_2 ~ 1, TT_3 ~ 1, 
      #                            Child_Temp_Extraversion ~ 1, Child_Temp_Negative_Affectivity ~ 1, Child_Temp_Effortful_Control ~ 1,
      #                            Child_Parasocial_1 ~ 1, Child_Parasocial_2 ~ 1, Child_Parasocial_3 ~ 1, Child_Parasocial_4 ~ 1, Child_Parasocial_5 ~ 1,
      #                            SOCIALEKLASSE2016 ~ 1,
      #                            Child_Age ~ 1, 
      #                            Child_Gender ~ 1, 
      #                            GSL ~ 1, 
      #                            LFT ~ 1, 
      #                            PMMS_1 ~ 1, PMMS_2 ~ 1, PMMS_3 ~ 1, PMMS_4 ~ 1, PMMS_5 ~ 1, PMMS_6 ~ 1),
      #                       data = rosie, nstates = 2, 
      #                       family = list(Gamma(),Gamma(),Gamma(),
      #                                     Gamma(),Gamma(),Gamma(),
      #                                     Gamma(),Gamma(),Gamma(),Gamma(),Gamma(),
      #                                     poisson(),
      #                                     Gamma(),
      #                                     poisson(),
      #                                     poisson(),
      #                                     Gamma(),
      #                                     Gamma(),Gamma(),Gamma(),Gamma(),Gamma(),Gamma()),
      #                       respstart=runif(44))
      
      #?depmixS4::GLMresponse
      
      #fit model       
      #fit.mod <- fit(model_definition)   # Fit the model
      
      #fit.mod