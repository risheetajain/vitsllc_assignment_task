import 'package:flutter/material.dart';
import 'package:vitsllc_assignment_task/constants/constant_list.dart';
import 'package:vitsllc_assignment_task/views/common_widgets/custom_button.dart';
import 'package:vitsllc_assignment_task/views/common_widgets/custom_textfield_with_title.dart';

import '../constants/decoration.dart';

class ServicesList extends StatelessWidget {
  const ServicesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Services We Provide"),
      ),
      body: ListView.builder(
        itemCount: servicesProvide.length,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(servicesProvide[index].toString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const AddNewServices();
            },
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Create New Services"),
      ),
    );
  }
}

class AddNewServices extends StatefulWidget {
  const AddNewServices({
    super.key,
  });

  @override
  State<AddNewServices> createState() => _AddNewServicesState();
}

class _AddNewServicesState extends State<AddNewServices> {
  StatusService? service;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const CustomTextFieldWithTitle(
            hintText: "Service Name",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DropdownButtonFormField<StatusService>(
                onChanged: (value) {
                  service = value;
                  setState(() {});
                },
                decoration: inputdecoration(context).copyWith(
                    hintText: 'Select Status', labelText: "Select Status"),
                items: StatusService.values
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name),
                        ))
                    .toList()),
          ),
          CustomButton(title: "Create New Services", onPressed: () {})
        ],
      ),
    );
  }
}
