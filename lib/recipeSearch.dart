import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makeathon/allergyFilter.dart';
import 'package:makeathon/recepieDetail.dart';

class RecipeSearchScreen extends StatefulWidget {
  @override
  _RecipeSearchScreenState createState() => _RecipeSearchScreenState();
}

class _RecipeSearchScreenState extends State<RecipeSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<QueryDocumentSnapshot> _searchResults = [];

  void _searchRecipes(String query) async {
    final CollectionReference recipesRef =
        FirebaseFirestore.instance.collection('recipes');

    QuerySnapshot querySnapshot =
        await recipesRef.where('name', isGreaterThanOrEqualTo: query).get();

    setState(() {
      _searchResults = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search for recipes',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
          onSubmitted: _searchRecipes,
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllergyFiltersScreen(
                      selectedAllergens: ['milk'],
                    ),
                  ),
                );
              },
              child: const Icon(Icons.sort))
        ],
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (BuildContext context, int index) {
          final recipe = _searchResults[index];

          return ListTile(
            title: Text(recipe['name'].toString()),
            subtitle: Text(recipe['description']),
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
          );
        },
      ),
    );
  }
}
