import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenis_app/src/routes/routes.dart';
import 'package:tenis_app/src/ui/pages/home/home_controller.dart';
import 'package:tenis_app/src/ui/pages/home/windgets/list_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: const Text(
          "Tennis App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Routes.REGISTER),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: Consumer<HomeController>(
        builder: (context, c, child) => ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: List.generate(c.reservations.length,
              (index) => ListItem(tennisCourt: c.reservations[index])),
        ),
      ),
    );
  }
}
