# About this Webpage (anonymous for peer-review process)
On this website, you can find the companion material for the paper "Virtual Assistants in Families. A Cross-Sectional Online-Survey Study to Understand Families’ Decisions to Use Virtual Assistants in the Home." This paper reports on the first study conducted as part of project Rosie using the following research question for guidance: *How do individual characteristics of families influence their decision to use virtual assistants in their home?*
This website is produced directly from the project’s github repository. 

## About Project Rosie
Project Rosie is set to study in depth how families with young children (aged 3 - 8 years) adopt, use, and eventually trust virtual assistants that are installed on smart speakers, like Google Home Nest or Amazon Echo, in their home. 

## Preregistration
[Here](https://osf.io/pmwud/?view_only=aaa1b70f0f75468388c8f50e2fed508f) you can find the prergistratration plan for the first study of project Rosie looking into families' individual characteristics that potentially influence their decision to use a vitual assistant in their home.

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
        # >> for some reason this participant has NAs for SS_childusage ***I really do not understand why there is a mssing value in the first place***
  ```

### Measurement Validity and Descriptives

### Preregistered Analyses

#### Latent Class Analysis: Individual differencs (DSMM)

#### Structural Equation Modelling: Technology acceptance (TAM + U&G)

### Exploratory Analyses
