import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:pp/features/popular/data/models/popular_model.dart';
import 'package:pp/utils/constants.dart';

class MoviesCardWidget extends StatelessWidget {
  const MoviesCardWidget(
    this.popular, {
    Key? key,
  }) : super(key: key);

  final PopularModel popular;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    const imageBaseUrl = AppConstants.kImageBaseUrl;

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: popular.knownFor!.length,
        itemBuilder: (context, index) {
          final movie = popular.knownFor![index];

          return Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(20),
            ),
            width: mediaQuery.width * 0.9,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CachedNetworkImage(
                    imageUrl: imageBaseUrl + movie.posterPath.toString(),
                    fit: BoxFit.cover,
                    errorWidget: (ctx, url, e) => const Icon(Icons.error),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        movie.title ?? movie.originalTitle.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: movie.voteAverage ?? 0 / 2,
                            itemCount: 5,
                            itemSize: 20.0,
                            itemBuilder: (__, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                          Text(' ${movie.voteAverage}/10')
                        ],
                      ),
                      const SizedBox(height: 5),
                      if (movie.releaseDate != null)
                        Text(
                          'Release date: ${DateFormat('yyyy/MM/dd').format(movie.releaseDate!)}',
                        ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: Text(
                          movie.overview ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
