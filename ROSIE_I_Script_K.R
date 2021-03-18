
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
 View(data)
  
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
   rosie_dataset <- data[,-c(2:16, 108:120, 190, 199:291, 294:309, 313:325)]
   View(rosie_dataset)
   
   #getting variable names and index numbers of reduced dataset
   names(rosie_dataset)
   #[1] "INTNR"             "Q401"              "Q402"              "Q403"              "Q404"              "Q405"              "Q406"              "Q407"             
   #[9] "Q408"              "Q409"              "Q410"              "Q411"              "Q412"              "Q413"              "Q414"              "Q415"             
   #[17] "Q416"              "Q417"              "Q418"              "Q419"              "Q420"              "Q421"              "Q422"              "Q423"             
   #[25] "Q424"              "Q425"              "Q4_4"              "Q4_40"             "Q4_41"             "Q4_42"             "Q4_43"             "Q4_44"            
   #[33] "Q4_45"             "Q4_46"             "Q4_47"             "Q4_48"             "Q4_49"             "Q4_4A"             "Q4_4B"             "Q4_7"             
   #[41] "Q4_70"             "Q4_71"             "Q4_72"             "Q4_73"             "Q4_74"             "Q4_75"             "Q4_76"             "Q4_77"            
   #[49] "Q4_78"             "Q4_79"             "Q4_7A"             "Q4_7B"             "Q4_96"             "Q4_960"            "Q4_961"            "Q4_962"           
   #[57] "Q4_963"            "Q4_964"            "Q4_965"            "Q4_966"            "Q4_967"            "Q4_968"            "Q4_969"            "Q4_96A"           
   #[65] "Q4_96B"            "Q5_1"              "Q5_2"              "Q5_3"              "Q5_4"              "Q5_5"              "Q5_6"              "Q5_7"             
   #[73] "Q5_8"              "Q5_9"              "Q5_10"             "Q5_11"             "Q6_1"              "Q6_2"              "Q6_3"              "Q6_4"             
   #[81] "Q6_5"              "Q6_6"              "Q6_7"              "Q6_8"              "Q6_9"              "Q6_10"             "Q6_11"             "Q6_12"            
   #[89] "Q6_13"             "Q6_14"             "Q6_15"             "Q6_16"             "Q8"                "Q28"               "Q29"               "Q30_1"            
   #[97] "Q30_2"             "Q30_3"             "Q31_1"             "Q31_2"             "Q31_3"             "Q31_4"             "Q31_5"             "Q31_6"            
   #[105] "Q11_1"             "Q11_2"             "Q42_1"             "Q42_2"             "Q12"               "Q120"              "Q121"              "Q122"             
   #[113] "Q123"              "Q124"              "Q125"              "Q126"              "Q127"              "Q128"              "Q129"              "Q12A"             
   #[121] "Q12B"              "Q32_1"             "Q32_2"             "Q32_3"             "Q32_4"             "Q32_5"             "Q13"               "Q13_96"           
   #[129] "Q13_90"            "Q13_91"            "Q13_92"            "Q13_93"            "Q13_94"            "Q13_95"            "Q13_97"            "Q13_98"           
   #[137] "Q13_99"            "Q13_9A"            "Q13_9B"            "Q13_9C"            "Q14"               "Q15"               "Q17_1"             "Q17_2"            
   #[145] "Q17_3"             "Q17_4"             "Q18_1"             "Q18_2"             "Q18_3"             "Q18_4"             "Q19_1"             "Q19_2"            
   #[153] "Q19_3"             "Q19_4"             "Q20"               "Q21_1"             "Q21_2"             "Q21_3"             "Q22_1"             "Q22_2"            
   #[161] "Q22_3"             "Q25_1"             "Q25_2"             "Q25_3"             "Q25_4"             "Q25_5"             "Q26_1"             "Q26_2"            
   #[169] "Q26_3"             "STATUS"            "PERSONEN"          "SOCIALEKLASSE2016" "GSL"               "LFT" 
   
   
#----------------------------------------------------------------------#
#       CONTINUE WITH REDUCED DATASET
   
   
#-----------------------------------------------#
### ROSIE TARGET GROUP ##########################
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
   View(rosie_dataset_renamed)
   names(rosie_dataset_renamed)
   #[1] "INTNR"              "IoT_Usage_1"        "IoT_Usage_2"        "IoT_Usage_3"        "IoT_Usage_4"        "IoT_Usage_5"        "IoT_Usage_6"        "IoT_Usage_7"        "IoT_Usage_8"        "IoT_Usage_9"       
   #[11] "IoT_Usage_10"       "IoT_Usage_11"       "IoT_Usage_12"       "IoT_Usage_13"       "IoT_Usage_14"       "IoT_Usage_15"       "IoT_Usage_16"       "IoT_Usage_17"       "IoT_Usage_18"       "IoT_Usage_19"      
   #[21] "IoT_Usage_20"       "IoT_Usage_21"       "IoT_Usage_22"       "IoT_Usage_23"       "IoT_Usage_24"       "IoT_Usage_25"       "Q4_4"               "Q4_40"              "Q4_41"              "Q4_42"             
   #[31] "Q4_43"              "Q4_44"              "Q4_45"              "Q4_46"              "Q4_47"              "Q4_48"              "Q4_49"              "Q4_4A"              "Q4_4B"              "IoT_Usage_other"   
   #[41] "Q4_70"              "Q4_71"              "Q4_72"              "Q4_73"              "Q4_74"              "Q4_75"              "Q4_76"              "Q4_77"              "Q4_78"              "Q4_79"             
   #[51] "Q4_7A"              "Q4_7B"              "Q4_96"              "Q4_960"             "Q4_961"             "Q4_962"             "Q4_963"             "Q4_964"             "Q4_965"             "Q4_966"            
   #[61] "Q4_967"             "Q4_968"             "Q4_969"             "Q4_96A"             "Q4_96B"             "GA_Freq_1"          "GA_Freq_2"          "GA_Freq_3"          "GA_Freq_4"          "GA_Freq_5"         
   #[71] "GA_Freq_6"          "GA_Freq_7"          "GA_Freq_8"          "GA_Freq_9"          "GA_Freq_10"         "GA_Freq_11"         "IoT_Freq_1"         "IoT_Freq_2"         "IoT_Freq_3"         "IoT_Freq_4"        
   #[81] "IoT_Freq_5"         "IoT_Freq_6"         "IoT_Freq_7"         "IoT_Freq_8"         "IoT_Freq_9"         "IoT_Freq_10"        "IoT_Freq_11"        "IoT_Freq_12"        "IoT_Freq_13"        "IoT_Freq_14"       
   #[91] "IoT_Freq_15"        "IoT_Freq_16"        "Child_Nr"           "Child_Age"          "Child_Gender"       "Child_Temp_1"       "Child_Temp_2"       "Child_Temp_3"       "PMMS_1"             "PMMS_2"            
   #[101] "PMMS_3"             "PMMS_4"             "PMMS_5"             "PMMS_6"             "SS_cousage_1"       "SS_cousage_2"       "SS_childusage_1"    "SS_childusage_2"    "Incorporation"      "Q120"              
   #[111] "Q121"               "Q122"               "Q123"               "Q124"               "Q125"               "Q126"               "Q127"               "Q128"               "Q129"               "Q12A"              
   #[121] "Q12B"               "Child_Parasocial_1" "Child_Parasocial_2" "Child_Parasocial_3" "Child_Parasocial_4" "Child_Parasocial_5" "Location"           "Q13_96"             "Q13_90"             "Q13_91"            
   #[131] "Q13_92"             "Q13_93"             "Q13_94"             "Q13_95"             "Q13_97"             "Q13_98"             "Q13_99"             "Q13_9A"             "Q13_9B"             "Q13_9C"            
   #[141] "Early_Adopter"      "Conversion"         "TAM_PEoU_1"         "TAM_PEoU_2"         "TAM_PEoU_3"         "TAM_PEoU_4"         "TAM_PU_1"           "TAM_PU_2"           "TAM_PU_3"           "TAM_PU_4"          
   #[151] "TAM_E_1"            "TAM_E_2"            "TAM_E_3"            "TAM_E_4"            "TAM_IMG"            "TAM_SN_1"           "TAM_SN_2"           "TAM_SN_3"           "TAM_ICU_1"          "TAM_ICU_2"         
   #[161] "TAM_ICU_3"          "IL_1"               "IL_2"               "IL_3"               "IL_4"               "IL_5"               "TT_1"               "TT_2"               "TT_3"               "STATUS"            
   #[171] "PERSONEN"           "SOCIALEKLASSE2016"  "GSL"                "LFT" 
   
   #filtering responses for Rosie target group (in total: 224 responses, completes: 183)
   ?dplyr::filter
   rosie_dataset_renamed_families_complete <- dplyr::filter(rosie_dataset_renamed, Child_Gender != 0 & STATUS == 1)
   View(rosie_dataset_renamed_families_complete)
   
#----------------------------------------------------------------------#
#       CONTINUE WITH FILTERED DATASET
   
#------------------------------------------#
### DATA CLEANING ##########################
#------------------------------------------#
  
  #make sure the following variables are coded as explicit factors:
    #Q4 IoT_Usage
    #Q29 Child_Gender
    #Q13 Location
    #Q14 Early_Adopter
    #SOCIALEKLASSE2016 (for SES) --> outdated???
    #STATUS (complete or screened-out)
    #GSL (parent gender)
   rosie_dataset_renamed_families_complete[, 2:26] <- sapply(rosie_dataset_renamed_families_complete[, 2:26], as.factor)
   rosie_dataset_renamed_families_complete[, 95] <- sapply(rosie_dataset_renamed_families_complete[, 95], as.factor)
   rosie_dataset_renamed_families_complete[, 127] <- sapply(rosie_dataset_renamed_families_complete[, 127], as.factor)
   rosie_dataset_renamed_families_complete[, 141] <- sapply(rosie_dataset_renamed_families_complete[, 141], as.factor)
   rosie_dataset_renamed_families_complete[, 170] <- sapply(rosie_dataset_renamed_families_complete[, 170], as.factor)
   rosie_dataset_renamed_families_complete[, 172] <- sapply(rosie_dataset_renamed_families_complete[, 172], as.factor) 
   
  #recoding values of variables
  
  #Previous experience - PE (Q5 GA_Freq) --> relevant for smart speakers are items: GA_Freq_8-11
  #Here, we computed the mean for each participant on their answers to the frequency of smart speaker usage to get an indicator for their previous experience (the higher this value the higher the PE)
  library(fame)
  rosie_dataset_renamed_families_complete$PE <- rowMeans(rosie_dataset_renamed_families_complete[, 73:76], na.rm = T)
  is.numeric(rosie_dataset_renamed_families_complete$PE)
  View(rosie_dataset_renamed_families_complete)

  #Smart-Household-Level - SHL (Q6 GA_IoT_Freq) 
  #Here, we computed the mean for each participant on their answers to the frequency of GA_IoT usage to get an indicator for their smart-household-level (the higher this value the higher the SHL)
  rosie_dataset_renamed_families_complete$SHL <- rowMeans(rosie_dataset_renamed_families_complete[, 77:92], na.rm = T)
  is.numeric(rosie_dataset_renamed_families_complete$SHL)
  rosie_dataset_renamed_families_complete$SHL
  View(rosie_dataset_renamed_families_complete)
  
  #ICU
      #We asked as our DV how the families assume their usage to look like in the near future (TAM_ICU_1 myself, TAM_ICU_2 with my child, TAM_ICU_3 child individually)
      #We asked one time how the families' usage has looked like until now (SS_cousage_1: samen met uw kind smart speaker without display, SS_cousage_2: samen met uw kind smart speaker with display, SS_childusage_1: uw kind zelfstandig without display, SS_childusage_2: uw kind zelfstandig with display)
        
        #Here, we computed the mean for each participant on their answers to the four questions, out of which we only need to know the level of co-usage and individual child usage, and not whetehr this was with a smart speaker with or without display
        #SS_cousage_1 & 2  
        rosie_dataset_renamed_families_complete$ICU_togetherwithchild <- rowMeans(rosie_dataset_renamed_families_complete[, 105:106], na.rm = T)
        is.numeric(rosie_dataset_renamed_families_complete$ICU_togetherwithchild)
        rosie_dataset_renamed_families_complete$ICU_togetherwithchild
        View(rosie_dataset_renamed_families_complete)
        
        #SS_childusage_1 & 2
        rosie_dataset_renamed_families_complete$ICU_childindividually <- rowMeans(rosie_dataset_renamed_families_complete[, 107:108], na.rm = T)
        is.numeric(rosie_dataset_renamed_families_complete$ICU_childindividually)
        rosie_dataset_renamed_families_complete$ICU_childindividually
        View(rosie_dataset_renamed_families_complete)
        
        
        summary(rosie_dataset_renamed_families_complete[,c(177:178, 159:161)]) #there seems to be one NA in ICU_childindividually, this is row 74 (in R) = pp 888
        
          #inspecting this 1 NA further  
          #create new subset df 
          rosie_ICU <- rosie_dataset_renamed_families_complete[,c(177:178, 159:161)]
          View(rosie_ICU)
          
          #and now remove missing values
          rosie_ICU_noNA <- na.omit(rosie_ICU)
          View(rosie_ICU_noNA)
        
          #correlating the control variables ICU_togetherwithchild & ICU_childindividually with the DVs TAM_ICU_1 myself, TAM_ICU_2 with my child, TAM_ICU_3 child individually
            round(cor(rosie_ICU_noNA), 2)
            #                      ICU_togetherwithchild ICU_childindividually TAM_ICU_1 TAM_ICU_2 TAM_ICU_3
            #ICU_togetherwithchild                  1.00                  0.78!    -0.05      0.45!     0.36
            #ICU_childindividually                  0.78                  1.00     -0.10      0.43!     0.40!
            #TAM_ICU_1                             -0.05                 -0.10      1.00     -0.04      0.06
            #TAM_ICU_2                              0.45                  0.43     -0.04      1.00      0.58
            #TAM_ICU_3                              0.36                  0.40      0.06      0.58!     1.00
            
            # >> reveals:
            #families who have used the smart speaker together with the child are likely to have let the child use it individually as well (.78)
            #families who have used the smart speaker together with the child are likely to intend to use it together with the child in the near future (.45)
            #families who have let the child use the smart speaker individually are likely to intend to use it together with the child (.43) as well as by the child individually (.40)
            #families who intend to use the smart speaker together with the child are likely to intend to let the child use it individually as well (.58)
            # >> co-usage and child-individual usage seem to go mostly hand-in-hand
            
      
      #Since ICA_togetherwithchild and ICU_childindividually act as control variables for the TAM_ICU variables 1, 2, 3 we need to create a new variable that assigns each participant to one of the four possible groups:
        #Co-usage only (meaning >= 2 for ICU_togetehrwithchild & == 1 for ICU_childindividually) => 1
        #Child-usage only (meaning == 1 for ICU_togetehrwithchild & >= 2 for ICU_childindividually) => 2
        #no Co-usage and no child-usage (meaning == 1 for ICU_togetehrwithchild & == 1 for ICU_childindividually)=> 3
        #Co-usage and child-usage (meaning meaning >= 2 for ICU_togetehrwithchild & >= 2 for ICU_childindividually) => 4
        
        #THIS SYNTAX IS NOT WORKING PROPERLY (YET), MAYBE FIX THIS LATER BUT WE MIGHT NOT NEED IT
        #library(dplyr)
        #rosie_dataset_renamed_families_complete$ICU_groups <- rosie_dataset_renamed_families_complete[c(177:178)] %>% mutate(group = case_when(
        #  ICU_togetherwithchild >= 2 & ICU_childindividually == 1 ~ "1", 
        #  ICU_togetherwithchild == 1 & ICU_childindividually >= 2 ~ "2", 
        #  ICU_togetherwithchild == 1 & ICU_childindividually == 1 ~ "3",
        #  ICU_togetherwithchild >= 2 & ICU_childindividually >= 2 ~ "4"))
        #rosie_dataset_renamed_families_complete$ICU_groups
        #View(rosie_dataset_renamed_families_complete)
        
        #is.factor(rosie_dataset_renamed_families_complete$ICU_groups.group)
        #as.factor(rosie_dataset_renamed_families_complete$ICU_groups.group)
        #is.factor(rosie_dataset_renamed_families_complete$ICU_groups.group)
        
