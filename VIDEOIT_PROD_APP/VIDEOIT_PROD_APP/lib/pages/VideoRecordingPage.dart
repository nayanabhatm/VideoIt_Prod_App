// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class VideoRecording extends StatefulWidget {
  @override
  _VideoRecordingState createState() {
    return _VideoRecordingState();
  }
}


class _VideoRecordingState extends State<VideoRecording> with WidgetsBindingObserver {
  CameraController controller;
  String videoPath;
  bool enableAudio = true;
  int selectedCameraId;
  List<CameraDescription> cameras = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    availableCameras().then((availablecameras) {
      cameras = availablecameras;
      if(cameras.length>0){
        setState(() {
          selectedCameraId=0;
        });
        onNewCameraSelected(cameras[selectedCameraId]);
      }

    }).catchError((err){
      print("Error : ${err.toString()}");
    }
    );

  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller.description);
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Returns a suitable camera icon for [direction].
  IconData getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        key: _scaffoldKey,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              child: Center(
                child: _cameraPreviewWidget(),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: controller != null && controller.value.isRecordingVideo
                      ? Colors.redAccent
                      : Colors.grey,
                  width: 3.0,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: IconButton(
                          disabledColor: Colors.white,
                          focusColor: Colors.lightGreen,
                          hoverColor: Colors.lightGreen,
                          iconSize: 38.0,
                          icon: controller != null && controller.value.isRecordingPaused
                              ? Icon(Icons.play_arrow) : Icon(Icons.pause),
                          color: Colors.red,
                          onPressed: controller != null && controller.value.isInitialized && controller.value.isRecordingVideo
                              ? (controller != null && controller.value.isRecordingPaused
                              ? onResumeButtonPressed : onPauseButtonPressed)
                              : null,
                        ),
                      ),
                      Expanded(child: GestureDetector(
                        child: Container(
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 25.0,
                            ),
                          ),
                        ),
                        onTap: controller != null && controller.value.isInitialized && !controller.value.isRecordingVideo
                            ? onVideoRecordButtonPressed
                            : null,
                      ),),
                      Expanded(
                        child: IconButton(
                          disabledColor: Colors.white,
                          focusColor: Colors.lightGreen,
                          hoverColor: Colors.lightGreen,
                          iconSize:38.0 ,
                          icon: const Icon(Icons.stop),
                          color: Colors.red,
                          onPressed: controller != null && controller.value.isInitialized && controller.value.isRecordingVideo
                              ? onStopButtonPressed
                              : null,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left:28.0,top: 28.0,bottom: 28.0),
                        child: Text('Microphone:',
                          style: TextStyle(
                          color: Colors.white
                          ),
                        ),
                      ),
                      Switch(
                        value: enableAudio,
                        onChanged: (bool value) {
                          enableAudio = value;
                          if (controller != null) {
                            onNewCameraSelected(controller.description);
                          }
                        },
                      ),
                      _cameraTogglesRowWidget(),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    if (cameras.isEmpty || cameras==null) {
      return Spacer();
    }
    else{
      CameraDescription selectedCamera = cameras[selectedCameraId];
      CameraLensDirection lensDirection = selectedCamera.lensDirection;

      return Expanded(
          child: Align(
              alignment: Alignment.center,
              child: FlatButton.icon(
                onPressed: onSwitchCamera,
                icon: Icon(
                    getCameraLensIcon(lensDirection),
                    color: Colors.white,
                ),
                label: Text(
                    "${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1)}",
                    style: TextStyle(
                      color: Colors.white
                    ),
                ),

              )

          )
      );

    }
  }

  void onSwitchCamera() {
    selectedCameraId = selectedCameraId < cameras.length - 1 ? selectedCameraId + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraId];
    onNewCameraSelected(selectedCamera);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: enableAudio,
    );

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print('Error Message: $e');
    }

    if (mounted) {
      setState(() {});
    }
  }


  void onVideoRecordButtonPressed() {
    startVideoRecording().then((String filePath) {
      if (mounted) setState(() {});
      if (filePath != null) showInSnackBar('Saving video to $filePath');
    });
  }

  void onStopButtonPressed() {
    stopVideoRecording().then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Video recorded to: $videoPath');
    });
  }

  void onPauseButtonPressed() {
    pauseVideoRecording().then((_) {
      if (mounted) setState(() {});
    });
  }

  void onResumeButtonPressed() {
    resumeVideoRecording().then((_) {
      if (mounted) setState(() {});
    });
  }

  Future<String> startVideoRecording() async {
    if (!controller.value.isInitialized) {
      return null;
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Movies/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    if (controller.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return null;
    }

    try {
      videoPath = filePath;
      await controller.startVideoRecording(filePath);
    } on CameraException catch (e) {
      print('Error: ${e.code}\nError Message: ${e.description}');
      return null;
    }
    return filePath;
  }

  Future<void> stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.stopVideoRecording();
    } on CameraException catch (e) {
      print('Error: ${e.code}\nError Message: ${e.description}');
      return null;
    }

  }

  Future<void> pauseVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.pauseVideoRecording();
    } on CameraException catch (e) {
      print('Error: ${e.code}\nError Message: ${e.description}');
      rethrow;
    }
  }

  Future<void> resumeVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.resumeVideoRecording();
    } on CameraException catch (e) {
      print('Error: ${e.code}\nError Message: ${e.description}');
      rethrow;
    }
  }

}
