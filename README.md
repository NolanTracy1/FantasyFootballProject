**Underdog Best Ball Mania III Analysis**
1. Background:

- My brother and I grew up playing fantasy football with our dad. Draft day was always a big event the week before the season started as we would head to a friend’s house with snacks and a big board. We loved drafting so much that Best Ball was a perfect hobby for us because all you do is draft and see how the season plays out. The most optimal lineup is set for you every week and you can't add or drop players. 

- We found Underdog while I was in college obtaining my Bachelors in Statistics and Data Science. Combining my hobby of fantasy football and my schoolwork seemed like a perfect idea, so I searched for the data through Google. To my surprise, Underdog shares the data of their Best Ball Mania tournament (their largest tournament every season).

- This data is in the format of a csv record and contained information about every draft pick made by every entry (https://underdognetwork.com/football/best-ball-research/best-ball-mania-iii-downloadable-pick-by-pick-data). 

- I started by downloading the BBMIII Finalists dataset. This contained the last 470 players remaining in the tournament. I wanted to see how these teams drafted in terms of roster allocation, bye week diversification, and RBs from the same NFL team. 

2. Roster Allocation: 

- This started because I wanted to see which positions get drafted the most by round. I summarized the data by grouping by *team_pick_number* and *position_name* then took the count of these groups. I added an ID column to create a bin for the x-axis by concatenating *position_name* with *team_pick_number* using a -R as the separator to indicate the number is a round (position-R #). Finally, I kept only the top 20 to make the chart more digestible.
![image](https://github.com/NolanTracy1/FantasyFootballProject/assets/125767620/2b4738c7-62f4-4cb7-9e7e-4f5250ef227f)
- This chart shows that most of the early picks and just picks in general are WRs and RBs. This makes sense because the weekly starters are 1 QB, 2 RB, 3 WR, 1 TE, and 1 FLEX (RB, WR, TE). So most of your starters are RBs and WRs. The general lesson from this chart is to allocate most of your picks to WRs, especially with early picks. However, as I mentioned this chart has flaws because logically there won't be as many QBs and TEs being drafted (particularly in the early rounds).

- The next question I had is: when do most teams take their first QB? I did this by filtering the raw data for only QBs then grouped by *tournament_entry_id* and took the minimum of *team_pick_number*. Then I did another group by this minimum round number and counted the *tournament_entry_id*.

![image](https://github.com/NolanTracy1/FantasyFootballProject/assets/125767620/301943de-780a-4c2a-adfe-c1bb2eb93552)
-This chart shows that most people took their first QB in rounds 5 and 6. The other takeaway is to take your first QB before round 11. 

- The last roster allocation question was: How many of each position should be drafted? I started by grouping the data by *tournament_entry_id* and *position_name* then counted *player_name*. I then grouped by *position_name* and the count while counting the *tournament_entry_id*.

![image](https://github.com/NolanTracy1/FantasyFootballProject/assets/125767620/22b28aba-c67d-4ab1-bb01-b099dff36608) 
- This chart shows how many of each position should be drafted to make it to the finals. Since it is an 18 round draft, an optimal build would be 2 or 3 QB, 5 or 6 RB, 2 or 3 TE, and between 7-9 WRs.

3. Bye Week Diversification
- The next question I had was: Does diversifying bye weeks matter? A lack of diversification in bye weeks could lead to 0 points from one of your starting spots. This mainly matters by position, so I looked at the diversification per position. I started by grouping by *tournament_entry_id*, *bye_week*, and *position_name* with a count. Then I performed another group by with *tournament_entry_id* and *position_name* to get how many teams had x amount players with the same bye week per position. 
![image](https://github.com/NolanTracy1/FantasyFootballProject/assets/125767620/480f78f3-d914-408a-a088-226bc6acb5a9)
- A one on this chart means that only 1 player had X bye week, so most teams have 2 QBs (from our last chart) with each of those QBs having a different bye week. Therefore, you shouldn't draft QBs or TEs with the same bye weeks (you could if you take 3) and you shouldn't take more than 3 RBs or WRs with the same bye week.  
4. RBs from the same NFL Team
- The logic behind drafting 2 RBs from the same NFL team can be confusing. On the one hand, you can secure a backup in case your player gets hurt. On the other hand, you are limiting your total upside because one of those players will likely be not usable in most weeks. There are some unique backfields where the RBs skillsets don't overlap (one is a between the tackle RB and one is a receiving RB). This lead to my final question: How many teams had 2 RBs from the same NFL team in the finals? To answer this, I had to find an outside dataset that had players with their corresponding teams. After I found a useful CSV file from Google, I used SQL to join the 2 datasets. At first there was duplication, which did not make much sense because I was using a right outer join. After further investigation I found that there were 2 players named Josh Allen (a QB and a LB). I was able to remove the linebacker because there are no defensive players in our player pool. I took this new dataset to R and grouped by *tournament_entry_id, *position_name*, and *Tm* and got a count. Then I filtered for only RBs and team not equal '2TM' or '3TM' (players that played for multiple teams during the season). I then counted the total number of 1 and 2 RBs from a team. 
![image](https://github.com/NolanTracy1/FantasyFootballProject/assets/125767620/95b663c1-3ab1-4cc9-b201-52e0149da020)
- This chart shows that most teams that made the finals did not draft RBs from the same NFL team. There were 62 pairs of RBs drafted from the same NFL team and 2242 RBs that were drafted without pairing with another RB from the same team.
5. Conclusion:
- All this analysis should be taken with a grain of salt because past results do not equal future performance. Additionally, 470 teams is a small sample size and there are plenty of random factors that play into an NFL season. Overall, I think the main takeaways are don't draft RBs from the same NFL team (in most situations), avoid taking too many players of the same position with the same bye week, and build teams with 2 or 3 QB, 5 or 6 RB, 2 or 3 TE, and between 7-9 WRs.
