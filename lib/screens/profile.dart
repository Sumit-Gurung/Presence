// import 'dart:html';

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http_parser/http_parser.dart";
import '../components/custom_button.dart';
import 'package:http/http.dart' as http;

import 'package:mime/mime.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int? selectedTileIndex;
  void handleTileTap(int index) {
    setState(() {
      selectedTileIndex = index;
      // index == 0
      //     ? Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => ,
      //         ))
      //     : (index == 3)
      //         ? Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => GenerateId()))
      //         : null;
    });
  }

// final GlobalKey<AlertDialogState> alertDialogKey =
  //     GlobalKey<AlertDialogState>();
  // TextEditingController controllersa = TextEditingController();
  String? fileName;
  FilePickerResult? result;
  PlatformFile? pickedFile;
  File? imageToDisplay;
  bool isFilePicked = false;
  bool isLoading = false;

  Future<void> pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });

      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null) {
        fileName = result!.files.first.name;
        isFilePicked = true;
        pickedFile = result!.files.first;
        imageToDisplay = File(pickedFile!.path.toString());

        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("EXCEPTION CATCHED!!!");
      print(e);
    }
  }

  Future<void> uploadImage(File imageFile) async {
    var inst = await SharedPreferences.getInstance();

    String accessToken = inst.getString('accessToken')!;

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
    };
//create mutipart req
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Endpoints.forProfileImage),
    );
//add headers to req
    request.headers.addAll(headers);

//imageFile is opened to obtain stream of its bytes and likewise for length
    var stream = http.ByteStream(imageFile.openRead());

    var length = await imageFile.length();
//The http.MultipartFile class is used to create a new multipart file. It takes the field name 'image',
//the byte stream of the image, its length, the filename, and the content type of the image file.
// The lookupMimeType function is used to determine the content type based on the file extension.
    var multipartFile = http.MultipartFile(
      'image',
      stream,
      length,
      filename: imageFile.path,
      contentType: MediaType.parse(lookupMimeType(imageFile.path)!),
    );
//now created multipart file is add to the request and finally it is sent
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      // Image uploaded successfully
      print('Image uploaded!');
    } else {
      // Error occurred while uploading image
      print('Image upload failed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (context, userProviderVariable, child) {
      final user = userProviderVariable;
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 90,
                            backgroundImage:
                                AssetImage('assets/images/avatar.jpg'),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 20,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context, setState1) {
                                      return AlertDialog(
                                        // actionsPadding: EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        // icon: Icon(Icons.home),
                                        title: Text('Upload Profile Photo'),

                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            isLoading
                                                ? CircularProgressIndicator()
                                                : CustomButton(
                                                    height: 35,
                                                    borderRadius: 20,
                                                    isValidated: isFilePicked,
                                                    width: 120,
                                                    onTap: () async {
                                                      await pickFile();
                                                      setState1(() {});
                                                    },
                                                    child: Text(
                                                      'CHoose Photo',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            isFilePicked
                                                ? SizedBox(
                                                    height: 85,
                                                    width: 140,
                                                    child: Image.file(
                                                      imageToDisplay!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : Text(
                                                    '\nCHOOSE IMAGE WISELY\n BECAUSE\n It WILL BE USED AS BASE',
                                                    textAlign: TextAlign.center,
                                                  )
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("cancel")),
                                          TextButton(
                                              onPressed: () {
                                                if (pickedFile != null &&
                                                    pickedFile!.path != null) {
                                                  File imageFile = File(
                                                      pickedFile!.path
                                                          .toString());
                                                  if (imageFile.existsSync()) {
                                                    uploadImage(imageFile);
                                                  } else {
                                                    print(
                                                        'File does not exist.');
                                                  }
                                                } else {
                                                  print('No file selected.');
                                                } // Replace with your image file path
                                              },
                                              child: Text("Upload")),
                                        ],
                                      );
                                    });
                                  },
                                );
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppColors.authBasicColor,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 26,
                      ),
//
                      Text(
                        user.user?.name ?? "Name Here",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      // user.phoneNumber,

                      Text(
                        user.user?.phoneNumber ?? "Phone Number Here",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 35),

                      SizedBox(height: 15),
                      CustomListTile(
                        onTap: () => handleTileTap(0),
                        isSelected: selectedTileIndex == 0,
                        icon: Icons.home,
                        title: 'Account',
                        subtitle: 'View your personal info',
                      ),
                    ],
                  ),
                  CustomListTile(
                      isSelected: selectedTileIndex == 1,
                      onTap: () => handleTileTap(1),
                      icon: Icons.my_library_books_rounded,
                      title: 'My Reports',
                      subtitle: 'See Your Progress'),
                  CustomListTile(
                      isSelected: selectedTileIndex == 2,
                      onTap: () => handleTileTap(2),
                      // onLongPress: () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => MyDevices()));
                      // },
                      icon: Icons.groups,
                      title: 'My Groups',
                      subtitle: ' Manage your Groups and More'),
                  CustomListTile(
                      isSelected: selectedTileIndex == 3,
                      onTap: () => handleTileTap(3),
                      icon: Icons.add_card,
                      title: 'Generate ID Card',
                      subtitle: ' Generate Id card and QR code'),
                  CustomListTile(
                      isSelected: selectedTileIndex == 4,
                      onTap: () => handleTileTap(4),
                      icon: Icons.settings,
                      title: 'Settings',
                      subtitle: 'Manage Settings'),
                  CustomListTile(
                      isSelected: selectedTileIndex == 5,
                      onTap: () => handleTileTap(5),
                      icon: Icons.logout,
                      title: 'Logout',
                      subtitle: ' Signout from this deveice')
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const CustomListTile({
    required this.isSelected,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        // height: 50,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isSelected ? null : Colors.grey[200],
            gradient: isSelected
                ? (LinearGradient(
                    colors: const [Color(0xff65F4CD), Color(0xff5A5BF3)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ))
                : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 22),
            Icon(
              icon,
              size: 25,
            ),
            SizedBox(width: 36),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
                SizedBox(width: 2),
                Text(subtitle,
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w300)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
