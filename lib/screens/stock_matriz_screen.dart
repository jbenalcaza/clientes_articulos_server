import 'package:animate_do/animate_do.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../blocs/theme.dart';
import '../models/producto_matriz_response.dart';

import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

class StockMatrizScreen extends StatefulWidget {
  const StockMatrizScreen({
    super.key,
    required this.lstFarmacias,
    required this.nombreProducto,
  });
  final List<Farmacia> lstFarmacias;
  final String nombreProducto;

  @override
  State<StockMatrizScreen> createState() => _StockMatrizScreenState();
}

class _StockMatrizScreenState extends State<StockMatrizScreen> {
  TextEditingController _searchController = TextEditingController();
  String _criterioFiltro = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Farmacia> farmaciasFiltradas = [];

    final Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeChanger>(context, listen: false);
    if (_criterioFiltro.isNotEmpty) {
      // Si se ha ingresado un idPlan para buscar, filtra la lista original según ese idPlan
      farmaciasFiltradas = widget.lstFarmacias
          .where((farmacia) => farmacia.nombre
              .toString()
              .toUpperCase()
              .contains(_criterioFiltro.toUpperCase()))
          .toList();
    } else {
      // Si no se ha ingresado un idPlan para buscar, muestra la lista original sin filtrar
      farmaciasFiltradas = widget.lstFarmacias;
    }
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
            title: Text(
              "STOCK FARMACIAS",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:
                    size.width > 600 ? size.height * 0.06 : size.height * 0.03,
              ),
            ),
            height: size.height),
        body: FadeIn(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopify_rounded,
                          textDirection: TextDirection.ltr),
                      Text(
                        widget.nombreProducto,
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(25),
                  child: BarraBusqueda(
                    hintText: "Digite el Nombre de la Farmacia",
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
                        /* Container(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text('Oficina',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),*/
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text('Nombre',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text('Stock Ent',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text('Stock Uni',
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
                          dataRowHeight: 80,
                          minWidth: 600,
                          showCheckboxColumn: false,
                          columns: const [
                            //DataColumn(label: Text('')),
                            DataColumn(label: Text('')),
                            DataColumn(label: Text('')),
                            DataColumn(label: Text('')),
                          ],
                          rows: farmaciasFiltradas.map((farmacia) {
                            return DataRow(cells: [
                              /* DataCell(
                                Center(
                                  child: Text(farmacia.oficina ?? ""),
                                ),
                              ),*/
                              DataCell(
                                Center(
                                  child: Text(farmacia.nombre ?? ""),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(farmacia.stock.toString() ?? ""),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(
                                      farmacia.stockFracciones.toString() ??
                                          ""),
                                ),
                              ),
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
      ),
    );
  }
}
