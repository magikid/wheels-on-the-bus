library(RJSONIO)
dat <- fromJSON("awesome.json")
summary(dat) ## unlist() choices
stops  <- sapply( dat$stop_schedules, unlist )
routes <- sapply( dat$routes, unlist )

route_id <- c()
for(i in 1:length(routes)) {
route_id[i] <- routes[[i]][1]
}

stops <- list()
for(i in 1:length(routes)){ 
  route <- gsub("/"," or ",routes[[i]])
  a <- c(1,2)
  b <- which(names(route) == "vehicles.direction")
  c <- which(names(route) == "vehicles.last_stop") 
  d <- which(names(route) == "vehicles.status")  
  e <- which(names(route) == "vehicles.lng")
  f <- which(names(route) == "vehicles.lat")
  g <- which(names(route) == "vehicles.id") 
  remove.lat <- which(names(route) == "geometry.lat") 
  remove.lng <- which(names(route) == "geometry.lng") 
  route.abv <- route[-c(a,b,c,d,e,f,g,remove.lat,remove.lng)]
  stops[[i]] <- t(matrix(route.abv,nrow=4))
  #colnames(route.mat) <- c("stops.id", "stops.name", "stops.lat", "stops.lng")
  #write.csv(route.mat, file = paste(route[2],sep = "", ".csv"))
}

finalstops.a <- matrix(0,ncol = 4)
colnames(finalstops.a) <- c("stop_id", "stop_name", "stop_lat", "stop_lon")

for(i in 1:length(stops)) {
   finalstops.a <- rbind(finalstops.a,stops[[i]])
}

finalstops.c <- data.frame(finalstops.a)
finalstops.d <- finalstops.c[-1, ]

## Are there equal stop_id's and names for stops?
length(levels(as.factor(finalstops.d$stop_id))) == length(levels(as.factor(finalstops.d$stop_name)))
## duplicates removed for stop_id's.  Two duplicates for stop_name remain but is not a concern. 
finalstops.e <- finalstops.d[-which(duplicated(finalstops.d$stop_id)), ]
## STOPS.CSV
write.csv(finalstops.e, "stops.csv", row.names = F)
