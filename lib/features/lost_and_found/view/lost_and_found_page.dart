import 'package:flutter/material.dart';
import 'package:hyve/features/lost_and_found/data/models/post_models.dart';
import 'post_comments_page.dart';
import 'mock_post_data.dart';



class LostAndFoundPage extends StatelessWidget {
  const LostAndFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final posts=samplePostList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lost & Found'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: posts.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return PostCard(postModel: posts[index]);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Open create post flow.
        },
        icon: const Icon(Icons.add),
        label: const Text('Create post'),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final PostModel postModel;

  const PostCard({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final postTypeLabel = switch (postModel.postType) {
      PostType.lost => 'Lost',
      PostType.found => 'Found',
    };
    final timeLabel = postModel.time.format(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child:InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => PostCommentsPage(postModel: postModel),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                postModel.image,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: colors.surfaceContainerHighest,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: colors.onSurfaceVariant,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            postModel.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: colors.primary,
                              decorationColor: colors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          postModel.author,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Chip(
                    label: Text(postTypeLabel),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                postModel.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    timeLabel,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}