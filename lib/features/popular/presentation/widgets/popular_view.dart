import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp/core/models/base_model.dart';
import 'package:pp/core/models/view_states.dart';
import 'package:pp/features/popular/data/models/popular_model.dart';
import 'package:pp/features/popular/presentation/providers/popular_provider.dart';
import 'package:pp/features/popular/presentation/widgets/popular_card_widget.dart';

class PopularView extends StatelessWidget {
  const PopularView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final state = ref.watch(popularProvider);

      if (state is LoadingViewState) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }

      if (state is ErrorViewState) {
        return Center(child: Text(state.errorMessage));
      }

      if (state is LoadedViewState<BaseModel<PopularModel>>) {
        final readProvider = ref.read(popularProvider.notifier);
        final watchProvider = ref.watch(popularProvider.notifier);
        final results = state.data.results;
        return ListView.builder(
          itemCount: results.length + (watchProvider.hasMoreData ? 1 : 0),
          itemBuilder: (BuildContext context, int index) {
            if (index >= results.length) {
              readProvider.loadMore();
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return PopularCardWidget(results[index]);
          },
        );
      }
      return const SizedBox();
    });
  }
}
