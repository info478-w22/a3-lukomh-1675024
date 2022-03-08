# load your libraries
library(shiny)
require("EpiModel")

# Deterministic Model 
server <- function(input, output) {
  
  output$dcm <- renderPlot({
    
    param.dcm <- param.dcm(inf.prob = as.numeric(input$mask_menu), 
                           act.rate = as.numeric(input$sd_menu), 
                           rec.rate = 0.07)
    init.dcm <- init.dcm(s.num = 999, i.num = 1,r.num = 0)
    control.dcm <- control.dcm(type = "SIR", nsteps = 500)
    mod.dcm <- dcm(param.dcm, init.dcm, control.dcm)
    plot(mod.dcm, alpha = 0.80, lwd = 3, main = "Deterministic Model")
    
  })
# Stochastic Model/Individual contact model
  
  output$icm <- renderPlot({
    
    param.icm <- param.icm(inf.prob = as.numeric(input$mask_menu), 
                           act.rate = as.numeric(input$sd_menu), 
                           rec.rate = 0.07)
    init.icm <- init.icm(s.num = 999, i.num = 1,r.num = 0)
    control.icm <- control.icm(type = "SIR", nsims = 100, nsteps = 500)
    mod.icm <- icm(param.icm, init.icm, control.icm)
    plot(mod.icm, alpha = 0.80, lwd = 3, main = "Stochastic/Individual Contact Model")
    
  })
  
}
