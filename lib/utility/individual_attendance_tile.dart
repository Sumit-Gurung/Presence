import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';

class IndividualTakeAttendanceTile extends StatefulWidget {
  // final bool? showToogle;
  final String name;
  final String? profilePic;
  final int attendeeId;
  final ValueChanged<bool> onSwitchChanged;
  final bool isPresent;

  const IndividualTakeAttendanceTile(
      {super.key,
      required this.name,
      this.profilePic,
      required this.onSwitchChanged,
      required this.attendeeId,
      required this.isPresent});

  // const IndividualTakeAttendanceTile({super.key, this.showToogle});
  // const IndividualTakeAttendanceTile({Key? key}) : super(key: key);

  @override
  State<IndividualTakeAttendanceTile> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<IndividualTakeAttendanceTile> {
  List idListOfPresentAttendee = [];
  bool isSwitch = false;
  @override
  void initState() {
    super.initState();
    isSwitch = widget.isPresent;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: AppColors.tilebackgroundColor,
          boxShadow: [
            BoxShadow(
                blurRadius: 7,
                spreadRadius: 1,
                color: Colors.grey.shade500,
                offset: Offset(2, 6)),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          onTap: () {
            print(idListOfPresentAttendee);
          },
          title: Text(widget.name),
          leading: CircleAvatar(
            radius: 15,
            backgroundImage: (widget.profilePic != null)
                ? NetworkImage("${widget.profilePic}") as ImageProvider
                : AssetImage("assets/images/avatar.jpg"),
          ),
          // NetworkImage("${Endpoints.url} ${widget.profilePic}" ??
          //       'https://i0.wp.com/sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png?ssl=1'),
          trailing: Switch.adaptive(
              value: isSwitch,
              onChanged: (v) {
                setState(() {
                  isSwitch = v;
                  widget.onSwitchChanged(v);
                  // idListOfPresentAttendee.add(widget.attendeeId);
                });
              }),
        ),
      ),
    );
  }
}
