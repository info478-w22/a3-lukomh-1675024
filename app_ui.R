# load your libraries
library(shiny)
library(shinythemes)

# Page One
page_one <- tabPanel(
  "Introduction",
    mainPanel(   
      h1("COVID-19 Disease Modeling"),
      p("In this assignment, we will examine two different epidemiological models. 
        As seen in the page tabs, the models we will look at 
        are the Deterministic Model and Stochastic/Individual Contact Model.
        A Deterministic Model is characterized by its determined path, whereas a
        Stochastic Model has room for fluctuations and variations. When examining
        COVID-19, a highly infectious respiratory disease, both of these models will
        allow us to explore infection rates and recovery rates. Both of these models will allow 
        users to manipulate outcomes, through the use of a drop down menu of 
        different adherance of social distancing and mask usage. Through this assignment
        we will be able to examine the effect these interventions have on these models.")
    ))
# Widgets 
sd_menu <- selectInput(
  inputId = "sd_menu",
  label = "Select Social Distancing Guidelines",
  choices = list(
    "None" = 0.70,
    "Social Distancing in Public Spaces " = 0.524,
    "Full Shutdown" = 0.119
  ),
  selected = "none",
  multiple = FALSE
)
mask_menu <- selectInput(
  inputId = "mask_menu",
  label = "Select Mask Mandate Policy",
  choices = list(
    "No Masking Policy" = 0.70,
    "Masks Required Indoors" = 0.105
  ),
  selected = "none",
  multiple = FALSE
)
# Page 2
page_two <- tabPanel(
  "Deterministic Model",
  sidebarLayout(             
    sidebarPanel(sd_menu, mask_menu),           
    mainPanel(   
      plotOutput("dcm")
    )))
# Page Three
page_three <- tabPanel(
  "Stochastic/Individual Contact Model",
  sidebarLayout(             
    sidebarPanel(sd_menu, mask_menu),           
    mainPanel(   
      plotOutput("icm")
    )))
# Page Four
page_four <- tabPanel(
  "Interpretations",            
    mainPanel(    
      h2("Base Assumptions for Both Models"),
      p("In order to create a deterministic and stochastic model of COVID-19, 
        we must first make assumptions based on current available research to 
        populate our model. There are a few assumptions that remain the same for 
        both the deterministic and stochastic model. The first assumption is that the 
        the average rate of recovery is 0.07. This figure is the reciprocal of 
        the disease duration. The quarantine and isolation period for COVID-19 
        is 14 days, as established by CDC guidelines.  
        For both models, we must set initial conditions for the simulation. 
        The initial conditions for both models are having 100 people susceptible 
        to COVID-19, 1 initial infection, and 0 initial recovered individuals. 
        This would mimic the beginning of the outbreak, given that it COVID-19 began with
        one individual. The final assumption made in these two models is the 
        number of steps the model will use to solve the simulation. For this 
        we used 500 to show an effective model. Please visit the link below for more 
        information on COVID-19's duration."),
      tags$a(href="https://www.cdc.gov/coronavirus/2019-ncov/hcp/duration-isolation.html", 
             "CDC Isolation and Quarantine Guidelines"),
      h2("Assumptions for Social Distancing & Mask Usage"),
      p("We must make several assumptions in order to create a tool where 
      infection rates can change according to different interventions, like 
      social distancing and mask wearing. For both of these interventions, we 
      must adjust the infection probability of each event. If two 
      individuals who are close contacts are not wearing a mask, the odds of 
      one person spreading COVID-19 to the other noninfected person are between 
      65%-80% given various studies. For the sake of this model we will go with a 
      conservative guess in between these two figures, at 70%, making the base 
      infection probability 0.70. Looking at mask wearing, studies have shown 
      that wearing a properly fitting surgical mask can decrease infection by up 
      to 85%, so we used an infection probability of 0.105 to simulate this 
      possibility. For our social distancing intervention, research shows that 
      social distancing in public spaces (1-2 meters of distance between 
      individuals) results in infections being reduced by 25% (0.524 infection 
      probability) . For full shutdowns with all individuals isolating and limiting 
      exposures outside of their immediate family and roommates infections can 
      be reduced by up to 83% (0.119 infection probability)."),
      p("Please explore the following links to view the studies that these 
        assumptions are based off of:"),
      tags$a(href="https://www.nature.com/articles/s41598-021-94960-5 ", 
             "Examining the interplay between face mask usage, asymptomatic transmission, and social 
             distancing on the spread of COVID-19"),
      p(""),
      tags$a(href="https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7428176/ ", 
             "Mask or no mask for COVID-19: A public health and market study"),
      p(""),
      tags$a(href="https://www.nature.com/articles/s41586-020-2405-7.pdf ", 
             "Estimating the effects of non-pharmaceuticalinterventions on 
             COVID-19 in Europe"),
      h2("Evaluation of the Impact of Social Distancing"),
      p("Holding masking policies constant (at “No Masking Policy”) we see 
        profound changes on the Deterministic and Stochastic model when we 
        apply a full shutdown, and marginal changes with social distancing in 
        public spaces. Looking at “i.num” which represents the number of 
        infections of COVID-19 we see that infections without any social 
        distancing policies peak at ~600 cases, with social distancing in 
        public spaces infections peak at ~500 cases, infections are extremely 
        rare (less than ~10) when there is a full shutdown. This indicates that 
        if masks were not able to be used, then a full shutdown would be the best 
        option for preventing COVID-19 infections."),
      h2("Evaluation of the Impact of Mask Usage"),
      p("In both the Deterministic and Stochastic models, masking is the best 
        intervention for limiting COVID-19 infections. In all conditions (no 
        social distancing, social distancing in public spaces, and full 
        shutdowns) masking dramatically decimates the number of COVID-19 cases. 
        This indicates that wearing tightly fitting surgical masks are a highly 
        effective prevention strategy that individuals can adopt to avoid being 
        infected with COVID-19."),
      h2("Limitations of these Models"),
      p("There are several limitations of these models. The first is that these 
        models represent a simple simulation that only takes into consideration 
        the infectiousness of COVID-19 under a couple conditions. In the real 
        world, COVID-19 infections are largely effected by population size, 
        access to health care, the health of an individual, congregate housing, 
        lifestyle choices, adherence to COVID-19 measures, and so on. This model 
        should not be used to predict or interpret the pandemic since it is 
        designed for educational purposes to understand the deterministic and 
        stochastic models. Additionally, there are limitations to the assumptions
        made to model the infectiousness of COVID-19. The numeric values used for
        the different conditions are based on peer reviewed scientific studies, 
        but since there were no studies that uniformly addressed all the 
        conditions simulated, the assumptions come from a variety of studies 
        that may have conflicting results. The studies the assumptions are based 
        on occurred in different geographic regions at different time periods of 
        the COVID-19 pandemic which accounts for the variation of their results.")
    ))

# Define the UI and what pages/tabs go into it
ui <- navbarPage(theme = shinytheme("journal"),
  "Assignment 3 COVID-19 Disease Modeling - Hannah Lukomski",
  page_one,
  page_two,
  page_three,
  page_four
)
