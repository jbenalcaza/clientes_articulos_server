// To parse this JSON data, do
//
//     final productosResponse = productosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

class ProductosResponse {
  List<Producto> productos;

  ProductosResponse({
    required this.productos,
  });

  static List<Producto> getProductosFromJsonDecode(
      List<dynamic> jsonDecodeAPI) {
    List<Producto> resultado = [];
    for (var item in jsonDecodeAPI) {
      Producto producto = Producto(
        listaPrecios: item['ListaPrecios'] ?? "N/A",
        codArticulo: item['COD_ARTICULO'] ?? "N/A",
        descripcion: item['descripcion'] ?? "N/A",
        pvp: item['PVP'] ?? 0,
        pvc: item['PVC'] ?? 0,
        entero: item['entero'] ?? 0,
        fraccion: item['fraccion'] ?? 0,
        valorPos: item['valor_pos'] ?? 0,
        esMf: item['es_mf'] ?? "N/A",
        iva: item['Iva'] ?? "N/A",
        idclase: item['idclase'] ?? "N/A",
        idmarca: item['idmarca'] ?? "N/A",
        aplicaDsctos: item['aplicaDsctos'] ?? "N/A",
      );
      try {
        producto.imgImagenmediana =
            MemoryImage(base64Decode(item['img_imagenmediana']));
      } catch (e) {
        producto.imgImagenmediana = null;
      }
      resultado.add(producto);
    }
    return resultado;
  }

  Map<String, dynamic> toJson() => {
        "productos": List<dynamic>.from(productos.map((x) => x.toJson())),
      };
}

class Producto {
  String listaPrecios;
  String codArticulo;
  String descripcion;
  double pvp;
  double pvc;
  int entero;
  int fraccion;
  ImageProvider? imgImagenmediana;
  int valorPos;
  String esMf;
  String iva;
  String idclase;
  String? idmarca;
  String aplicaDsctos;

  Producto({
    required this.listaPrecios,
    required this.codArticulo,
    required this.descripcion,
    required this.pvp,
    required this.pvc,
    required this.entero,
    required this.fraccion,
    this.imgImagenmediana,
    required this.valorPos,
    required this.esMf,
    required this.iva,
    required this.idclase,
    this.idmarca,
    required this.aplicaDsctos,
  });

  factory Producto.fromRawJson(String str) =>
      Producto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        listaPrecios: json["ListaPrecios"],
        codArticulo: json["COD_ARTICULO"],
        descripcion: json["descripcion"],
        pvp: json["PVP"]?.toDouble(),
        pvc: json["PVC"]?.toDouble(),
        entero: json["entero"],
        fraccion: json["fraccion"],
        imgImagenmediana: json["img_imagenmediana"],
        valorPos: json["valor_pos"],
        esMf: json["es_mf"],
        iva: json["Iva"],
        idclase: json["idclase"],
        idmarca: json["idmarca"],
        aplicaDsctos: json["aplicaDsctos"],
      );

  Map<String, dynamic> toJson() => {
        "ListaPrecios": listaPrecios,
        "COD_ARTICULO": codArticulo,
        "descripcion": descripcion,
        "PVP": pvp,
        "PVC": pvc,
        "entero": entero,
        "fraccion": fraccion,
        "img_imagenmediana": imgImagenmediana,
      };
}
