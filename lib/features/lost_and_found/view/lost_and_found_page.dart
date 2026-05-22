import 'package:flutter/material.dart';
import 'package:hyve/features/lost_and_found/data/models/post_models.dart';
import 'post_comments_page.dart';



class LostAndFoundPage extends StatelessWidget {
  final List<PostModel> posts;

  const LostAndFoundPage({super.key, this.posts = samplePostList});

  @override
  Widget build(BuildContext context) {
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
                      // Keep the title itself as the tap target so it feels like a post thread link.
                      InkWell(
                        borderRadius: BorderRadius.circular(4),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PostCommentsPage(postModel: postModel),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            postModel.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: colors.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor: colors.primary,
                                ),
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
                Icon(
                  Icons.bookmark_border_rounded,
                  color: colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// sample post list

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
    postId: 'post-003',
    title: "Panties Found 3",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 14, minute: 45),
  ),
  PostModel(
    postId: 'post-004',
    title: "Panties Found 4",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 15, minute: 45),
  ),
  PostModel(
    postId: 'post-005',
    title: "Panties Found 5",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 16, minute: 45),
  ),
  PostModel(
    postId: 'post-006',
    title: "Panties Found 6",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 16, minute: 45),
  ),
  PostModel(
    postId: 'post-007',
    title: "Panties Found 7",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 17, minute: 45),
  ),
  PostModel(
    postId: 'post-008',
    title: "Panties Found 8",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 18, minute: 45),
  ),
  PostModel(
    postId: 'post-009',
    title: "Panties Found 9",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 19, minute: 45),
  ),
  PostModel(
    postId: 'post-010',
    title: "Panties Found 10",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 20, minute: 45),
  ),
  PostModel(
    postId: 'post-011',
    title: "Panties Found 11",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 12, minute: 30),
  ),
  PostModel(
    postId: 'post-012',
    title: "Panties Found 12",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 13, minute: 30),
  ),
  PostModel(
    postId: 'post-013',
    title: "Panties Found 13",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 14, minute: 30),
  ),
  PostModel(
    postId: 'post-014',
    title: "Panties Found 14",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 15, minute: 30),
  ),
  PostModel(
    postId: 'post-015',
    title: "Panties Found 15",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 16, minute: 30),
  ),
  PostModel(
    postId: 'post-016',
    title: "Panties Found 16",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 17, minute: 30),
  ),
  PostModel(
    postId: 'post-017',
    title: "Panties Found 17",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 18, minute: 30),
  ),
  PostModel(
    postId: 'post-018',
    title: "Panties Found 18",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 19, minute: 30),
  ),
  PostModel(
    postId: 'post-019',
    title: "Panties Found 19",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 20, minute: 30),
  ),
  PostModel(
    postId: 'post-020',
    title: "Panties Found 20",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 21, minute: 30),
  ),
  PostModel(
    postId: 'post-021',
    title: "Panties Found 21",
    description: "Found a frilly pair of panties in e-block",
    image: "https://m.media-amazon.com/images/I/51mEJXtli6L._AC_UY1100_.jpg",
    author: "Nao Sama",
    postType: PostType.found,
    time: TimeOfDay(hour: 22, minute: 30),
  ),
  
];

