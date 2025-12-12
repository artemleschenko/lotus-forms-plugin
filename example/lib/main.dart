import 'package:flutter/material.dart';
import 'package:lotus_forms_package/lotus_forms_package.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: DynamicForms(formId: '', jwtToken: ''),
        ),
      ),
    );
  }
}
