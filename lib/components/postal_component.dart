import 'package:flutter/material.dart';
import 'package:flutter_postal_code/api/dadata/dto/suggestions_response.dart';
import 'package:flutter_postal_code/components/container_component.dart';

class PostalComponent extends StatelessWidget {
  final bool isLoading;
  final SuggestionResponse? postalUnit;

  const PostalComponent({super.key, required this.isLoading, this.postalUnit});

  @override
  Widget build(BuildContext context) {
    return ContainerComponent(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children(),
      ),
    );
  }

  List<Widget> children() {
    if (isLoading) {
      return [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: const CircularProgressIndicator())
      ];
    }

    if (postalUnit != null ) {
      return [
        Text(
          postalUnit!.postalCode,
          style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600
          ),
        ),
        const SizedBox(height: 16,),
        Text(
          postalUnit!.unrestrictedValue,
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ];
    }

    return [
      const Text(
        "Ошибка в получении данных",
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    ];
  }
}
