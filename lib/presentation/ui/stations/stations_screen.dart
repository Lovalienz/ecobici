import 'package:ecobici/presentation/ui/stations/utils/flutter_elastic_list_view.dart';
import 'package:flutter/material.dart';

class Stations extends StatelessWidget {
  const Stations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Encuentra tu Ecobici'),
      ),
      body: ElasticListView(
        children: List.generate(
          50,
          (index) {
            return Container(
              height: 100,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red[(index % 9 + 1) * 100],
                borderRadius: BorderRadius.circular(16),
              ),
            );
          },
        ),
      ),
    );
  }
}
