import 'dart:async';

import 'package:get/get.dart';

class ServiceInController extends GetxController {
  bool _isClockedin = false;
  bool get isClockedin => _isClockedin;

  late DateTime _clockedInTime;
  DateTime get clockedInTime => _clockedInTime;

  Timer? timer;

  Map<String, num> timeSoFar = {
    "hours": 00,
    "minutes": 00,
    "seconds": 00,
  };

  void updateClockInTime(DateTime dateTime) => _clockedInTime = dateTime;

  void calculateTime() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        // DateTime mySetData = DateTime(2024, 3, 27);
        // print(mySetData);
        DateTime myCurrentDate = DateTime.now();
        Duration myDuration = myCurrentDate.difference(_clockedInTime);

        int hours = myDuration.inHours;
        int minutes = myDuration.inMinutes.remainder(60);
        int seconds = myDuration.inSeconds.remainder(60);

        timeSoFar = {
          "hours": hours,
          "minutes": minutes,
          "seconds": seconds,
        };
        update();
      },
    );
  }

  void cancelTimer() => timer?.cancel();

  void updateIsClockedIn(bool value) {
    _isClockedin = value;
    update();
  }

  void onClockin(DateTime clockinTime) {
    updateClockInTime(clockinTime);
    updateIsClockedIn(true);

    calculateTime();
  }

  void onClockoutTime() {
    cancelTimer();

    updateIsClockedIn(false);

    timeSoFar = {
      "hours": 00,
      "minutes": 00,
      "seconds": 00,
    };
    update();
  }

  @override
  void onClose() {
    cancelTimer();
    super.onClose();
  }
}
