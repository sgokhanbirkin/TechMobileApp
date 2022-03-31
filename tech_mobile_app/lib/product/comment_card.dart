import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({Key? key, required this.snap}) : super(key: key);
  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    var item = widget.snap.data();

    return Container(
      child: Card(
        child: Column(
          children: [
            Text(item['title']),
            Container(
              height: context.height * 0.2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    item['answerUrl'],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(item['description']),
          ],
        ),
      ),
    );
  }
}
