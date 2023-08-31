import 'package:clientes_articulos/widgets/widgets.dart';

import 'package:flutter/material.dart';

class LocationField extends StatelessWidget {
  const LocationField(
      {Key? key,
      required this.titlePlace,
      required this.titleSucursal,
      required this.informationPlace,
      required this.informationSucursal})
      : super(key: key);

  final List informationPlace;
  final String titlePlace;
  final List informationSucursal;
  final String titleSucursal;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return size.width > 600
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownField(title: titlePlace, customList: informationPlace),
              const SizedBox(width: 20),
              DropdownField(title: titleSucursal, customList: informationSucursal),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownField(title: titlePlace, customList: informationPlace),
              const SizedBox(height: 20),
              DropdownField(title: titleSucursal, customList: informationSucursal),
            ],
          );
  }
}
