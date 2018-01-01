setwd("/home/pablote/pdrive/pwork/basketball-r/analytical/data/files/")

standings <- read.csv("standings.csv")
teamBoxScore <- read.csv("teamBoxScore.csv")
mrg <- merge(x=standings, y=teamBoxScore, by.x=c("stDate", "teamAbbr"), by.y=c("gmDate", "teamAbbr"),all.y=TRUE)
mrg$stDate <- as.Date(mrg$stDate)

team <- mrg[which(mrg$teamAbbr=='CHI'),]
team <- subset(team, stDate > "2016-12-01")

par(mfrow=c(1,2))

plot(team$stDate,
     team$pyth.13.91,
     type="l",
     col="blue",
     xlab="Game Date",
     ylab="Win Percentage",
     main = "Pythagorean 13.91 Win%",
     cex.main=0.75
)

dailyWinPct <- team$gameWon / team$gamePlay
lines(team$stDate, dailyWinPct, "l", col="red")

maxDate <- subset(team, team$stDate == max(team$stDate))
seasonWinPct <- maxDate$gameWon / maxDate$gamePlay
abline(c(seasonWinPct,0))

legend("topright", 
       lty = 1,
       col = c("blue", "red", "black"), 
       legend = c("Pyth13.91", "Daily", "Season"),
       cex=0.5
)

plot(team$stDate,
     team$pw.,
     type="l",
     col="green",
     xlab="Game Date",
     ylab="Win Percentage",
     main = "Projected Win%",
     cex.main=0.75
)

lines(team$stDate, dailyWinPct, "l", col="red")

abline(c(seasonWinPct,0))

legend("topright", 
       lty = 1,
       col = c("green", "red", "black"), 
       legend = c("Projected Win%", "Daily", "Season"),
       cex=0.5
)

mtext("12/01/16 to 04/12/17 for Chicago Bulls", side=3, line=-1, outer=T)
