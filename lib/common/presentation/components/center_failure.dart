import 'package:flutter/material.dart';

class CenterFailure extends StatelessWidget {
  const CenterFailure({
    Key? key,
    required this.text,
    required this.onRetry,
  }) : super(key: key);

  final String text;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        children: [
          Text(text),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          )
        ],
      ),
    );
  }
}
