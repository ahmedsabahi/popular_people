import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:pp/core/models/view_states.dart';
import 'package:pp/features/popular/data/models/popular_model.dart';
import 'package:pp/features/popular/presentation/providers/download_popular_image_provider.dart';
import 'package:pp/utils/constants.dart';

class PersonImageScreen extends ConsumerStatefulWidget {
  const PersonImageScreen({
    Key? key,
    required this.filePath,
    required this.popular,
  }) : super(key: key);

  final String filePath;
  final PopularModel popular;

  @override
  ConsumerState<PersonImageScreen> createState() => _PersonImageScreenState();
}

class _PersonImageScreenState extends ConsumerState<PersonImageScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(downloadPopularImageProvider, (previous, state) async {
      if (state is LoadingViewState) {
        showDialog(
          context: context,
          useRootNavigator: true,
          barrierDismissible: false,
          barrierColor: Colors.black12,
          builder: (context) => AlertDialog(
            title: const Center(child: CircularProgressIndicator.adaptive()),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
      }
      if (state is ErrorViewState) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: state.errorMessage,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.redAccent,
        );
      }
      if (state is LoadedViewState<Uint8List>) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: 'You have successfully added to your gallery.',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.orange,
        );
        await ImageGallerySaver.saveImage(Uint8List.fromList(state.data));
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.popular.name ?? ''),
      ),
      body: LayoutBuilder(
        builder: (buildCtx, constraints) {
          return Hero(
            tag: widget.popular.id ?? widget.popular.name.toString(),
            child: CachedNetworkImage(
              height: constraints.maxHeight,
              fit: BoxFit.cover,
              imageUrl: AppConstants.kImageBaseUrl + widget.filePath,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 9.0,
        child: const Icon(Icons.file_download),
        onPressed: () => ref
            .read(downloadPopularImageProvider.notifier)
            .fetchDownloadPopularImage(widget.filePath),
      ),
    );
  }
}
