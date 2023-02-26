import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makeathon/recipeSearch.dart';

class AllergyFiltersScreen extends StatefulWidget {
  final List<String> selectedAllergens;
  // final Function(List<String>) onSelectionChanged;

  const AllergyFiltersScreen({
    required this.selectedAllergens,
    //required this.onSelectionChanged,
  });

  @override
  _AllergyFiltersScreenState createState() => _AllergyFiltersScreenState();
}

class _AllergyFiltersScreenState extends State<AllergyFiltersScreen> {
  String id = FirebaseAuth.instance.currentUser!.uid;
  List<String> listofallergen = [];
  bool isGluten = false;
  bool isLac = false;
  bool isVeg = false;
  bool isVegan = false;

  @override
  void initState() {
    _try();
    super.initState();
  }

  Future<void> _try() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) {
      for (var val in value['allergens']) {
        listofallergen.add(val);
      }
      isGluten = value['gluten-free'];
      isLac = value['lactose-free'];
      isVeg = value['vegetarian'];
      isVegan = value['vegan'];
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Allergy Filters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              //widget.onSelectionChanged(widget.selectedAllergens);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeSearchScreen(
                    isGluten: isGluten,
                    isVeg: isVeg,
                    isLac: isLac,
                    isVegan: isVegan,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Vegan',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15),
                    ),
                    CupertinoSwitch(
                      value: isVegan,
                      onChanged: (val) {
                        setState(() {
                          isVegan = !isVegan;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Veg',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15),
                    ),
                    CupertinoSwitch(
                      value: isVeg,
                      onChanged: (val) {
                        setState(() {
                          isVeg = !isVeg;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Gluten-free',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15),
                    ),
                    CupertinoSwitch(
                      value: isGluten,
                      onChanged: (val) {
                        setState(() {
                          isGluten = !isGluten;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Lactose-free',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15),
                    ),
                    CupertinoSwitch(
                      value: isLac,
                      onChanged: (val) {
                        setState(() {
                          isLac = !isLac;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Allergens:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: listofallergen.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0,
                          ),
                          margin:
                              const EdgeInsets.only(right: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(listofallergen[index]),
                              const SizedBox(width: 5.0),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    listofallergen
                                        .remove(listofallergen[index]);
                                  });
                                },
                                child: const Icon(
                                  Icons.clear,
                                  size: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
