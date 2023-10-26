import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pp/features/popular/data/models/popular_model.dart';
import 'package:pp/features/popular/presentation/widgets/images_card_widget.dart';
import 'package:pp/features/popular/presentation/widgets/movies_card_widget.dart';
import 'package:pp/utils/constants.dart';

class PopularDetailsScreen extends StatelessWidget {
  const PopularDetailsScreen(this.popular, {super.key});

  final PopularModel popular;

  @override
  Widget build(BuildContext context) {
    const imageBaseUrl = AppConstants.kImageBaseUrl;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 550.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(popular.name ?? ''),
                    ),
                    const SizedBox(width: 10),
                    if (popular.popularity != null) ...[
                      const Icon(Icons.star, color: Colors.amber, size: 12),
                      Text(
                        popular.popularity.toString(),
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ],
                ),
                background: Hero(
                  tag: popular.id ?? popular.name.toString(),
                  child: CachedNetworkImage(
                    imageUrl: imageBaseUrl + popular.profilePath.toString(),
                    fit: BoxFit.cover,
                    errorWidget: (ctx, url, e) => const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (popular.knownFor != null) ...[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Known For:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                MoviesCardWidget(popular),
              ],
              ImagesCardWidget(popular),
            ],
          ),
        ),
      ),
    );
  }
}
