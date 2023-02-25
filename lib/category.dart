import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makeathon/home.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    List<String> myProducts = [
      'North Indian',
      'South Indian',
      'Italian',
      'French',
      'Japanese',
      'Chinese'
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  myProducts[index].toString(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryRecipe extends StatefulWidget {
  final String id;
  const CategoryRecipe({Key? key, required this.id}) : super(key: key);

  @override
  State<CategoryRecipe> createState() => _CategoryRecipeState();
}

class _CategoryRecipeState extends State<CategoryRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              if (snapshot.data!.docs[index]["cuisine"].toString() ==
                  widget.id) {
                dynamic recipe = snapshot.data!.docs[index];

                return ListTile(
                  title: Text(recipe['name']),
                  onTap: () {},
                );
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
