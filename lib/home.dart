import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makeathon/recepieDetail.dart';
import 'package:makeathon/recipeSearch.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      appBar: AppBar(
        title: const Text('Popular Recipes'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot recipe = snapshot.data!.docs[index];
              return Card(
                child: SizedBox(
                  height: 80,
                  child: ListTile(
                    trailing: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(recipe['image_url']))),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(recipe['image_url']),
                    ),
                    title: Text(recipe['name']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailsScreen(
                            recipeId: recipe.id.toString(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 180,
              childAspectRatio: 2.5,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
          );
        },
      ),
    );
  }
}
