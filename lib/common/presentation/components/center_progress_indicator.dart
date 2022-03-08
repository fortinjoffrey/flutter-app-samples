import 'package:flutter/material.dart';

class CenterProgressIndicator<T extends ProgressIndicator> extends StatelessWidget {
  const CenterProgressIndicator({
    Key? key,
    this.progressIndicator,
  }) : super(key: key);

  final T? progressIndicator;

  @override
  Widget build(BuildContext context) {
    return Center(child: progressIndicator ?? const CircularProgressIndicator());
  }
}
