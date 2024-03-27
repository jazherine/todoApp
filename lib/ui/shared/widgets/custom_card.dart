// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todoapp/ui/shared/styles/text_styles.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageURL,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 20,
        child: ListTile(
          trailing: Image.network(imageURL),
          title: Text(
            title,
            style: titleStyle,
          ),
          subtitle: Text(subtitle),
        ));
  }

  Widget get imagePlace {
    return imageURL.isEmpty ? const Placeholder() : Image.network(imageURL);
  }
}
