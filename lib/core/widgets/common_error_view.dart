import 'package:flutter/material.dart';

class CommonErrorView extends StatelessWidget {
  final String message;
  const CommonErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
