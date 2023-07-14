class MvoyUser {
  String? id;
  int? contactInfoId;
  bool? isDriver;
  String? cedula;
  String? phone;
  String? direccion;
  String? relativeName;
  String? relativeNumber;
  String? email;
  String? name;
  String? middleName;
  String? lastname;
  String? lastname2;
  String? birthDate;
  String? gender;
  String? creationDate;
  bool? isDeleted;
  int? userKind;

  MvoyUser(
      {this.id,
      this.contactInfoId,
      this.isDriver,
      this.cedula,
      this.phone,
      this.direccion,
      this.relativeName,
      this.relativeNumber,
      this.email,
      this.name,
      this.middleName,
      this.lastname,
      this.lastname2,
      this.birthDate,
      this.gender,
      this.creationDate,
      this.isDeleted,
      this.userKind});

  MvoyUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contactInfoId = json['contactInfoId'];
    isDriver = json['isDriver'];
    cedula = json['cedula'];
    direccion = json['direccion'];
    relativeName = json['relativeName'];
    relativeNumber = json['relativeNumber'];
    phone = json['phone'];
    email = json['email'];
    name = json['name'];
    middleName = json['middleName'];
    lastname = json['lastname'];
    lastname2 = json['lastname2'];
    birthDate = json['birthDate'];
    gender = json['gender'];
    creationDate = json['creationDate'];
    isDeleted = json['isDeleted'];
    userKind = json['userKind'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contactInfoId'] = this.contactInfoId;
    data['isDriver'] = this.isDriver;
    data['cedula'] = this.cedula;
    data['direccion'] = this.direccion;
    data['relativeName'] = this.relativeName;
    data['relativeNumber'] = this.relativeNumber;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['name'] = this.name;
    data['middleName'] = this.middleName;
    data['lastname'] = this.lastname;
    data['lastname2'] = this.lastname2;
    data['birthDate'] = this.birthDate;
    data['gender'] = this.gender;
    data['creationDate'] = this.creationDate;
    data['isDeleted'] = this.isDeleted;
    data['userKind'] = this.userKind;
    return data;
  }
}
