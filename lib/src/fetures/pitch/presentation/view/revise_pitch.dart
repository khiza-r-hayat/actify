import 'package:flutter/material.dart';

class RevisePitch extends StatelessWidget{
  const RevisePitch({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Revise Pitch'),),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
            color: Colors.white,
            constraints: BoxConstraints(minWidth: size.width),
            padding: EdgeInsets.all(8),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pitch'),
                Text('data'),
              ],
            ),
          ),
          const SizedBox(height: 12,)
          ,Container(
            padding: EdgeInsets.all(8),
            constraints: BoxConstraints(minWidth: size.width),
            color: Colors.white,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Does'),
                Text('data'),
                const SizedBox(height: 12,),
                Text("Don'ts"),
                Text('Pitch'),
              ],
            ),
          ),
        ],),
      ),
    );
  }
}