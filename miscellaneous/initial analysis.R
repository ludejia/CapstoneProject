# website:https://www.kaggle.com/anthonypino/melbourne-housing-market
# Domain.com.au
#Suburb: Suburb
#Address: Address
#Rooms: Number of rooms
#Price: Price in Australian dollars
#Method: 
#S - property sold; 
#SP - property sold prior; 
#PI - property passed in; 
#PN - sold prior not disclosed; 
#SN - sold not disclosed; 
#NB - no bid; 
#VB - vendor bid; 
#W - withdrawn prior to auction; 
#SA - sold after auction; 
#SS - sold after auction price not disclosed. 
#N/A - price or highest bid not available.
#Type:
# br - bedroom(s); 
# h - house,cottage,villa, semi,terrace; 
# u - unit, duplex;
# t - townhouse; 
# dev site - development site; 
# o res - other residential.
# SellerG: Real Estate Agent
# Date: Date sold
# Distance: Distance from CBD in Kilometres
# Regionname: General Region (West, North West, North, North east …etc)
# Propertycount: Number of properties that exist in the suburb.
# Bedroom2 : Scraped # of Bedrooms (from different source)
# Bathroom: Number of Bathrooms
# Car: Number of carspots
# Landsize: Land Size in Metres
# BuildingArea: Building Size in Metres
# YearBuilt: Year the house was built
# CouncilArea: Governing council for the area
# Lattitude: Self explanitory
# Longtitude: Self explanitory


house=read.csv('data/Melbourne_housing_FULL.csv')
str(house)
sapply(house,function(x){sum(is.na(x))})
summary(house)
unique(house$Suburb)
table(house$Suburb)
table(house$Regionname)

library(ggmap)
options(scipen=999)



#for gg map you will need to use you google cloud api project key.
#here is the tutorial https://developers.google.com/maps/documentation/embed/get-api-key
#You will also need to enalble the following two APIs in cloud to let the functions working
#Map Static API, Geocoding API
register_google(key = "AIzaSyCyjfy52N-yvo76okcOhh4sc1wSqSMi8oI", write = TRUE)
map=get_map(location='Melbourne',zoom = 10,maptype = "terrain",color = "bw",)
ggmap(map)+geom_point(data = house, aes(x = house$Longtitude, y = house$Lattitude), 
                 color ='red', size = 0.05,alpha=0.15)

(house)

str(house)
#visualize the missing values

sapply(house,function(x){sum(is.na(x))})

library(visdat)
vis_miss(house)

sapply(house,function(x){sum(is.na(x))})
missing=sapply(house,function(x){sum(is.na(x))})
missing=as.data.frame(missing,row.names = NULL)
missing$var=colnames(house)
missing
missing$missing=missing$missing/nrow(house)
missing=missing[order(missing$missing),]
missing
ggplot(missing)+geom_bar(aes(x=reorder(var, missing),y=missing),
                         stat = "identity", fill='grey',)+
        coord_flip()+
        labs(x='percentage missing')


upset(airquality,nsets = 3, number.angles = 30)
upset(house, sets = c("Bathroom", "Car", "BuildingArea", "YearBuilt"),nsets = 6, number.angles = 30)

test=data.frame(a=c(1,1,NA,NA,1),b=c(NA,1,1,1,1),c=c(1,1,NA,1,1))
test
upset(test)

?upset
houseNoNA=na.omit(house)
vis_miss(houseNoNA)

gg_misvar(airquality)

tmp <- mtcars

tmp$car <- rownames(mtcars)
list <- lapply(colnames(mtcars), function(x) {
        tmp[tmp[[x]] > median(tmp[[x]]), "car"]
})
names(list) <- colnames(mtcars)


fromList(list)
class(fromList(list))

upset(fromList(list))

#datamanipulation
#drop address

house=read.csv('data/Melbourne_housing_FULL.csv')
#house$Suburb
dim(house)
table(house$Suburb)
sum(is.na(house$Suburb))
table(house$Suburb, useNA ='always')

#house$address to be removed
#str(house)
#house=house[,-2]

#recategory room type
house$Type=as.character(house$Type)
house[house$Type=='u',]$Type='apartment'
house[house$Type=='h',]$Type='house'
house[house$Type=='t',]$Type='townhouse'
house$Type=as.factor(house$Type)

#remove missing values of the houses
house=house[!is.na(house$Price),]

