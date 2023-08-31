import 'dart:convert';

class AcumulacionesResponse {
  List<List<Acumulacion>> acumulaciones;

  AcumulacionesResponse({
    required this.acumulaciones,
  });

  String toRawJson() => json.encode(toJson());

  static List<Acumulacion> getAcumulacionFromJsonDecode(
      List<dynamic> jsonDecodeAPI) {
    List<Acumulacion> resultado = [];
    for (var item in jsonDecodeAPI) {
      Acumulacion acumulacion = Acumulacion(
        acumulacion: item['acumulacion'] ?? "N/A",
      );

      resultado.add(acumulacion);
    }
    return resultado;
  }

  Map<String, dynamic> toJson() => {
        "acumulaciones": List<dynamic>.from(acumulaciones
            .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class Acumulacion {
  String acumulacion;

  Acumulacion({
    required this.acumulacion,
  });

  factory Acumulacion.fromRawJson(String str) =>
      Acumulacion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Acumulacion.fromJson(Map<String, dynamic> json) => Acumulacion(
        acumulacion: json["acumulacion"],
      );

  Map<String, dynamic> toJson() => {
        "acumulacion": acumulacion,
      };
}
