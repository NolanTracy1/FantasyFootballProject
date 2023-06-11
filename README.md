**Underdog Best Ball Mania III Analysis**
1. Background:

- My brother and I grew up playing fantasy football with our Dad. Draft day was always a big event the week before the season started as we would head to a friends house with snacks and a big board. We loved drafting so much that Best Ball was a perfect hobby for us because all you do is draft and see how the season plays out. The most optimal lineup is set for you every week and you can't add or drop players. 

- We found Underdog while I was in college obtaining my Bachelors in Statistics and Data Science. Combining my hobby of fantasy football and my school work seemed like a perfect idea, so I seeked out the data through Google. To my surprise, Underdog shares the data of their Best Ball Mania tournament (their largest tournament every season).

- This data is in the format of a csv record and contained information about every draft pick made by every entry (https://underdognetwork.com/football/best-ball-research/best-ball-mania-iii-downloadable-pick-by-pick-data). 

- I started by downloading the BBMIII Finalists dataset. This contained the last 470 players remaining in the tournament. I wanted to see how these teams drafted in terms of roster allocation, bye week diverification, and RBs from the same NFL team. 

2. Roster Allocation: 

- This started because I wanted to see which positions get drafted the most by round. I summarized the data by grouping by *team_pick_number* and *position_name* then took the count of these groups. I added an ID column to create a bin for the x-axis by concatenating *position_name* with *team_pick_number* using a -R as the seperator to indicate the number is a round (position-R #). 
