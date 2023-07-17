class MvoyVehicle {
  String? Id;
  String? ownerId;
  String? license;
  String? seguro;
  String? chasis;
  String? placa;
  String? color;
  String? marca;
  String? modelo;
  bool? tieneSeguro;
  String? year;

  MvoyVehicle(
      {this.ownerId,
      this.license,
      this.Id,
      this.seguro,
      this.chasis,
      this.placa,
      this.color,
      this.marca,
      this.modelo,
      this.tieneSeguro,
      this.year});

  MvoyVehicle.fromJson(Map<String, dynamic> json) {
    ownerId = json['ownerId'];
    license = json['license'];
    seguro = json['seguro'];
    Id = json['id'];
    chasis = json['chasis'];
    placa = json['placa'];
    color = json['color'];
    marca = json['marca'];
    modelo = json['modelo'];
    tieneSeguro = json['tieneSeguro'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ownerId'] = this.ownerId;
    data['license'] = this.license;
    data['id'] = this.Id;
    data['seguro'] = this.seguro;
    data['chasis'] = this.chasis;
    data['placa'] = this.placa;
    data['color'] = this.color;
    data['marca'] = this.marca;
    data['modelo'] = this.modelo;
    data['tieneSeguro'] = this.tieneSeguro;
    data['year'] = this.year;
    return data;
  }
}
