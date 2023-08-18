import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/providers/group_Provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyGroupTile extends StatefulWidget {
  final String groupName;
  final int? numberOfAttendee;
  final int? numberOfRecords;
  final String date;
  final int? index;
  final VoidCallback? ontap;
  final int groupId;
  // final dynamic group;
  final Function? onGroupDelete;

  const MyGroupTile(
      {super.key,
      required this.groupName,
      this.numberOfAttendee,
      this.numberOfRecords,
      required this.groupId,
      this.index,
      // required this.group,
      this.onGroupDelete,
      this.ontap,
      required this.date});

  @override
  State<MyGroupTile> createState() => _MyGroupTileState();
}

class _MyGroupTileState extends State<MyGroupTile> {
  // const MyGroupTile({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
      builder: (context, groupProviderVariable, child) {
        return GestureDetector(
          onTap: widget.ontap,
          child: Container(
            width: double.maxFinite,
            // height: double.maxFinite,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                color: AppColors.tilebackgroundColor,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      spreadRadius: -2,
                      color: Colors.grey.shade500,
                      offset: Offset(1, 6)),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            child: Slidable(
              endActionPane: ActionPane(motion: ScrollMotion(), children: [
                SlidableAction(
                  onPressed: (context) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState11) {
                            return AlertDialog(
                              title: Text("Are You sure?"),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      var inst =
                                          await SharedPreferences.getInstance();
                                      String authToken =
                                          inst.getString('accessToken')!;

                                      var headers = {
                                        'Content-Type': 'application/json',
                                        'Authorization': 'Bearer $authToken',
                                      };
                                      final response = await http.delete(
                                        Uri.parse(
                                            '${Endpoints.forDeleteGroup}${widget.groupId}'),
                                        headers: headers,
                                      );
                                      setState11(
                                        () {},
                                      );

                                      print(
                                          '${Endpoints.forDeleteGroup}${widget.groupId}');

                                      if (response.statusCode == 200) {
                                        setState11(() {
                                          // Remove the deleted group from the list
                                          // Update the state to trigger a refresh of the list
                                          // widget.group.removeWhere((group) =>
                                          //     group.id == widget.groupId);
                                        });
                                        if (widget.onGroupDelete != null) {
                                          widget.onGroupDelete!();
                                        }
                                        print(
                                            'Group has been deleted successfully');
                                      } else {
                                        print(
                                            'Request failed with status: ${response.statusCode}');
                                      }

                                      Navigator.pop(context);
                                    },
                                    child: Text('YES')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("NO"))
                              ],
                            );
                          },
                        );
                      },
                    );
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
                  icon: Icons.edit,
                  label: 'Edit',
                ),
              ]),
              child: Container(
                // width: double.maxFinite,
                // height: double.maxFinite,
                // margin: EdgeInsets.only(bottom: 15),

                padding: EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      widget.groupName,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.2),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.numberOfAttendee}  Attendeee',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'since ${widget.date}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${widget.numberOfRecords}  Records',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
