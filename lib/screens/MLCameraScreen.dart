import 'package:camera/camera.dart';
/* import 'package:chat_gpt/src/UI/pages/camera_screen.dart'; */
/* import 'package:chat_gpt/src/colors/colors.dart'; */
import 'package:flutter/material.dart';

import '../components/MLCameraComponent.dart';
import '../utils/MLColors.dart';

class MLCameraScreen extends StatefulWidget {
  const MLCameraScreen({required this.cameras, Key? key}) : super(key: key);
  final List<CameraDescription> cameras;

  @override
  State<MLCameraScreen> createState() => _MLCameraScreenState();
}

class _MLCameraScreenState extends State<MLCameraScreen> {
  late CameraController _controller;
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.cameras[0], ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'cameraPermission':
            print('Camera permission not granted');
            break;
          case 'serviceStatus':
            print('Service status error');
            break;
          case 'serviceDisabled':
            print('Service disabled');
            break;
          case 'cameraUnavailable':
            print('Camera unavailable');
            break;
          case 'invalidCameraDescription':
            print('Invalid camera description');
            break;
          default:
            print('Unknown error');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            CameraWidgets().size(
                double.infinity,
                MediaQuery.of(context).size.height * 0.65,
                context,
                _controller),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  color: Colors.black.withOpacity(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          /* camara delantera */
                          if (_controller.description == widget.cameras[1]) {
                            _controller = CameraController(
                                widget.cameras[0], ResolutionPreset.medium);
                            _controller.initialize().then((_) {
                              if (!mounted) {
                                return;
                              }
                              setState(() {});
                            }).catchError((Object e) {
                              if (e is CameraException) {
                                switch (e.code) {
                                  case 'cameraPermission':
                                    print('Camera permission not granted');
                                    break;
                                  case 'serviceStatus':
                                    print('Service status error');
                                    break;
                                  case 'serviceDisabled':
                                    print('Service disabled');
                                    break;
                                  case 'cameraUnavailable':
                                    print('Camera unavailable');
                                    break;
                                  case 'invalidCameraDescription':
                                    print('Invalid camera description');
                                    break;
                                  default:
                                    print('Unknown error');
                                    break;
                                }
                              }
                            });
                          } else {
                            /* camara trasera */
                            _controller = CameraController(
                                widget.cameras[1], ResolutionPreset.medium);
                            _controller.initialize().then((_) {
                              if (!mounted) {
                                return;
                              }
                              setState(() {});
                            }).catchError((Object e) {
                              if (e is CameraException) {
                                switch (e.code) {
                                  case 'cameraPermission':
                                    print('Camera permission not granted');
                                    break;
                                  case 'serviceStatus':
                                    print('Service status error');
                                    break;
                                  case 'serviceDisabled':
                                    print('Service disabled');
                                    break;
                                  case 'cameraUnavailable':
                                    print('Camera unavailable');
                                    break;
                                  case 'invalidCameraDescription':
                                    print('Invalid camera description');
                                    break;
                                  default:
                                    print('Unknown error');
                                    break;
                                }
                              }
                            });
                          }
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: appColorPrimary,
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: appColorPrimary, width: 5),
                            boxShadow: const [
                              BoxShadow(
                                  color: appColorPrimary,
                                  blurRadius: 10,
                                  spreadRadius: 5)
                            ],
                            backgroundBlendMode: BlendMode.darken,
                          ),
                          child: const Icon(
                            Icons.flip_camera_ios,
                            /* color: primary, */
                            color: iconColorPrimary,
                            size: 30,
                          ),
                        ),
                      ),
                      CameraWidgets().buttonCapture(context, _controller, isLoading),
                      CameraWidgets().buttonFlash(context, _controller)
                    ],
                  ),
                ),
              ],
            ),
            ValueListenableBuilder<bool>(
                valueListenable: isLoading,
                builder: (context, value, child) {
                  return value
                      ? Container(
                          color: Colors.black.withOpacity(0.5),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: appColorPrimary,
                            ),
                          ),
                        )
                      : const SizedBox();
                })
          ],
        ));
  }
}
