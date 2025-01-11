import 'package:flutter/material.dart';

class ConfirmationDialog{
  static Future<void> showConfirmationDialog(context,onConfirm) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this lead?'),
          actions: <Widget>[
            TextButton(
              onPressed: onConfirm,
              child: const Text('yes'),
            ),TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}