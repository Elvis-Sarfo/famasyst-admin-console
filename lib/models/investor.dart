class Investor {
  String name, id, phone, location, picture, email, type;
  List interests;
  bool enabled;

  Investor(
      {this.name,
      this.enabled,
      this.id,
      this.phone,
      this.location,
      this.picture,
      this.email,
      this.type,
      this.interests});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['location'] = location;
    map['picture'] = picture;
    map['email'] = email;
    map['type'] = type;
    map['interests'] = interests;
    map['enabled'] = enabled;
    return map;
  }

  Investor.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.phone = map['phone'];
    this.location = map['location'];
    this.picture = map['picture'];
    this.email = map['email'];
    this.enabled = map['enabled'] == null ? false : map['enabled'];
    this.type = map['type'];
    this.interests = (map['interests'] is String)
        ? map['interests'].toString().split(',')
        : map['interests'] != null
            ? map['interests']
            : [];
  }
}
