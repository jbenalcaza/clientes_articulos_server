import 'dart:convert';

class ProductoPromocionResponse {
  ProductoPromocion productoPromocion;

  ProductoPromocionResponse({
    required this.productoPromocion,
  });

  static ProductoPromocion getProductoAcumulacionFromJsonDecode(
      List<dynamic> jsonDecodeAPI) {
    dynamic infoAPI = jsonDecodeAPI[0];

    ProductoPromocion productoPromocion = ProductoPromocion.fromJson(infoAPI);
    return productoPromocion;
  }
}

class ProductoPromocion {
  String secuencia;
  String descripcion;
  int prioridad;
  String sugerencia;
  String requisito;
  String descripcionReq;
  String items;
  String codigo;

  ProductoPromocion({
    required this.secuencia,
    required this.descripcion,
    required this.prioridad,
    required this.sugerencia,
    required this.requisito,
    required this.descripcionReq,
    required this.items,
    required this.codigo,
  });

  factory ProductoPromocion.fromRawJson(String str) =>
      ProductoPromocion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductoPromocion.fromJson(Map<String, dynamic> json) =>
      ProductoPromocion(
        secuencia: json["secuencia"] ?? "N/A",
        descripcion: json["descripcion"] ?? "N/A",
        prioridad: json["prioridad"] ?? 0,
        sugerencia: json["sugerencia"] ?? "N/A",
        requisito: json["requisito"] ?? "N/A",
        descripcionReq: json["descripcionReq"] ?? "N/A",
        items: json["items"] ?? "N/A",
        codigo: json["codigo"] ?? "N/A",
      );

  Map<String, dynamic> toJson() => {
        "secuencia": secuencia,
        "descripcion": descripcion,
        "prioridad": prioridad,
        "sugerencia": sugerencia,
        "requisito": requisito,
        "descripcionReq": descripcionReq,
        "items": items,
        "codigo": codigo,
      };
}
