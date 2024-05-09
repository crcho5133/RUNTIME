import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Button extends ConsumerWidget {
  const Button({
    super.key,
    required this.onPress,
  });

  final void Function() onPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onPress,
      child: Container(),
    );
  }
}

// void a() {
//   Button(onPress: () => Navigator.pushNamed(context, routeName),)
// }