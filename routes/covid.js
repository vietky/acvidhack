var express = require('express');
var router = express.Router();

const {
    foodDepot,
    issueDb
} = require('./db');

/* CREATE users listing. */
router.post('/issues', function(req, res, next) {
    const issue = issueDb.addIssue(req.body);
    res.status(200)
        .json(issue)
        .end();
  });

router.put('/issues/:id', function(req, res, next) {
    console.log('req.params', req.params)
    const issue = issueDb.updateIssue(req.params.id, req.body);
    res.status(200)
        .json(issue)
        .end();
});

router.delete('/issues/:id', function(req, res, next) {
    console.log('req.params', req.params)
    issueDb.removeIssue(req.params.id);
    res.status(200)
        .json({
            message: 'ok'
        })
        .end();
});

router.get('/issues/get-all', function(req, res, next) {
    res.status(200)
        .json(issueDb.getAllIssues())
        .end();
});


/* GET users listing. */
router.get('/food_depot/get-all', function(req, res, next) {
  res.status(200)
    .json(foodDepot)
    .end();
});


module.exports = router;
