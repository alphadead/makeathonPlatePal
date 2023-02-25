import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:makeathon/category.dart';
import 'package:makeathon/fav.dart';
import 'package:makeathon/home.dart';
import 'package:makeathon/login.dart';
import 'package:makeathon/recipeSearch.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String id = FirebaseAuth.instance.currentUser!.uid;

  final TextEditingController _allergenController = TextEditingController();
  final TextEditingController _dishController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> listofallergen = [];
    List<String> listofdish = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!'),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false);
                },
                child: const Icon(Icons.logout)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeSearchScreen(),
            ),
          );
        },
        child: const Icon(Icons.search),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(id)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  dynamic user = snapshot.data!.data();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
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
                      // Container(
                      //   padding: const EdgeInsets.all(20.0),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       const Text(
                      //         'Favorite Dishes:',
                      //         style: TextStyle(fontSize: 20.0),
                      //       ),
                      //       const SizedBox(height: 10.0),
                      //       if (user['favoriteDishes'].isEmpty)
                      //         const Text(
                      //             'You haven\'t added any favorite dishes yet.'),
                      //       for (var dish in user['favoriteDishes'])
                      //         Text('- $dish'),
                      //       Row(
                      //         children: [
                      //           Expanded(
                      //             child: TextField(
                      //               controller: _dishController,
                      //               decoration: const InputDecoration(
                      //                 hintText: 'Add new allergen...',
                      //               ),
                      //             ),
                      //           ),
                      //           const SizedBox(width: 8.0),
                      //           ElevatedButton(
                      //             onPressed: () {
                      //               for (String allergen
                      //                   in user['favoriteDishes']!) {
                      //                 listofdish.add(allergen);
                      //               }
                      //               listofdish.add(_dishController.text);
                      //               FirebaseFirestore.instance
                      //                   .collection('users')
                      //                   .doc(id)
                      //                   .update({
                      //                 'favoriteDishes': listofdish,
                      //               });

                      //               setState(() {});
                      //             },
                      //             child: const Text('Add'),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  );
                }),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                elevation: 10,
                child: SizedBox(
                  height: 50,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FavPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Your Favorite Dishes',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Icon(Icons.favorite)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 250,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 5.0,
                  shrinkWrap: true,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.asset(
                              'assets/dish.jpg',
                              height: 150,
                            ),
                          ),
                          const Center(
                            child: Text(
                              'Dishes',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const Categories()),
                        );
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.asset(
                              'assets/cuisine.jpg',
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Center(
                            child: Text(
                              'Cuisine',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