#Rename category method
table(house$Method, useNA ='always')
house$Method=as.character(house$Method)
house$Method[house$Method=='PI']='property passed in'
house$Method[house$Method=='S']='property sold'
house$Method[house$Method=='SA']='sold after auction'
house$Method[house$Method=='SP']='property sold prior'
house$Method[house$Method=='VB']='vendor bid'
house$Method=as.factor(house$Method)

# convert column date to date format
house$Date
table(house$Date, useNA ='always')
class(house$Date)
library(lubridate)
house$Date=dmy(house$Date)
library(ggplot2)
theme_set(theme_bw())

# converdistance to numeric and change colname
house$Distance=as.numeric(house$Distance)
colnames(house)[9]='distance_to_CBD'


#rooms
house$Rooms
table(house$Rooms)
sum(is.na(house$Rooms))
table(house$Rooms, useNA ='always')

library(ggplot2)
theme_set(theme_bw())

table(house$Rooms, useNA = 'always')
table(house$Bedroom2, useNA = 'always')

test=house[house$Bedroom2==0 & !is.na(house$Bedroom2),]

ggplot(house)+geom_bar(aes(x=house$Rooms), fill='blue')+
        coord_cartesian(xlim=c(0,16),)+ 
        scale_x_continuous(breaks=seq(0, 16, 1))+
        labs(x='Number of Room')

ggplot(house)+geom_bar(aes(x=house$Bedroom2), fill='grey',col='black')+
        coord_cartesian(xlim=c(0,16),)+ 
        scale_x_continuous(breaks=seq(0, 16, 1))+
        labs(x='Number of Room')

#house Type
#h - house,cottage,villa, semi,terrace; 
#u - unit, duplex;
#t - townhouse; 
house$Type
sum(is.na(house$Type))
table(house$Type, useNA ='always')

ggplot(house)+geom_bar(aes(x=house$Type),fill='grey',width = 0.3,col='black')+
        labs(x='house type')


#house$Price

summary(house$Price)
g=ggplot(house)
g+geom_histogram(aes(x=house$Price),
                 binwidth = 20000, fill='blue')+
        labs(title="histogram for house price", x='price')+
        coord_cartesian(xlim=c(0,4000000),)

g+geom_histogram(aes(x=house$Price, fill=house$Type),
                 binwidth = 20000)+
        labs(title="histogram for house price", x='price')+
        coord_cartesian(xlim=c(0,4000000),)



#house$Method        
table(house$Method, useNA ='always')
ggplot(house)+geom_bar(aes(x=house$Method), fill='grey', col='black',
              width = 0.5)+
        theme(axis.text.x = element_text(angle = 30,vjust = 0.5))+
        labs(x='method')
        

#house$SellerG
#remove

#houes$date
library(lubridate)

df_avghouseprice=aggregate(house$Price~house$Date,house,mean)
df_avghouseprice
df_avghouseprice$`house$Date`=dmy(df_avghouseprice$`house$Date`)
colnames(df_avghouseprice)=c('Date','average sold price')
df_avghouseprice
ggplot(df_avghouseprice)+geom_line(aes(x=df_avghouseprice$Date,y=df_avghouseprice$`average sold price`),
                    color="red")+
        labs(x='date', y='average sold price')


house$Distance

summary(house$distance_to_CBD)
g=ggplot(house)
g+geom_histogram(aes(x=house$distance_to_CBD),
                 col='black',fill='grey')+
        labs(title="histogram for distance_to_CBD", x='Distance to CBD(km)')


#postal code only one postal code is missing
str(house)
str(house$Postcode)
table(house$Postcode, useNA ='always')
sum(is.na(house$Postcode))

house[house$Postcode=='#N/A',]

length(unique(house$Postcode))
length(unique(house$Suburb))


#number of Bedroom
#drop as room has the data without any missing value
table(house$Bedroom2, useNA ='always')
df_bedroom=as.data.frame(table(house$Bedroom2, useNA ='always'))
colnames(df_bedroom)=c('number of bedroom','count')
df_bedroom
g_df_bedroom=ggplot(df_bedroom)
g_df_bedroom+geom_bar(aes(x=df_bedroom$`number of bedroom`, y=df_bedroom$count),
                      stat = "identity",
                 col='black',fill='grey')+
        labs(title="Histogram for the number of bedroom", x='number of bedroom',
             y='count')

