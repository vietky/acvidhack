var express = require('express');
var router = express.Router();

let id = 1;

/* CREATE users listing. */
router.post('/issues', function(req, res, next) {
    console.log('req', req.body);
    const data = Object.assign({}, req.body, {
        id,
    });
    id++;
    res.status(200)
        .json(data)
        .end();
  });


/* GET users listing. */
router.get('/food_depot/get-all', function(req, res, next) {
    const data = [
    {
        id: 1,
        name: "điểm cứu trợ 1",
        longitute: 1.000001,
        latitude: 1.000001,
        provider: "nhung@gmail.com",
        "merchandise": [
        {
            name: "cơm"
        },
        {
            name: "gạo"
        },
        {
            name: "chuối"
        }
        ]
    },
    {
        id: 2,
        name: "điểm cứu trợ 2",
        longitute: 1.000001,
        latitude: 1.000001,
        provider: "viet@gmail.com",
        "merchandise": [
        {
            name: "cam"
        },
        {
            name: "ổi"
        }
        ]
    },
    {
        id: 3,
        name: "điểm cứu trợ 3",
        longitute: 1.000001,
        latitude: 1.000001,
        provider: "trang@gmail.com",
        "merchandise": [
        {
            name: "cam"
        },
        {
            name: "quýt"
        }
        ]
    }
    ]
  res.status(200)
    .json(data)
    .end();
});


module.exports = router;
