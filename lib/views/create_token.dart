import 'package:flutter/material.dart';
import 'package:vitsllc_assignment_task/views/common_widgets/custom_button.dart';
import 'package:vitsllc_assignment_task/views/common_widgets/custom_textfield_with_title.dart';

class CreateTokenScreen extends StatelessWidget {
  const CreateTokenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Token"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const CustomTextFieldWithTitle(
              hintText: "Token Number",
              readOnly: true,
            ),
            const CustomTextFieldWithTitle(
              hintText: "Job Number",
              readOnly: true,
            ),
            const CustomTextFieldWithTitle(
              hintText: "Enter a vehicle Type",
            ),
            const CustomTextFieldWithTitle(
              hintText: "Vehicle No.",
            ),
            const CustomTextFieldWithTitle(
              hintText: "User Mobile No.",
            ),
            CustomButton(title: "Create Token", onPressed: () {})
          ],
        ),
      )),
    );
  }
}
