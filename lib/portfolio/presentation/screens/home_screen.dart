import 'package:flutter/material.dart';

import '../../../extensions/context_extension.dart';
import '../widgets/home_header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio'),
        actions: [
          TextButton(
            onPressed: () => context.cubit.toggleLanguage(),
            child: const Text("Toogle Language"),
          ),
        ],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [HomeHeaderWidget()],
          ),
        ),
      ),
    );
  }
}
