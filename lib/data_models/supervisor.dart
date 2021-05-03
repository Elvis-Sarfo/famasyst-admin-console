class Supervisor {
  String name, location, telephone, id, gender;
  String img;
  int age;
  Supervisor(
      {this.gender,
      this.id,
      this.name,
      this.location,
      this.telephone,
      this.img,
      this.age});

  // Convert a Farmer object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['telephone'] = telephone;
    map['location'] = location;
    map['img'] = img;
    map['age'] = age;
    map['gender'] = gender;
    return map;
  }

  Supervisor.fromMapObject(Map<String, dynamic> map) {
    this.name = map['name'];
    this.telephone = map['telephone'];
    this.location = map['location'];
    this.img = map['img'];
    this.age = map['age'];
    this.gender = map['gender'];
  }
}