#----------------------------------------------------------------------#
#       CONTINUE WITH CLEANED DATASET
  
  View(rosie_dataset_renamed_families_complete)
  
  #restarting dataset naming
  rosie <- rosie_dataset_renamed_families_complete
  View(rosie)
  names(rosie)
  #[1] "INTNR"                 "IoT_Usage_1"           "IoT_Usage_2"           "IoT_Usage_3"           "IoT_Usage_4"           "IoT_Usage_5"          
  #[7] "IoT_Usage_6"           "IoT_Usage_7"           "IoT_Usage_8"           "IoT_Usage_9"           "IoT_Usage_10"          "IoT_Usage_11"         
  #[13] "IoT_Usage_12"          "IoT_Usage_13"          "IoT_Usage_14"          "IoT_Usage_15"          "IoT_Usage_16"          "IoT_Usage_17"         
  #[19] "IoT_Usage_18"          "IoT_Usage_19"          "IoT_Usage_20"          "IoT_Usage_21"          "IoT_Usage_22"          "IoT_Usage_23"         
  #[25] "IoT_Usage_24"          "IoT_Usage_25"          "Q4_4"                  "Q4_40"                 "Q4_41"                 "Q4_42"                
  #[31] "Q4_43"                 "Q4_44"                 "Q4_45"                 "Q4_46"                 "Q4_47"                 "Q4_48"                
  #[37] "Q4_49"                 "Q4_4A"                 "Q4_4B"                 "IoT_Usage_other"       "Q4_70"                 "Q4_71"                
  #[43] "Q4_72"                 "Q4_73"                 "Q4_74"                 "Q4_75"                 "Q4_76"                 "Q4_77"                
  #[49] "Q4_78"                 "Q4_79"                 "Q4_7A"                 "Q4_7B"                 "Q4_96"                 "Q4_960"               
  #[55] "Q4_961"                "Q4_962"                "Q4_963"                "Q4_964"                "Q4_965"                "Q4_966"               
  #[61] "Q4_967"                "Q4_968"                "Q4_969"                "Q4_96A"                "Q4_96B"                "GA_Freq_1"            
  #[67] "GA_Freq_2"             "GA_Freq_3"             "GA_Freq_4"             "GA_Freq_5"             "GA_Freq_6"             "GA_Freq_7"            
  #[73] "GA_Freq_8"             "GA_Freq_9"             "GA_Freq_10"            "GA_Freq_11"            "IoT_Freq_1"            "IoT_Freq_2"           
  #[79] "IoT_Freq_3"            "IoT_Freq_4"            "IoT_Freq_5"            "IoT_Freq_6"            "IoT_Freq_7"            "IoT_Freq_8"           
  #[85] "IoT_Freq_9"            "IoT_Freq_10"           "IoT_Freq_11"           "IoT_Freq_12"           "IoT_Freq_13"           "IoT_Freq_14"          
  #[91] "IoT_Freq_15"           "IoT_Freq_16"           "Child_Nr"              "Child_Age"             "Child_Gender"          "Child_Temp_1"         
  #[97] "Child_Temp_2"          "Child_Temp_3"          "PMMS_1"                "PMMS_2"                "PMMS_3"                "PMMS_4"               
  #[103] "PMMS_5"                "PMMS_6"                "SS_cousage_1"          "SS_cousage_2"          "SS_childusage_1"       "SS_childusage_2"      
  #[109] "Incorporation"         "Q120"                  "Q121"                  "Q122"                  "Q123"                  "Q124"                 
  #[115] "Q125"                  "Q126"                  "Q127"                  "Q128"                  "Q129"                  "Q12A"                 
  #[121] "Q12B"                  "Child_Parasocial_1"    "Child_Parasocial_2"    "Child_Parasocial_3"    "Child_Parasocial_4"    "Child_Parasocial_5"   
  #[127] "Location"              "Q13_96"                "Q13_90"                "Q13_91"                "Q13_92"                "Q13_93"               
  #[133] "Q13_94"                "Q13_95"                "Q13_97"                "Q13_98"                "Q13_99"                "Q13_9A"               
  #[139] "Q13_9B"                "Q13_9C"                "Early_Adopter"         "Conversion"            "TAM_PEoU_1"            "TAM_PEoU_2"           
  #[145] "TAM_PEoU_3"            "TAM_PEoU_4"            "TAM_PU_1"              "TAM_PU_2"              "TAM_PU_3"              "TAM_PU_4"             
  #[151] "TAM_E_1"               "TAM_E_2"               "TAM_E_3"               "TAM_E_4"               "TAM_IMG"               "TAM_SN_1"             
  #[157] "TAM_SN_2"              "TAM_SN_3"              "TAM_ICU_1"             "TAM_ICU_2"             "TAM_ICU_3"             "IL_1"                 
  #[163] "IL_2"                  "IL_3"                  "IL_4"                  "IL_5"                  "TT_1"                  "TT_2"                 
  #[169] "TT_3"                  "STATUS"                "PERSONEN"              "SOCIALEKLASSE2016"     "GSL"                   "LFT"                  
  #[175] "PE"                    "SHL"                   "ICU_togetherwithchild" "ICU_childindividually" "ICU_groups"           
  


  
#---------------------------------------------------#
### INSPECTING MISSINGNESS ##########################
#---------------------------------------------------#
  
  #Where are missing values?
  complete.cases(rosie[c(93:104, 122:126, 143:178)])
  ?complete.cases
  summary(rosie[c(93:104, 122:126, 143:178)])
  options(max.print=1000000)
 
  #plotting the missing values for variables relevant for LCA 
  names(rosie)
  rosie_LCArelevant <- rosie[,-c(2:92, 105:121, 127:158, 162:172, 175:179)] 
  View(rosie_LCArelevant)
  library(VIM)
  aggr(rosie_LCArelevant)
  missingness_LCA <- aggr(rosie_LCArelevant)
  missingness_LCA 
  summary(missingness_LCA)
  # >> no missingness
  
  #plotting the missing values for variables relevant for SEM later to identify their pattern
  rosie_SEMrelevant <- rosie[,-c(2:92, 94:142, 170, 172:174, 179:181)]
  View(rosie_SEMrelevant)
  library(VIM)
  aggr(rosie_SEMrelevant)
  missingness_SEM <- aggr(rosie_SEMrelevant)
  missingness_SEM
  summary(missingness_SEM)
  #only 1 missing value in ICU_childindividually but this does not impact the SEM in any way ... I really do not understand why that can be...
  
        #inspecting this row
        rosie[74,] 
        # >> for some reason this participant has NAs for SS_childusage 
  

#----------------------------------------------------------------------------------------------------------------#
  
#------------------------------------------------------#
### CHECKING MEASUREMENTMENTS ##########################
#------------------------------------------------------#
  
  #-------------------------------------------------------------------------------------#
  #Confirmatory Factor Analysis for all model variables built up of two or more items
    #TAM_IMG and TAM_ICU only consist of one item and were therefore excluded here
  
    #Dispositional: 
      #Q26 TT >> 3 items
      #Q30 Child_Temp >> 3 items
      #Q32 Child_Parasocial >> 5 items
    
    #Developmental: NONE
  
    #Social: 
      #Q31 PMMS >> 6 items
  
    #TAM: 
      #Q17 TAM_PEoU >> 4 items
      #Q18 TAM_PU >> 4 items
      #Q19 TAM_E >> 4 items
      #Q21 TAM_SN >> 3 items
      #Q22 TAM_ICU >> 3 items
      #Q25 IL >> 5 items
      
  #Extract factor scores???
  #Cronbach's Alpha
  
#-------------------------------------------------------------------------------------#
  
