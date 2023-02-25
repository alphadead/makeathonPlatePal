import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavPage extends StatefulWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  String id = FirebaseAuth.instance.currentUser!.uid;
  List favs = [];
  dynamic data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _try();
  }

  Future<void> _try() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) {
      for (var val in value['fav']) {
        favs.add(val);
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favorite Dishes!'),
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

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              if (favs.contains(snapshot.data!.docs[index].id)) {
                DocumentSnapshot recipe = snapshot.data!.docs[index];

                return ListTile(
                  title: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(recipe['image_url']))),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(recipe['image_url']),
                  ),
                  subtitle: Text(recipe['name']),
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
