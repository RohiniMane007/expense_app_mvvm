import 'package:flutter/material.dart';

void alertDialogBox(BuildContext context,
    {required String title,
    required Widget content,
    VoidCallback? onOkClicked,
    String cancelText = 'Cancel',
    String okText = 'OK',
    bool? showCancelBtn = false}) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing the dialog by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        content: content,
        actions: [
          if (showCancelBtn!)
            TextButton(
              child: Text(cancelText),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          TextButton(
            child: Text(okText),
            onPressed: () {
              if (onOkClicked != null) {
                onOkClicked(); // Execute the provided callback
              }
              Navigator.of(context).pop(); // Close the dialog
            },
          )
        ],
      );
    },
  );
}
