import 'package:flutter/material.dart';
import 'package:vitsllc_assignment_task/views/create_token.dart';
import 'package:vitsllc_assignment_task/views/services_list.dart';

import 'create_user.dart';
import 'tokens_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HomeCard(
              title: "Create a new Token",
              navigateTo: CreateTokenScreen(),
            ),
            HomeCard(
              title: "Create a Users",
              navigateTo: AddNewUsers(),
            ),
            HomeCard(
              title: "Add Services",
              navigateTo: ServicesList(),
            ),
            HomeCard(
              title: "My Reports",
              navigateTo: ServicesList(),
            ),
            HomeCard(
              title: "Token List",
              navigateTo: TokenList(),
            ),
            // HomeCard(
            //   title: "Services Start Stop",
            //   navigateTo: ServicesStartStop(),
            // ),
            // HomeCard(
            //   title: "Phone Verificaton",
            //   navigateTo: PhoneOTPVerification(),
            // ),
          ],
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.title,
    required this.navigateTo,
  });
  final String title;
  final Widget navigateTo;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => navigateTo));
        },
        child: Card(child: ListTile(title: Text(title))));
  }
}
