// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'companies.g.dart';

@JsonSerializable()
class Companies {
  String productName;
  int money;
  String imageUrl;
  String? key;
  Companies({
    required this.productName,
    required this.money,
    required this.imageUrl,
  });

  factory Companies.fromJson(Map<String, dynamic> json) => _$CompaniesFromJson(json);

  Map<String, dynamic> toJson() => _$CompaniesToJson(this);
}

class CompaniesList {
  List<Companies> companies = [];

  CompaniesList.fromJson(Map value) {
    value.forEach((key, value) {
      var companie = Companies.fromJson(value);
      companie.key = key;
      companies.add(companie);
    });
  }
}
