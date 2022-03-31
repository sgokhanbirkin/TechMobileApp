import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_mobile_app/core/constant/services/storages_methods.dart';
import 'package:tech_mobile_app/feature/askQuestionPage/model/question_model.dart';

import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload post
  Future<String> uploadPost(
    String description,
    File file,
    String id,
    String username,
    String profImage,
    String category,
    String value,
    String userId,
  ) async {
    String res = "Some error occured";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();

      Question question = Question(
        description: description,
        id: id,
        name: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        value: value,
        category: category,
        userId: userId,
      );
      print("PHOTO URL : : : " + photoUrl);

      _firestore.collection('questions').doc(postId).set(question.toJson());
      return "success";
    } catch (err) {
      res = err.toString();
      return res;
    }
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (err) {
      print(
        err.toString(),
      );
    }
  }

  Future<void> postComment(String postId, String comment, String uid,
      String name, String profilePic) async {
    try {
      if (comment.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'comment': comment,
          'uid': uid,
          'name': name,
          'commentId': commentId,
          'profilePic': profilePic,
          'datePublished': DateTime.now()
        });
      } else {
        print("Text is empty");
      }
    } catch (err) {
      print(
        err.toString(),
      );
    }
  }

  // deleting post

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List<dynamic> following = (snap.data()! as dynamic)['following'];
      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }
}
