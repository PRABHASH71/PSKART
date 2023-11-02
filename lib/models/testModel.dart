class TestModel {
  String? branch;
  String? college;
  String? enroll;
  String? name;
  String? image;

  TestModel({this.branch, this.college, this.enroll, this.name, this.image});

  TestModel.fromJson(Map<String, dynamic> json) {
    branch = json['branch'];
    college = json['college'];
    enroll = json['enroll'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch'] = this.branch;
    data['college'] = this.college;
    data['enroll'] = this.enroll;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
