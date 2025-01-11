import 'package:flutter/material.dart';

class ApproveBaReturnsScreen extends StatelessWidget{
  const ApproveBaReturnsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Approve Returns'),),body: const Center(child: Text('No returns to show'),),);
  }
}