#house$car
table(house$Car,useNA ='always')

sapply(house,function(x){sum(is.na(x))})
nrow(house[is.na(house$Bedroom2),])
nrow(house[is.na(house$Bathroom),])
nrow(house[is.na(house$Bedroom2)&is.na(house$Bathroom),])

table(house$Bathroom, useNA ='always')





#number of parking,

table(house$Car,useNA ='always')



sum(house[!is.na(house$Bedroom2),]$Rooms==house[!is.na(house$Bedroom2),]$Bedroom2)
nrow(house[is.na(house$Car),])
nrow(house[is.na(house$Landsize),])
nrow(house[is.na(house$Car)&is.na(house$Landsize),])
     


df_car=as.data.frame(table(house$Car, useNA ='always'))
colnames(df_car)=c('number of parking','count')
ggplot(df_car)+geom_bar(aes(x=df_car$`number of parking`, y=df_car$count),
                      stat = "identity",
                      col='black',fill='grey')+
        labs(title="Histogram for the number of parking", x='number of parking',
             y='count')

ggplot(house)+geom_histogram(aes(x=house$Car),
                        col='black',fill='grey')+
        coord_cartesian(xlim=c(0,10),)+
        labs(x='number of parking',
             y='count')


#bathroom
table(house$Bathroom,useNA ='always')

ggplot(house)+geom_bar(aes(x=house$Bathroom), fill='grey',col='black')+
        coord_cartesian(xlim=c(0,16),)+ 
        scale_x_continuous(breaks=seq(0, 16, 1))+
        labs(x='Number of bathroom')

ggplot(house)+geom_point(aes(x=house$Rooms,y=house$Bathroom))

cor.test(house$Rooms,house$Bathroom)

#just impute from room
nrow(house[is.na(house$Bathroom)&is.na(house$Bedroom2),])

#Landsize & building area
#for townhouse and apartment landsize would be much bigger than building area so just use building area

str(house)
test=house[house$Type=='apartment' &! is.na(house$BuildingArea),]
library(ggplot2)
plot1=ggplot(house)+geom_histogram(aes(x=house$Landsize),binwidth = 20,
                                   fill='grey',col='black')+
        coord_cartesian(xlim=c(0,900))+
        labs(x='landsize')
plot2=ggplot(house)+geom_histogram(aes(x=house$BuildingArea),binwidth = 20,
                                   fill='grey',col='black')+
        coord_cartesian(xlim=c(0,700))+
        labs(x='building area')

grid.arrange(plot1, plot2, ncol=2)

test=house[house$Landsize>600,]
test=test[order(-test$Landsize),]


#
table(house$YearBuilt,useNA ='always')


df_year=as.data.frame(table(house$YearBuilt, useNA ='always'))
colnames(df_year)=c('year','count')
df_year$year=as.numeric(as.character(df_year$year))
df_year$year50 <- cut(df_year$year, c(0, 1899,1949,1979,1999,2050),
                      include.lowest = T,
                      right = TRUE)
levels(df_year$year50) <- c("<1900", "1900~1949", "1950~1979", "1980~1999",'2000~2010')
ggplot(df_year)+geom_bar(aes(x=df_year$year50, y=df_year$count),
                         stat = "identity",
                         fill='black', width = 0.5)+
        labs(title="Histogram for year built", x='year',
             y='count')+
        coord_flip()


#Suburb, Regionname, CouncilArea, Postcode

Suburb=nrow(table(house$Suburb))
RegionName=nrow(table(house$Regionname))
CouncilArea=nrow(table(house$CouncilArea))
PostalCode=nrow(table(house$Postcode))
Division=data.frame(a=c('Suburb',"RegionName",'CouncilArea','PostalCode'),
                    b=c(Suburb,RegionName,CouncilArea,PostalCode))
ggplot(Division)+geom_bar(aes(x=reorder(a, b),y=b),
                         stat = "identity", fill='grey',col='black')+
        coord_flip()+
        labs(y='Number of Cateories',x='')


#distance
table(house$Regionname)

house=read.csv('data/Melbourne_housing_FULL.csv')
house$Distance=as.character(house$Distance)
house$Distance=as.numeric(house$Distance)
ggplot(house)+geom_histogram(aes(x=house$Distance), 
                             fill='grey',col='black',binwidth = 2)+
        labs(x='Distance to CBD')























