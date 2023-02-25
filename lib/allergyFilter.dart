import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
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
                  })),
        ),
      ),
    );
  }
}
