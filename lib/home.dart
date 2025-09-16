import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _seedIfEmpty() async {
    final col = FirebaseFirestore.instance.collection('services');
    final snap = await col.limit(1).get();
    if (snap.docs.isEmpty) {
      await col.add({
        'title': 'درس خصوصي برمجة',
        'providerName': 'Anas',
        'city': 'Jerusalem',
        'pricePerHour': 80,
        'ratingAvg': 4.9,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _seedIfEmpty(); // مرّة واحدة للتجربة

    final query = FirebaseFirestore.instance
        .collection('services')
        .orderBy('createdAt', descending: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        actions: [
          IconButton(
            tooltip: 'تسجيل الخروج',
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: query.snapshots(),
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(child: Text('خطأ: ${snap.error}'));
          }
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snap.data!.docs;
          if (docs.isEmpty) {
            return const Center(child: Text('لا توجد خدمات بعد'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final d = docs[i].data() as Map<String, dynamic>;
              final title = d['title']?.toString() ?? '';
              final provider = d['providerName']?.toString() ?? '';
              final city = d['city']?.toString() ?? '';
              final price = d['pricePerHour']?.toString() ?? '0';
              final rating = d['ratingAvg']?.toString() ?? '0';
              return Card(
                child: ListTile(
                  title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('$provider • $city\n$rating ★'),
                  isThreeLine: true,
                  trailing: Text('$price₪/ساعة'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final col = FirebaseFirestore.instance.collection('services');
          await col.add({
            'title': 'خدمة جديدة ${DateTime.now().millisecondsSinceEpoch}',
            'providerName': 'Provider X',
            'city': 'City',
            'pricePerHour': 100,
            'ratingAvg': 4.5,
            'createdAt': FieldValue.serverTimestamp(),
          });
        },
        label: const Text('أضف خدمة'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
