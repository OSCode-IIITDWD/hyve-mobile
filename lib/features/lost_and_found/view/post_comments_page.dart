import 'package:flutter/material.dart';
import 'package:hyve/features/lost_and_found/data/models/post_models.dart';

class PostCommentsPage extends StatelessWidget {
  final PostModel postModel;

  const PostCommentsPage({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    // This screen is intentionally lightweight for now; the postId makes it easy to load real thread data later.
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments • ${postModel.postId}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            postModel.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Post ID: ${postModel.postId}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(postModel.description),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Conversation',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Comments for this post will appear here.'),
            ),
          ),
          const SizedBox(height: 12),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Add a reply composer here when the comments flow is connected.'),
            ),
          ),
        ],
      ),
    );
  }
}