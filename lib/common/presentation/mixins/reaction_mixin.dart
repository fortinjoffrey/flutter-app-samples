import 'package:mobx/mobx.dart';

mixin ReactionMixin {
  final reactionDisposers = <ReactionDisposer>[];

  /// Adds a reaction
  void addReaction(ReactionDisposer value) {
    reactionDisposers.add(value);
  }

  /// Disposes all added reactions
  /// This method must be called in view's dispose method
  void disposeReactions() {
    reactionDisposers.forEach((disposer) => disposer());
  }
}
