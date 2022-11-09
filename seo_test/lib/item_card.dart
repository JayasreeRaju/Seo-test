import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:seo_test/api_service.dart';
import 'package:seo_test/details_screen.dart';

class ItemCard extends StatelessWidget {
  final ListResult result;

  const ItemCard(
    this.result, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(result.name),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Modular.to.popAndPushNamed(
            DetailsScreen.routeName.replaceAll(':id', result.id.toString()),
          );
        },
      ),
    );
  }
}
