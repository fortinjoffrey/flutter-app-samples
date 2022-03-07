import 'package:flutter/material.dart';

/// Creates a [Column] with a fixed [SizedBox] as spacer between each children
class ColumnWithSpacing extends StatelessWidget {
  const ColumnWithSpacing({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.children,
    required this.spacing,
  }) : super(key: key);

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final spacedChildren = <Widget>[];
    // Add a spacing after each children expect for the last one
    for (var index = 0; index < children.length - 1; index++) {
      spacedChildren.addAll(
        [children[index], SizedBox(height: spacing)],
      );
    }
    // Add last children with spacing after it
    spacedChildren.add(children.last);

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: spacedChildren,
    );
  }
}
