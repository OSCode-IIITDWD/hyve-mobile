import 'package:flutter/material.dart';

class PostModel {
  final String postId;
  final String title;
  final String description;
  final String image;
  final String author;
  final PostType postType;
  final TimeOfDay time;



  const PostModel({
    required this.postId,
    required this.title,
    required this.description,
    required this.image,
    required this.author,
    required this.postType,
    required this.time,
    
  });
}

enum PostType {
  lost,
  found,
}