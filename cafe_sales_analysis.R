getwd()

#loading the dataset
df <- read.csv("D:/R Langauge/Projects/Cafe_Sales_R_Project/cafe_sales_dirty.csv", stringsAsFactors = FALSE)


#Viewing stucture
str(df)
summary(df)
head(df)

#lets start cleaning
#Cleaning Total.Spent as there is mix of characters and numbers
# Check unique values in Total.Spent
unique(df$Total.Spent)

df$Total.Spent <- as.numeric(df$Total.Spent) #converting to numeric

summary(df$Total.Spent)

mean_spent <- mean(df$Total.Spent, na.rm = TRUE)
print(mean_spent)

df$Total.Spent[is.na(df$Total.Spent)] <- mean_spent #wherever there is NA, this puts the mean value these

mean_spent <- round(mean(df$Total.Spent, na.rm = TRUE), 2)

#Final check
sum(is.na(df$Total.Spent))    # This counts how many NAs are left
summary(df$Total.Spent)       # This gives you min, max, mean, quartiles, etc.         

#Now lets clean Pament.Method
unique(df$Payment.Method)

df$Payment.Method <- trimws(df$Payment.Method)  ## Remove any leading/trailing spaces
df$Payment.Method[df$Payment.Method %in% c("UNKNOWN", "ERROR", "")] <- "Missing"  #Replace invalid entries with "Missing"
unique(df$Payment.Method) ## View updated unique values
table(df$Payment.Method)

#lets clean Transaction.Date
unique(df$Transaction.Date)

df$Transaction.Date <- trimws(df$Transaction.Date)  #removes any accidental spaces
df$Transaction.Date[df$Transaction.Date %in% c("ERROR", "UNKNOWN", "")] <- NA  #Replace bad date entries ("ERROR", "UNKNOWN", "" to NA)

df$Transaction.Date <- as.Date(df$Transaction.Date, format = "%Y-%m-%d")

#checking
str(df$Transaction.Date)
summary(df$Transaction.Date)
sum(is.na(df$Transaction.Date))


df$Year <- format(df$Transaction.Date, "%Y") #helpful for year-level summaries
df$Month <- format(df$Transaction.Date, "%Y-%m") #helpful for month-level trends

head(df[c("Transaction.Date", "Year", "Month")])

df_with_date <- df[!is.na(df$Transaction.Date)]
names(df)

df$Transaction.Date <- as.Date(df$Transaction.Date, format = "%Y-%m-%d")
df_with_date <- df[!is.na(df$Transaction.Date), ]
df_with_date$Month <- format(df_with_date$Transaction.Date, "%Y-%m")


monthly_sales <- aggregate(Total.Spent ~ Month, data = df_with_date, sum)

#Plotting
library(ggplot2)

ggplot(monthly_sales, aes(x = Month, y = Total.Spent)) +
  geom_line(group = 1, color = "steelblue", size = 1.2 ) +
      geom_point(color =  "darkred", size = 2) +
    labs(title = "Monthly Sales Trend (2003)", x ="Month", y = "Total Sales ($)") + 
  theme_minimal()+
  theme(axis.text = element_text(angle = 45, hjust = 1))


## Top 5 selling items by revenue 
item_sales <- aggregate(Total.Spent ~ Item, data = df, sum)

head(item_sales)

unique(df$Item) #beacuase there is missing value in Item

df$Item <- trimws(df$Item) #Remove leading/trailing whitespace
df$Item[df$Item %in% c("", "ERROR", "UNKNOWN")] <- "Unknown" #Replace known invalid item names with "Unknown"

unique(df$Item)

#lets rerun grouping 
item_sales <- aggregate(Total.Spent ~ Item, data = df, sum)
top_items <- item_sales[order(-item_sales$Total.Spent), ][1:5, ]

library(ggplot2)

ggplot(top_items, aes(x = reorder(Item, Total.Spent), y = Total.Spent)) +
  geom_bar(stat = "identity", fill = "forestgreen") +
  coord_flip() +
  labs(
    title = "Top 5 Café Items by Total Revenue",
    x = "Item",
    y = "Total Revenue ($)"
  ) + 
  theme_minimal() +
  theme(axis.text = element_text(size = 12))

##Top 3 items, show how revenue changed each month in 2023.
item_sales <- aggregate(Total.Spent ~ Item, data = df, sum)
top_items <- item_sales[order(-item_sales$Total.Spent), ][1:3, ]

library(dplyr)
library(ggplot2)

df_top <- df %>% filter(Item %in% top_items$Item)  # Filter Dataset to Top 3 Items
df_top

#Group by Month and Item, Sum Revenue
monthly_item_sales <- df_top %>%
  group_by(Month, Item) %>%
  summarise(Monthly.Revenue = sum(Total.Spent), .groups = "drop")

#Plot Monthly Trend (ggplot2)
ggplot(monthly_item_sales, aes(x = Month, y = Monthly.Revenue, color = Item, group = Item)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  labs(
    title = "Monthly Sales Trend of Top 3 Items",
    x = "Month",
    y = "Revenue ($)"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

##Analyze total revenue grouped by payment method
unique(df$Payment.Method)

#Group and Summarize Revenue by Payment Method
payment_sales <- df %>%
  group_by(Payment.Method) %>%
  summarise(Total.Revenue = sum(Total.Spent), .groups = "drop") %>%
  arrange(desc(Total.Revenue))

#View result
print(payment_sales)

#Plot Bar Chart of Payment Methods
ggplot(payment_sales, aes(x = reorder(Payment.Method, Total.Revenue), y = Total.Revenue)) +
  geom_bar(stat = "identity", fill = "skyblue4") +
  coord_flip() +
  labs(
    title = "Total Revenue by Payment Method",
    x = "Payment Method",
    y = "Total Revenue ($)"
  ) +
  theme_minimal() +
  theme(axis.text = element_text(size = 12))

##Revenue by Location
unique(df$Location)


df$Location <- trimws(df$Location) #Remove leading/trailing spaces
df$Location[df$Location %in% c("UNKNOWN", "", "ERROR")] <- "Missing" #Replace invalid entries with "Missing"
unique(df$Location) #Confirm cleaned values

#Group and Summarize Revenue by Location
library(dplyr)

location_sales <- df %>%
  group_by(Location) %>%
  summarise(Total.Revenue = sum(Total.Spent), .groups = "drop") %>%
  arrange(desc(Total.Revenue))

# View the summary
print(location_sales)

#Plot Revenue by Location (Bar Chart)
library(ggplot2)

ggplot(location_sales, aes(x = reorder(Location, Total.Revenue), y = Total.Revenue)) +
  geom_bar(stat = "identity", fill = "tomato") +
  coord_flip() +
  labs(
    title = "Total Revenue by Sales Location",
    x = "Location",
    y = "Total Revenue ($)"
  ) +
  theme_minimal() +
  theme(axis.text = element_text(size = 12))
write.csv(df, "D:/R Langauge/Projects/Cafe_Sales_R_Project/cafe_sales_cleaned.csv", row.names = FALSE)

