print(Data)
# first 6 rows of the data
row <- head(Data)
print(row)
# Dimension of the dataset
dim(Data)
# Names of the variables
names(Data)
# Basics statistical mesures
summary(Data[6:12])
#interpratation
#The dataset contains various attributes related to employee demographics and work experience. Below is a detailed interpretation of the summary statistics for key variables:

  ##1. Monthly Income
#1st Quartile: $2,911 signifies that 25% of employees earn this amount or less.
Median: The median monthly income is $4,919, meaning half of the employees earn below this threshold.
Mean: The average monthly income is $6,503, suggesting that while many employees earn moderate salaries, a few high earners may be skewing the average upwards.
3rd Quartile: $8,379 indicates that 75% of employees earn this amount or less.
Maximum: The highest monthly income is $19,999, reflecting the presence of high-income earners within the organization.
2. Total Working Years
Minimum: The minimum value of 0 years suggests that some employees are new to the workforce.
1st Quartile: 6 years indicates that 25% of employees have 6 years or less of total working experience.
Median: The median total working years is 10, meaning that half of the employees have 10 years or fewer of experience.
Mean: The average total working years is approximately 11.28, indicating a workforce with significant experience.
3rd Quartile: 15 years shows that 75% of the employees have 15 years or fewer of total working experience.
Maximum: The maximum recorded total working years is 40, highlighting the presence of very experienced employees.
3. Years at Company
Minimum: A minimum of 0 years indicates that some employees have just joined the company.
1st Quartile: 3 years means that 25% of employees have been with the company for 3 years or less.
Median: The median value of 5 years suggests that half of the employees have been with the company for up to 5 years.
Mean: The average number of years at the company is approximately 7.01, indicating a relatively stable workforce.
3rd Quartile: 9 years shows that 75% of employees have been with the company for 9 years or less.
Maximum: The maximum tenure at the company is 40 years, reflecting long-term employment among some staff.
4. Years with Current Manager
Minimum: The minimum value of 0 years indicates that some employees have recently started working under their current manager.
1st Quartile: 2 years signifies that 25% of employees have been with their current manager for 2 years or less.
Median: The median value of 3 years suggests that half of the employees have been under their current manager for 3 years or fewer.
Mean: The average is approximately 4.12 years, showing a moderate duration of managerial relationships.
3rd Quartile: 7 years indicates that 75% of employees have been with their current manager for 7 years or less.
Maximum: The maximum tenure with a current manager is 17 years, indicating some long-standing management relationships.
5. Job Level
Minimum: The lowest job level is 1, indicating entry-level positions.
1st Quartile: 1 shows that 25% of employees are at the entry-level.
Median: The median job level is 2, suggesting that half of the employees hold positions at or below this level.
Mean: The average job level is approximately 2.06, indicating a workforce primarily composed of lower to mid-level positions.
3rd Quartile: 3 shows that 75% of employees hold job levels at or below this level.
Maximum: The highest job level is 5, reflecting the presence of senior management roles.
6. Distance from Home
Minimum: The minimum distance from home is 1 mile, indicating that some employees live very close to their workplace.
1st Quartile: 2 miles signifies that 25% of employees live within 2 miles of work.
Median: The median distance is 7 miles, suggesting that half of the employees commute less than this distance.
Mean: The average commuting distance is approximately 9.19 miles, indicating a moderate commute for most employees.
3rd Quartile: 14 miles shows that 75% of employees commute 14 miles or less.
Maximum: The maximum distance from home is 29 miles, reflecting some longer commutes.
7. Age
Minimum: The youngest employee is 18 years old, indicating entry-level positions may be filled by recent graduates.
1st Quartile: 30 years signifies that 25% of employees are 30 years old or younger.
Median: The median age is 36 years, suggesting that half of the workforce is below this age.
Mean: The average age is approximately 36.92 years, indicating a relatively mature workforce.
3rd Quartile: 43 years shows that 75% of employees are 43 years old or younger.
Maximum: The oldest employee is 60 years old, reflecting a diverse age range in the workforce.

#Boxplot
boxplot(Data[,6:12], las=2)
#Interpretation
#boxplot without outliers
boxplot(Data[,6:12], outline = FALSE)
boxplot(Data[, c(6:12)],main = "Boxplot of Numerical Variables (Without Outliers)",las = 2,outline = FALSE)
#variance and std deviation
var(Data[,6:12])
sd(Data[,6])
#The high variance and standard deviation indicate that monthly income varies significantly across employees.
#Number of Row
Data[2:100,]
#5 conditions
   ##1 condition: counting the number of employees working in R&D
    table(Data[,] $Department == "Research & Development" )
    table(Data[,] $Department == "Sales" )
    table(Data[1:20,] $Department == "Sales" )
    nrow(subset(Data[1:10, ], Department == "Research & Development"))

##2Employees with income > 5000
    high_income <- Data[Data$MonthlyIncome > 10000, ]
print(high_income)

