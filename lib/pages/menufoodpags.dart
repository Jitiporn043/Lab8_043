import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MenuFoodPage extends StatefulWidget {
  const MenuFoodPage({super.key});

  @override
  State<MenuFoodPage> createState() => _MenuFoodState();
}

class _MenuFoodState extends State<MenuFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("เมนูอาหาร"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("foods").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("ไม่มีรายการอาหาร"),
            );
          }

          // แสดงรายการอาหาร
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var food = snapshot.data!.docs[index];
              return ListTile(
                leading: food["image"] != null
                    ? Image.network(food["image"],
                        width: 50, height: 50, fit: BoxFit.cover)
                    : const Icon(Icons.fastfood),
                title: Text(food["name"] ?? "ไม่มีชื่อ"),
                subtitle: Text("ราคา: ${food["price"] ?? "ไม่ระบุ"} บาท"),
              );
            },
          );
        },
      ),
    );
  }
}
