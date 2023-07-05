import 'package:flutter/material.dart';
import 'package:presence/model/allUsers.dart';

class Test1 extends StatefulWidget {
  Test1({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _Test1State createState() => new _Test1State();
}

class _Test1State extends State<Test1> {
  TextEditingController editingController = TextEditingController();

  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = <String>[];
  var datafromSnapShot;

  late Future<List<AllUsers>> allUserList;

  @override
  void initState() {
    items = duplicateItems;
    super.initState();

    allUserList = AllUsersRepository.getAllUsers();
    allUserList.then((list) {
      for (int i = 0; i < list.length; i++) {
        print(list[0].name);
      }
    }).catchError((error, stackTrace) {
      print('Error: $error');
      print('Stack trace: $stackTrace');
    });

    // print(allUserList[0].name,);
  }

  void filterSearchResults(String query) {
    setState(() {
      items = duplicateItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          FutureBuilder(
            future: allUserList,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error} found'),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                final datafromSnapShot = snapshot.data;
                final length = datafromSnapShot!.length;

                return ListView.builder(
                  itemCount: length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${datafromSnapShot[index].name}'),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          // Expanded(
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     itemCount: items.length,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         onTap: () {
          //           setState(() {
          //             editingController.text = items[index];
          //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //                 duration: Duration(milliseconds: 300),
          //                 content: Text('${items[index]}')));
          //           });
          //         },
          //         title: Text('${items[index]}'),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
