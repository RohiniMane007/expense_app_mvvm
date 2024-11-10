import 'package:flutter/material.dart';

class Demo extends InheritedWidget {
  const Demo({super.key, required super.child, required this.num});
  final int num;

  static Demo? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Demo>();
  }

  static Demo of(BuildContext context) {
    final Demo? res = maybeOf(context);
    assert(res != null, 'Error');
    return res!;
  }

  @override
  bool updateShouldNotify(Demo oldWidget) {
    return num != oldWidget.num;
  }
}
