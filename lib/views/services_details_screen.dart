import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitsllc_assignment_task/controllers/services_start_controller.dart';
import 'package:vitsllc_assignment_task/models/token_models.dart';

import 'timer_text.dart';

class TokenDetailScreen extends StatefulWidget {
  const TokenDetailScreen(
      {super.key, required this.tokenModel, required this.docId});
  final TokenModel tokenModel;
  final String docId;

  @override
  State<TokenDetailScreen> createState() => _TokenDetailScreenState();
}

class _TokenDetailScreenState extends State<TokenDetailScreen> {
  bool? isStartService;
  final ServiceInController controller = Get.put(
    ServiceInController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Job Details'),
        ),
        body: Column(
          children: [
            JobDetails(
              tokenNo: widget.tokenModel.tokenNo,
              jobNo: widget.tokenModel.jobNo,
              vehicleType: widget.tokenModel.vehicleType,
              vehicleNumber: widget.tokenModel.vehicleNumber,
              userMobile: widget.tokenModel.userMobile,
              createdAt: widget.tokenModel.createdAt,
            ),
            TimerText(
              docId: widget.docId,
              myData: widget.tokenModel.toJson(),
            ),
            // ElevatedButton(
            //     onPressed: () {}, child: const Text("Start Services"))
          ],
        ));
  }
}

class JobDetails extends StatelessWidget {
  final String tokenNo;
  final String jobNo;
  final String vehicleType;
  final String vehicleNumber;
  final String userMobile;
  final DateTime createdAt;

  const JobDetails({
    super.key,
    required this.tokenNo,
    required this.jobNo,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.userMobile,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailItem("Token No", tokenNo),
          _buildDetailItem("Job No", jobNo),
          _buildDetailItem("Vehicle Type", vehicleType),
          _buildDetailItem("Vehicle Number", vehicleNumber),
          _buildDetailItem("User Mobile", userMobile),
          _buildDetailItem("Created At", "${createdAt.toLocal()}"),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
