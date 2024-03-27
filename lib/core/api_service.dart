import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:todoapp/core/model/companies/companies.dart';

class ApiService {
  late String _baseUrl;

  static final ApiService _instance = ApiService._privateConstructor();

  ApiService._privateConstructor() {
    _baseUrl = "https://todoapp-s1s1-default-rtdb.europe-west1.firebasedatabase.app";
  }

  static ApiService getInstance() {
    return _instance;
  }

  Future<List<Companies>> getProducts() async {
    final response = await http.get(Uri.parse("$_baseUrl/products.json"));
    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        if (jsonResponse.isNotEmpty) {
          print(jsonResponse);
          final companiesList = CompaniesList.fromJson(jsonResponse);
          return companiesList.companies;
        }

      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        return Future.error("Unauthorized");
    }
    Logger().e(jsonResponse);
    return Future.error("Error");
  }

  Future<void> addCompanies(Companies companies) async {
    final jsonBody = jsonEncode(companies.toJson());
    final response = await http.post(Uri.parse("$_baseUrl/products.json"), body: jsonBody);
    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(jsonResponse);

      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        return Future.error("Unauthorized");
    }
    Logger().e(jsonResponse);
    return Future.error("Error");
  }

  Future<void> removeProducts(String key) async {
    final response = await http.delete(Uri.parse("$_baseUrl/products/$key.json"));
    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(true);

      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        return Future.error("Unauthorized");
    }
    Logger().e(jsonResponse);
    return Future.error("Error");
  }
}
