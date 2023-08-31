import 'package:clientes_articulos/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/clientes_response.dart';
import '../providers/user_provider.dart';

class ProductsWebScreen extends StatelessWidget {
  const ProductsWebScreen({super.key, required this.cliente});
  final Cliente cliente;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          flex: 3,
          child:
              LeftInformationUser(cliente: cliente, userProvider: userProvider),
        ),
        Expanded(
          flex: 7,
          child: RightInformationUser(
              userProvider: userProvider, cliente: cliente),
        ),
      ],
    );
  }
}
