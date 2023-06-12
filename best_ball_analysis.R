##Load Libraries
library(magrittr)
library(dplyr)
library(ggplot2)

##Read CSV Dataset
ball <- read.csv("BBM_III_Data_Dump_Finals_01302023.csv")

###Which positions get drafted the most by round?###

##Count Positions per Round
ball_sum <- ball %>%
  group_by(team_pick_number ,position_name) %>%
  summarize(total_count =n(), .groups = 'drop')

##Add ID Column by concatenating position, pick#, and a -R
ball_sum['ID']<- paste(ball_sum$position_name,ball_sum$team_pick_number, sep = '-R ')

##Order data in descending Order and keep the top 20 rows
ball_sort <- ball_sum[order(-ball_sum$total_count),]
top_20 <- head(ball_sort,20)

##Factor levels in decreasing order
top_20$ID <- factor(top_20$ID,           
      levels = top_20$ID[order(top_20$total_count, decreasing = TRUE)])

##Bar Plot to Display Totals
ggplot(data=top_20, aes(x=ID, y=total_count))+
  geom_bar(stat='identity')+
  ggtitle("# of Positions Drafted by Round")+
  xlab("Position - Round Number")+
  ylab("# of Picks")

###What rounds are most common for TEs to be drafted in?###

##Filter for only TE
TE <- subset(ball_sort, ball_sort$position_name == 'TE')

##Factor levels in decreasing order
TE$ID <- factor(TE$ID,           
                    levels = TE$ID[order(TE$total_count, decreasing = TRUE)])

##Plot totals
ggplot(data=TE, aes(x=ID, y=total_count))+
  geom_bar(stat='identity')+
  ggtitle("# of TEs Drafted by Round")+
  xlab("Position - Round Number")+
  ylab("# of Picks")



###How many of each position should be drafted?###

##Group data by Entry ID and Position Name (count Player Name)
num_positions <- aggregate(player_name ~ tournament_entry_id + position_name, data = ball, FUN = length)

##Group by Position Name and Count of Player Name (count Entry ID)
num_builds <- aggregate(tournament_entry_id ~ player_name + position_name, data = num_positions, FUN = length)

##Concatenate the Counts with the Position Name to create the bins
num_builds$number_of_position <- paste(num_builds$player_name, num_builds$position_name)

##Create bar plot that displays the counts
barplot(num_builds$tournament_entry_id,xlab = 'Builds',ylab = '# of Teams',main = '# of Positions per Team', names.arg = num_builds$number_of_position)

###When do most teams take their 1st QB###

##Filter Picks for only QB
qb<- subset(ball, ball$position_name == 'QB')

##Group By Entry ID
qb_min <- qb %>%
  group_by(tournament_entry_id) %>%
  summarise_at(vars(team_pick_number),
               list(min = min))

first_qb <- qb_min%>%
  group_by(min) %>%
  summarize(total_count =n(), .groups = 'drop')

ggplot(data=first_qb, aes(x=min, y=total_count))+
  geom_bar(stat='identity')+
  ggtitle("1st QB Drafted per Team")+
  xlab("Round Number")+
  ylab("# of Teams")+
  scale_x_continuous(breaks = seq(min(first_qb$min), max(first_qb$min), by = 1))


###Does diverisying bye weeks matter?###

##Group by Entry Id, Bye Week #, and Position then Count players
bye_position <- ball %>%
  group_by(tournament_entry_id, bye_week, position_name) %>%
  summarize(total_count =n(), .groups = 'drop')

##Group By Entry ID
bye_pos_max <- bye_position %>%
  group_by(tournament_entry_id, position_name) %>%
  summarise_at(vars(total_count),
               list(bye_week_count = max))

##Bar chart
ggplot(bye_pos_max, aes(x = bye_week_count, y = bye_week_count, fill = position_name)) +
  geom_col()+
  ggtitle("# of Players with same Bye Week")+
  xlab("Players with Bye Week")+
  ylab("Player Count")


##Import Team Data
teams<- read.csv('player_team.csv')

###How many teams had 2 RBs from the same NFL team?###

##Group by Entry ID, Position Name, and Team
rb_team <- teams %>%
  group_by(tournament_entry_id ,position_name, Tm) %>%
  summarize(total_count =n(), .groups = 'drop')

##Filter for RBs that were only on 1 team through out the season
rb<- subset(rb_team, rb_team$position_name == 'RB' & (rb_team$Tm != '2TM' & rb_team$Tm != '3TM'))

##Count the teams
rb_count <- rb %>%
  count(total_count)

##Bar Plot
ggplot(rb_count, aes(x = total_count, y = n)) +
  geom_bar(stat = 'identity') +
  geom_text(aes(label = n),  vjust = -0.5, size = 4)+
  ggtitle("2+ RBs Selected from same NFL Team")+
  xlab("1 RB VS 2 RB")+
  ylab("Count")
   



            
