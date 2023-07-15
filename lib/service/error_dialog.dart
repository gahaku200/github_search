// Flutter imports:
import 'package:flutter/material.dart';

// エラー発生時にダイアログを表示させる為のグローバルクラス
class ErrorDialog {
  static Future<void> errorDialog({
    required String subtitle,
    required BuildContext context,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('エラーが発生しました'),
          content: Text(
            subtitle,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.cyan,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
