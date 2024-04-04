import 'package:flutter/material.dart';

class MainUtils {
  static formattedDuration(num time, String end) =>
      "${time.toString().padLeft(2, "0")}$end";
  static showBanner(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
        .showMaterialBanner(MaterialBanner(content: Text(msg), actions: [
      TextButton(
          onPressed: () {
            closeBanner(context);
          },
          child: const Text("Ok"))
    ]));
  }

  static closeBanner(BuildContext context) {
    ScaffoldMessenger.of(context).clearMaterialBanners();
  }
}
