# Cloud Alarm

## API
https://app.apiary.io/cloudalarm/editor

## Server

### Heroku

Server in last stable build run at the Heroku. Here is the base url:

http://cloud-alarm-server.herokuapp.com 

All requests are describe in the Apiary.

For example get all alarms per user: <br>
` http://cloud-alarm-server.herokuapp.com/api/alarms?access_token=EYaIMLCjoXpgX8s31KWQettcw5jN4aLuWW9p1LXXnKQyiOdchPNLi43AhaXo5zjHegFvfn3bNCZDgpnjJa0xDvzBOpm1tJbhMgnEtwH8ZntbfMLBrhx7lFOFjwnxvDih ` (access token is for user named "user")

### Localhost

Before first starting server you must install ` node.js ` and ` mongo `.

To start mongo database you simply type ` mongod ` or if you need select special place where database will be save: ` mongod --dbpath ~/Documents/mongodb/data/db `. File path is always on your choice.
To install dependencies run ` npm install ` in the folder ` Cloud-alarm-server `.
To start server run ` npm install ` also in the folder ` Cloud-alarm-server `.

