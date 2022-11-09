import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seo_test/api_service.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = '/detail/:id';
  final int id;
  const DetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Map<dynamic, dynamic>? _item;
  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    final item =
        await Provider.of<ApiService>(context, listen: false).detail(widget.id);

    setState(() {
      _item = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _item == null
          ? null
          : AppBar(
              title: Text(
                _item!['name'],
              ),
            ),
      body: _item == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    _item!['sprites']['other']['official-artwork']
                            ['front_default']
                        .toString(),
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  Text(_item!['order'].toString())
                ],
              ),
            ),
    );
  }
}
