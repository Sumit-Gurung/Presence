import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<List<CameraDescription>> getAvailableCameras() async {
  WidgetsFlutterBinding.ensureInitialized();
  return await availableCameras();
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await getAvailableCameras();

    // Request camera permission
    final permissionStatus = await Permission.camera.request();
    if (permissionStatus.isGranted) {
      _controller = CameraController(cameras[0], ResolutionPreset.medium);
      _initializeControllerFuture = _controller!.initialize();
      setState(() {});
    } else {
      // Handle permission not granted
      // You can display an error message or take appropriate action
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          CupertinoIcons.camera,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller!);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
