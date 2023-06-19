// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:presence/providers/Individual_attendee_provider.dart';
import 'package:presence/providers/group_Provider.dart';
import 'package:provider/provider.dart';

class ManageAttendeeTile extends StatefulWidget {
  // final bool? showToogle;

  // const Individual_tile({super.key, this.showToogle});
  // const ManageAttendeeTile({Key? key}) : super(key: key);
  final int index;
  // final String attendeeName;

  const ManageAttendeeTile({super.key, required this.index});

  @override
  State<ManageAttendeeTile> createState() => _ManageAttendeeTileState();
}

class _ManageAttendeeTileState extends State<ManageAttendeeTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AttendeeProvider, GroupProvider>(
      builder: (context, AttendeeVariable, groupProviderVariable, child) {
        return Container(
          margin: EdgeInsets.only(bottom: 25),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Slidable(
            child: ListTile(
                title: Text(
                    "${AttendeeVariable.attendeeName[widget.index]["name"]}"),
                // title: Text(
                //     "${groupProviderVariable.myGroups[widget.index]["attendeeList"][0]["name"]}"),
                //
                leading: CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                      'https://www.google.com/search?q=avatar+url&source=lnms&tbm=isch&sa=X&ved=2ahUKEwiegO6ty-X8AhXMI7cAHZr3AU8Q_AUoAXoECAEQAw&biw=1536&bih=754&dpr=1.25#imgrc=YYYLguVFuko0CM'),
                ),
                trailing: Icon(Icons.room_preferences_outlined)),
            endActionPane: ActionPane(
              children: [
                SlidableAction(
                  onPressed: (context) {
                    setState(() {
                      AttendeeVariable.deleteFromList(
                          AttendeeVariable.attendeeName[widget.index]["name"]);
                    });
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: null,
                  backgroundColor: Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.find_replace_outlined,
                  label: 'Replace',
                ),
              ],
              motion: ScrollMotion(),
            ),
          ),
        );
      },
    );
  }
}
