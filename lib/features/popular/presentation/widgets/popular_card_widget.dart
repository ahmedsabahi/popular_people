import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pp/features/popular/data/models/popular_model.dart';
import 'package:pp/features/popular/presentation/screens/popular_details_screen.dart';
import 'package:pp/utils/constants.dart';

class PopularCardWidget extends StatelessWidget {
  const PopularCardWidget(this.popular, {super.key});

  final PopularModel popular;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    const imageBaseUrl = AppConstants.kImageBaseUrl;
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => PopularDetailsScreen(popular),
            ),
          );
        },
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Hero(
                tag: popular.id ?? popular.name.toString(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CachedNetworkImage(
                    imageUrl: imageBaseUrl + popular.profilePath.toString(),
                    width: mediaQuery.width * 0.4,
                    height: mediaQuery.height * .21,
                    fit: BoxFit.cover,
                    errorWidget: (_, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      popular.name ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (popular.knownFor != null) ...[
                      const Text(
                        'Known for:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Wrap(
                        children: popular.knownFor!
                            .map((movie) => Text(
                                  '${movie.title ?? ''}${movie.title == null ? '' : ','} ',
                                  style: const TextStyle(fontSize: 14),
                                ))
                            .toList(),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
