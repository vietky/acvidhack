# SOS Backend

### Architecture Overview
![alt text](https://github.com/vietky/acvidhack/raw/master/SOSVN-1.png "architecture")

### Technologies Using
- nodejs 
- mongodb
- redis
- kafka (in future)

### How to run
- ```npm start```

### Deploy
- ```docker build -t sosbe .```
- ```docker run -d --name sosbe sosbe npm start```
