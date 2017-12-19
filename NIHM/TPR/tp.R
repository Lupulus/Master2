data = read.table("data.txt", header=TRUE, sep=",")
participant2SurfPad=subset(data,Participant==2 & Technique=="SurfPad")
mean(participant2SurfPad[,"Time"])
techniques=unique(data$Technique)
participants = unique(data$Participant)
readData(data, "SurfPad")

readData = function(dataframe, technique){
  tempParticipants = 0;
  for(i in 1:length(participants)){
    participant2SurfPad=subset(data,Participant==i & Technique==technique)
    p <- mean(participant2SurfPad[,"Time"])
    for(j in 1:length(p))
       tempParticipants = tempParticipants + p[i] 
  }
  print(tempParticipants)
  return(tempParticipants / length(participants))
}
