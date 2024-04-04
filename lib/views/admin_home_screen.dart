import 'package:flutter/material.dart';
import 'package:vitsllc_assignment_task/views/create_token.dart';
import 'package:vitsllc_assignment_task/views/services_list.dart';

import 'create_user.dart';
import 'login_signup.dart';
import 'tokens_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
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
      body: const SafeArea(
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
