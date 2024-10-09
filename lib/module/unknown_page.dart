import 'package:flutter/material.dart';

class UnknownPage extends StatefulWidget {
  const UnknownPage({super.key});

  @override
  State<UnknownPage> createState() => _UnknownPageState();
}

class _UnknownPageState extends State<UnknownPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("404 Not found"),
      ),
      body: const Center(
        child: Text("The page you are looking for is not found!!!"),
      ),
    );
  }
}
