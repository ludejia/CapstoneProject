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


house=read.csv('/Users/dejialu/Documents/Data Science/Ryerson/CKME136/Project/data/Melbourne_housing_FULL.csv')
str(house)
sapply(house,function(x){sum(is.na(x))})
summary(house)
unique(house$Suburb)
table(house$Suburb)
table(house$Regionname)

library(ggmap)

#for gg map you will need to use you google cloud api project key.
#here is the tutorial https://developers.google.com/maps/documentation/embed/get-api-key
#You will also need to enalble the following two APIs in cloud to let the functions working
#Map Static API, Geocoding API
register_google(key = "AIzaSyCyjfy52N-yvo76okcOhh4sc1wSqSMi8oI", write = TRUE)


map=get_map(location='Melbourne',zoom = 10,maptype = "terrain",color = "bw",)
test=ggmap(map)
house=read.csv('/Users/dejialu/Documents/Data Science/Ryerson/CKME136/Project/data/Melbourne_housing_FULL.csv')
test+ geom_point(data = house, aes(x = house$Longtitude, y = house$Lattitude), 
                 color ='blue', size = 0.1,alpha=0.20)


