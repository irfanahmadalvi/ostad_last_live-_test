import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_model.dart';

Future<List<Product>> fetchProducts() async {
  final uri = Uri.parse('http://35.73.30.144:2008/api/v1/ReadProduct');

  try {
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = jsonDecode(response.body);

      if (decodedJson['status'] == 'success') {
        List<dynamic> dataList = decodedJson['data'];
        return dataList.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('API returned status: ${decodedJson['status']}');
      }
    } else {
      throw Exception('Failed to load products (StatusCode: ${response.statusCode})');
    }
  } catch (e) {
    throw Exception('Failed to fetch products: $e');
  }
}