import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp/core/models/view_states.dart';
import 'package:pp/features/popular/data/models/popular_image_model.dart';
import 'package:pp/features/popular/data/models/popular_model.dart';
import 'package:pp/features/popular/presentation/providers/popular_images_provider.dart';
import 'package:pp/features/popular/presentation/screens/popular_image_screen.dart';
import 'package:pp/utils/constants.dart';

class ImagesCardWidget extends ConsumerStatefulWidget {
  const ImagesCardWidget(
    this.popular, {
    Key? key,
  }) : super(key: key);

  final PopularModel popular;

  @override
  ConsumerState<ImagesCardWidget> createState() => _ImagesCardWidgetState();
}

class _ImagesCardWidgetState extends ConsumerState<ImagesCardWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(popularImagesProvider.notifier)
          .fetchPopularImages(widget.popular.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    const imageBaseUrl = AppConstants.kImageBaseUrl;

    final state = ref.watch(popularImagesProvider);

    if (state is LoadingViewState) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }

    if (state is ErrorViewState) {
      return Center(child: Text(state.errorMessage));
    }

    if (state is LoadedViewState<List<PopularImageModel>>) {
      final images = state.data;
      return GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(5.0),
        itemCount: images.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          mainAxisExtent: 150.0,
        ),
        itemBuilder: (BuildContext context, index) {
          final image = images[index];
          return GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PersonImageScreen(
                  popular: widget.popular,
                  filePath: image.filePath.toString(),
                ),
              ),
            ),
            child: Hero(
              tag: image.filePath.toString(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: CachedNetworkImage(
                  imageUrl: imageBaseUrl + image.filePath.toString(),
                  fit: BoxFit.cover,
                  errorWidget: (ctx, url, e) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      );
    }
    return const SizedBox();
  }
}
