import 'dart:convert';

class ClienteResponse {
  List<Cliente> clientes;

  ClienteResponse({
    required this.clientes,
  });

  String toRawJson() => json.encode(toJson());

  static List<Cliente> getClienteFromJsonDecode(List<dynamic> jsonDecodeAPI) {
    List<Cliente> resultado = [];
    for (var item in jsonDecodeAPI) {
      Cliente cliente = Cliente.fromJson(item);
      resultado.add(cliente);
    }
    return resultado;
  }

  Map<String, dynamic> toJson() => {
        "clientes": List<dynamic>.from(clientes.map((x) => x.toJson())),
      };
}

class Cliente {
  String tipoIdcliente;
  String numeroDocumento;
  String nombreCliente;
  String email;
  String telefono;

  Cliente({
    required this.numeroDocumento,
    required this.nombreCliente,
    required this.email,
    required this.telefono,
    required this.tipoIdcliente,
  });

  factory Cliente.fromRawJson(String str) => Cliente.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        tipoIdcliente: json["tipo_idcliente"] ?? "N/A",
        numeroDocumento: json["numero_documento"] ?? "N/A",
        nombreCliente: json["nombre_cliente"] ?? "N/A",
        email: json["email"] ?? "N/A",
        telefono: json["telefono"] ?? "N/A",
      );

  Map<String, dynamic> toJson() => {
        "tipo_idcliente": tipoIdcliente,
        "numero_documento": numeroDocumento,
        "nombre_cliente": nombreCliente,
        "email": email,
        "telefono": telefono,
      };
}
