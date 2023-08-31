import 'dart:convert';

class ProductoAcumulacionResponse {
  ProductoAcumulacion productoAcumulacion;

  ProductoAcumulacionResponse({
    required this.productoAcumulacion,
  });

  static ProductoAcumulacion getProductoAcumulacionFromJsonDecode(
      List<dynamic> jsonDecodeAPI) {
    dynamic infoAPI = jsonDecodeAPI[0];

    ProductoAcumulacion productoAcumulacion =
        ProductoAcumulacion.fromJson(infoAPI);
    return productoAcumulacion;
  }
}

class ProductoAcumulacion {
  String activarBoton;
  String descripcion;
  String promocion1;
  String promocion2;
  String promocion3;
  String informativoDobleMonitor;

  ProductoAcumulacion({
    required this.activarBoton,
    required this.descripcion,
    required this.promocion1,
    required this.promocion2,
    required this.promocion3,
    required this.informativoDobleMonitor,
  });

  factory ProductoAcumulacion.fromRawJson(String str) =>
      ProductoAcumulacion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductoAcumulacion.fromJson(Map<String, dynamic> json) =>
      ProductoAcumulacion(
        activarBoton: json["activar_boton"] ?? "N/A",
        descripcion: json["descripcion"] ?? "N/A",
        promocion1: json["promocion1"] ?? "N/A",
        promocion2: json["promocion2"] ?? "N/A",
        promocion3: json["promocion3"] ?? "N/A",
        informativoDobleMonitor: json["Informativo_doble_monitor"] ?? "N/A",
      );

  Map<String, dynamic> toJson() => {
        "activar_boton": activarBoton,
        "descripcion": descripcion,
        "promocion1": promocion1,
        "promocion2": promocion2,
        "promocion3": promocion3,
        "Informativo_doble_monitor": informativoDobleMonitor,
      };
}
