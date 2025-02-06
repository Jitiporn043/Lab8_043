import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'product_home.dart';

class ProductCart extends StatefulWidget {
  const ProductCart({super.key});

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("รายละเอียดสินค้า"),
      ),
      body: Center(
        child: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : null,
                    child: user.photoURL == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.displayName ?? "กล้วย",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    user.displayName ?? "รายละเอียดสินค้า",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              )
            : const Text("ราคา 50 บาท"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.food_bank),
                    title: const Text("รายการสินค้า"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductHome(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.menu_book_rounded),
                    title: const Text("รายละเอียดสินค้า"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductHome(),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.menu),
      ),
    );
  }
}
