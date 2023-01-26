import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home For now'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            'Present?',
            textAlign: TextAlign.end,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
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
              );
            },
            itemCount: 5,
          ),
          Row(
            children: [
              Expanded(
                  child:
                      ElevatedButton(onPressed: () {}, child: Text('Confirm')))
            ],
          )
        ],
      )),
    );
  }
}
