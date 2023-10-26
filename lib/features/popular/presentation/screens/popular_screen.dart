import 'package:flutter/material.dart';
import 'package:pp/features/popular/presentation/widgets/popular_view.dart';

class PopularScreen extends StatelessWidget {
  const PopularScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular People'),
      ),
      body: const PopularView(),
    );
  }
}
