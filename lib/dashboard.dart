import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String id = FirebaseAuth.instance.currentUser!.uid;

  final TextEditingController _allergenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> listofallergen = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(id)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              dynamic user = snapshot.data!.data();
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${user['name']}',
                          style: const TextStyle(fontSize: 20.0),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Age: ${user['age']}',
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Allergens:',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        const SizedBox(height: 10.0),
                        Wrap(
                          children: [
                            for (String allergen in user['allergens']!)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 5.0,
                                ),
                                margin: const EdgeInsets.only(
                                    right: 10.0, bottom: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(allergen),
                                    const SizedBox(width: 5.0),
                                    GestureDetector(
                                      onTap: () {
                                        for (String allergen
                                            in user['allergens']!) {
                                          listofallergen.add(allergen);
                                        }
                                        listofallergen.remove(allergen);
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(id)
                                            .update({
                                          'allergens': listofallergen,
                                        });
                                        setState(() {});
                                      },
                                      child: const Icon(
                                        Icons.clear,
                                        size: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _allergenController,
                                    decoration: const InputDecoration(
                                      hintText: 'Add new allergen...',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                ElevatedButton(
                                  onPressed: () {
                                    for (String allergen
                                        in user['allergens']!) {
                                      listofallergen.add(allergen);
                                    }
                                    listofallergen
                                        .add(_allergenController.text);
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(id)
                                        .update({
                                      'allergens': listofallergen,
                                    });

                                    setState(() {});
                                  },
                                  child: const Text('Add'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Favorite Dishes:',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        const SizedBox(height: 10.0),
                        if (user['favoriteDishes'].isEmpty)
                          const Text(
                              'You haven\'t added any favorite dishes yet.'),
                        for (var dish in user['favoriteDishes'])
                          Text('- $dish'),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
