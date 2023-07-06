import 'package:flutter/material.dart';
import 'package:presence/model/group.dart';
import 'package:presence/screens/searchModule.dart';

class GroupShow extends StatefulWidget {
  const GroupShow({super.key});

  @override
  State<GroupShow> createState() => _GroupShowState();
}

class _GroupShowState extends State<GroupShow> {
  late Future<List<Group>> groups;
  @override
  void initState() {
    super.initState();

    groups = MyGroupRepository.getGroup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          // SearchModule(),
          FutureBuilder(
            future: groups,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error} found'),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                final datafromSnapShot = snapshot.data;
                final length = datafromSnapShot!.length;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${datafromSnapShot[index].name}'),
                      subtitle: Text('${datafromSnapShot[index].created_at}'),
                      trailing:
                          Text('${datafromSnapShot[index].id.toString()}'),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      )),
    );
  }
}
