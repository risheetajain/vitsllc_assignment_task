import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitsllc_assignment_task/constants/collection_string.dart';
import 'package:vitsllc_assignment_task/constants/constant_list.dart';
import 'package:vitsllc_assignment_task/services/firestore_services.dart';
import 'package:vitsllc_assignment_task/views/common_widgets/custom_button.dart';

import '../controllers/services_start_controller.dart';
import '../utils/main_utils.dart';

class TimerText extends StatefulWidget {
  const TimerText({super.key, required this.myData, required this.docId});
  final Map<String, dynamic> myData;
  final String docId;

  @override
  State<TimerText> createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late final Animation<double> opacity;

  late final ServiceInController clockinController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    opacity = Tween(begin: 1.0, end: 0.0).animate(_animationController);

    clockinController = Get.find<ServiceInController>();

    if (clockinController.isClockedin) {
      _animationController.repeat(reverse: true);
    }
    print(widget.myData);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<ServiceInController>(
          builder: (clockinController) {
            return clockinController.isClockedin
                ? Column(
                    children: [
                      CustomButton(
                        title: "Stop Services ",
                        onPressed: () {
                          clockinController.updateIsClockedIn(false);
                          FirestoreServices.updateData(
                              collection: CollectionString.tokenCollection,
                              docId: widget.docId,
                              myData: {"end_time": DateTime.now()});
                          FirestoreServices.updateData(
                              collection: CollectionString.servicesCollection,
                              docId: widget.myData["service_id"],
                              myData: {"status": StatusService.Done.name});
                        },
                      ),
                    ],
                  )
                : CustomButton(
                    title: "Start Services",
                    onPressed: () {
                      var clockInTime = DateTime.now();
                      clockinController.onClockin(clockInTime);
                      print(widget.myData);
                      _animationController.repeat(reverse: true);
                      FirestoreServices.updateData(
                          collection: CollectionString.tokenCollection,
                          docId: widget.docId,
                          myData: {"start_time": DateTime.now()});
                      FirestoreServices.updateData(
                          collection: CollectionString.servicesCollection,
                          docId: widget.myData["service_id"],
                          myData: {"status": StatusService.InProcess.name});
                    },
                  );
          },
        ),
        const SizedBox(
          height: 24,
        ),
        const Text(
          "Time",
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<ServiceInController>(
              builder: (controller) {
                return Text(
                  MainUtils.formattedDuration(
                      controller.timeSoFar["hours"]!, "H"),
                );
              },
            ),
            FadeTransition(
              opacity: opacity,
              child: const Text(
                " : ",
              ),
            ),
            GetBuilder<ServiceInController>(
              builder: (controller) {
                return Text(
                  MainUtils.formattedDuration(
                      controller.timeSoFar["minutes"]!, "M"),
                );
              },
            ),
            FadeTransition(
              opacity: opacity,
              child: const Text(
                " : ",
              ),
            ),
            GetBuilder<ServiceInController>(builder: (controller) {
              return Text(
                MainUtils.formattedDuration(
                    controller.timeSoFar["seconds"]!, "S"),
              );
            }),
          ],
        ),
      ],
    );
  }
}
