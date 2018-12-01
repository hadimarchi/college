//importing modules
var express = require('express');
var mongoose = require('mongoose');
var bodyparser = require('body-parser');
var cors = require('cors');
var path = require('path');

var app = express();

//ip and port
const ip = '10.25.74.223';
const port = 3000;
const route = require('./routes/route');

//connect to mongodb on default port
mongoose.connect('mongodb://localhost:27017/contactlist');
//on connection
mongoose.connection.on('connected', () => {
  console.log('Connected to database mongodb @ 27017');
});
mongoose.connection.on('error', (err) => {
    console.log('Error in Database connection ' + err);
});

//adding middleware
app.use(cors());

//parse json data
app.use(bodyparser.json());

//allow public folder in path
app.use(express.static(path.join(__dirname, 'public')));

//Our API is defined in route.js
app.use('/api', route);

//testing only
app.get('/', (req, res) => {
    res.send('Testing 1, 2, 3');
 });

app.listen(port, ip, () => {
    console.log('Server started at port: ' + port);
 });
