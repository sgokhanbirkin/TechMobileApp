import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CardWidget extends StatelessWidget {
  CardWidget({
    Key? key,
    required this.category,
    required this.description,
    required this.title,
    required this.url,
    required this.value,
    required this.onPressed,
  }) : super(key: key);
  final String url;
  String? title;
  String? description;
  String? value;
  String? category;

  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                title ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                height: context.height * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(url), fit: BoxFit.cover),
                ),
              ),
              Text(
                description ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                value ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                category ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
