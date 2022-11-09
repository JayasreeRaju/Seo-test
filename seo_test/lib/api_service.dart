import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const apiBaseURL = 'https://pokeapi.co/api/v2';
const limit = 100;

class PaginatedResponse<T> {
  final List<T> results;
  final String? next;
  final String? previous;
  final int count;

  PaginatedResponse({
    required this.results,
    this.next,
    this.previous,
    required this.count,
  });
}

class ListResult {
  final String name;
  final String url;

  ListResult({
    required this.name,
    required this.url,
  });

  int get id {
    final parts = url.split('/');
    return int.parse(parts[parts.length - 2]);
  }
}

class ApiService with ChangeNotifier, DiagnosticableTreeMixin {
  Future<Map<String, dynamic>> _getHttp(String path, [params]) async {
    try {
      final url = "$apiBaseURL/$path";
      var response = await Dio().get(url, queryParameters: params ?? {});
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return {};
    }
  }

  Future<PaginatedResponse<ListResult>> list([int page = 1]) async {
    final params = {
      'page': page,
      'offset': (page - 1) * limit,
      'limit': limit,
    };

    final data = await _getHttp('pokemon', params);

    final results = data['results']
        .map<ListResult>(
          (item) => ListResult(
            name: item['name'],
            url: item['url'],
          ),
        )
        .toList();

    return PaginatedResponse<ListResult>(
      count: data['count'],
      results: results,
      next: data['next'],
      previous: data['previous'],
    );
  }

  Future<Map<dynamic, dynamic>>? detail(int id) async {
    final path = 'pokemon/$id';
    final data = await _getHttp(path);
    return data;
  }
}
