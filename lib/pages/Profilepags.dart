import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'menufoodpags.dart';

class Profilepags extends StatefulWidget {
  const Profilepags({super.key});

  @override
  State<Profilepags> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profilepags> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("โปรไฟล์"),
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
                    user.displayName ?? "ไม่มีชื่อ",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    user.email ?? "ไม่มีอีเมล",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "เข้าสู่ระบบครั้งล่าสุด: ${user.metadata.lastSignInTime?.toString() ?? "N/A"}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              )
            : const Text("ไม่มีผู้ใช้ที่ล็อกอิน."),
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
                    title: const Text("เมนูอาหาร"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MenuFoodPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("การตั้งค่า"),
                    onTap: () {
                      Navigator.pop(context);
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
