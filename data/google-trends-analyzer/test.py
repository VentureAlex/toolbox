import pandas as pd
from pytrends.request import TrendReq
import time

# Set up a pytrends request
pytrends = TrendReq()

# Define the search parameters
kw_list = ["AAPL"]  # List of search terms
timeframe = 'today 5-y'  # Last 5 years

# Introducing a delay to avoid hitting Google's rate limits
time.sleep(5)  # Sleep for 5 seconds

# Request the interest over time
pytrends.build_payload(kw_list, timeframe=timeframe)
interest_over_time_df = pytrends.interest_over_time()

# Save the DataFrame to a CSV file
interest_over_time_df.to_csv('interest_over_time.csv', index=True)

#
# Load the data
df = pd.read_csv('interest_over_time.csv', index_col=0)
df.index = pd.to_datetime(df.index)

# Calculate percentage change
df['percent_change'] = df['AAPL'].pct_change() * 100  # 'AAPL' is the column of interest

# Identify significant increases
# Defining a "significant" increase as more than 100% increase from the previous period
significant_increases = df[df['percent_change'] > 100]

print(significant_increases)
