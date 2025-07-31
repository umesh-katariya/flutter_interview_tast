import 'package:flutter/material.dart';

class CommonLoadingView extends StatelessWidget {
  const CommonLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
