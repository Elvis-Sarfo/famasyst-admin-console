class Farm {
  String description;
  List farmState, pictures, crops;
  Map farmer, supervisor;
  double farmSize;
  String location, farmId;

  Farm({
    this.farmer,
    this.supervisor,
    this.farmId,
    this.description,
    this.farmState = const [],
    this.pictures,
    this.crops,
    this.farmSize,
    this.location,
  });

  // Convert a Farmer object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['farmId'] = farmId;
    map['farmer'] = farmer;
    map['supervisor'] = supervisor;
    map['pictures'] = pictures;
    map['description'] = description;
    map['farmState'] = farmState;
    map['crops'] = crops;
    map['farmSize'] = farmSize;
    map['location'] = location;
    return map;
  }

  Farm.fromMapObject(Map<String, dynamic> map) {
    this.farmId = map['farmId'];
    this.farmer = map['farmer'];
    this.supervisor = map['supervisor'];
    this.location = map['location'];
    this.pictures = map['pictures'];
    this.description = map['description'];
    this.farmSize = double.parse(map['farmSize'].toString());
    this.farmState = map['farmState'];
    this.crops = map['crops'];
  }
}
