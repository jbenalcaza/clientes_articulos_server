import 'dart:convert';

class PermisosResponse {
  Permiso permisos;

  PermisosResponse({
    required this.permisos,
  });

  static Permiso getPermisoFromJsonDecode(List<dynamic> jsonDecodeAPI) {
    dynamic infoAPI = jsonDecodeAPI[0];

    Permiso permiso = Permiso.fromJson(infoAPI);
    return permiso;
  }
}

class Permiso {
  List<Atribucion> atribuciones;
  dynamic ipFarmacia;
  String cedula;
  String token;

  Permiso({
    required this.atribuciones,
    this.ipFarmacia,
    required this.cedula,
    required this.token,
  });

  factory Permiso.fromRawJson(String str) => Permiso.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Permiso.fromJson(Map<String, dynamic> json) => Permiso(
        atribuciones: List<Atribucion>.from(
            json["atribuciones"].map((x) => Atribucion.fromJson(x))),
        ipFarmacia: json["ipFarmacia"]??[],
        cedula: json["Cedula"],
        token: json["Token"],
      );

  Map<String, dynamic> toJson() => {
        "atribuciones": List<dynamic>.from(atribuciones.map((x) => x.toJson())),
        "ipFarmacia": ipFarmacia,
        "Cedula": cedula,
        "Token": token,
      };
}

class Atribucion {
  String nombreCorto;
  String aplicacion;
  String modulo;
  String transaccion;
  String habilitado;
  String envioPos;
  dynamic rolId;

  Atribucion({
    required this.nombreCorto,
    required this.aplicacion,
    required this.modulo,
    required this.transaccion,
    required this.habilitado,
    required this.envioPos,
    this.rolId,
  });

  factory Atribucion.fromRawJson(String str) =>
      Atribucion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Atribucion.fromJson(Map<String, dynamic> json) => Atribucion(
        nombreCorto: json["NombreCorto"] ?? "N/A",
        aplicacion: json["Aplicacion"] ?? "N/A",
        modulo: json["Modulo"] ?? "N/A",
        transaccion: json["Transaccion"] ?? "N/A",
        habilitado: json["Habilitado"] ?? "N/A",
        envioPos: json["ENVIO_POS"] ?? "N/A",
        rolId: json["rol_id"] ?? "N/A",
      );

  Map<String, dynamic> toJson() => {
        "NombreCorto": nombreCorto,
        "Aplicacion": aplicacion,
        "Modulo": modulo,
        "Transaccion": transaccion,
        "Habilitado": habilitado,
        "ENVIO_POS": envioPos,
        "rol_id": rolId,
      };
}
