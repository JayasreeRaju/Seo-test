import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seo_test/api_service.dart';
import 'package:seo_test/item_card.dart';

class ListScreen extends StatefulWidget {
  static const routeName = '/';
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<ListResult> _items = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final response =
        await Provider.of<ApiService>(context, listen: false).list();
    setState(() {
      _isLoading = false;
      _items = response.results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokemon')),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return ItemCard(
                  _items[index],
                );
              },
            ),
    );
  }
}
