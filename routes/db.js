const foodDepot = [
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
];

class IssueDb {
    constructor() {
        this.db = {}
        this.currentId = 1;
    }
    addIssue(issue) {
        issue.id = this.currentId++;
        this.db[this.currentId] = issue;
        return issue;
    }
    updateIssue(id,issue) {
        issue.id = id;
        this.db[id] = issue;
        return issue;
    }
    removeIssue(id) {
        delete this.db[id];
    }
    getAllIssues() {
        const list = Object.values(this.db);
        list.sort((a, b) => {
            return a.id < b.id;
        })
        return list;
    }
}


module.exports = {
    foodDepot,
    issueDb: new IssueDb()
}