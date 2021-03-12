
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
  
  
#-----------------------------------------#
### DESCRIPTIVES ##########################
#-----------------------------------------#
  
  #taking a first numerical look
  summary(rosie)
  str(rosie)
  
  library(pastecs)
  stat.desc(rosie)
  
  library(psych)
  describe(rosie[c(93:104, 122:126, 143:178)]) #without the last ICU_group because of their syntax error, otherwise describe function does not run
  #                      vars   n  mean   sd median trimmed  mad  min max range  skew kurtosis   se
  #Child_Nr                 1 183  2.36 0.55    2.0    2.28 0.00  2.0   5   3.0  1.45     2.18 0.04
  #Child_Age                2 183  3.83 1.71    4.0    3.91 1.48  1.0   6   5.0 -0.20    -1.25 0.13
  #Child_Gender*            3 183  1.55 0.50    2.0    1.56 0.00  1.0   2   1.0 -0.19    -1.98 0.04
  #Child_Temp_1             4 183  5.18 1.47    6.0    5.30 1.48  1.0   7   6.0 -0.62    -0.38 0.11
  #Child_Temp_2             5 183  3.30 1.76    3.0    3.21 1.48  1.0   7   6.0  0.29    -1.01 0.13
  #Child_Temp_3             6 183  4.78 1.62    5.0    4.90 1.48  1.0   7   6.0 -0.53    -0.39 0.12
  #PMMS_1                   7 183  2.93 0.78    3.0    2.99 0.00  1.0   4   3.0 -0.57     0.16 0.06
  #PMMS_2                   8 183  3.08 0.94    3.0    3.21 1.48  1.0   4   3.0 -0.80    -0.26 0.07
  #PMMS_3                   9 183  2.87 0.85    3.0    2.96 0.00  1.0   4   3.0 -0.66     0.00 0.06
  #PMMS_4                  10 183  3.26 0.72    3.0    3.36 0.00  1.0   4   3.0 -0.95     1.17 0.05
  #PMMS_5                  11 183  2.74 0.97    3.0    2.80 1.48  1.0   4   3.0 -0.41    -0.79 0.07
  #PMMS_6                  12 183  2.95 0.80    3.0    2.99 0.00  1.0   4   3.0 -0.49    -0.12 0.06
  #Child_Parasocial_1      13 183  1.92 1.18    1.0    1.73 0.00  1.0   5   4.0  1.00    -0.15 0.09
  #Child_Parasocial_2      14 183  3.24 1.22    3.0    3.30 1.48  1.0   5   4.0 -0.37    -0.72 0.09
  #Child_Parasocial_3      15 183  2.11 1.18    2.0    1.99 1.48  1.0   5   4.0  0.59    -1.00 0.09
  #Child_Parasocial_4      16 183  1.72 1.01    1.0    1.54 0.00  1.0   5   4.0  1.26     0.70 0.07
  #Child_Parasocial_5      17 183  1.77 1.07    1.0    1.56 0.00  1.0   5   4.0  1.23     0.44 0.08
  #TAM_PEoU_1              18 183  5.20 1.30    5.0    5.34 1.48  1.0   7   6.0 -1.14     1.25 0.10
  #TAM_PEoU_2              19 183  5.11 1.50    6.0    5.26 1.48  1.0   7   6.0 -0.88     0.02 0.11
  #TAM_PEoU_3              20 183  5.36 1.37    6.0    5.54 1.48  1.0   7   6.0 -1.21     1.14 0.10
  #TAM_PEoU_4              21 183  5.01 1.42    5.0    5.16 1.48  1.0   7   6.0 -1.01     0.54 0.11
  #TAM_PU_1                22 183  4.16 1.57    4.0    4.24 1.48  1.0   7   6.0 -0.35    -0.59 0.12
  #TAM_PU_2                23 183  3.88 1.57    4.0    3.95 1.48  1.0   7   6.0 -0.28    -0.68 0.12
  #TAM_PU_3                24 183  4.32 1.61    5.0    4.46 1.48  1.0   7   6.0 -0.58    -0.47 0.12
  #TAM_PU_4                25 183  4.76 1.44    5.0    4.86 1.48  1.0   7   6.0 -0.68     0.08 0.11
  #TAM_E_1                 26 183  5.07 1.38    5.0    5.20 1.48  1.0   7   6.0 -1.00     0.87 0.10
  #TAM_E_2                 27 183  5.14 1.34    5.0    5.28 1.48  1.0   7   6.0 -1.09     1.22 0.10
  #TAM_E_3                 28 183  5.26 1.35    5.0    5.41 1.48  1.0   7   6.0 -1.18     1.67 0.10
  #TAM_E_4                 29 183  4.50 1.48    5.0    4.63 1.48  1.0   7   6.0 -0.62    -0.09 0.11
  #TAM_IMG                 30 183  3.63 1.90    4.0    3.50 1.48  1.0   8   7.0  0.44    -0.35 0.14
  #TAM_SN_1                31 183  2.69 1.64    2.0    2.50 1.48  1.0   7   6.0  0.60    -0.64 0.12
  #TAM_SN_2                32 183  2.74 1.69    2.0    2.57 1.48  1.0   7   6.0  0.59    -0.83 0.13
  #TAM_SN_3                33 183  3.21 1.82    3.0    3.10 2.97  1.0   7   6.0  0.27    -1.11 0.13
  #TAM_ICU_1               34 183  3.40 1.72    3.0    3.33 1.48  1.0   7   6.0  0.36    -0.92 0.13
  #TAM_ICU_2               35 183  5.30 1.37    6.0    5.46 1.48  1.0   7   6.0 -1.13     1.20 0.10
  #TAM_ICU_3               36 183  4.44 1.78    5.0    4.56 1.48  1.0   7   6.0 -0.51    -0.84 0.13
  #IL_1                    37 183  2.19 1.39    2.0    1.93 1.48  1.0   7   6.0  1.50     1.88 0.10
  #IL_2                    38 183  2.03 1.30    2.0    1.78 1.48  1.0   7   6.0  1.49     1.82 0.10
  #IL_3                    39 183  2.25 1.38    2.0    2.03 1.48  1.0   7   6.0  1.29     1.10 0.10
  #IL_4                    40 183  2.49 1.76    2.0    2.23 1.48  1.0   7   6.0  1.03    -0.17 0.13
  #IL_5                    41 183  2.73 1.61    2.0    2.55 1.48  1.0   7   6.0  0.78    -0.37 0.12
  #TT_1                    42 183  4.21 1.47    4.0    4.26 1.48  1.0   7   6.0 -0.31    -0.64 0.11
  #TT_2                    43 183  4.77 1.41    5.0    4.83 1.48  1.0   7   6.0 -0.51    -0.17 0.10
  #TT_3                    44 183  4.91 1.22    5.0    5.00 1.48  1.0   7   6.0 -0.67     0.75 0.09
  #STATUS*                 45 183  1.00 0.00    1.0    1.00 0.00  1.0   1   0.0   NaN      NaN 0.00
  #PERSONEN                46 183  3.78 1.04    4.0    3.85 0.00  1.0   6   5.0 -0.59     0.79 0.08
  #SOCIALEKLASSE2016*      47 183  2.07 1.24    2.0    1.92 1.48  1.0   5   4.0  0.92    -0.47 0.09
  #GSL                     48 183  1.51 0.50    2.0    1.51 0.00  1.0   2   1.0 -0.03    -2.01 0.04
  #LFT                     49 183 41.11 7.76   40.0   40.01 5.93 28.0  76  48.0  1.74     4.05 0.57
  #PE                      50 183  4.41 1.34    5.0    4.53 1.48  1.0   6   5.0 -0.51    -0.72 0.10
  #SHL                     51 183  3.78 1.35    4.0    3.77 1.48  1.2   6   4.8 -0.03    -1.10 0.10
  #ICU_togetherwithchild   52 183  3.34 1.45    4.0    3.35 1.48  1.0   6   5.0 -0.18    -0.90 0.11
  #ICU_childindividually   53 182  3.21 1.62    3.5    3.18 2.22  1.0   6   5.0 -0.07    -1.22 0.12
 
  
  library(psych)
  psych::describeBy(rosie[c(93:104, 122:126, 143:178)], group = "GSL")
  # 1 = male, 2 = female
  
  #more descriptives on our DV-levels
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
  
  hist(rosie$TT_1) #faily normally distributed
  hist(rosie$TT_2)
  hist(rosie$TT_3)
  
  hist(rosie$Child_Temp_Extraversion)
  hist(rosie$Child_Temp_Negative_Affectivity)
  hist(rosie$Child_Temp_Effortful_Control)
  
  hist(rosie$Child_Parasocial_1) #strong deviation from normal distribution
  hist(rosie$Child_Parasocial_2)
  hist(rosie$Child_Parasocial_3)
  hist(rosie$Child_Parasocial_4)
  hist(rosie$Child_Parasocial_5)
  
  hist(rosie$PMMS_1)
  hist(rosie$PMMS_2)
  hist(rosie$PMMS_3)
  hist(rosie$PMMS_4)
  hist(rosie$PMMS_5)
  hist(rosie$PMMS_6)
  
  hist(rosie$LFT) #most parents between 30-50, only very few between 60 - 80
  hist(rosie$Child_Age) #almost equally distributed, most 8-year olds

  
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
  
          #Q26 TT >> 3 items
          
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
          m1a  <- ' f  =~ TT_1 + TT_2 + TT_3' 
          onefac3items_TT <- cfa(m1a, data=rosie) 
          summary(onefac3items_TT, fit.measures=TRUE, standardized=TRUE) # >> Seems like a "just" identified model. Wait and see for testing whole measurement model in SEM.
          # >> fit index criteria: Chi-Square = / because 0 df just identified, CFI = 1 > 0.95, TLI = 1 > 0.90 and RMSEA = 0 < 0.10
    
  
          #Q30 Child_Temp >> 3 items
  
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
          
          
          #Q32 Child_Parasocial >> 5 items
          
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
          
          #Q31 PMMS >> 6 items
          
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
        
          #Q17 TAM_PEoU >> 4
          
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
          m1e  <- ' f  =~ TAM_PEoU_1 + TAM_PEoU_2 + TAM_PEoU_3 + TAM_PEoU_4'
          onefac4items_TAM_PEoU <- cfa(m1e, data=rosie, std.lv=TRUE) 
          summary(onefac4items_TAM_PEoU, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .861 > .05, CFI = 1 > 0.95, TLI = 1.012 > 0.90 and RMSEA  = 0 < 0.10 >> VERY NICE
          
          #Q18 TAM_PU >> 4
          
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
          m1f  <- ' f  =~ TAM_PU_1 + TAM_PU_2 + TAM_PU_3 + TAM_PU_4'
          onefac4items_TAM_PU <- cfa(m1f, data=rosie, std.lv=TRUE) 
          summary(onefac4items_TAM_PU, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .234 > .05, CFI = .998 > 0.95, TLI = .995 > 0.90 and RMSEA = .050 < 0.10 >> VERY NICE
          
          #Q19 TAM_E >> 4
          
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
          m1g  <- ' f  =~ TAM_E_1 + TAM_E_2 + TAM_E_3 + TAM_E_4'
          onefac4items_TAM_E <- cfa(m1g, data=rosie,std.lv=TRUE) 
          summary(onefac4items_TAM_E, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = .058 > .05, CFI = .993 > 0.95, TLI = .979 > 0.90 and RMSEA = .100 < 0.10 >> NICE
          
          
          #Q21 TAM_SN >> 3
          
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
          m1h  <- ' f  =~ TAM_SN_1 + TAM_SN_2 + TAM_SN_3 '
          onefac3items_TAM_SN <- cfa(m1h, data=rosie) 
          summary(onefac3items_TAM_SN, fit.measures=TRUE, standardized=TRUE)
          # >> fit index criteria: Chi-Square = 0 > .05, CFI = 1 > 0.95, TLI = 1 > 0.90 and RMSEA = 0 < 0.10 >> AGAIN, problematic because just identified        
          
          #Q22 TAM_ICU >> 3 EXCEPTION 
          
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
          m1r  <- ' f  =~ TAM_ICU_1 + TAM_ICU_2 + TAM_ICU_3'
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
                      
              
       
          #Q25 IL >> 5 items      
          
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
                
        
        #----------------------------------------------#
        ### !!! Solve the factor scores and run correlations among TAM variables ##########################
        #----------------------------------------------#        
        #Extract factor scores for correlations >> Along resources from Theo (https://www.rdocumentation.org/packages/lavaan/versions/0.6-7/topics/lavPredict), but really needed? Journal of Computer sin human Behaviour 
        #usually reports descriptives only on demographics and does not explicitly report anything on the extracted factor scores.

        
        ####----RELIABILITY ANALSIS----####
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
   mult.norm(rosie[c(96:104, 122:126, 143:169, 175:176)])$mult.test
          
   #Beta-hat        kappa                   p-val
   #Skewness  549.0508 16746.048561 0.000000000000000000000
   #Kurtosis 2008.0810     7.945926 0.000000000000001998401
   
   # >> Since both p-values are waaaay less than .05, we reject the null hypothesis of the test. We have evidence to say that the variables in our dataset do not follow a multivariate distribution.
   # >> Together with the non-normality detected earlier, we will run our main analyses using bottstrapping

###----------------------------------------------------------------------------------------------------------------###   
   
#----------------------------------------------------------#
### LATENT PROFILE/CLASS ANALYSIS ##########################
#----------------------------------------------------------#
      
   
   #Which variables should go in the LCA? >> All individual characteristics! Those are:
   
         #Dispositional: 
         #Q26 TT >> 3 items
         #Q30_1 Child_Temp_Extraversion
         #Q30_2 Child_Temp_Negative_Affectivity
         #Q30_3 Child_Temp_Effortful_Control 
         #Q32 Child_Parasocial >> 5 items
         # SOCIALEKLASSE2016
         
         #Developmental: 
         # Child_Age
         # Child-Gender
         # LFT
         # GSL
         
         #Social: 
         #Q31 PMMS >> 6 items
  
     
   library(poLCA) # >> only allows categorical indicators, so we convert all continuous variables into categorical ones
   
         #Dispositional: 
         #Q26 TT >> 3 items >> 
         #Q30_1 Child_Temp_Extraversion >> 0-split method appropriate since scale went from -3 (not at all like this description to +3 exactly like this description, so all answers below 0 can be regarded as "no" while all alswers above 0 can be ragrded as "yes")
         #Q30_2 Child_Temp_Negative_Affectivity
         #Q30_3 Child_Temp_Effortful_Control 
         #Q32 Child_Parasocial >> 5 items
         # SOCIALEKLASSE2016
         
         #Developmental: 
         # Child_Age
         # Child-Gender
         # LFT
         # GSL
         
         #Social: 
         #Q31 PMMS >> 6 items
   
   
   #mean-split factor creation for all continuous variables, which are:
   # - TT
   rosie$TT_1_factor[rosie$TT_1<mean(rosie$TT_1)] = 1
   rosie$TT_1_factor[rosie$TT_1==mean(rosie$TT_1)] = 2
   rosie$TT_1_factor[rosie$TT_1>mean(rosie$TT_1)] = 3
   
   rosie$TT_2_factor[rosie$TT_2<mean(rosie$TT_2)] = 1
   rosie$TT_2_factor[rosie$TT_2==mean(rosie$TT_2)] = 2
   rosie$TT_2_factor[rosie$TT_2>mean(rosie$TT_2)] = 3
   
   rosie$TT_3_factor[rosie$TT_3<mean(rosie$TT_3)] = 1
   rosie$TT_3_factor[rosie$TT_3==mean(rosie$TT_3)] = 2
   rosie$TT_3_factor[rosie$TT_3>mean(rosie$TT_3)] = 3
   
   # - Child_Temp
   rosie$Temp_Extraversion_factor[rosie$Child_Temp_Extraversion<mean(rosie$Child_Temp_Extraversion)] = 1
   rosie$Temp_Extraversion_factor[rosie$Child_Temp_Extraversion==mean(rosie$Child_Temp_Extraversion)] = 2
   rosie$Temp_Extraversion_factor[rosie$Child_Temp_Extraversion>mean(rosie$Child_Temp_Extraversion)] = 3
   
   rosie$Temp_Negative_Affectivity_factor[rosie$Child_Temp_Negative_Affectivity<mean(rosie$Child_Temp_Negative_Affectivity)] = 1
   rosie$Temp_Negative_Affectivity_factor[rosie$Child_Temp_Negative_Affectivityn==mean(rosie$Child_Temp_Negative_Affectivity)] = 2
   rosie$Temp_Negative_Affectivity_factor[rosie$Child_Temp_Negative_Affectivity>mean(rosie$Child_Temp_Negative_Affectivity)] = 3
   
   rosie$Temp_Effortful_Control_factor[rosie$Child_Temp_Effortful_Control<mean(rosie$Child_Temp_Effortful_Control)] = 1
   rosie$Temp_Effortful_Control_factor[rosie$Child_Temp_Effortful_Control==mean(rosie$Child_Temp_Effortful_Control)] = 2
   rosie$Temp_Effortful_Control_factor[rosie$Child_Temp_Effortful_Control>mean(rosie$Child_Temp_Effortful_Control)] = 3
   
   # - Child_Parasocial
   rosie$Child_Parasocial_1_factor[rosie$Child_Parasocial_1<mean(rosie$Child_Parasocial_1)] = 1
   rosie$Child_Parasocial_1_factor[rosie$Child_Parasocial_1==mean(rosie$Child_Parasocial_1)] = 2
   rosie$Child_Parasocial_1_factor[rosie$Child_Parasocial_1>mean(rosie$Child_Parasocial_1)] = 3
   
   rosie$Child_Parasocial_2_factor[rosie$Child_Parasocial_2<mean(rosie$Child_Parasocial_2)] = 1
   rosie$Child_Parasocial_2_factor[rosie$Child_Parasocial_2==mean(rosie$Child_Parasocial_2)] = 2
   rosie$Child_Parasocial_2_factor[rosie$Child_Parasocial_2>mean(rosie$Child_Parasocial_2)] = 3
   
   rosie$Child_Parasocial_3_factor[rosie$Child_Parasocial_3<mean(rosie$Child_Parasocial_3)] = 1
   rosie$Child_Parasocial_3_factor[rosie$Child_Parasocial_3==mean(rosie$Child_Parasocial_3)] = 2
   rosie$Child_Parasocial_3_factor[rosie$Child_Parasocial_3>mean(rosie$Child_Parasocial_3)] = 3
   
   rosie$Child_Parasocial_4_factor[rosie$Child_Parasocial_4<mean(rosie$Child_Parasocial_4)] = 1
   rosie$Child_Parasocial_4_factor[rosie$Child_Parasocial_4==mean(rosie$Child_Parasocial_4)] = 2
   rosie$Child_Parasocial_4_factor[rosie$Child_Parasocial_4>mean(rosie$Child_Parasocial_4)] = 3
   
   rosie$Child_Parasocial_5_factor[rosie$Child_Parasocial_5<mean(rosie$Child_Parasocial_5)] = 1
   rosie$Child_Parasocial_5_factor[rosie$Child_Parasocial_5==mean(rosie$Child_Parasocial_5)] = 2
   rosie$Child_Parasocial_5_factor[rosie$Child_Parasocial_5>mean(rosie$Child_Parasocial_5)] = 3
   
   # - Child_Age
   rosie$Child_Age_factor[rosie$Child_Age<mean(rosie$Child_Age)] = 1
   rosie$Child_Age_factor[rosie$Child_Age==mean(rosie$Child_Age)] = 2
   rosie$Child_Age_factor[rosie$Child_Age>mean(rosie$Child_Age)] = 3
   
   # - LFT
   rosie$LFT_factor[rosie$LFT<mean(rosie$LFT)] = 1
   rosie$LFT_factor[rosie$LFT==mean(rosie$LFT)] = 2
   rosie$LFT_factor[rosie$LFT>mean(rosie$LFT)] = 3
   
   # - PMMS
   rosie$PMMS_1_factor[rosie$PMMS_1<mean(rosie$PMMS_1)] = 1
   rosie$PMMS_1_factor[rosie$PMMS_1==mean(rosie$PMMS_1)] = 2
   rosie$PMMS_1_factor[rosie$PMMS_1>mean(rosie$PMMS_1)] = 3
   
   rosie$PMMS_2_factor[rosie$PMMS_2<mean(rosie$PMMS_2)] = 1
   rosie$PMMS_2_factor[rosie$PMMS_2==mean(rosie$PMMS_2)] = 2
   rosie$PMMS_2_factor[rosie$PMMS_2>mean(rosie$PMMS_2)] = 3
   
   rosie$PMMS_3_factor[rosie$PMMS_3<mean(rosie$PMMS_3)] = 1
   rosie$PMMS_3_factor[rosie$PMMS_3==mean(rosie$PMMS_3)] = 2
   rosie$PMMS_3_factor[rosie$PMMS_3>mean(rosie$PMMS_3)] = 3
   
   rosie$PMMS_4_factor[rosie$PMMS_4<mean(rosie$PMMS_4)] = 1
   rosie$PMMS_4_factor[rosie$PMMS_4==mean(rosie$PMMS_4)] = 2
   rosie$PMMS_4_factor[rosie$PMMS_4>mean(rosie$PMMS_4)] = 3
   
   rosie$PMMS_5_factor[rosie$PMMS_5<mean(rosie$PMMS_5)] = 1
   rosie$PMMS_5_factor[rosie$PMMS_5==mean(rosie$PMMS_5)] = 2
   rosie$PMMS_5_factor[rosie$PMMS_5>mean(rosie$PMMS_5)] = 3
   
   rosie$PMMS_6_factor[rosie$PMMS_6<mean(rosie$PMMS_6)] = 1
   rosie$PMMS_6_factor[rosie$PMMS_6==mean(rosie$PMMS_6)] = 2
   rosie$PMMS_6_factor[rosie$PMMS_6>mean(rosie$PMMS_6)] = 3
   
   View(rosie) 
   
   
   #LCA
   LCAmodel <- cbind(TT_1_factor, TT_2_factor, TT_3_factor,
                     Temp_Extraversion_factor, Temp_Negative_Affectivity_factor, Temp_Effortful_Control_factor, 
                     Child_Parasocial_1_factor, Child_Parasocial_2_factor, Child_Parasocial_3_factor, Child_Parasocial_4_factor, Child_Parasocial_5_factor,
                     SOCIALEKLASSE2016,
                     Child_Age_factor, 
                     Child_Gender, 
                     LFT_factor, 
                     GSL, 
                     PMMS_1_factor, PMMS_2_factor, PMMS_3_factor, PMMS_4_factor, PMMS_5_factor, PMMS_6_factor)~1
   
   M_2class <- poLCA(LCAmodel, data=rosie, nclass=2, graphs=TRUE, na.rm=TRUE)
   
   M_3class <- poLCA(LCAmodel, data=rosie, nclass=3, graphs=TRUE, na.rm=TRUE)
   
   M_4class <- poLCA(LCAmodel, data=rosie, nclass=4, graphs=TRUE, na.rm=TRUE)
   
   # https://statistics.ohlsen-web.de/latent-class-analysis-polca/
   #Since we do not have a solid theoretical assumption of the number of unobserved subpopulations (aka family types)
   #we take an exploratory approach and compare multiple models (2-4 classes) against each other. 
   #If choosing this approach, one can decide to take the model that has the most plausible interpretation. 
   #Additionally one could compare the different solutions by BIC or AIC information criteria. 
   #BIC is preferred over AIC in latent class models, but usually both are used. 
   #A smaller BIC is better than a bigger BIC. 
   #Next to AIC and BIC one also gets a Chi-Square goodness of fit, which one can compare.
   
   
   ### OR instead: depmixS4 which also allows continuous and categorical indicators https://maksimrudnev.com/2016/12/28/latent-class-analysis-in-r/#depmixS4
   
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
          
   #########  :) Script run until here #################
   
###----------------------------------------------------------------------------------------------------------------###      
      
#----------------------------------------------------------#
### STRUCTURAL EQUATION MODELLING ##########################
#----------------------------------------------------------#
      
   #-----------------------------------------------#
   ### SEM-POWER ANALYSIS ##########################
   #-----------------------------------------------#
   
   ??simsem
   #http://rstudio-pubs-static.s3.amazonaws.com/253855_164b16e3a9074cf9a6f3045cbe1f99ce.html 
   
   #--------------------------------#
   ### SEM ##########################
   #--------------------------------#
   
      #CHI-SQUARE
      install.packages("gmodels")
      library(gmodels)
      CrossTable(DataSet$Variable1, DataSet$Variable2, chisq = TRUE, expected = TRUE, prop.c = FALSE, prop.r = FALSE, prop.t = FALSE, prop.chisq = FALSE, asresid = TRUE, format = "SPSS")
      
      #CORRELATION
      library(ltm)
      rcor.test(dataset[,c(2, 4:6)]) #for specified columns
      rcor.test(dataset$variable1, dataset$variable2..) #for specified variables
      #pairwise correlations all in one scatterplot matrix
      library(car)
      scatterplotMatrix(~Variable1+Variable2+Variable3, data = DataSet)
      
      #inspecting correlations of all TAM model components using the CFA-factor scores
      rosie_correlations <- rosie[,c(143:169, 171, 175:176)] #dataset with CFA-factor scores needs to be used here
      round(cor(rosie_correlations), 2)
      
            #for better visual overivew 
            library(devtools)
            devtools::install_github("laresbernardo/lares")
            library(lares)
            
            ??corr_cross
            corr_cross(rosie_correlations, # name of dataset
                       max_pvalue = 0.05, # display only significant correlations (at 5% level)
                       top = 10 # display top 10 couples of variables (by correlation coefficient)
            )
      
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
      install.packages("MVN", dependencies = T)
      library(lavaan)
      library(MVN)
      
      #analysis preparations
        #check multivariate normality
        pathex_comp <- pathex[complete.cases(pathex),]
      
        #check univariate distributions, multivariate normality and identify multivariate outliers
        MVpathex <- mvn(pathex_comp[, c(5,8,11:13)] mvnTest = “mardia”, multivariatePlot = “qq”, multivariateOutlierMethod = “adj”, showOutliers = T, showNewData = T)
        #or oldschool way via plots
      
      #perform the analysis
        #https://benwhalley.github.io/just-enough-r/cfa.html
      
        #general functions for sem
        #sem() #for path analysis and SEM
        #cfa() #for confirmatory factor analysis
        #growth() #for latent growth curve modeling
        #lavaan() #for all models (without default parameters)
      
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
      
      
