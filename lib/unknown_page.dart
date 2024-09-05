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
        title: Text("Ohh Not found"),
      ),
      body: Center(
        child: Container(
          child: Text("The page you are looking for is not found!!!"),
        ),
      ),
    );
  }
}
