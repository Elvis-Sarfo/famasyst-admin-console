class Farm {
  String farmerId, description;
  List farmState, pictures, crops;
  Map farmerDetails;
  double farmSize;
  String location;
  int farmId;

  Farm(
      {this.farmerId,
      this.farmerDetails,
      this.farmId,
      this.description,
      this.farmState,
      this.pictures,
      this.crops,
      this.farmSize,
      this.location});

  // Convert a Farmer object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['farmerId'] = farmerId;
    map['farmId'] = farmId;
    map['farmerDetails'] = farmerDetails;
    map['pictures'] = pictures;
    map['description'] = description;
    map['farmState'] = farmState;
    map['cropType'] = crops;
    map['farmSize'] = farmSize;
    map['location'] = location;
    return map;
  }

  Farm.fromMapObject(Map<String, dynamic> map) {
    this.farmerId = map['farmerId'];
    this.farmerDetails = map['farmerDetails'];
    this.farmId = map['farmId'];
    this.location = map['location'];
    this.pictures = map['pictures'];
    this.description = map['description'];
    this.farmSize = map['farmSize'];
    this.farmState = map['farmState'];
    this.crops = map['cropType'];
    this.crops = map['cropType'];
  }
}
