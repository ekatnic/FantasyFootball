import requests
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import seaborn as sns

scores = {}
for week in range(1,17):
    r = requests.get('http://games.espn.com/ffl/api/v2/scoreboard',
                     params={'leagueId': 17056, 'seasonId': 2017, 'matchupPeriodId': week})
    scores[week] = r.json()

df = []
for key in scores:
    temp = scores[key]['scoreboard']['matchups']
    for match in temp:
        df.append([key,
                    match['teams'][0]['team']['teamAbbrev'],
                    match['teams'][1]['team']['teamAbbrev'],
                    match['teams'][0]['score'],
                    match['teams'][1]['score']])

df = pd.DataFrame(df, columns=['Week', 'HomeAbbrev', 'AwayAbbrev', 'HomeScore', 'AwayScore'])
df.head()