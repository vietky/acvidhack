const foodDepot = [
      {
        "id": "5ea3b4e3f0a9332db0f17f1d",
        "name": "Điểm cứu trợ 1",
        "address": "Số 25 Đường Hoàng Diệu 2, Phường Linh Trung, Quận Thủ Đức",
        "longitude": 106.762047,
        "latitude": 10.86036,
        "provider": "nhung@gmail.com",
        "phone": "0989878765",
        "merchandiseList": [
          {
            "id": "5ea3b304f0a9332db0f17f1c",
            "name": "quần áo"
          },
          {
            "id": "5ea3b2e0f0a9332db0f17f1b",
            "name": "thực phẩm"
          }
        ]
      },
      {
        "id": "5ea3b920f0a9332db0f17f1e",
        "name": "Điểm cứu trợ 2",
        "address": "70 Đỗ Xuân Hợp (quận 2)",
        "longitude": 106.779533,
        "latitude": 10.79968,
        "provider": "trang@gmail.com",
        "phone": "0987654321",
        "merchandiseList": [
          {
            "id": "5ea3b2e0f0a9332db0f17f1b",
            "name": "thực phẩm"
          }
        ]
      },
      {
        "id": "5ea3ba8bf0a9332db0f17f1f",
        "name": "Điểm cứu trợ 3",
        "address": "Ấp 5, xã Vĩnh Lộc B, huyện Bình Chánh",
        "longitude": 106.58024,
        "latitude": 10.81914,
        "provider": "viet@gmail.com",
        "phone": "0908767324",
        "merchandiseList": [
          {
            "id": "5ea3b2e0f0a9332db0f17f1b",
            "name": "thực phẩm"
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
        this.db[issue.id] = issue;
        return issue;
    }
    updateIssue(id,issue) {
        if (!this.db[id]) {
            return null;
        }
        issue.id = id;
        this.db[id] = issue;
        return issue;
    }
    removeIssue(id) {
        const issue = this.db[id];
        delete this.db[id];
        return issue;
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
