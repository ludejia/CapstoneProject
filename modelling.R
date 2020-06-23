## Modelling

linear = lm(PriceSQM ~., house)
summary(linear)
cor(house)

house_cat= house
house_cat$Rooms=as.character(house_cat$Rooms)
house_cat$Rooms=as.factor(house_cat$Rooms)

house_cat$Rooms=as.character(house_cat$Rooms)
house_cat$Rooms=as.factor(house_cat$Rooms)

house_cat$Bathroom=as.character(house_cat$Bathroom)
house_cat$Bathroom=as.factor(house_cat$Bathroom)

house_cat$Car=as.character(house_cat$Car)
house_cat$Car=as.factor(house_cat$Car)

str(house_cat)

summary(house)

linear_cat = lm(PriceSQM ~., house_cat)
summary(linear_cat)

# numeric correlation
summary(house_numeric)
colnames(house)[c(2,3,9,10)]
str(house)
house_numeric=house[,c(-2,-3,-8,-9)]
corr <- cor(house_numeric)
ggcorrplot(corr, hc.order = TRUE, 
           type = "lower", 
           lab = TRUE, 
           lab_size = 3, 
           method="circle", 
           colors = c("tomato2", "white", "springgreen3"), 
           title="Correlogram of house", 
           ggtheme=theme_bw)

linear_test = lm(PriceSQM ~., house_numeric)
summary(linear_test)

corr1=ggplot(house)+geom_point(aes(x=house$YearBuilt,y=house$PriceSQM), color='blue', alpha=0.10)+
        labs(x='YearBuilt', y='PriceSQM' )

corr2=ggplot(house)+geom_point(aes(x=house$Distance,y=house$PriceSQM), color='red', alpha=0.10)+
        labs(x='Distance', y='PriceSQM' )

grid.arrange(corr1, corr2, ncol=2)

str(house)

house=house[,-which(names(house)=='PriceSQM')]


library(MASS)
null=lm(PriceSQM~1,data=house_cat)
full=lm(PriceSQM~.,data=house_cat)
stepAIC(null, scope=list(lower=null, upper=full), direction= "forward", trace=TRUE)
stepAIC(full, direction= "backward", trace=TRUE)
stepAIC(null, scope=list(lower=null, upper=full), direction= "both", trace=TRUE)
stepAIC(full, direction= "both", trace=TRUE)

test=lm(formula = Price ~ BuildingArea + CouncilArea + Type + Distance + 
           YearBuilt + Bathroom + Rooms + Regionname + BuildingAreaRatio + 
           Method + Car + AVGprice, data = house)

summary(test)


normalize_z <- function(x) {
        return ((x - mean(x) / sd(x))) }




#common normalize
normalize_common <- function(x) {
        return ((x - min(x)) / (max(x) - min(x))) }
#z normalize
normalize_z <- function(x) {
        return ((x - mean(x) / sd(x))) }

normalize_common(test)
normalize_z(test)

aa=c(1,5,-6,6,3,5)
normalize_z(aa)
#common normalize
normalize_common <- function(x) {
        return ((x - min(x)) / (max(x) - min(x))) }
#z normalize
normalize_z <- function(x) {
        return ((x - mean(x) / sd(x))) }

normalize_common(test)
normalize_z(test)
mean(test$model$Price)
sd(test$model$Price)

summary(test$model$Price)
summary(Zprice)

test2=test$model$Price
test2
test$residuals

library("psycho")

res=test$residuals/1000000
summary(res)
summary(Zprice)
summary(test)
hist(res)

?scale
Zprice=normalize_z(res)
Zprice
ZpricSQM=normalize_z(model_linear$residuals)
hist(ZpricSQM)
summary(ZpricSQM)
summary(model_linear$residuals)
boxplot(Zprice)
boxplot(ZpricSQM)



test$residuals

test$model$Price

residual=data.frame(residual=test$residuals/10, fitted=test$fitted.values)
pred=data.frame(pred=test$model$Price, fitted=test$fitted.values)
ggplot(pred)+geom_point(aes(x=fitted,y=pred), color='blue', alpha=0.10)+
        coord_cartesian(xlim=c(0,4000000), ylim=c(0,4000000))

full=lm(Price~.,data=house)

null=lm(Price~1,data=house)
full=lm(Price~.,data=house)
stepAIC(null, scope=list(lower=null, upper=full), direction= "forward", trace=TRUE)
stepAIC(full, direction= "backward", trace=TRUE)
stepAIC(null, scope=list(lower=null, upper=full), direction= "both", trace=TRUE)
stepAIC(full, direction= "both", trace=TRUE)

linear=lm(formula = PriceSQM ~ Rooms + Type + Method + Distance + Bathroom + 
                  Car + YearBuilt + CouncilArea + Regionname + BuildingAreaRatio + 
                  AVGprice, data = house_cat)
