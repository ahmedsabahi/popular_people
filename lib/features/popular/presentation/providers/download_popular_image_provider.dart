import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pp/core/models/view_states.dart';
import 'package:pp/core/provider/base_provider.dart';
import 'package:pp/features/popular/domain/useCases/download_populor_image.dart';

final downloadPopularImageProvider =
    StateNotifierProvider.autoDispose<DownloadPopularImageProvider, ViewState>(
  (ref) => DownloadPopularImageProvider(
    ref.watch(downloadPopularImageUseCaseProvider),
  ),
);

class DownloadPopularImageProvider extends BaseProvider<Uint8List> {
  final DownloadPopularImage _downloadPopularImage;

  DownloadPopularImageProvider(this._downloadPopularImage);

  late PermissionStatus status;

  Future<void> fetchDownloadPopularImage(String imaPath) async {
    setLoadingState();
    final isMediaLibraryGranted = await Permission.mediaLibrary.isGranted;
    final isStorageGranted = await Permission.storage.isGranted;
    if (isStorageGranted || isMediaLibraryGranted) {
      final response = await _downloadPopularImage.call(imaPath);
      response.fold(
        (failure) => setErrorState(failure.message),
        setLoadedState,
      );
    } else {
      setErrorState('Permission denied');
    }
  }
}
