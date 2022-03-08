import 'package:flutter/material.dart';
import 'package:flutter_app_samples/common/presentation/theme/app_widgets_constants.dart';

class SizedDivider extends StatelessWidget {
  const SizedDivider({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height ?? 4,
        width: width ?? MediaQuery.of(context).size.width * 3 / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey,
        ),
        child: sizedBoxShrink,
      ),
    );
  }
}
