import 'package:flutter/material.dart';
import 'package:vitsllc_assignment_task/views/admin_home_screen.dart';
import 'package:vitsllc_assignment_task/views/service_horizontal_view.dart';

import 'login_signup.dart';

class EmployeeHomeScreen extends StatelessWidget {
  const EmployeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee Home Screen"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PhoneOTPVerification(),
                    ));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Column(
        children: [
          HomeCard(title: "Services", navigateTo: HorizontalServiceList())
        ],
      ),
    );
  }
}
