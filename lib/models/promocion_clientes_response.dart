import 'dart:convert';

class PromocionesClientesResponse {
  Promocion promocion;

  PromocionesClientesResponse({
    required this.promocion,
  });

  static Promocion getPromocionFromJsonDecode(List<dynamic> jsonDecodeAPI) {
    Promocion promocion =
        Promocion(crmMensaje: "N/A", crmPromo: "N/A", crmTipo: "N/A");
    if (jsonDecodeAPI.length > 0) {
      dynamic infoAPI = jsonDecodeAPI[0];
      promocion = Promocion.fromJson(infoAPI);
    }
    return promocion;
  }
}

class Promocion {
  String crmTipo;
  String crmMensaje;
  String crmPromo;

  Promocion({
    required this.crmTipo,
    required this.crmMensaje,
    required this.crmPromo,
  });

  factory Promocion.fromRawJson(String str) =>
      Promocion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Promocion.fromJson(Map<String, dynamic> json) => Promocion(
        crmTipo: json["crmTipo"] ?? "N/A",
        crmMensaje: json["crmMensaje"] ?? "N/A",
        crmPromo: json["crmPromo"] ?? "N/A",
      );

  Map<String, dynamic> toJson() => {
        "crmTipo": crmTipo,
        "crmMensaje": crmMensaje,
        "crmPromo": crmPromo,
      };
}
