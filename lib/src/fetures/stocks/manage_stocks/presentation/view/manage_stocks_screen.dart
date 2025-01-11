import 'package:flutter/material.dart';

class ManageStocksScreen extends StatelessWidget{
  const ManageStocksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Manage Stocks'),),body: const Center(child: Text('No Stocks found'),),);
  }
}