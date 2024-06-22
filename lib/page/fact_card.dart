import 'package:bloc_vs_riverpod_example/Data/models/fact.dart';
import 'package:flutter/material.dart';

class FactCard extends StatelessWidget{

  final Fact fact;
  const FactCard(this.fact,{super.key});

  @override
  Widget build(BuildContext context) {
    return Card(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.lightbulb),
          title: Text(fact.text),
        )
      ],
    ),);

  }
}