##3number of employees with the age between 55 and 60
EM_age <- Data[Data$Age>=55 & Data$Age<=60, ]
print(EM_age)

##4number of employees not from medical field
Data[Data$EducationField !="Medical", ]

##5 list of employees married or single
Data[Data$MaritalStatus =="Single"| Data$MaritalStatus=="Married", ]

# Two variables and their correlation
cor(Data$MonthlyIncome,Data$YearsAtCompany)

#find two corrrlated variables and extract the linear regression. then draw a scatter plot to represent
# those two variables and add the eregression line, interpret the result
Model <- lm(Data$MonthlyIncome ~ Data$YearsAtCompany, )
print(Model)
Model <- lm(MonthlyIncome ~ YearsAtCompany, data=Data)
summary(Model)
#A simple linear regression analysis was performed to examine the relationship between an employee’s number of years at the company and their monthly income. The results show a statistically significant positive relationship: for every additional year at the company, monthly income increases by approximately €395.20. The regression equation is: Monthly Income = 3733.3 + 395.2 × YearsAtCompany. The model is highly significant (p < 2e-16), with an F-statistic of 527.9. However, the R-squared value is only 0.2645, indicating that only about 26.45% of the variation in monthly income is explained by years at the company. The residual standard error is €4,039, reflecting a fairly high variation around the predicted values. While tenure has a clear influence on salary, it alone is not a strong predictor, and other variables—such as job level, department, or education—likely play an important role in determining income. A multivariable regression model would provide a more accurate and comprehensive understanding.

#scatterplot of this linear regression
# Create the scatterplot with correct axes
plot(Data$YearsAtCompany, Data$MonthlyIncome,
     xlab = "YearsAtCompany",
     ylab = "MonthlyIncome",
     main = "Monthly Income vs Years at Company",
     col = "blue", pch = 16)

Model <- lm(MonthlyIncome ~ YearsAtCompany, data = Data)
abline(Model, col = "red", lwd = 2)

#The scatter plot illustrates the relationship between an employee’s monthly income and their tenure at the company. While the upward-sloping red regression line indicates a positive linear relationship—suggesting that employees with more years at the company tend to earn higher salaries—the spread of the data points reveals a high degree of variability. Employees with similar years of service often earn very different incomes, and a large concentration of data is clustered around lower tenure and income levels. This visual pattern supports the earlier regression results, which showed that only about 26% of the variation in monthly income can be explained by years at the company. Therefore, while tenure has some influence, other factors such as job level, role, and performance likely play a more significant role in determining salary.

#Variables that can be categorized
table(Data$Department)
table(Data$JobLevel)
table(Data$MaritalStatus)
table(Data$Gender)

#pie chart and barplot of those variables
Gender_count <- table(Data$Gender)
Gender_count
boxplot(Gender_count)

MarritalStatus_count <- table(Data$MaritalStatus)
MarritalStatus_count
pie(MarritalStatus_count)
boxplot(MarritalStatus_count)

Joblevel_count <- table(Data$JobLevel)
Joblevel_count
pie(Joblevel_count)
boxplot(Joblevel_count)

#display on the same page
par(mfrow = c(1, 2))
pie(Joblevel_count, main = "Job Level")
boxplot(Joblevel_count, main = "Job Level", col = "blue",las=2)

#calculation of covariance of the variables of our choices
cov(Data$MonthlyIncome,Data$YearsAtCompany)

#Interpration: The covariance between MonthlyIncome and YearsAtCompany is 14,833.73, indicating a positive linear relationship between the two variables. This means that, in general, employees who have been with the company longer tend to earn higher monthly incomes. However, while the positive covariance confirms that the two variables move in the same direction, it does not tell us how strong or consistent this relationship is. To better understand the strength and scale of the association, a correlation coefficient would be more informative, as it standardizes the relationship on a scale from –1 to +1. Nonetheless, this result supports previous findings from the regression model and scatter plot, which suggested a trend of increasing income with tenure.

YearlyIncome <- Data$MonthlyIncome*12
YearlyIncome

#adding a new function
Income_Years <- function(income, totalyears){
  return(income * totalyears)
}
Income_Years(Data$MonthlyIncome,Data$TotalWorkingYears)

#Full Linear regression model
# Full model
full_model <- lm(MonthlyIncome ~ Age + TotalWorkingYears + YearsAtCompany + YearsWithCurrManager + JobLevel + DistanceFromHome, data = Data)
print(full_model)
summary(full_model)


#fitted_model/ MonthlyIncome= -1336.05 + 61.639*toltalWorkingYears + (-56.926)*YearWithCurrManager + 3784.463*JobLevel + (-12.633)*DistanceFromHome

#predicted Income
predictedIncome <- function(TotalWorkingYears,YearsWithCurrManager, JobLevel, DistanceFromHome){
  return(-1336.05 + 61.639*TotalWorkingYears + (-56.926)*YearsWithCurrManager + 3784.463*JobLevel + (-12.633)*DistanceFromHome)
}
predictedIncome(3,5,7,9)
