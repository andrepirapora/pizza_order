import 'package:flutter/material.dart';
import 'pizza_order_bloc.dart';

class PizzaOrderProvider extends InheritedWidget {
  final PizzaOrderBLoC? bloc;

  const PizzaOrderProvider({this.bloc, required Widget child})
      : super(child: child);

  static PizzaOrderBLoC? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<PizzaOrderProvider>()!.bloc;

  @override
  bool updateShouldNotify(covariant PizzaOrderProvider oldWidget) => true;
}
