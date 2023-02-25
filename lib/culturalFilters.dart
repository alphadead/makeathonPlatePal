import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CulturalFiltersScreen extends StatefulWidget {
  final List<String> selectedCultures;
  final Function(List<String>) onSelectionChanged;

  const CulturalFiltersScreen({
    required this.selectedCultures,
    required this.onSelectionChanged,
  });

  @override
  _CulturalFiltersScreenState createState() => _CulturalFiltersScreenState();
}

class _CulturalFiltersScreenState extends State<CulturalFiltersScreen> {
  late List<String> _cultures;

  @override
  void initState() {
    super.initState();

    // Initialize the list of available cultures from Firestore
    FirebaseFirestore.instance
        .collection('cultures')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          _cultures = List<String>.from(
              querySnapshot.docs.map((doc) => doc['name']).toList());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cultural Filters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              widget.onSelectionChanged(widget.selectedCultures);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _cultures == null ? 0 : _cultures.length,
        itemBuilder: (BuildContext context, int index) {
          String culture = _cultures[index];
          bool isSelected = widget.selectedCultures.contains(culture);

          return CheckboxListTile(
            title: Text(culture),
            value: isSelected,
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  widget.selectedCultures.add(culture);
                } else {
                  widget.selectedCultures.remove(culture);
                }
              });
            },
          );
        },
      ),
    );
  }
}
