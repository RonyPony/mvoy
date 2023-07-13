class DominicanPerson {
  String? cedula;
  String? nombres;
  String? apellido1;
  String? apellido2;
  String? fechaNacimiento;
  String? lugarNacimiento;
  String? sexo;
  String? estadoCivil;
  String? ocupacion;
  String? nacionalidad;
  String? cedulaAnterior;
  String? provincia;
  String? referenciaCercana;
  String? direccionReferenciaCercana;
  String? sectordeRecidencia;

  DominicanPerson(
      {this.cedula,
      this.nombres,
      this.apellido1,
      this.apellido2,
      this.fechaNacimiento,
      this.lugarNacimiento,
      this.sexo,
      this.estadoCivil,
      this.ocupacion,
      this.nacionalidad,
      this.cedulaAnterior,
      this.provincia,
      this.referenciaCercana,
      this.direccionReferenciaCercana,
      this.sectordeRecidencia});

  DominicanPerson.fromJson(Map<String, dynamic> json) {
    cedula = json['cedula'];
    nombres = json['nombres'];
    apellido1 = json['apellido1'];
    apellido2 = json['apellido2'];
    fechaNacimiento = json['fechaNacimiento'];
    lugarNacimiento = json['lugarNacimiento'];
    sexo = json['sexo'];
    estadoCivil = json['estadoCivil'];
    ocupacion = json['ocupacion'];
    nacionalidad = json['nacionalidad'];
    cedulaAnterior = json['cedulaAnterior'];
    provincia = json['provincia'];
    referenciaCercana = json['referenciaCercana'];
    direccionReferenciaCercana = json['direccionReferenciaCercana'];
    sectordeRecidencia = json['sectordeRecidencia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cedula'] = this.cedula;
    data['nombres'] = this.nombres;
    data['apellido1'] = this.apellido1;
    data['apellido2'] = this.apellido2;
    data['fechaNacimiento'] = this.fechaNacimiento;
    data['lugarNacimiento'] = this.lugarNacimiento;
    data['sexo'] = this.sexo;
    data['estadoCivil'] = this.estadoCivil;
    data['ocupacion'] = this.ocupacion;
    data['nacionalidad'] = this.nacionalidad;
    data['cedulaAnterior'] = this.cedulaAnterior;
    data['provincia'] = this.provincia;
    data['referenciaCercana'] = this.referenciaCercana;
    data['direccionReferenciaCercana'] = this.direccionReferenciaCercana;
    data['sectordeRecidencia'] = this.sectordeRecidencia;
    return data;
  }
}
