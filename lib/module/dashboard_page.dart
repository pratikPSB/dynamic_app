import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vfs_dynamic_app/data/model/app_modules_by_client_model.dart';

class DashboardPage extends StatefulWidget {
  final List<Module> moduleList;

  const DashboardPage({super.key, required this.moduleList});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: ListView.builder(
        itemCount: widget.moduleList.length,
        itemBuilder: (context, index) {
          var model = widget.moduleList[index];
          return ListTile(
            title: Text(model.displayName!),
            onTap: () {
              context.push("/${model.routeUrl}");
            },
            trailing: IconButton(
              onPressed: () {
                context.push("/${model.routeUrl}");
              },
              icon: const Icon(Icons.arrow_forward_rounded),
            ),
          );
        },
      ),
    );
  }
}
