import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  final String imageUrl;
  final String description;
  final bool isActive; // Estado, true para activo y false para inactivo

  const BannerCard({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: const Icon(
              Icons.edit,
              color: Colors.grey,
            ),
          ),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15.0)),
              image: DecorationImage(
                image: AssetImage(imageUrl),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              description,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: isActive ? Colors.green : Colors.red,
                ),
                Text(
                  isActive ? ' ACTIVO' : ' DESACTIVADO',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
