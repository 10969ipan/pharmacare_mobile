import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Account'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Orders'),
              Tab(text: 'Notifications'),
              Tab(text: 'Settings'),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Your Orders Will Appear Here')),
            Center(child: Text('Your Notifications Will Appear Here')),
            Center(child: Text('Account Settings')),
          ],
        ),
      ),
    );
  }
}
