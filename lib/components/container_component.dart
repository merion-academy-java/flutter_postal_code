import 'package:flutter/material.dart';

class ContainerComponent extends StatelessWidget {
  final Widget child;
  const ContainerComponent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
        width: double.infinity,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.all(Radius.circular(16.0))),
          child: child,
        ));
  }
}
