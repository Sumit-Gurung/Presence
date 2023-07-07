import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';

class Individual_tile extends StatefulWidget {
  // final bool? showToogle;
  final String name;
  final String profilePic;

  const Individual_tile(
      {super.key, required this.name, required this.profilePic});

  // const Individual_tile({super.key, this.showToogle});
  // const Individual_tile({Key? key}) : super(key: key);

  @override
  State<Individual_tile> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Individual_tile> {
  bool isSwitch = false;
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
          title: Text(widget.name),
          leading: CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage("${Endpoints.url} ${widget.profilePic}" ??
                'https://i0.wp.com/sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png?ssl=1'),
          ),
          trailing: Switch.adaptive(
              value: isSwitch,
              onChanged: (v) {
                setState(() {
                  isSwitch = v;
                });
              }),
        ),
      ),
    );
  }
}
