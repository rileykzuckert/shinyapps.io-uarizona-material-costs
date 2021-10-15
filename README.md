# UArizona textbook and homework access code costs for Fall 2021 semester

shinyapps.io interactive visualization of how much UArizona students spent on homework materials for the Fall 2021 semester
https://rileykzuckert.shinyapps.io/university-homework-material-costs-dashboard/


Programming language: R


Data collection: This data was collected from a talk back board survey hosted by the University of Arizona Libraries UX Team (conducted by myself). The board was placed in the lobby of Main Library for two weeks and received over 250 responses. The board focused on the questions, "How much did you spend on textbooks this semester?" and "How much did you spend on homework access codes this semester?" The price range catergories were separated into ten bins, ranging from $0 to $800+. Undergraduate students and graduate students were targeted to participate, separating their responsy color when marking their "vote" on the board. For a full explanation of the board, see https://www.notion.so/University-textbook-and-homework-costs-04a4c16bc6064c9c8e6f54d5a6c86014.


Data description: The variables collected from the talk back board to be input into a data frame for the shinyaps.io are material, price range, and level of school. Material is separated into textbook and homework access code, price range is split into bins comprising $0, $1-$99, $100-$199, $200-$299, $300-$399, $400-$499, $500-$599, $600-$699, $700-$799, and $800+, and with level separated into undergraduate students and graduate students.


Overview of the visualizations:
1. Bar graphs depicting how many students from the survey paid for materials at each price range, grouped by material and level.
2. Box plots displaying the distribution of student material costs, grouped by material and level.
3. Pie chart displaying the overall distribution of student payments for materials.
