#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(RColorBrewer)
library(shiny)
library(tidyverse)

# read in files
student_costs = read_csv('university_textbook_and_homework_costs.csv')

# list of homework materials
homework_material = student_costs %>% 
  distinct(material)

# list of homework material 2
homework_material_2 = student_costs %>% 
  distinct(material)

# list of grade levels
grade_level = student_costs %>% 
  distinct(level)

# new df with counts of each observation
price_range_count = student_costs %>% 
  group_by(level, material) %>% 
  count(price_range)

# create new student_costs df with price range as numeric value
student_costs_altered = data.frame(student_costs)
student_costs_altered$price_range[student_costs_altered$price_range == '$0'] <- '0'
student_costs_altered$price_range[student_costs_altered$price_range == '$1-$99'] <- '1'
student_costs_altered$price_range[student_costs_altered$price_range == '$100-$199'] <- '2' 
student_costs_altered$price_range[student_costs_altered$price_range == '$200-$299'] <- '3'
student_costs_altered$price_range[student_costs_altered$price_range == '$300-$399'] <- '4'
student_costs_altered$price_range[student_costs_altered$price_range == '$400-$499'] <- '5'
student_costs_altered$price_range[student_costs_altered$price_range == '$500-$599'] <- '6'
student_costs_altered$price_range[student_costs_altered$price_range == '$600-$699'] <- '7'
student_costs_altered$price_range[student_costs_altered$price_range == '$700-$799'] <- '8'
student_costs_altered$price_range[student_costs_altered$price_range == '$800+'] <- '9'
student_costs_altered$price_range = as.numeric(student_costs_altered$price_range)

# create df for overall student totals
price_ranges = c('$0', '$1-$99', '$100-$199', '$200-$299', '$300-$399', '$400-$499', '$500-$599', '$600-$699', '$800+')
percentages = c(23.23, 18.71, 27.74, 16.13, 7.74, 1.94, 0.65, 0.65, 3.23)
overall_spending = data.frame(price_ranges, percentages)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("UArizona student material costs dashboard for Fall 2021 semester"),

    # Sidebar with info 
    sidebarLayout(
        sidebarPanel(
          h3('Homework material'),
          p('Click on tabs to view different visualizations of the distribution of student homework expenses.'),
          HTML('Data collected from the <a href=https://www.notion.so/University-textbook-and-homework-costs-04a4c16bc6064c9c8e6f54d5a6c86014>University of Arizona UX Team talk back board.</a>')
        ),

        # Show different plots
        mainPanel(
          tabsetPanel(type='tabs',
                      tabPanel('Bar plot',
                               # first input
                               selectInput('material',
                                           'Select a material to view:',
                                           choices=homework_material),
                               # second input
                               selectInput('level',
                                           'Select a grade level to view:',
                                           choices=grade_level),
                               plotOutput('bar_plot')),
                      tabPanel('Box plot',
                               selectInput('material_2',
                                           'Select a material to view:',
                                           choices=homework_material_2),
                               plotOutput('box_plot')),
                      tabPanel('Pie chart', plotOutput('pie_chart')))
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$bar_plot <- renderPlot({
      
      data_to_plot = price_range_count %>% 
        group_by(level)
      
      highlighted_region <- data_to_plot %>%
        filter(material == input$material, level == input$level)
      
      data_to_plot %>%
        ggplot(aes(x = n,
                   y = price_range,
                   fill=price_range)) +
        geom_col(data=highlighted_region) +
        #geom_label(fill='white') +
        labs(x = 'Number of students',
             y = 'Price range',
             caption = 'Price range intervals skipped where no student responses present',
             fill = 'Purchase values',
             title = 'Frequency of the number of students who paid for materials per price range') +
        scale_fill_manual(values = brewer.pal(9, 'Reds')) +
        theme_minimal() +
        theme(legend.position = 'none')
    })
    
    output$box_plot <- renderPlot({
      
      data_to_plot = student_costs_altered %>% 
        group_by(level, material)
      
      highlighted_region <- data_to_plot %>%
        filter(material == input$material_2)
      
      data_to_plot %>% 
        ggplot(aes(x=level,
                   y=price_range,
                   fill=level)) +
        geom_boxplot(data=highlighted_region) +
        theme_minimal() +
        labs(x = 'Grade level',
             y = 'Price range',
             caption='Price range intervals skipped where no student responses present',
             title = 'Distribution of material prices per grade level') +
        theme(legend.position = 'none') +
        scale_y_discrete(limits=c('$0', '$1-$99', '$100-$199', '$200-$299', '$300-$399', '$400-$499', '$500-$599', '$600-$699', '$800+'))
    })
      
    
    output$pie_chart <- renderPlot({
      
      overall_spending = overall_spending %>% 
        arrange(desc(price_ranges)) %>% 
        mutate(prop=percentages / sum(overall_spending$percentage) * 100) %>% 
        mutate(ypos=cumsum(prop) - 0.5*prop)
      
      ggplot(overall_spending,
             aes(x='',
                 y=prop,
                 fill=price_ranges)) +
        geom_bar(stat='identity', width=1, color='white') +
        coord_polar('y', start=0) +
        theme_minimal() +
        scale_fill_brewer(palette='YlGnBu') +
        labs(x = '',
             y = '',
             caption = 'Price range intervals skipped where no student responses present',
             fill = 'Price range',
             title = 'Overall student spending on all materials')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
