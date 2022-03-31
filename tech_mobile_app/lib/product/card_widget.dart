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
    required this.date,
  }) : super(key: key);
  final String url;
  String? title;
  String? description;
  String? value;
  String? category;
  final date;

  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: Card(
        shadowColor: Colors.pink,
        elevation: 5,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.pink.shade200,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            '$value TMC',
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Positioned(
                  child: Text(
                    '23/12/2020',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
