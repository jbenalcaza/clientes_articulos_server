import 'dart:convert';

class ProductoMatrizResponse {
  List<Farmacia> farmacia;

  ProductoMatrizResponse({
    required this.farmacia,
  });

  static List<Farmacia> getFarmaciaFromJsonDecode(List<dynamic> jsonDecodeAPI) {
    List<Farmacia> resultado = [];
    for (var json in jsonDecodeAPI) {
      Farmacia farmacia = Farmacia.fromJson(json);
      resultado.add(farmacia);
    }
    return resultado;
  }
}

class Farmacia {
  String codigo;
  String descripcion;
  String sucursal;
  String oficina;
  String nombre;
  String idbodega;
  int existencias;
  String direccion1;
  int stock;
  int stockFracciones;
  String idProvincia;
  String provincia;
  String idCiudad;
  String ciudad;
  String ipRed;
  String restringidoInventario;

  Farmacia({
    required this.codigo,
    required this.descripcion,
    required this.sucursal,
    required this.oficina,
    required this.nombre,
    required this.idbodega,
    required this.existencias,
    required this.direccion1,
    required this.stock,
    required this.stockFracciones,
    required this.idProvincia,
    required this.provincia,
    required this.idCiudad,
    required this.ciudad,
    required this.ipRed,
    required this.restringidoInventario,
  });

  factory Farmacia.fromRawJson(String str) =>
      Farmacia.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Farmacia.fromJson(Map<String, dynamic> json) => Farmacia(
        codigo: json["codigo"] ?? "N/A",
        descripcion: json["descripcion"] ?? "N/A",
        sucursal: json["sucursal"] ?? "N/A",
        oficina: json["oficina"] ?? "N/A",
        nombre: json["Nombre"] ?? "N/A",
        idbodega: json["idbodega"] ?? "N/A",
        existencias: json["existencias"] ?? 0,
        direccion1: json["Direccion1"] ?? "N/A",
        stock: json["stock"] ?? 0,
        stockFracciones: json["stockFracciones"] ?? 0,
        idProvincia: json["idProvincia"] ?? "N/A",
        provincia: json["Provincia"] ?? "N/A",
        idCiudad: json["idCiudad"] ?? "N/A",
        ciudad: json["Ciudad"] ?? "N/A",
        ipRed: json["ip_red"] ?? "N/A",
        restringidoInventario: json["RESTRINGIDO_INVENTARIO"],
      );

  Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "descripcion": descripcion,
        "sucursal": sucursal,
        "oficina": oficina,
        "Nombre": nombre,
        "idbodega": idbodega,
        "existencias": existencias,
        "Direccion1": direccion1,
        "stock": stock,
        "stockFracciones": stockFracciones,
        "idProvincia": idProvincia,
        "Provincia": provincia,
        "idCiudad": idCiudad,
        "Ciudad": ciudad,
        "ip_red": ipRed,
        "RESTRINGIDO_INVENTARIO": restringidoInventario,
      };
}
