// import 'dart:html';

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:presence/components/constant.dart';
import 'package:presence/providers/user_provider.dart';
import 'package:presence/screens/onBoardingScreens/onBoardingController.dart';
import 'package:presence/start_page.dart';
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
  // bool _isUploadingImage = false;
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
    setState(() {
      isLoading = true;
    });

    try {
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
      'profilePic',
      stream,
      length,
      filename: imageFile.path,
      contentType: MediaType.parse(lookupMimeType(imageFile.path)!),
    );
//now created multipart file is add to the request and finally it is sent
    request.files.add(multipartFile);

    var response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      // Image uploaded successfully
      print('Image uploaded!');

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Image Uploaded Succeesfully")));
      Navigator.of(context).pop();
      setState(() {
        imageToDisplay = null;
      });
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
                                (userProviderVariable.user != null &&
                                        userProviderVariable.user!.profilePic !=
                                            null)
                                    ? NetworkImage(user.user!.profilePic!)
                                        as ImageProvider
                                    : AssetImage('assets/images/avatar.jpg'),
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
                                                      setState1(() {
                                                        isLoading = true;
                                                      });
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
                                                    child: imageToDisplay !=
                                                            null
                                                        ? Image.file(
                                                            imageToDisplay!,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Text(
                                                            "Choose file first"),
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
                                              onPressed: () async {
                                                if (pickedFile != null &&
                                                    pickedFile!.path != null) {
                                                  File imageFile = File(
                                                      pickedFile!.path
                                                          .toString());
                                                  if (imageFile.existsSync()) {
                                                    setState1(() {
                                                      isLoading = true;
                                                    });
                                                    await uploadImage(
                                                        imageFile);
                                                    setState1(() {
                                                      isLoading = false;
                                                    });
                                                  } else {
                                                    print(
                                                        'File does not exist.');
                                                  }
                                                } else {
                                                  print('No file selected.');
                                                }
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
                        height: 20,
                      ),
//
                      Text(
                        user.user?.name ?? "Name Here",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      // SizedBox(
                      //   height: 11,
                      // ),
                      // user.phoneNumber,

                      Text(
                        user.user?.phoneNumber ?? "Phone Number Here",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      // SizedBox(height: 35),

                      SizedBox(height: 20),
                      CustomListTile(
                        onLongPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StartPage(
                                  selectedIndexFromOutside: 3,
                                ),
                              ));
                        },
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
                      onLongPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StartPage(
                                selectedIndexFromOutside: 2,
                              ),
                            ));
                      },
                      icon: Icons.my_library_books_rounded,
                      title: 'My Reports',
                      subtitle: 'See Your Progress'),
                  CustomListTile(
                      isSelected: selectedTileIndex == 2,
                      onTap: () => handleTileTap(2),
                      onLongPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StartPage(
                                selectedIndexFromOutside: 2,
                              ),
                            ));
                      },
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
                      onLongPress: () async {
                        // var inst = await SharedPreferences.getInstance();
                        // await inst.setString("accessToken", '');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OnBoardingController(),
                            ));
                      },
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
                    colors: const [
                      AppColors.mainGradientOne,
                      AppColors.mainGradientTwo
                    ],
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
              color: isSelected ? Colors.white : Colors.black,
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
