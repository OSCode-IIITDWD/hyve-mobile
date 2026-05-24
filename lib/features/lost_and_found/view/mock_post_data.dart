import 'package:flutter/material.dart';
import 'package:hyve/features/lost_and_found/data/models/post_models.dart';

Future<List<PostModel>> fetchXYZ() async {
  return samplePostList;
}

const List<PostModel> samplePostList = [
  PostModel(
    postId: 'post-001',
    title: "Panties Found 1",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 12, minute: 45),
  ),
  PostModel(
    postId: 'post-002',
    title: "Panties Found 2",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 13, minute: 45),
  ),
  PostModel(
    postId: 'post-0003',
    title: "Bra Found 21",
    description: "Found a pink bra in e-block",
    image: "https://www.bareessentials.in/cdn/shop/products/ProductMain18SFS001Pink.jpg?v=1628747752&width=1445",
    author: "witeasfck",
    postType: PostType.found,
    time: TimeOfDay(hour: 23, minute: 21),
  ),
  PostModel(
    postId: 'post-0003',
    title: "Bra Found 21",
    description: "Found a pink bra in e-block",
    image: "https://www.bareessentials.in/cdn/shop/products/ProductMain18SFS001Pink.jpg?v=1628747752&width=1445",
    author: "witeasfck",
    postType: PostType.found,
    time: TimeOfDay(hour: 23, minute: 21),
  ),
  PostModel(
    postId: 'post-0003',
    title: "Bra Found 21",
    description: "Found a pink bra in e-block",
    image: "https://www.bareessentials.in/cdn/shop/products/ProductMain18SFS001Pink.jpg?v=1628747752&width=1445",
    author: "witeasfck",
    postType: PostType.found,
    time: TimeOfDay(hour: 23, minute: 21),
  ),
];