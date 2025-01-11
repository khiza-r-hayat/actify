import 'package:flutter/material.dart';

class AssignStocksScreen extends StatelessWidget{
  const AssignStocksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Assign Stocks'),),body: const Center(child: Text('No Stocks found'),),);
  }
}