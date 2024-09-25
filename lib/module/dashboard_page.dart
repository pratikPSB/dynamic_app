import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vfs_dynamic_app/data/model/app_modules_by_client_model.dart';
import 'package:vfs_dynamic_app/data/utils/extensions.dart';

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
      body: ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: widget.moduleList.length,
        itemBuilder: (context, index) {
          var model = widget.moduleList[index];
          return Card(
            shape: 15.modifyShapeBorder(),
            elevation: 5,
            child: ListTile(
              shape: 15.modifyShapeBorder(),
              contentPadding: const EdgeInsetsDirectional.only(start: 10),
              horizontalTitleGap: 10,
              minVerticalPadding: 20,
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
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.transparent,
          );
        },
      ),
    );
  }
}
