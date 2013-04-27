library(RJSONIO)
## set the file below for your directory.
dat <- fromJSON("awesome.json")
summary(dat) 
## unlist(dat) to find stop and route data seperated.
stops  <- sapply( dat$stop_schedules, unlist )
routes <- sapply( dat$routes, unlist )


## yes I know how ugly this loop looks. 
for(i in 1:length(routes)){ 
  route <- routes[[9]]
  route <- gsub("/"," or ",routes[[9]])
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
  route.mat <- t(matrix(route.abv,nrow=4))
  colnames(route.mat) <- c("stops.id", "stops.name", "stops.lat", "stops.lng")
  write.csv(route.mat, file = paste(route[2],sep = "", ".csv"))
}
