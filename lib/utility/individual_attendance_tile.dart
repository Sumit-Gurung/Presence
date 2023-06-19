import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';

class Individual_tile extends StatefulWidget {
  // final bool? showToogle;

  // const Individual_tile({super.key, this.showToogle});
  const Individual_tile({Key? key}) : super(key: key);

  @override
  State<Individual_tile> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Individual_tile> {
  bool isSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: AppColors.tilebackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text('Student Name'),
        leading: CircleAvatar(
          radius: 15,
          backgroundImage: NetworkImage(
              'https://www.google.com/search?q=avatar+url&source=lnms&tbm=isch&sa=X&ved=2ahUKEwiegO6ty-X8AhXMI7cAHZr3AU8Q_AUoAXoECAEQAw&biw=1536&bih=754&dpr=1.25#imgrc=YYYLguVFuko0CM'),
        ),
        trailing: Switch.adaptive(
            value: isSwitch,
            onChanged: (v) {
              setState(() {
                isSwitch = v;
              });
            }),
      ),
    );
  }
}
