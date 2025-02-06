import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductHome extends StatefulWidget {
  const ProductHome({super.key});

  @override
  State<ProductHome> createState() => _MenuFoodState();
}

class _MenuFoodState extends State<ProductHome> {
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
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: food["image"] != null
                      ? Image.network(
                          food["image"],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.fastfood, size: 50),
                  title: Text(
                    food["name"] ?? "ไม่มีชื่อ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "ราคา: ${food["price"] ?? "ไม่ระบุ"} บาท",
                    style: const TextStyle(color: Colors.green),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      // TODO: เพิ่มในตะกร้า
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('${food["name"]} ถูกเพิ่มในตะกร้า')),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
