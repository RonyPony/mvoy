class Trip {
  String? originName;
  String? destinyName;
  String? duration;
  String? distance;
  String? leavingTime;
  String? driverId;
  String? clientId;
  String? price;
  String? arrivingTime;

  Trip(
      {this.originName,
      this.destinyName,
      this.duration,
      this.distance,
      this.leavingTime,
      this.driverId,
      this.clientId,
      this.price,
      this.arrivingTime});

  Trip.fromJson(Map<String, dynamic> json) {
    originName = json['originName'];
    destinyName = json['destinyName'];
    duration = json['duration'];
    distance = json['distance'];
    leavingTime = json['leavingTime'];
    driverId = json['driverId'];
    clientId = json['clientId'];
    price = json['price'];
    arrivingTime = json['arrivingTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['originName'] = this.originName;
    data['destinyName'] = this.destinyName;
    data['duration'] = this.duration;
    data['distance'] = this.distance;
    data['leavingTime'] = this.leavingTime;
    data['driverId'] = this.driverId;
    data['clientId'] = this.clientId;
    data['price'] = this.price;
    data['arrivingTime'] = this.arrivingTime;
    return data;
  }
}