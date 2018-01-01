setwd("/home/pablote/pdrive/pwork/basketball-social/kaggle/files")
#install.packages("ggplot2")

library(ggplot2)

standings <- read.csv("2016-17_standings.csv")
standings$stDate <- as.Date(standings$stDate)

team <- standings[which(standings$teamAbbr=='CHI'),]
team <- subset(team, stDate > "2016-12-15")

maxDate <- subset(team, team$stDate == max(team$stDate))
seasonWinPct <- maxDate$gameWon / maxDate$gamePlay

sosPythWinPct <- (team$pyth.13.91 + team$sos) / 2
sosProjWinPct <- (team$pw. + team$sos) / 2

tail(team)

g <- ggplot(data=team, aes(x=stDate)) +
    geom_line(aes(y=seasonWinPct, color="Season Win%")) +
    ylab(label="Win Percentage") +
    xlab(label="Date") +
    ggtitle("12/15/16 to 04/12/17 for Chicago Bulls") +
    scale_colour_manual("", 
        breaks = c("Season Win%", "Pyth13.91 Win%", "Projected Win%", "SosPyth13.91 Win%", "SosProjected Win%"),
        values = c("Season Win%"="black", "Pyth13.91 Win%"="blue", "Projected Win%"="green", "SosPyth13.91 Win%"="red", "SosProjected Win%"="darkgoldenrod4"))
g

g + geom_line(aes(y=pyth.13.91, color="Pyth13.91 Win%")) +
    geom_point(aes(y=pyth.13.91, color="Pyth13.91 Win%")) +
    geom_line(aes(y=pw., color="Projected Win%")) +
    geom_point(aes(y=pw., color="Projected Win%")) +
    geom_line(aes(y=sosPythWinPct, color="SosPyth13.91 Win%")) +
    geom_point(aes(y=sosPythWinPct, color="SosPyth13.91 Win%")) +
    geom_line(aes(y=sosProjWinPct, color="SosProjected Win%")) +
    geom_point(aes(y=sosProjWinPct, color="SosProjected Win%"))