#---------------------------------------------------#
### CFA (Measurement model)##########################
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
                standardized_TT <- scale(rosie[,c(167:169)]) 
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
          round(cor(rosie[,167:169]), 2)
          #     TT_1 TT_2 TT_3
          #TT_1 1.00 0.67 0.44
          #TT_2 0.67 1.00 0.49
          #TT_3 0.44 0.49 1.00
  
          #Step 2: variance-covariance matrix
          round(cov(rosie[,167:169]), 2) 
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
                standardized_Child_Temp <- scale(rosie[,c(96:98)]) 
                outliers_Child_Temp <- colSums(abs(standardized_Child_Temp)>=3, na.rm = T) 
                outliers_Child_Temp
                #Child_Temp_1 Child_Temp_2 Child_Temp_3 
                #0            0            0 
                
                # >> Child_Temp_1 = negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers
                # >> Child_Temp_2 = fairly symmetrical (skew), fewer returns in its tail than normal (kurtosis), no outliers
                # >> Child_Temp_3 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers
          
          #Step 1: correlations
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,96:98]), 2) # >> Here, it seems running a CFA does not really make much sense due to the extremely low correlations. I guess that is due to the adjusted dense scale?
          #             Child_Temp_1 Child_Temp_2 Child_Temp_3
          #Child_Temp_1         1.00         0.03         0.14
          #Child_Temp_2         0.03         1.00        -0.04
          #Child_Temp_3         0.14        -0.04         1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,96:98]), 2) 
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
                standardized_Child_Parasocial <- scale(rosie[,c(122:126)]) 
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
          round(cor(rosie[,122:126]), 2) 
          #                   Child_Parasocial_1 Child_Parasocial_2 Child_Parasocial_3 Child_Parasocial_4 Child_Parasocial_5
          #Child_Parasocial_1               1.00               0.31               0.56               0.69               0.68
          #Child_Parasocial_2               0.31               1.00               0.40               0.27               0.29
          #Child_Parasocial_3               0.56               0.40               1.00               0.54               0.57
          #Child_Parasocial_4               0.69               0.27 !!            0.54               1.00               0.81
          #Child_Parasocial_5               0.68               0.29  !!           0.57               0.81               1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,122:126]), 2)
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
                standardized_PMMS <- scale(rosie[,c(99:104)]) 
                outliers_PMMS <- colSums(abs(standardized_PMMS)>=3, na.rm = T) 
                outliers_PMMS
                #PMMS_1 PMMS_2 PMMS_3 PMMS_4 PMMS_5 PMMS_6 
                #0      0      0      6      0      0
                  
              # >> PMMS_1 = fairly symmetrical (skew), fewer returns in its tail than normal (kurtosis), no outliers
              # >> PMMS_2 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers
              # >> PMMS_3 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers
              # >> PMMS_4 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers
              # >> PMMS_5 = fairly symmetrical (skew), fewer returns in its tail than normal (kurtosis), no outliers
              # >> PMMS_6 = fairly symmetrical (skew), fewer returns in its tail than normal (kurtosis), no outliers
          
          #Step 1: correlations
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,99:104]), 2) 
          #       PMMS_1 PMMS_2 PMMS_3 PMMS_4 PMMS_5 PMMS_6
          #PMMS_1   1.00   0.59   0.43   0.22   0.25   0.19
          #PMMS_2   0.59   1.00   0.38   0.29   0.36   0.32
          #PMMS_3   0.43   0.38   1.00   0.23   0.59   0.23
          #PMMS_4   0.22   0.29   0.23   1.00   0.30   0.60
          #PMMS_5   0.25   0.36   0.59   0.30   1.00   0.29
          #PMMS_6   !!0.19 0.32   0.23   0.60   0.29   1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,99:104]), 2) 
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
                standardized_TAM_PEoU <- scale(rosie[,c(143:146)]) 
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
          round(cor(rosie[,143:146]), 2) 
          #           TAM_PEoU_1 TAM_PEoU_2 TAM_PEoU_3 TAM_PEoU_4
          #TAM_PEoU_1       1.00       0.54       0.76       0.76
          #TAM_PEoU_2       0.54       1.00       0.51       0.54
          #TAM_PEoU_3       0.76       0.51       1.00       0.74
          #TAM_PEoU_4       0.76       0.54       0.74       1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,143:146]), 2) 
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
                standardized_TAM_PU <- scale(rosie[,c(147:150)]) 
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
          round(cor(rosie[,147:150]), 2) 
          #         TAM_PU_1 TAM_PU_2 TAM_PU_3 TAM_PU_4
          #TAM_PU_1     1.00     0.76     0.83     0.72
          #TAM_PU_2     0.76     1.00     0.78     0.62
          #TAM_PU_3     0.83     0.78     1.00     0.68
          #TAM_PU_4     0.72     0.62     0.68     1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,147:150]), 2) 
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
                standardized_TAM_E <- scale(rosie[,c(151:154)]) 
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
          round(cor(rosie[,151:154]),2) 
          #        TAM_E_1 TAM_E_2 TAM_E_3 TAM_E_4
          #TAM_E_1    1.00    0.83    0.83    0.60
          #TAM_E_2    0.83    1.00    0.78    0.56
          #TAM_E_3    0.83    0.78    1.00    0.64
          #TAM_E_4    0.60    0.56    0.64    1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,151:154]),2)
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
                standardized_TAM_SN <- scale(rosie[,c(156:158)]) 
                outliers_TAM_SN <- colSums(abs(standardized_TAM_SN)>=3, na.rm = T) 
                outliers_TAM_SN
                #TAM_SN_1 TAM_SN_2 TAM_SN_3 
                #0        0        0 
              
          #Step 1: correlations
          #The function cor specifies the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,156:158]),2) 
          #         TAM_SN_1 TAM_SN_2 TAM_SN_3
          #TAM_SN_1     1.00     0.83     0.65
          #TAM_SN_2     0.83     1.00     0.61
          #TAM_SN_3     0.65     0.61     1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,156:158]),2) 
          #         TAM_SN_1 TAM_SN_2 TAM_SN_3
          #TAM_SN_1     2.69     2.32     1.94
          #TAM_SN_2     2.32     2.86     1.88
          #TAM_SN_3     1.94     1.88     3.31
          
          #Step 3: one-factor CFA
          #one factor three items, default marker method
          m1h  <- ' TAM_SN_f  =~ TAM_SN_1 + TAM_SN_2 + TAM_SN_3 '
          onefac3items_TAM_SN <- cfa(m1h, data=rosie) 
          summary(onefac3items_TAM_SN, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = 0 > .05, CFI = 1 > 0.95, TLI = 1 > 0.90 and RMSEA = 0 < 0.10 >> AGAIN, problematic because just identified        
          
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
              standardized_TAM_ICU <- scale(rosie[,c(159:161)]) 
              outliers_TAM_ICU <- colSums(abs(standardized_TAM_ICU)>=3, na.rm = T) 
              outliers_TAM_ICU
              #TAM_ICU_1 TAM_ICU_2 TAM_ICU_3 
              #0         5         0
              
              
              # >> TAM_ICU_1 = fairly summetrical (skew), fewer returns in its tail than normal (kurtosis), no outliers
              # >> TAM_ICU_2 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), 5 outliers
              # >> TAM_ICU_3 = moderately negatively skewed, fewer returns in its tail than normal (kurtosis), no outliers
          
          #Step 1: correlations
          #The function cor specifies a the correlation and round with the option 2 specifies that we want to round the numbers to the second digit.
          round(cor(rosie[,159:161]), 2) 
          #          TAM_ICU_1 TAM_ICU_2 TAM_ICU_3
          #TAM_ICU_1      1.00     -0.02      0.07
          #TAM_ICU_2     -0.02      1.00      0.58
          #TAM_ICU_3      0.07      0.58      1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,159:161]), 2) 
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
          
                #to gouble check this structure let's run an EFA
          
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
                      
                      #naming factors
                      # >> Factor 1 holding item 1 => parent only usage
                      # >> Factor 2 holding items 2 and 3 => child (co)usage
                      
                      #confirming this with a CFA is problematic because one factor is defined by just one item and, thus, the model will not be identified
                      #but this is reason enough to argue to only look at co-usage perhaps as the main level of our DV 
                      
              
       
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
                standardized_IL <- scale(rosie[,c(162:166)]) 
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
          round(cor(rosie[,162:166]),2) 
          #     IL_1 IL_2 IL_3 IL_4 IL_5
          #IL_1 1.00 0.56 0.69 0.53 0.44
          #IL_2 0.56 1.00 0.66 0.66 0.53
          #IL_3 0.69 0.66 1.00 0.56 0.50
          #IL_4 0.53 0.66 0.56 1.00 0.57
          #IL_5 0.44 0.53 0.50 0.57 1.00
          
          #Step 2: variance-covariance matrix
          round(cov(rosie[,162:166]),2) 
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
                
        
      
          ####----Extracting factors scores----####
            #Journal of Computer sin human Behaviour usually reports descriptives only on demographics and does not explicitly report anything on the extracted factor scores.
                
                #summary of all CFA models (from above)
                # onefac3items_TT
                # onefac3items_Child_Temp
                # twofac5items_Child_Parasocial
                # threefac2items_PMMS
                # onefac4items_TAM_PeoU
                # onefac4items_TAM_PU
                # onefac4items_TAM_E
                # onefac3items_TAM_SN
                # onefac3items_TAM_ICU
                # twofac5items_IL
                
                #predicting factor scores of all CFA models
                onefac3items_TTfitPredict <- as.data.frame(predict(onefac3items_TT))
                twofac5items_Child_ParasocialfitPredict <- as.data.frame(predict(twofac5items_Child_Parasocial))
                threefac2items_PMMSfitPredict <- as.data.frame(predict(threefac2items_PMMS)) 
                onefac4items_TAM_PeoUfitPredict <- as.data.frame(predict(onefac4items_TAM_PEoU))
                onefac4items_TAM_PUfitPredict <- as.data.frame(predict(onefac4items_TAM_PU))
                onefac4items_TAM_EfitPredict <- as.data.frame(predict(onefac4items_TAM_E))
                onefac3items_TAM_SNfitPredict <- as.data.frame(predict(onefac3items_TAM_SN))
                onefac3items_TAM_ICUfitPredict <- as.data.frame(predict(onefac3items_TAM_ICU))
                twofac5items_ILfitPredict <- as.data.frame(predict(twofac5items_IL))
                
                #adding to rosie-dataset
                rosie_fscores <- cbind(rosie, onefac3items_TTfitPredict, twofac5items_Child_ParasocialfitPredict,
                                       threefac2items_PMMSfitPredict, onefac4items_TAM_PeoUfitPredict, onefac4items_TAM_PUfitPredict,  onefac4items_TAM_EfitPredict,
                                       onefac3items_TAM_SNfitPredict, onefac3items_TAM_ICUfitPredict, twofac5items_ILfitPredict)
                View(rosie_fscores)
                
        
        ####----Reliability analysis----####
        #https://rpubs.com/hauselin/reliabilityanalysis
        #raw_alpha: Cronbach’s α (values ≥ .7 or .8 indicate good reliability; Kline (1999))
          
          #Dispositional: 
          
          #Q26 TT >> 3 items
          TT <- rosie[, c(167:169)]
          psych::alpha(TT) ### --> 0.77
          
          #Q32 Child_Parasocial >> 5 items
          Child_Parasocial <- rosie[, c(122:126)]
          psych::alpha(Child_Parasocial) ### --> 0.83
          
                #for each factor separately
                Parasocial_relationship <- rosie[, c(122, 125:126)]
                psych::alpha(Parasocial_relationship) ### --> 0.89
                
                Anthropomorphism <- rosie[, c(123:124)]
                psych::alpha(Anthropomorphism) ### --> 0.57
          
          #Developmental: NONE
          
          #Social: 
          
          #Q31 PMMS >> 6 items 
          PMMS <- rosie[, c(99:104)]
          psych::alpha(PMMS) ### --> 0.76
          
          #TAM: 
          
          #Q17 TAM_PEoU >> 4
          TAM_PEoU <- rosie[, c(143:146)]
          psych::alpha(TAM_PEoU) ### --> 0.87
          
          #Q18 TAM_PU >> 4
          TAM_PU <- rosie[, c(147:150)]
          psych::alpha(TAM_PU) ### --> 0.92
          
          #Q19 TAM_E >> 4
          TAM_E <- rosie[, c(151:154)]
          psych::alpha(TAM_E) ### --> 0.9
          
          #Q21 TAM_SN >> 3
          TAM_SN <- rosie[, c(156:158)]
          psych::alpha(TAM_SN) ### --> 0.87
          
          #Q22 TAM_ICU >> 3 
          TAM_ICU <- rosie[, c(159:161)]
          psych::alpha(TAM_ICU) ### --> 0.43
          
                #for each factor separately
                child_co_usage <- rosie[, c(160:161)]
                psych::alpha(child_co_usage) ### --> 0.72
                
                parent_only_usage <- rosie[, c(159)]
                psych::alpha(parent_only_usage) ### --> error because only 1 item in this factor
          
          #Q25 IL >> 5 items
          IL <- rosie[, c(162:166)]
          psych::alpha(IL) ### --> 0.86
          
                #for each factor separately
                Information <- rosie[, c(162, 164)]
                psych::alpha(Information) ### --> 0.82
                
                Navigation <- rosie[, c(163, 165:166)]
                psych::alpha(Navigation) ### --> 0.8

###----------------------------------------------------------------------------------------------------------------###   
                
#-----------------------------------------#
### DESCRIPTIVES ##########################
#-----------------------------------------#
                
   #taking a first numerical look
   summary(rosie)
   str(rosie)
                
   library(pastecs)
   stat.desc(rosie)
                
   library(psych)
   describe(rosie_fscores[c(93:104, 122:126, 143:178, 189:201)]) #without the last ICU_group because of their syntax error, otherwise describe function does not run
   #                                vars   n  mean    sd median trimmed   mad    min   max  range  skew kurtosis   se
   #Child_Nr                           1 183  2.36  0.55   2.00    2.28  0.00   2.00  5.00   3.00  1.45     2.18 0.04
   #Child_Age                          2 183  3.83  1.71   4.00    3.91  1.48   1.00  6.00   5.00 -0.20    -1.25 0.13
   #Child_Gender*                      3 183  1.55  0.50   2.00    1.56  0.00   1.00  2.00   1.00 -0.19    -1.98 0.04
   #Child_Temp_Extraversion            4 183  5.18  1.47   6.00    5.30  1.48   1.00  7.00   6.00 -0.62    -0.38 0.11
   #Child_Temp_Negative_Affectivity    5 183  3.30  1.76   3.00    3.21  1.48   1.00  7.00   6.00  0.29    -1.01 0.13
   #Child_Temp_Effortful_Control       6 183  4.78  1.62   5.00    4.90  1.48   1.00  7.00   6.00 -0.53    -0.39 0.12
   #PMMS_1                             7 183  2.93  0.78   3.00    2.99  0.00   1.00  4.00   3.00 -0.57     0.16 0.06
   #PMMS_2                             8 183  3.08  0.94   3.00    3.21  1.48   1.00  4.00   3.00 -0.80    -0.26 0.07
   #PMMS_3                             9 183  2.87  0.85   3.00    2.96  0.00   1.00  4.00   3.00 -0.66     0.00 0.06
   #PMMS_4                            10 183  3.26  0.72   3.00    3.36  0.00   1.00  4.00   3.00 -0.95     1.17 0.05
   #PMMS_5                            11 183  2.74  0.97   3.00    2.80  1.48   1.00  4.00   3.00 -0.41    -0.79 0.07
   #PMMS_6                            12 183  2.95  0.80   3.00    2.99  0.00   1.00  4.00   3.00 -0.49    -0.12 0.06
   #Child_Parasocial_1                13 183  1.92  1.18   1.00    1.73  0.00   1.00  5.00   4.00  1.00    -0.15 0.09
   #Child_Parasocial_2                14 183  3.24  1.22   3.00    3.30  1.48   1.00  5.00   4.00 -0.37    -0.72 0.09
   #Child_Parasocial_3                15 183  2.11  1.18   2.00    1.99  1.48   1.00  5.00   4.00  0.59    -1.00 0.09
   #Child_Parasocial_4                16 183  1.72  1.01   1.00    1.54  0.00   1.00  5.00   4.00  1.26     0.70 0.07
   #Child_Parasocial_5                17 183  1.77  1.07   1.00    1.56  0.00   1.00  5.00   4.00  1.23     0.44 0.08
   #TAM_PEoU_1                        18 183  5.20  1.30   5.00    5.34  1.48   1.00  7.00   6.00 -1.14     1.25 0.10
   #TAM_PEoU_2                        19 183  5.11  1.50   6.00    5.26  1.48   1.00  7.00   6.00 -0.88     0.02 0.11
   #TAM_PEoU_3                        20 183  5.36  1.37   6.00    5.54  1.48   1.00  7.00   6.00 -1.21     1.14 0.10
   #TAM_PEoU_4                        21 183  5.01  1.42   5.00    5.16  1.48   1.00  7.00   6.00 -1.01     0.54 0.11
   #TAM_PU_1                          22 183  4.16  1.57   4.00    4.24  1.48   1.00  7.00   6.00 -0.35    -0.59 0.12
   #TAM_PU_2                          23 183  3.88  1.57   4.00    3.95  1.48   1.00  7.00   6.00 -0.28    -0.68 0.12
   #TAM_PU_3                          24 183  4.32  1.61   5.00    4.46  1.48   1.00  7.00   6.00 -0.58    -0.47 0.12
   #TAM_PU_4                          25 183  4.76  1.44   5.00    4.86  1.48   1.00  7.00   6.00 -0.68     0.08 0.11
   #TAM_E_1                           26 183  5.07  1.38   5.00    5.20  1.48   1.00  7.00   6.00 -1.00     0.87 0.10
   #TAM_E_2                           27 183  5.14  1.34   5.00    5.28  1.48   1.00  7.00   6.00 -1.09     1.22 0.10
   #TAM_E_3                           28 183  5.26  1.35   5.00    5.41  1.48   1.00  7.00   6.00 -1.18     1.67 0.10
   #TAM_E_4                           29 183  4.50  1.48   5.00    4.63  1.48   1.00  7.00   6.00 -0.62    -0.09 0.11
   #TAM_IMG                           30 183  3.63  1.90   4.00    3.50  1.48   1.00  8.00   7.00  0.44    -0.35 0.14
   #TAM_SN_1                          31 183  2.69  1.64   2.00    2.50  1.48   1.00  7.00   6.00  0.60    -0.64 0.12
   #TAM_SN_2                          32 183  2.74  1.69   2.00    2.57  1.48   1.00  7.00   6.00  0.59    -0.83 0.13
   #TAM_SN_3                          33 183  3.21  1.82   3.00    3.10  2.97   1.00  7.00   6.00  0.27    -1.11 0.13
   #TAM_ICU_1                         34 183  3.40  1.72   3.00    3.33  1.48   1.00  7.00   6.00  0.36    -0.92 0.13
   #TAM_ICU_2                         35 183  5.30  1.37   6.00    5.46  1.48   1.00  7.00   6.00 -1.13     1.20 0.10
   #TAM_ICU_3                         36 183  4.44  1.78   5.00    4.56  1.48   1.00  7.00   6.00 -0.51    -0.84 0.13
   #IL_1                              37 183  2.19  1.39   2.00    1.93  1.48   1.00  7.00   6.00  1.50     1.88 0.10
   #IL_2                              38 183  2.03  1.30   2.00    1.78  1.48   1.00  7.00   6.00  1.49     1.82 0.10
   #IL_3                              39 183  2.25  1.38   2.00    2.03  1.48   1.00  7.00   6.00  1.29     1.10 0.10
   #IL_4                              40 183  2.49  1.76   2.00    2.23  1.48   1.00  7.00   6.00  1.03    -0.17 0.13
   #IL_5                              41 183  2.73  1.61   2.00    2.55  1.48   1.00  7.00   6.00  0.78    -0.37 0.12
   #TT_1                              42 183  4.21  1.47   4.00    4.26  1.48   1.00  7.00   6.00 -0.31    -0.64 0.11
   #TT_2                              43 183  4.77  1.41   5.00    4.83  1.48   1.00  7.00   6.00 -0.51    -0.17 0.10
   #TT_3                              44 183  4.91  1.22   5.00    5.00  1.48   1.00  7.00   6.00 -0.67     0.75 0.09
   #STATUS*                           45 183  1.00  0.00   1.00    1.00  0.00   1.00  1.00   0.00   NaN      NaN 0.00
   #PERSONEN                          46 183  3.78  1.04   4.00    3.85  0.00   1.00  6.00   5.00 -0.59     0.79 0.08
   #SOCIALEKLASSE2016*                47 183  2.07  1.24   2.00    1.92  1.48   1.00  5.00   4.00  0.92    -0.47 0.09
   #GSL                               48 183  1.51  0.50   2.00    1.51  0.00   1.00  2.00   1.00 -0.03    -2.01 0.04
   #LFT                               49 183 41.11  7.76  40.00   40.01  5.93  28.00 76.00  48.00  1.74     4.05 0.57
   #PE                                50 183  4.41  1.34   5.00    4.53  1.48   1.00  6.00   5.00 -0.51    -0.72 0.10
   #SHL                               51 183  3.78  1.35   4.00    3.77  1.48   1.20  6.00   4.80 -0.03    -1.10 0.10
   #ICU_togetherwithchild             52 183  3.34  1.45   4.00    3.35  1.48   1.00  6.00   5.00 -0.18    -0.90 0.11
   #ICU_childindividually             53 182  3.21  1.62   3.50    3.18  2.22   1.00  6.00   5.00 -0.07    -1.22 0.12
   #TT_f                              54 183  0.00  1.04   0.07    0.03  0.96  -3.09  2.03   5.12 -0.26    -0.35 0.08
   #anthropomorphism                  55 183  0.00  0.96  -0.52   -0.15  0.44  -0.81  3.21   4.02  1.14     0.56 0.07
   #parasocial_relationship           56 183  0.00  0.91  -0.18   -0.08  1.02  -1.03  2.62   3.65  0.60    -0.73 0.07
   #restrMed                          57 183  0.00  0.89   0.06    0.08  0.86  -2.59  1.29   3.88 -0.82     0.41 0.07
   #negacMed                          58 183  0.00  0.89   0.15    0.07  0.69  -2.38  1.42   3.80 -0.70     0.17 0.07
   #posacMed                          59 183  0.00  0.88  -0.08    0.07  0.90  -2.92  1.28   4.20 -0.80     1.15 0.06
   #TAM_PEoU_f                        60 183  0.00  0.96   0.18    0.11  0.69  -3.28  1.43   4.71 -1.16     1.35 0.07
   #TAM_PU_f                          61 183  0.00  0.97   0.05    0.06  1.02  -2.19  1.87   4.05 -0.42    -0.43 0.07
   #TAM_E_f                           62 183  0.00  0.97  -0.06    0.10  1.05  -3.15  1.47   4.62 -1.16     1.71 0.07
   #TAM_SN_f                          63 183  0.00  1.49  -0.12   -0.15  1.94  -1.66  4.04   5.70  0.57    -0.49 0.11
   #TAM_ICU_f                         64 183  0.00 26.88   9.03    2.92 18.51 -84.04 51.19 135.22 -1.01     0.67 1.99
   #navigation                        65 183  0.00  0.93  -0.21   -0.12  0.93  -0.98  3.64   4.62  1.12     0.91 0.07
   #information                       66 183  0.00  0.94  -0.19   -0.14  0.87  -0.96  3.67   4.63  1.18     0.97 0.07
                
                
   library(psych)
   psych::describeBy(rosie_fscores[c(93:104, 122:126, 143:178, 189:201)], group = "GSL")
   # 1 = male, 2 = female
                
   #more descriptives on the different DV-levels
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
                
   hist(rosie$TT_1) 
   hist(rosie$TT_2)
   hist(rosie$TT_3)
   hist(rosie_fscores$TT_f) #fairly normally distributed
                
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
   round(cor(rosie_fscores[,c(93, 171, 175, 200:201, 195:198, 155, 199, 176)]),2)
   #             Child_Nr PERSONEN    PE navigation information TAM_PEoU_f TAM_PU_f TAM_E_f TAM_SN_f TAM_IMG TAM_ICU_f   SHL
   # Child_Nr        1.00     0.06  0.06       0.07        0.09      -0.01     0.00   -0.08     0.02   -0.04     -0.01  0.01
   # PERSONEN        0.06     1.00  0.06      -0.11       -0.07       0.03     0.09    0.04    -0.08   -0.05     -0.06 -0.03
   # PE              0.06     0.06  1.00       0.03        0.04       0.32     0.43    0.44     0.09   -0.02      0.00  0.64
   # navigation      0.07    -0.11  0.03       1.00        0.93      -0.12     0.07   -0.01     0.27    0.10      0.14  0.11
   # information     0.09    -0.07  0.04       0.93        1.00      -0.07     0.10    0.03     0.25    0.08      0.16  0.11
   # TAM_PEoU_f     -0.01     0.03  0.32      -0.12       -0.07       1.00     0.44    0.63     0.15   -0.02      0.09  0.31
   # TAM_PU_f        0.00     0.09  0.43       0.07        0.10       0.44     1.00    0.58     0.40    0.21      0.11  0.32
   # TAM_E_f        -0.08     0.04  0.44      -0.01        0.03       0.63     0.58    1.00     0.25    0.05      0.02  0.40
   # TAM_SN_f        0.02    -0.08  0.09       0.27        0.25       0.15     0.40    0.25     1.00    0.26      0.07  0.21
   # TAM_IMG        -0.04    -0.05 -0.02       0.10        0.08      -0.02     0.21    0.05     0.26    1.00     -0.01  0.06
   # TAM_ICU_f      -0.01    -0.06  0.00       0.14        0.16       0.09     0.11    0.02     0.07   -0.01      1.00 -0.02
   # SHL             0.01    -0.03  0.64       0.11        0.11       0.31     0.32    0.40     0.21    0.06     -0.02  1.00
   
         #pairwise correlations all in one scatterplot matrix
         library(car)
         scatterplotMatrix(~Child_Nr+PERSONEN+PE+navigation+information+TAM_PEoU_f+TAM_PU_f+TAM_E_f+TAM_SN_f+TAM_IMG+TAM_ICU_f+SHL, data = rosie_fscores)
         
         #for better visual overivew 
         library(devtools)
         devtools::install_github("laresbernardo/lares")
         library(lares)

         corr_cross(rosie_fscores[,c(93, 171, 175, 200:201, 195:198, 155, 199, 176)], # name of dataset
                    max_pvalue = 0.05, # display only significant correlations (at 5% level)
                    top = 20 # display top 10 couples of variables (by correlation coefficient)
         )
         
   #descriptives
   summary(rosie_fscores)
   describe(rosie_fscores)
   #                               vars   n    mean      sd  median trimmed     mad    min     max   range  skew kurtosis     se
   #TT_f                             189 183    0.00    1.04    0.07    0.03    0.96  -3.09    2.03    5.12 -0.26    -0.35   0.08
   #anthropomorphism                 190 183    0.00    0.96   -0.52   -0.15    0.44  -0.81    3.21    4.02  1.14     0.56   0.07
   #parasocial_relationship          191 183    0.00    0.91   -0.18   -0.08    1.02  -1.03    2.62    3.65  0.60    -0.73   0.07
   #restrMed                         192 183    0.00    0.89    0.06    0.08    0.86  -2.59    1.29    3.88 -0.82     0.41   0.07
   #negacMed                         193 183    0.00    0.89    0.15    0.07    0.69  -2.38    1.42    3.80 -0.70     0.17   0.07
   #posacMed                         194 183    0.00    0.88   -0.08    0.07    0.90  -2.92    1.28    4.20 -0.80     1.15   0.06
   #TAM_PEoU_f                       195 183    0.00    0.96    0.18    0.11    0.69  -3.28    1.43    4.71 -1.16     1.35   0.07
   #TAM_PU_f                         196 183    0.00    0.97    0.05    0.06    1.02  -2.19    1.87    4.05 -0.42    -0.43   0.07
   #TAM_E_f                          197 183    0.00    0.97   -0.06    0.10    1.05  -3.15    1.47    4.62 -1.16     1.71   0.07
   #TAM_SN_f                         198 183    0.00    1.49   -0.12   -0.15    1.94  -1.66    4.04    5.70  0.57    -0.49   0.11
   #TAM_ICU_f                        199 183    0.00   26.88    9.03    2.92   18.51 -84.04   51.19  135.22 -1.01     0.67   1.99
   #navigation                       200 183    0.00    0.93   -0.21   -0.12    0.93  -0.98    3.64    4.62  1.12     0.91   0.07
   #information                      201 183    0.00    0.94   -0.19   -0.14    0.87  -0.96    3.67    4.63  1.18     0.97   0.07
   
   
###----------------------------------------------------------------------------------------------------------------###
    
#----------------------------------------------#
### KNOWING YOUR DATA ##########################
#----------------------------------------------#

          
#--------------------------------------------------------------------------------#   
  #Check multivariate assumptions prior to analysis
   #multivariate normality
   #multivariate ouliers
#--------------------------------------------------------------------------------# 
          
  #check multivariate normality
  ??pathex
  pathex_multinorm <- pathex[complete.cases(pathex),]
          
  #check univariate distributions, multivariate normality and identify multivariate outliers
  #MVpathex <- mvn(pathex_comp[, c(5,8,11:13)] mvnTest = “mardia”, multivariatePlot = “qq”, multivariateOutlierMethod = “adj”, showOutliers = T, showNewData = T)
  #library(gdtools)
  #library(MVN)
  #mvn(rosie, subset = c(96:104, 122:126, 143:169, 175:176), mvnTest = c("mardia"), covariance = TRUE, tol = 1e-25, alpha = 0.5,
  #            scale = FALSE, desc = TRUE, transform = "none", R = 1000,
  #            univariateTest = c("SW"),
  #            univariatePlot = "qq", multivariatePlot = "qq",
  #            multivariateOutlierMethod = "adj", showOutliers = FALSE, showNewData = FALSE)
  #this syntax takes super long and crashes all the time without giving me an error, so I do not know if I did something wrong here
          
   #therefore, I alternatively run a multivariate normality test using the package QuantPsyc's multi.norm function:
   library(QuantPsyc)
   #for rosie dataset
   mult.norm(rosie[c(96:104, 122:126, 143:169, 175:176)])$mult.test
   #Beta-hat        kappa                   p-val
   #Skewness  549.0508 16746.048561 0.000000000000000000000
   #Kurtosis 2008.0810     7.945926 0.000000000000001998401
   
   #for rosie dataset including extracted factor scores
   mult.norm(rosie_fscores[c(189:201, 155, 96:98, 175:176)])$mult.test 
   # Beta-hat       kappa       p-val
   # Skewness  59.46034 1813.540425 0.000000000
   # Kurtosis 412.27424    3.178366 0.001481078

   # >> Since both p-values are waaaay less than .05, we reject the null hypothesis of the test. We have evidence to say that the variables in our dataset do not follow a multivariate distribution.
   # >> Together with the non-normality detected earlier, we will run our main analyses using bottstrapping
   
###----------------------------------------------------------------------------------------------------------------###   
   
#--------------------------------------------------------------------#
### LATENT PROFILE/CLASS ANALYSIS VERSION 1 ##########################
#--------------------------------------------------------------------#

   #along preregistered DSMM using original scales  
   
   #Which variables should go in the LCA? >> All individual characteristics! Those are:
   
         #Dispositional: 
         # TT >> 3 items
         # Child_Temp_Extraversion
         # Child_Temp_Negative_Affectivity
         # Child_Temp_Effortful_Control 
         # Child_Parasocial >> 5 items
         # SOCIALEKLASSE2016
         
         #Developmental: 
         # Child_Age
         # Child-Gender
         # LFT
         # GSL
         
         #Social: 
         # PMMS >> 6 items
  

   library(poLCA) # >> only allows categorical indicators, so we convert all continuous variables into categorical ones
   
         #Dispositional: 
         # TT >> 3 items one factor >> median split method because of fairly normal distribution 
         # Child_Temp_Extraversion >> since conceptually everything < 0 is a more or less clear "no", change into:-3 - -1 = no and 0- 3 = yes, which means 1-3 = 1 and 4-7 = 2
         #Q Child_Temp_Negative_Affectivity >> since conceptually everything < 0 is a more or less clear "no", change into:-3 - -1 = no and 0- 3 = yes, which means 1-3 = 1 and 4-7 = 2
         # Child_Temp_Effortful_Control >> since conceptually everything < 0 is a more or less clear "no", change into:-3 - -1 = no and 0- 3 = yes, which means 1-3 = 1 and 4-7 = 2
         # Child_Parasocial >> 5 items two factors >> anthropomorphism & parasocial_relationship >> since distributions show that answer options 1+2 as well as 3+4+5 group together: 1-2 = 1, 3-5 = 2
         # SOCIALEKLASSE2016 >> ALREADY CATEGORICAL
         
         #Developmental: 
         # Child_Age >> agre group "pre-schoolers 3-5 years, age group "schoolkids" 6-8 years, which means 1-3 = 1 and 4-6 = 2
         # Child-Gender >> ALREADY CATEGORICAL
         # LFT >> mean-split
         # GSL >> ALREADY CATEGORICAL
         
         #Social: 
         # PMMS >> 6 items three factors >> restsMed & negacMed & posacMed >> since distributions show that answer options 1+2 group together: 1-2 = 1 (nooit), 3 = 2 (soms), 4 = 3 (vaak)
   
   
   #artificial categorization
   # - TT
   rosie_fscores$TT_1_factor[rosie_fscores$TT_1<=median(rosie_fscores$TT_1)] = 1
   rosie_fscores$TT_1_factor[rosie_fscores$TT_1>median(rosie_fscores$TT_1)] = 2
   
   rosie_fscores$TT_2_factor[rosie_fscores$TT_2<=median(rosie_fscores$TT_2)] = 1
   rosie_fscores$TT_2_factor[rosie_fscores$TT_2>median(rosie_fscores$TT_2)] = 2
   
   rosie_fscores$TT_3_factor[rosie_fscores$TT_3<=median(rosie_fscores$TT_3)] = 1
   rosie_fscores$TT_3_factor[rosie_fscores$TT_3>median(rosie_fscores$TT_3)] = 2
   
   rosie_fscores$TT_total_LCA_factor[rosie_fscores$TT_1_factor==1 & rosie_fscores$TT_2_factor==1 & rosie_fscores$TT_3_factor==1] = 1
   rosie_fscores$TT_total_LCA_factor[rosie_fscores$TT_1_factor==2 & rosie_fscores$TT_2_factor==2 & rosie_fscores$TT_3_factor==2] = 2
   rosie_fscores$TT_total_LCA_factor[rosie_fscores$TT_1_factor==2 & rosie_fscores$TT_2_factor==1 & rosie_fscores$TT_3_factor==2] = 3
   rosie_fscores$TT_total_LCA_factor[rosie_fscores$TT_1_factor==2 & rosie_fscores$TT_2_factor==2 & rosie_fscores$TT_3_factor==1] = 4
   rosie_fscores$TT_total_LCA_factor[rosie_fscores$TT_1_factor==2 & rosie_fscores$TT_2_factor==1 & rosie_fscores$TT_3_factor==1] = 5
   rosie_fscores$TT_total_LCA_factor[rosie_fscores$TT_1_factor==1 & rosie_fscores$TT_2_factor==2 & rosie_fscores$TT_3_factor==2] = 6
   rosie_fscores$TT_total_LCA_factor[rosie_fscores$TT_1_factor==1 & rosie_fscores$TT_2_factor==1 & rosie_fscores$TT_3_factor==2] = 7
   rosie_fscores$TT_total_LCA_factor[rosie_fscores$TT_1_factor==1 & rosie_fscores$TT_2_factor==2 & rosie_fscores$TT_3_factor==1] = 8
   
   View(rosie_fscores$TT_total_LCA_factor)
   View(rosie_fscores)


   # - Child_Temp
   rosie_fscores$Temp_Extraversion_factor[rosie$Child_Temp_Extraversion<=3] = 1
   rosie_fscores$Temp_Extraversion_factor[rosie$Child_Temp_Extraversion>=4] = 2
   
   rosie_fscores$Temp_Negative_Affectivity_factor[rosie_fscores$Child_Temp_Negative_Affectivity<=3] = 1
   rosie_fscores$Temp_Negative_Affectivity_factor[rosie_fscores$Child_Temp_Negative_Affectivity>=4] = 2
   
   rosie_fscores$Temp_Effortful_Control_factor[rosie_fscores$Child_Temp_Effortful_Control<=3] = 1
   rosie_fscores$Temp_Effortful_Control_factor[rosie_fscores$Child_Temp_Effortful_Control>=4] = 2
   
   # - Child_Parasocial
   #anthropomorphism
   rosie_fscores$Child_Parasocial_1_factor[rosie_fscores$Child_Parasocial_1<=2] = 1
   rosie_fscores$Child_Parasocial_1_factor[rosie_fscores$Child_Parasocial_1>=3] = 2
   
   rosie_fscores$Child_Parasocial_4_factor[rosie_fscores$Child_Parasocial_4<=2] = 1
   rosie_fscores$Child_Parasocial_4_factor[rosie_fscores$Child_Parasocial_4>=3] = 2
   
   rosie_fscores$Child_Parasocial_5_factor[rosie_fscores$Child_Parasocial_5<=2] = 1
   rosie_fscores$Child_Parasocial_5_factor[rosie_fscores$Child_Parasocial_5>=3] = 2
   
   rosie_fscores$Para_anthropomorphism_total_LCA_factor[rosie_fscores$Child_Parasocial_1_factor==1 & rosie_fscores$Child_Parasocial_4_factor==1 & rosie_fscores$Child_Parasocial_5_factor==1] = 1
   rosie_fscores$Para_anthropomorphism_total_LCA_factor[rosie_fscores$Child_Parasocial_1_factor==2 & rosie_fscores$Child_Parasocial_4_factor==2 & rosie_fscores$Child_Parasocial_5_factor==2] = 2
   rosie_fscores$Para_anthropomorphism_total_LCA_factor[rosie_fscores$Child_Parasocial_1_factor==2 & rosie_fscores$Child_Parasocial_4_factor==1 & rosie_fscores$Child_Parasocial_5_factor==2] = 3
   rosie_fscores$Para_anthropomorphism_total_LCA_factor[rosie_fscores$Child_Parasocial_1_factor==2 & rosie_fscores$Child_Parasocial_4_factor==2 & rosie_fscores$Child_Parasocial_5_factor==1] = 4
   rosie_fscores$Para_anthropomorphism_total_LCA_factor[rosie_fscores$Child_Parasocial_1_factor==2 & rosie_fscores$Child_Parasocial_4_factor==1 & rosie_fscores$Child_Parasocial_5_factor==1] = 5
   rosie_fscores$Para_anthropomorphism_total_LCA_factor[rosie_fscores$Child_Parasocial_1_factor==1 & rosie_fscores$Child_Parasocial_4_factor==2 & rosie_fscores$Child_Parasocial_5_factor==2] = 6
   rosie_fscores$Para_anthropomorphism_total_LCA_factor[rosie_fscores$Child_Parasocial_1_factor==1 & rosie_fscores$Child_Parasocial_4_factor==1 & rosie_fscores$Child_Parasocial_5_factor==2] = 7
   rosie_fscores$Para_anthropomorphism_total_LCA_factor[rosie_fscores$Child_Parasocial_1_factor==1 & rosie_fscores$Child_Parasocial_4_factor==2 & rosie_fscores$Child_Parasocial_5_factor==1] = 8
   
   View(rosie_fscores$Para_anthropomorphism_total_LCA_factor)
   
   #parasocial relationship
   rosie_fscores$Child_Parasocial_2_factor[rosie_fscores$Child_Parasocial_2<=2] = 1
   rosie_fscores$Child_Parasocial_2_factor[rosie_fscores$Child_Parasocial_2>=3] = 2
   
   rosie_fscores$Child_Parasocial_3_factor[rosie_fscores$Child_Parasocial_3<=2] = 1
   rosie_fscores$Child_Parasocial_3_factor[rosie_fscores$Child_Parasocial_3>=3] = 2
   
   rosie_fscores$Para_parasocialrelationship_total_LCA_factor[rosie_fscores$Child_Parasocial_2_factor==1 & rosie_fscores$Child_Parasocial_3_factor==1] = 1
   rosie_fscores$Para_parasocialrelationship_total_LCA_factor[rosie_fscores$Child_Parasocial_2_factor==2 & rosie_fscores$Child_Parasocial_3_factor==2] = 2
   rosie_fscores$Para_parasocialrelationship_total_LCA_factor[rosie_fscores$Child_Parasocial_2_factor==1 & rosie_fscores$Child_Parasocial_3_factor==2] = 3
   rosie_fscores$Para_parasocialrelationship_total_LCA_factor[rosie_fscores$Child_Parasocial_2_factor==2 & rosie_fscores$Child_Parasocial_3_factor==1] = 4
   
   View(rosie_fscores$Para_parasocialrelationship_total_LCA_factor)
   View(rosie_fscores)

   
   # - Child_Age
   rosie_fscores$Child_Age_factor[rosie_fscores$Child_Age<=3] = 1 
   rosie_fscores$Child_Age_factor[rosie_fscores$Child_Age>=4] = 2
   
   # - LFT
   rosie_fscores$LFT_factor[rosie_fscores$LFT<=mean(rosie$LFT)] = 1
   rosie_fscores$LFT_factor[rosie_fscores$LFT>mean(rosie$LFT)] = 2
   
   # - PMMS
   #restrMed
   rosie_fscores$PMMS_1_factor[rosie_fscores$PMMS_1<=2] = 1
   rosie_fscores$PMMS_1_factor[rosie_fscores$PMMS_1==3] = 2
   rosie_fscores$PMMS_1_factor[rosie_fscores$PMMS_1==4] = 3
   
   rosie_fscores$PMMS_2_factor[rosie_fscores$PMMS_2<=2] = 1
   rosie_fscores$PMMS_2_factor[rosie_fscores$PMMS_2==3] = 2
   rosie_fscores$PMMS_2_factor[rosie_fscores$PMMS_2==4] = 3
   
   rosie_fscores$PMMS_restrMed_total_LCA_factor[rosie_fscores$PMMS_1_factor==1 & rosie_fscores$PMMS_2_factor==1] = 1
   rosie_fscores$PMMS_restrMed_total_LCA_factor[rosie_fscores$PMMS_1_factor==2 & rosie_fscores$PMMS_2_factor==2] = 2
   rosie_fscores$PMMS_restrMed_total_LCA_factor[rosie_fscores$PMMS_1_factor==3 & rosie_fscores$PMMS_2_factor==3] = 3
   rosie_fscores$PMMS_restrMed_total_LCA_factor[rosie_fscores$PMMS_1_factor==1 & rosie_fscores$PMMS_2_factor==2] = 4
   rosie_fscores$PMMS_restrMed_total_LCA_factor[rosie_fscores$PMMS_1_factor==2 & rosie_fscores$PMMS_2_factor==1] = 5
   rosie_fscores$PMMS_restrMed_total_LCA_factor[rosie_fscores$PMMS_1_factor==1 & rosie_fscores$PMMS_2_factor==3] = 6
   rosie_fscores$PMMS_restrMed_total_LCA_factor[rosie_fscores$PMMS_1_factor==3 & rosie_fscores$PMMS_2_factor==1] = 7
   rosie_fscores$PMMS_restrMed_total_LCA_factor[rosie_fscores$PMMS_1_factor==2 & rosie_fscores$PMMS_2_factor==3] = 8
   rosie_fscores$PMMS_restrMed_total_LCA_factor[rosie_fscores$PMMS_1_factor==3 & rosie_fscores$PMMS_2_factor==2] = 9

   View(rosie_fscores$PMMS_restrMed_total_LCA_factor)
   
   #negacMed
   rosie_fscores$PMMS_3_factor[rosie_fscores$PMMS_3<=2] = 1
   rosie_fscores$PMMS_3_factor[rosie_fscores$PMMS_3==3] = 2
   rosie_fscores$PMMS_3_factor[rosie_fscores$PMMS_3==4] = 3
   
   rosie_fscores$PMMS_5_factor[rosie_fscores$PMMS_5<=2] = 1
   rosie_fscores$PMMS_5_factor[rosie_fscores$PMMS_5==3] = 2
   rosie_fscores$PMMS_5_factor[rosie_fscores$PMMS_5==4] = 3
   
   rosie_fscores$PMMS_negacMed_total_LCA_factor[rosie_fscores$PMMS_3_factor==1 & rosie_fscores$PMMS_5_factor==1] = 1
   rosie_fscores$PMMS_negacMed_total_LCA_factor[rosie_fscores$PMMS_3_factor==2 & rosie_fscores$PMMS_5_factor==2] = 2
   rosie_fscores$PMMS_negacMed_total_LCA_factor[rosie_fscores$PMMS_3_factor==3 & rosie_fscores$PMMS_5_factor==3] = 3
   rosie_fscores$PMMS_negacMed_total_LCA_factor[rosie_fscores$PMMS_3_factor==1 & rosie_fscores$PMMS_5_factor==2] = 4
   rosie_fscores$PMMS_negacMed_total_LCA_factor[rosie_fscores$PMMS_3_factor==2 & rosie_fscores$PMMS_5_factor==1] = 5
   rosie_fscores$PMMS_negacMed_total_LCA_factor[rosie_fscores$PMMS_3_factor==1 & rosie_fscores$PMMS_5_factor==3] = 6
   rosie_fscores$PMMS_negacMed_total_LCA_factor[rosie_fscores$PMMS_3_factor==3 & rosie_fscores$PMMS_5_factor==1] = 7
   rosie_fscores$PMMS_negacMed_total_LCA_factor[rosie_fscores$PMMS_3_factor==2 & rosie_fscores$PMMS_5_factor==3] = 8
   rosie_fscores$PMMS_negacMed_total_LCA_factor[rosie_fscores$PMMS_3_factor==3 & rosie_fscores$PMMS_5_factor==2] = 9
   
   View(rosie_fscores$PMMS_negacMed_total_LCA_factor)
   
   #posacMed
   rosie_fscores$PMMS_4_factor[rosie_fscores$PMMS_4<=2] = 1
   rosie_fscores$PMMS_4_factor[rosie_fscores$PMMS_4==3] = 2
   rosie_fscores$PMMS_4_factor[rosie_fscores$PMMS_4==4] = 3
   
   rosie_fscores$PMMS_6_factor[rosie_fscores$PMMS_6<=2] = 1
   rosie_fscores$PMMS_6_factor[rosie_fscores$PMMS_6==3] = 2
   rosie_fscores$PMMS_6_factor[rosie_fscores$PMMS_6==4] = 3
   
   rosie_fscores$PMMS_posacMed_total_LCA_factor[rosie_fscores$PMMS_4_factor==1 & rosie_fscores$PMMS_6_factor==1] = 1
   rosie_fscores$PMMS_posacMed_total_LCA_factor[rosie_fscores$PMMS_4_factor==2 & rosie_fscores$PMMS_6_factor==2] = 2
   rosie_fscores$PMMS_posacMed_total_LCA_factor[rosie_fscores$PMMS_4_factor==3 & rosie_fscores$PMMS_6_factor==3] = 3
   rosie_fscores$PMMS_posacMed_total_LCA_factor[rosie_fscores$PMMS_4_factor==1 & rosie_fscores$PMMS_6_factor==2] = 4
   rosie_fscores$PMMS_posacMed_total_LCA_factor[rosie_fscores$PMMS_4_factor==2 & rosie_fscores$PMMS_6_factor==1] = 5
   rosie_fscores$PMMS_posacMed_total_LCA_factor[rosie_fscores$PMMS_4_factor==1 & rosie_fscores$PMMS_6_factor==3] = 6
   rosie_fscores$PMMS_posacMed_total_LCA_factor[rosie_fscores$PMMS_4_factor==3 & rosie_fscores$PMMS_6_factor==1] = 7
   rosie_fscores$PMMS_posacMed_total_LCA_factor[rosie_fscores$PMMS_4_factor==2 & rosie_fscores$PMMS_6_factor==3] = 8
   rosie_fscores$PMMS_posacMed_total_LCA_factor[rosie_fscores$PMMS_4_factor==3 & rosie_fscores$PMMS_6_factor==2] = 9
   
   View(rosie_fscores$PMMS_posacMed_total_LCA_factor)
   
   View(rosie_fscores)
   

   #LCA
   LCAmodel_v1 <- cbind(TT_total_LCA_factor,
                     Temp_Extraversion_factor, Temp_Negative_Affectivity_factor, Temp_Effortful_Control_factor, 
                     Para_anthropomorphism_total_LCA_factor, Para_parasocialrelationship_total_LCA_factor,
                     SOCIALEKLASSE2016,
                     Child_Age_factor, 
                     Child_Gender, 
                     LFT_factor, 
                     GSL, 
                     PMMS_restrMed_total_LCA_factor, PMMS_negacMed_total_LCA_factor, PMMS_posacMed_total_LCA_factor)~1
   
   Mv1_2class <- poLCA(LCAmodel_v1, data=rosie_fscores, nclass=2, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
   # Estimated class population shares 
   # 0.5509 0.4491 
   # 
   # Predicted class memberships (by modal posterior prob.) 
   # 0.5628 0.4372 
   # 
   # ====================== 2-class results =================================== 
   #   Fit for 2 latent classes: 
   #
   #   number of observations: 183 
   # number of estimated parameters: 105 
   # residual degrees of freedom: 78 
   # maximum log-likelihood: -2710.811 
   # 
   # AIC(2): 5631.622
   # BIC(2): 5968.618
   # G^2(2): 3514.95 (Likelihood ratio/deviance statistic) 
   # X^2(2): 78508072 (Chi-square goodness of fit) 
   
   Mv1_3class <- poLCA(LCAmodel_v1, data=rosie_fscores, nclass=3, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
   # Estimated class population shares 
   # 0.1302 0.5681 0.3017 
   # 
   # Predicted class memberships (by modal posterior prob.) 
   # 0.1311 0.5683 0.3005 
   # 
   # ======================== 3-class results ================================= 
   #   Fit for 3 latent classes: 
   #   
   #   number of observations: 183 
   # number of estimated parameters: 158 
   # residual degrees of freedom: 25 
   # maximum log-likelihood: -2644.919 
   # 
   # AIC(3): 5605.837
   # BIC(3): 6112.936
   # G^2(3): 3383.165 (Likelihood ratio/deviance statistic) 
   # X^2(3): 34019945 (Chi-square goodness of fit) 
   
   Mv1_4class <- poLCA(LCAmodel_v1, data=rosie_fscores, nclass=4, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE) 
   # ======================== 4-class results =================================
   # ALERT: number of parameters estimated ( 211 ) exceeds number of observations ( 183 ) 
   # 
   # ALERT: negative degrees of freedom; respecify model 
   
   
   # https://statistics.ohlsen-web.de/latent-class-analysis-polca/
   #Since we do not have a solid theoretical assumption of the number of unobserved subpopulations (aka family types)
   #we take an exploratory approach and compare multiple models (2-4 classes) against each other. 
   #If choosing this approach, one can decide to take the model that has the most plausible interpretation. 
   #Additionally one could compare the different solutions by BIC or AIC information criteria. 
   #BIC is preferred over AIC in latent class models, but usually both are used. 
   #A smaller BIC is better than a bigger BIC. 
   #Next to AIC and BIC one also gets a Chi-Square goodness of fit, which one can compare.
   
   #>> 2-class model seems to have the best fit, since BIC is smaller  
   
   #in order to transfer the LCA-results into SEM, we need to assign each parent to the respective class, for that we...
   #...extract 2-class solution and save in twoclass object (https://osf.io/vec6s/)
   set.seed(123)
   ?set.seed
   twoclass_v1 <- poLCA(LCAmodel_v1, data=rosie_fscores, nclass=2, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
   
   #...output predicted classes from selected model so that we can use it in subsequent analyses:
   rosie_fscores$classv1 <- twoclass_v1$predclass
   
   #...declare the class variable as a factor
   rosie_fscores$classv1 <-  as.factor(rosie_fscores$classv1)
   is.factor(rosie_fscores$classv1)
   
   View(rosie_fscores)
   
   #...name the levels of the class factor using the response probabilities plot
   levels(rosie_fscores$classv1)[levels(rosie_fscores$classv1)=="1"] <- "XXX"
   levels(rosie_fscores$classv1)[levels(rosie_fscores$classv1)=="2"] <- "YYY"
   
   
   #--------------------------------------------------------------------#
   ### LATENT PROFILE/CLASS ANALYSIS VERSION 1 ##########################
   #--------------------------------------------------------------------#
   
   #along preregistered DSMM using factor scores where available  
   
   #Which variables should go in the LCA? >> All individual characteristics! Those are:
   
   #Dispositional: 
   # TT >> 3 items
   # Child_Temp_Extraversion
   # Child_Temp_Negative_Affectivity
   # Child_Temp_Effortful_Control 
   # Child_Parasocial >> 5 items
   # SOCIALEKLASSE2016
   
   #Developmental: 
   # Child_Age
   # Child-Gender
   # LFT
   # GSL
   
   #Social: 
   # PMMS >> 6 items
   
   
   library(poLCA) # >> only allows categorical indicators, so we convert all continuous variables into categorical ones
   
   #Dispositional: 
   # TT >> 3 items one factor >> median split method because of fairly normal distribution 
   # Child_Temp_Extraversion >> since conceptually everything < 0 is a more or less clear "no", change into:-3 - -1 = no and 0- 3 = yes, which means 1-3 = 1 and 4-7 = 2
   # Child_Temp_Negative_Affectivity >> since conceptually everything < 0 is a more or less clear "no", change into:-3 - -1 = no and 0- 3 = yes, which means 1-3 = 1 and 4-7 = 2
   # Child_Temp_Effortful_Control >> since conceptually everything < 0 is a more or less clear "no", change into:-3 - -1 = no and 0- 3 = yes, which means 1-3 = 1 and 4-7 = 2
   # Child_Parasocial >> 5 items two factors >> anthropomorphism & parasocial_relationship >> since distributions show that answer options 1+2 as well as 3+4+5 group together: 1-2 = 1, 3-5 = 2 >> translating groups of 1-2 = 1, 3-5 = 2 into factor scores
   # SOCIALEKLASSE2016 >> ALREADY CATEGORICAL
   
   #Developmental: 
   # Child_Age >> agre group "pre-schoolers 3-5 years, age group "schoolkids" 6-8 years, which means 1-3 = 1 and 4-6 = 2
   # Child-Gender >> ALREADY CATEGORICAL
   # LFT >> mean-split
   # GSL >> ALREADY CATEGORICAL
   
   #Social: 
   # PMMS >> 6 items three factors >> restsMed & negacMed & posacMed >> since distributions show that answer options 1+2 group together: 1-2 = 1 (nooit), 3 = 2 (soms), 4 = 3 (vaak) >> translating groups of into factor scores
   
   #artificial categorization
   # - TT
   rosie_fscores$TT_f_factor[rosie_fscores$TT_f<=median(rosie_fscores$TT_f)] = 1
   rosie_fscores$TT_f_factor[rosie_fscores$TT_f>median(rosie_fscores$TT_f)] = 2
   
   # - Child_Temp
   rosie_fscores$Temp_Extraversion_factor[rosie$Child_Temp_Extraversion<=3] = 1
   rosie_fscores$Temp_Extraversion_factor[rosie$Child_Temp_Extraversion>=4] = 2
   
   rosie_fscores$Temp_Negative_Affectivity_factor[rosie_fscores$Child_Temp_Negative_Affectivity<=3] = 1
   rosie_fscores$Temp_Negative_Affectivity_factor[rosie_fscores$Child_Temp_Negative_Affectivity>=4] = 2
   
   rosie_fscores$Temp_Effortful_Control_factor[rosie_fscores$Child_Temp_Effortful_Control<=3] = 1
   rosie_fscores$Temp_Effortful_Control_factor[rosie_fscores$Child_Temp_Effortful_Control>=4] = 2
   
   # - Child_Parasocial
   rosie_fscores$anthropomorphism_factor[rosie_fscores$anthropomorphism<=0] = 1
   rosie_fscores$anthropomorphism_factor[rosie_fscores$anthropomorphism>0] = 2
   
   rosie_fscores$parasocial_relationship_factor[rosie_fscores$parasocial_relationship<=0] = 1
   rosie_fscores$parasocial_relationship_factor[rosie_fscores$parasocial_relationship>0] = 2
   
   # - Child_Age
   rosie_fscores$Child_Age_factor[rosie_fscores$Child_Age<=3] = 1 
   rosie_fscores$Child_Age_factor[rosie_fscores$Child_Age>=4] = 2
   
   # - LFT
   rosie_fscores$LFT_factor[rosie_fscores$LFT<=mean(rosie$LFT)] = 1
   rosie_fscores$LFT_factor[rosie_fscores$LFT>mean(rosie$LFT)] = 2
   
   # - PMMS
   #restrMed
   rosie_fscores$restrMed_factor[rosie_fscores$restrMed<(-1)] = 1
   rosie_fscores$restrMed_factor[rosie_fscores$restrMed>=(-1) & rosie_fscores$restrMed<=0] = 2
   rosie_fscores$restrMed_factor[rosie_fscores$restrMed>0] = 3
   
   View(rosie_fscores$restrMed_factor)
   
   #negacMed
   rosie_fscores$negacMed_factor[rosie_fscores$negacMed<(-1)] = 1
   rosie_fscores$negacMed_factor[rosie_fscores$negacMed>=(-1) & rosie_fscores$negacMed<=0] = 2
   rosie_fscores$negacMed_factor[rosie_fscores$negacMed>0] = 3
   
   View(rosie_fscores$negacMed_factor)
   
   #posacMed
   rosie_fscores$posacMed_factor[rosie_fscores$posacMed<(-1)] = 1
   rosie_fscores$posacMed_factor[rosie_fscores$posacMed>=(-1) & rosie_fscores$posacMed<=0] = 2
   rosie_fscores$posacMed_factor[rosie_fscores$posacMed>0] = 3
   
   View(rosie_fscores$posacMed_factor)
   
   View(rosie_fscores)
   
   
   #LCA
   LCAmodel_v2 <- cbind(TT_f_factor,
                     Temp_Extraversion_factor, Temp_Negative_Affectivity_factor, Temp_Effortful_Control_factor, 
                     anthropomorphism_factor, parasocial_relationship_factor,
                     SOCIALEKLASSE2016,
                     Child_Age_factor, 
                     Child_Gender, 
                     LFT_factor, 
                     GSL, 
                     restrMed_factor, negacMed_factor, posacMed_factor)~1
   
   Mv2_2class <- poLCA(LCAmodel_v2, data=rosie_fscores, nclass=2, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
   # Estimated class population shares 
   # 0.3761 0.6239 
   # 
   # Predicted class memberships (by modal posterior prob.) 
   # 0.3825 0.6175 
   # 
   # ======================= 2-class results ================================== 
   #   Fit for 2 latent classes: 
   # 
   #   number of observations: 183 
   # number of estimated parameters: 41 
   # residual degrees of freedom: 142 
   # maximum log-likelihood: -1856.486 
   # 
   # AIC(2): 3794.972
   # BIC(2): 3926.561
   # G^2(2): 1811.845 (Likelihood ratio/deviance statistic) 
   # X^2(2): 158757.2 (Chi-square goodness of fit) 
   
   Mv2_3class <- poLCA(LCAmodel_v2, data=rosie_fscores, nclass=3, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
   # Estimated class population shares 
   # 0.3232 0.3038 0.373 
   # 
   # Predicted class memberships (by modal posterior prob.) 
   # 0.3279 0.3115 0.3607 
   # 
   # ======================= 3-class results ================================== 
   #   Fit for 3 latent classes: 
   #  
   #   number of observations: 183 
   # number of estimated parameters: 62 
   # residual degrees of freedom: 121 
   # maximum log-likelihood: -1814.724 
   # 
   # AIC(3): 3753.448
   # BIC(3): 3952.436
   # G^2(3): 1728.321 (Likelihood ratio/deviance statistic) 
   # X^2(3): 193232.4 (Chi-square goodness of fit)
   
   Mv2_4class <- poLCA(LCAmodel_v2, data=rosie_fscores, nclass=4, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
   # Estimated class population shares 
   # 0.2493 0.2783 0.2258 0.2466 
   # 
   # Predicted class memberships (by modal posterior prob.) 
   # 0.2404 0.2678 0.2459 0.2459 
   # 
   # ======================== 4-class results ================================= 
   #   Fit for 4 latent classes: 
   #
   #   number of observations: 183 
   # number of estimated parameters: 83 
   # residual degrees of freedom: 100 
   # maximum log-likelihood: -1786.553 
   # 
   # AIC(4): 3739.105
   # BIC(4): 4005.493
   # G^2(4): 1671.979 (Likelihood ratio/deviance statistic) 
   # X^2(4): 129425.1 (Chi-square goodness of fit) 
   
   # https://statistics.ohlsen-web.de/latent-class-analysis-polca/
   #Since we do not have a solid theoretical assumption of the number of unobserved subpopulations (aka family types)
   #we take an exploratory approach and compare multiple models (2-4 classes) against each other. 
   #If choosing this approach, one can decide to take the model that has the most plausible interpretation. 
   #Additionally one could compare the different solutions by BIC or AIC information criteria. 
   #BIC is preferred over AIC in latent class models, but usually both are used. 
   #A smaller BIC is better than a bigger BIC. 
   #Next to AIC and BIC one also gets a Chi-Square goodness of fit, which one can compare.
   
   #>> 2-class model seems to have the best fit, since BIC is smaller  
   
   set.seed(123)
   ?set.seed
   twoclass_v2 <- poLCA(LCAmodel_v2, data=rosie_fscores, nclass=2, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
   
   #...output predicted classes from selected model so that we can use it in subsequent analyses:
   rosie_fscores$classv2 <- twoclass_v2$predclass
   
   #...declare the class variable as a factor
   rosie_fscores$classv2 <-  as.factor(rosie_fscores$classv2)
   is.factor(rosie_fscores$classv2)
   
   View(rosie_fscores)
   
   #...name the levels of the class factor using the response probabilities plot
   levels(rosie_fscores$classv2)[levels(rosie_fscores$classv2)=="1"] <- "XXX"
   levels(rosie_fscores$classv2)[levels(rosie_fscores$classv2)=="2"] <- "YYY"
   
   
   #--------------------------------------------------------------------------------#
   ### COMPARISON BETWEEN VERSION 1 AND VERSION 2 SOLUTION ##########################
   #--------------------------------------------------------------------------------#
   
   #A correlation does not make much sense because it does not work with categorical variables; it needs continuous ones.
   #But the whole purpose of this is to artificially categorize. 
   
   View(rosie_fscores)
   
   #for TT
   round(cor(rosie_fscores[,c(205, 216)]),2)
   #                      TT_f_factor TT_total_LCA_factor
   # TT_f_factor                1.00                0.44
   # TT_total_LCA_factor        0.44                1.00
   
   #for Child_Parasocail
   round(cor(rosie_fscores[,c(211:212, 220, 223)]),2)
   #                                              anthropomorphism_factor parasocial_relationship_factor Para_anthropomorphism_total_LCA_factor Para_parasocialrelationship_total_LCA_factor
   # anthropomorphism_factor                                         1.00                           0.62                                   0.45                                         0.00
   # parasocial_relationship_factor                                  0.62                           1.00                                   0.33                                        -0.21
   # Para_anthropomorphism_total_LCA_factor                          0.45                           0.33                                   1.00                                         0.03
   # Para_parasocialrelationship_total_LCA_factor                    0.00                          -0.21                                   0.03                                         1.00
   
   #for better visual overivew 
   library(devtools)
   devtools::install_github("laresbernardo/lares")
   library(lares)
   
   corr_cross(rosie_fscores[,c(211:212, 220, 223)], # name of dataset
              max_pvalue = 0.05, # display only significant correlations (at 5% level)
              top = 20 # display top 10 couples of variables (by correlation coefficient)
   )
   
   #for PMMS
   round(cor(rosie_fscores[,c(202:204, 226, 229, 232)]),2)
   # restrMed_factor negacMed_factor posacMed_factor PMMS_restrMed_total_LCA_factor PMMS_negacMed_total_LCA_factor PMMS_posacMed_total_LCA_factor
   # restrMed_factor                           1.00            0.56            0.42                           0.50                           0.38                           0.15
   # negacMed_factor                           0.56            1.00            0.32                           0.08                           0.40                           0.12
   # posacMed_factor                           0.42            0.32            1.00                           0.24                           0.23                           0.50
   # PMMS_restrMed_total_LCA_factor            0.50            0.08            0.24                           1.00                           0.00                           0.09
   # PMMS_negacMed_total_LCA_factor            0.38            0.40            0.23                           0.00                           1.00                           0.07
   # PMMS_posacMed_total_LCA_factor            0.15            0.12            0.50                           0.09                           0.07                           1.00
   
   #for better visual overivew 
   library(devtools)
   devtools::install_github("laresbernardo/lares")
   library(lares)
   
   corr_cross(rosie_fscores[,c(202:204, 226, 229, 232)], # name of dataset
              max_pvalue = 0.05, # display only significant correlations (at 5% level)
              top = 20 # display top 10 couples of variables (by correlation coefficient)
   )
   
   #An alternative to confirm that we can indeed just translate the grouping to the factor scores would be to standardize the values
   #on the original scale per item (per construct) and compare each person's mean on that standardized scale with their factor score.
   
   rosie_fscores_standardized <- scale(rosie_fscores[,c(167:169)])
   View(rosie_fscores_standardized)
   is.numeric(rosie_fscores_standardized$TT_1)
   
   rosie_fscores_standardized$TT_mean <- sum(rosie_fscores_standardized$TT_1 + rosie_fscores_standardized$TT_2 + rosie_fscores_standardized$TT_3)/3
   View(rosie_fscores_standardized)
   rosie_fscores_standardized$TT_1_mean <- mean(rosie_fscores_standardized$TT_1)
   
   #--------------------------------------------------------------------#
   ### LATENT PROFILE/CLASS ANALYSIS VERSION 3 ##########################
   #--------------------------------------------------------------------#
   
   #along idea of including also household composition, smart-household-level, and internet literacy
   
   #Which variables should go in the LCA? >> All individual characteristics! Those are:
   
   #Dispositional: 
   # IL >> 5 items (information + navigation)
   # TT >> 3 items
   # Child_Temp_Extraversion
   # Child_Temp_Negative_Affectivity
   # Child_Temp_Effortful_Control 
   # Child_Parasocial >> 5 items
   # SOCIALEKLASSE2016
   # smart-household-level
   
   #Developmental: 
   # Child_Age
   # Child-Gender
   # LFT
   # GSL
   
   #Social: 
   # PMMS >> 6 items
   # household composition >> built up of Child_Nr and PERSONEN
   
   
   library(poLCA) # >> only allows categorical indicators, so we convert all continuous variables into categorical ones
   
   #Dispositional: 
   # IL >> 5 items two factors >> since answer options 1+2 as well as the rest group together (same for looking at factor score distribution). we change into: <= 0 = 1, > 0 = 2
   # TT >> 3 items one factor >> median split method because of fairly normal distribution and conceptual understanding of 0 = Neutraal
   # Child_Temp_Extraversion >> since conceptually everything < 0 is a more or less clear "no", change into:-3 - -1 = no and 0- 3 = yes, which means 1-3 = 1 and 4-7 = 2
   # Child_Temp_Negative_Affectivity >> since conceptually everything < 0 is a more or less clear "no", change into:-3 - -1 = no and 0- 3 = yes, which means 1-3 = 1 and 4-7 = 2
   # Child_Temp_Effortful_Control >> since conceptually everything < 0 is a more or less clear "no", change into:-3 - -1 = no and 0- 3 = yes, which means 1-3 = 1 and 4-7 = 2
   # Child_Parasocial >> 5 items two factors >> anthropomorphism & parasocial_relationship >> since distributions show that answer options 1+2 as well as 3+4+5 group together: 1-2 = 1, 3-5 = 2 >> translating groups of 1-2 = 1, 3-5 = 2 into factor scores
   # SOCIALEKLASSE2016 >> ALREADY CATEGORICAL
   # smart-household-level >> convert single-item into factor
   
   #Developmental: 
   # Child_Age >> agre group "pre-schoolers 3-5 years, age group "schoolkids" 6-8 years, which means 1-3 = 1 and 4-6 = 2
   # Child-Gender >> ALREADY CATEGORICAL
   # LFT >> mean-split
   # GSL >> ALREADY CATEGORICAL
   
   #Social: 
   # PMMS >> 6 items three factors >> restsMed & negacMed & posacMed >> since distributions show that answer options 1+2 group together: 1-2 = 1 (nooit), 3 = 2 (soms), 4 = 3 (vaak) >> translating groups of into factor scores
   # household composition >> convert both items into factors
   
   #artificial categorization
   # - IL
   #navigation
   rosie_fscores$IL_navigation_factor[rosie_fscores$navigation<=0] = 1
   rosie_fscores$IL_navigation_factor[rosie_fscores$navigation>0] = 2
   
   #information
   rosie_fscores$IL_information_factor[rosie_fscores$information<=0] = 1
   rosie_fscores$IL_information_factor[rosie_fscores$information>0] = 2
   
   # - TT
   rosie_fscores$TT_f_factor[rosie_fscores$TT_f<=median(rosie_fscores$TT_f)] = 1
   rosie_fscores$TT_f_factor[rosie_fscores$TT_f>median(rosie_fscores$TT_f)] = 2
   
   # - Child_Temp
   rosie_fscores$Temp_Extraversion_factor[rosie$Child_Temp_Extraversion<=3] = 1
   rosie_fscores$Temp_Extraversion_factor[rosie$Child_Temp_Extraversion>=4] = 2
   
   rosie_fscores$Temp_Negative_Affectivity_factor[rosie_fscores$Child_Temp_Negative_Affectivity<=3] = 1
   rosie_fscores$Temp_Negative_Affectivity_factor[rosie_fscores$Child_Temp_Negative_Affectivity>=4] = 2
   
   rosie_fscores$Temp_Effortful_Control_factor[rosie_fscores$Child_Temp_Effortful_Control<=3] = 1
   rosie_fscores$Temp_Effortful_Control_factor[rosie_fscores$Child_Temp_Effortful_Control>=4] = 2
   
   # - Child_Parasocial
   rosie_fscores$anthropomorphism_factor[rosie_fscores$anthropomorphism<=0] = 1
   rosie_fscores$anthropomorphism_factor[rosie_fscores$anthropomorphism>0] = 2
   
   rosie_fscores$parasocial_relationship_factor[rosie_fscores$parasocial_relationship<=0] = 1
   rosie_fscores$parasocial_relationship_factor[rosie_fscores$parasocial_relationship>0] = 2
   
   # - smart-household-level
   rosie_fscores$SHL_f[rosie_fscores$SHL<=median(rosie_fscores$SHL)] = 1
   rosie_fscores$SHL_f[rosie_fscores$SHL>median(rosie_fscores$SHL)] = 2
   
   # - Child_Age
   rosie_fscores$Child_Age_factor[rosie_fscores$Child_Age<=3] = 1 
   rosie_fscores$Child_Age_factor[rosie_fscores$Child_Age>=4] = 2
   
   # - LFT
   rosie_fscores$LFT_factor[rosie_fscores$LFT<=mean(rosie$LFT)] = 1
   rosie_fscores$LFT_factor[rosie_fscores$LFT>mean(rosie$LFT)] = 2
   
   # - PMMS
   #restrMed
   rosie_fscores$restrMed_factor[rosie_fscores$restrMed<(-1)] = 1
   rosie_fscores$restrMed_factor[rosie_fscores$restrMed>=(-1) & rosie_fscores$restrMed<=0] = 2
   rosie_fscores$restrMed_factor[rosie_fscores$restrMed>0] = 3
   
   View(rosie_fscores$restrMed_factor)
   
   #negacMed
   rosie_fscores$negacMed_factor[rosie_fscores$negacMed<(-1)] = 1
   rosie_fscores$negacMed_factor[rosie_fscores$negacMed>=(-1) & rosie_fscores$negacMed<=0] = 2
   rosie_fscores$negacMed_factor[rosie_fscores$negacMed>0] = 3
   
   View(rosie_fscores$negacMed_factor)
   
   #posacMed
   rosie_fscores$posacMed_factor[rosie_fscores$posacMed<(-1)] = 1
   rosie_fscores$posacMed_factor[rosie_fscores$posacMed>=(-1) & rosie_fscores$posacMed<=0] = 2
   rosie_fscores$posacMed_factor[rosie_fscores$posacMed>0] = 3
   
   View(rosie_fscores$posacMed_factor)
   
   # - household composition
   rosie_fscores$Child_Nr_f <- as.factor(rosie_fscores$Child_Nr)
   
   rosie_fscores$PERSONEN_f <- as.factor(rosie_fscores$PERSONEN)
   
   
   View(rosie_fscores) 
   
   
   #LCA
   LCAmodel_v3 <- cbind(IL_navigation_factor, IL_information_factor,
                     TT_f_factor,
                     Temp_Extraversion_factor, Temp_Negative_Affectivity_factor, Temp_Effortful_Control_factor, 
                     anthropomorphism_factor, parasocial_relationship_factor,
                     SOCIALEKLASSE2016,
                     SHL_f,
                     Child_Age_factor, 
                     Child_Gender, 
                     LFT_factor, 
                     GSL, 
                     restrMed_factor, negacMed_factor, posacMed_factor,
                     Child_Nr_f, PERSONEN_f)~1
   
   Mv3_2class <- poLCA(LCAmodel_v3, data=rosie_fscores, nclass=2, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
   
   Mv3_3class <- poLCA(LCAmodel_v3, data=rosie_fscores, nclass=3, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
   
   Mv3_4class <- poLCA(LCAmodel_v3, data=rosie_fscores, nclass=4, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
   
   # https://statistics.ohlsen-web.de/latent-class-analysis-polca/
   #Since we do not have a solid theoretical assumption of the number of unobserved subpopulations (aka family types)
   #we take an exploratory approach and compare multiple models (2-4 classes) against each other. 
   #If choosing this approach, one can decide to take the model that has the most plausible interpretation. 
   #Additionally one could compare the different solutions by BIC or AIC information criteria. 
   #BIC is preferred over AIC in latent class models, but usually both are used. 
   #A smaller BIC is better than a bigger BIC. 
   #Next to AIC and BIC one also gets a Chi-Square goodness of fit, which one can compare.
   
   
   #extract 2-class solution and save in twoclass object (https://osf.io/vec6s/)
   set.seed(123)
   ?set.seed
   twoclass=poLCA(LCAmodel, data=rosie_fscores, nclass=2, maxiter = 1000, nrep = 5, graphs=TRUE, na.rm=TRUE)
   
   #output predicted classes from selected model so that we can use it in subsequent analyses:
   rosie_fscores$class=twoclass$predclass
   
   #declare the class variable as a factor
   rosie_fscores$class = as.factor(rosie_fscores$class)
   
   #name the levels of the class factor using the response probabilities plot
   levels(rosie_fscores$class)[levels(rosie_fscores$class)=="1"] <- "XXX"
   levels(rosie_fscores$class)[levels(rosie_fscores$class)=="2"] <- "YYY"
   
   
          
   #########  :) Script run until here #################
   
###----------------------------------------------------------------------------------------------------------------###      
      
#----------------------------------------------------------#
### STRUCTURAL EQUATION MODELLING ##########################
#----------------------------------------------------------#
      
   #-----------------------------------------------#
   ### SEM-POWER ANALYSIS ##########################
   #-----------------------------------------------#
   
   #https://yilinandrewang.shinyapps.io/pwrSEM/ 
     
   ??simsem
   #http://rstudio-pubs-static.s3.amazonaws.com/253855_164b16e3a9074cf9a6f3045cbe1f99ce.html 
   
   #--------------------------------#
   ### SEM ##########################
   #--------------------------------#
   
      #CHI-SQUARE
      install.packages("gmodels")
      library(gmodels)
      CrossTable(DataSet$Variable1, DataSet$Variable2, chisq = TRUE, expected = TRUE, prop.c = FALSE, prop.r = FALSE, prop.t = FALSE, prop.chisq = FALSE, asresid = TRUE, format = "SPSS")
      
      
      #MULTIPLE LINEAR REGRESSION (!!! use centered predictors)
      #centering predictors
      DataSet$Variable1_c <- DataSet$Variable1 - mean(DataSat$Variable1)
      #OR
      scale(variable, center=TRUE/FALSE, scale = TRUE/FALSE)
      #perform the lm
      NameOfRegressionModel <- lm(DataSet$Variable1 ~ DataSet$Variable2 + DataSet$Variable3)
      summary(NameOfRegressionModel)
      #add standardized residuals to the data frame
      dataSet$NameOfVariableThatShowsStandardizedResiduals <- rstandard(NameOfModel)
      

      install.packages("lavaan", dependencies = T)
      library(lavaan)
 
      
      #perform the analysis
        #https://benwhalley.github.io/just-enough-r/cfa.html
      
        #general functions for sem
        #sem() #for path analysis and SEM
        #cfa() #for confirmatory factor analysis
        #growth() #for latent growth curve modeling
        #lavaan() #for all models (without default parameters)
      
        ### Higher Order Model in Lavaan ###
        
        #specify the model
        rosiesTAM <- '
          #measurement model
            IL  =~ 1*information + navigation      
            PE =~ PE
            E =~ 1*TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4
            IMG =~ TAM_IMG
            SN =~ 1*TAM_SN_1 + TAM_SN_2 + TAM_SN_3
            PEoU =~ 1*TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4
            PU =~ 1*TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4
            ICU =~ 1*TAM_ICU_1 + TAM_ICU_2 + TAM_ICU_3
        
          #regressions
            PEoU ~ IL + PE ?+ FAM? + SHL + Child_nr
            PU ~ FAM + PEoU + SHL + Child_nr
            ICU ~ PEoU + PU + E + IMG + SN +SHL + Child_nr
        
          #add (residual) variances ????
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
        rosiesTAM_fit <- lavaan(rosiesTAM, data = rosie_fscores)
        
        #print summary  
        summary(rosiesTAM_fit, standardized = T, fit.measures = T)
      
        #compare models
        anova(rosiesTAM_fit, fit2?)
###----------------------------------------------------------------------------------------------------------------###
          
#------------------------------------------------#
### MODEL VISUALIZATION ##########################
#------------------------------------------------#
          
### SemPaths Model Visualization ###
          
    semPaths(fit_final, what = "col", "std", layout = "tree", rotation = 2, 
                   intercepts = F, residuals = F, curve = 2, nCharNodes = 0,
                   edge.label.cex = 1, edge.color = "black", sizeMan = 10, sizeMan2 = 5)
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