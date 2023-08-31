import 'package:clientes_articulos/screens/update_client_screen.dart';
import 'package:clientes_articulos/theme/app_theme.dart';
import 'package:provider/provider.dart';

import '../blocs/theme.dart';
import '../providers/auth_provider.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../models/clientes_response.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:clientes_articulos/screens/products_screen.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen(
      {super.key, required this.lstClientes, required this.redirectToProduct});
  final List<Cliente> lstClientes;
  final bool redirectToProduct;

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _criterioFiltro = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChanger>(context, listen: false);
    List<Cliente> clientesFiltrados = [];
    final Size size = MediaQuery.of(context).size;
    if (_criterioFiltro.isNotEmpty) {
      // Si se ha ingresado un idPlan para buscar, filtra la lista original según ese idPlan
      clientesFiltrados = widget.lstClientes
          .where((cliente) =>
              cliente.nombreCliente
                  .toString()
                  .contains(_criterioFiltro.toUpperCase()) ||
              cliente.numeroDocumento.toString().contains(_criterioFiltro))
          .toList();
    } else {
      // Si no se ha ingresado un idPlan para buscar, muestra la lista original sin filtrar
      clientesFiltrados = widget.lstClientes;
    }
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
            title: Text(
              "Escoger Cliente",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:
                    size.width > 600 ? size.height * 0.05 : size.height * 0.03,
              ),
            ),
            height: size.height),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(25),
                child: BarraBusqueda(
                  hintText: "Digite Identificación o Nombres",
                  onFilter: (value) {
                    setState(() {
                      _criterioFiltro = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: themeProvider.getThemeIsMedi()
                        ? AppTheme.buttomAndheadersMedi
                        : AppTheme.buttomAndheadersEco,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('Cédula',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('Nombres',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('Email',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, bottom: 55, top: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.white,
                      child: DataTable2(
                        headingRowHeight: 0,
                        showBottomBorder: false,
                        minWidth: 400,
                        dataRowHeight: 80,
                        showCheckboxColumn: false,
                        columns: const [
                          DataColumn(label: Text('')),
                          DataColumn(label: Text('')),
                          DataColumn(label: Text('')),
                        ],
                        rows: clientesFiltrados.map((cliente) {
                          return DataRow(
                              onSelectChanged: (_) {
                                print(cliente.toJson());
                                if (widget.redirectToProduct) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ProductsScreen(
                                        cliente: cliente,
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => UpdateClienteScreen(
                                        cliente: cliente,
                                        isNew: false,
                                      ),
                                    ),
                                  );
                                }
                              },
                              cells: [
                                DataCell(Center(
                                    child:
                                        Text(cliente.numeroDocumento ?? ""))),
                                DataCell(
                                  Center(
                                    child: Text(
                                      cliente.nombreCliente ?? "",
                                    ),
                                  ),
                                ),
                                DataCell(
                                    Center(child: Text(cliente.email ?? ""))),
                              ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
