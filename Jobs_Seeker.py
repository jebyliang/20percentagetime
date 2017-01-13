from bs4 import BeautifulSoup
import urllib.request
import pandas as pd

def company(website, city_phrase, job_phrase, cities, positions, companies):
    page = urllib.request.urlopen(website)
    soup = BeautifulSoup(page, 'html.parser')

    for item in soup.select(city_phrase):
        cities.append(item.text.strip())

    for item in soup.select(job_phrase):
        positions.append(item.text.strip())

    for item in range(len(soup.select(job_phrase))):
        companies.append(website)

    return cities, positions, companies

company_list = [   # website, location, job #
    ['http://www.spacex.com/careers/list', 'tr td div', 'tr td a'] # SpaceX
]

cities = []
positions = []
companies = []

for item in company_list:
    cities, positions, companies = company(item[0], item[1], item[2], cities, positions, companies)

# Create a Pandas dataframe from the data.
df = pd.DataFrame({'Position': positions, 'City': cities, 'Company': companies})
df.insert(0, "ID", df.index)
df1 = df[df.Position.str.contains("Data|Analyst") == True]

# Create a Pandas Excel writer using XlsxWriter as the engine.
writer = pd.ExcelWriter('Jobs_seeker_1.xlsx', engine='xlsxwriter')

# Convert the dataframe to an XlsxWriter Excel object.
df1.to_excel(writer)
writer.save()

df2 = pd.ExcelFile("Jobs_seeker_2.xlsx").parse("Sheet1")

df1 = df1.set_index("ID")
df2 = df2.set_index("ID")

a1, a2 = df1.align(df2)
different = (a1 != a2).any(axis=1)
compare = a1[different].join(a2[different], lsuffix='_old', rsuffix='_new')
print(compare)