summary(linear)
ncol(house)

plot(model_linear)


model_linear=lm(PriceSQM ~ Rooms + Type + Method + Distance + Bathroom + 
                        Car + YearBuilt + CouncilArea + Regionname + BuildingAreaRatio + 
                        AVGprice, data = house)
summary(model_linear)

model_linear2=lm(PriceSQM ~ Rooms + Type + Method + Bathroom + 
                        Car + CouncilArea + Regionname + BuildingAreaRatio + 
                        AVGprice, data = house)


#pricePSQ vs price fited
residual=data.frame(pricesqm=model_linear$model$PriceSQM, fitted=model_linear$fitted.values)
ggplot(residual)+geom_point(aes(x=fitted,y=pricesqm), color='blue', alpha=0.10)+
        coord_cartesian(xlim=c(0,10000),ylim=c(0,10000))

residual=data.frame(residual=model_linear$residuals, fitted=model_linear$fitted.values)
ggplot(residual)+geom_point(aes(x=fitted,y=residual), color='blue', alpha=0.10)+
        coord_cartesian(ylim=c(-8000,8000))

residual2=data.frame(residual=model_linear2$residuals, fitted=model_linear2$fitted.values)

res1=ggplot(residual)+geom_point(aes(x=fitted,y=residual), color='blue', alpha=0.10)+
        coord_cartesian(ylim=c(-8000,8000))

res2=ggplot(residual2)+geom_point(aes(x=fitted,y=residual), color='blue', alpha=0.10)+
        coord_cartesian(ylim=c(-8000,8000))
grid.arrange(res1, res2, ncol=2)


grid.arrange(pd1, pd2, ncol=2)
summary(residual)
summary(model_linear)

summary(house$Price)
str(house)
str(house_numeric)
house_numeric=house[,-which(names(house)=='Type')]
house_numeric=house[,-which(names(house)=='Method')]
house_numeric=house[,-which(names(house)=='CouncilArea')]
house_numeric=house[,-which(names(house)=='Regionname')]
which(names(house)=='Type')


house_cat= house
house_cat$Rooms=as.character(house_cat$Rooms)
house_cat$Rooms=as.factor(house_cat$Rooms)

house_cat$Rooms=as.character(house_cat$Rooms)
house_cat$Rooms=as.factor(house_cat$Rooms)

house_cat$Bathroom=as.character(house_cat$Bathroom)
house_cat$Bathroom=as.factor(house_cat$Bathroom)

house_cat$Car=as.character(house_cat$Car)
house_cat$Car=as.factor(house_cat$Car)

str(house_cat)
full2=lm(Price~.,data=house_cat)
summary(full2)


full=lm(Price~.,data=house)

null=lm(Price~1,data=house)
full=lm(Price~.,data=house)
stepAIC(null, scope=list(lower=null, upper=full), direction= "forward", trace=TRUE)
stepAIC(full, direction= "backward", trace=TRUE)
stepAIC(null, scope=list(lower=null, upper=full), direction= "both", trace=TRUE)
stepAIC(full, direction= "both", trace=TRUE)

model_linear=lm(formula = Price ~ Rooms + Type + Method + Distance + Bathroom + 
                        Car + BuildingArea + YearBuilt + CouncilArea + Regionname + 
                        BuildingAreaRatio + AVGprice, data = house)
summary(model_linear)

residual=data.frame(residual=model_linear$residuals, prediction=model_linear$fitted.values)
pred=data.frame(price=model_linear$model$Price, prediction=model_linear$fitted.values)

ggplot(residual)+geom_histogram(aes(x=residual),
                             binwidth = 0.1, fill='grey', col='black')+
        coord_cartesian(xlim=c(-1.5,1.5))+
        scale_x_continuous(breaks=seq(-1.5,1.5,0.5))+
        labs(title = 'histogram of residuals (unit: million dollars)')

ggplot(pred)+geom_point(aes(y=prediction,x=price), color='blue', alpha=0.10)+
        coord_cartesian(xlim=c(0,3), ylim=c(0,3))+
        labs(title='price vs predection (unit: million)', x='price (million)')

ggplot(residual)+geom_point(aes(x=prediction,y=residual), color='blue', alpha=0.10)+
        labs(title='prediction vs residual (unit: million)',
             x='prediction ', y='residual')+
        coord_cartesian(xlim=c(0,2), ylim=c(-2,2))



ggplot(residual)+

bc = boxcox(lm(Price~BuildingArea, data = house),lambda=seq(-3,3,by=.1))
lambda<-bc$x[which.max(bc$y)]

model_linear=lm(formula = Price ~ Rooms + Type + Method + Distance + Bathroom + 
                        Car + BuildingArea + YearBuilt + CouncilArea + Regionname + 
                        BuildingAreaRatio + AVGprice, data = house)
testmodel=lm(Price~Regionname, data = house)
summary(testmodel) 

