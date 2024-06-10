import 'dart:io';
import 'package:camera/camera.dart';
/* import 'package:chat_gpt/src/colors/colors.dart'; */
/* import 'package:chat_gpt/src/controllers/register.controller.dart'; */
import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medilab_prokit/services/auth_service.dart';
import 'package:nb_utils/nb_utils.dart';

/* import '../../controllers/authController.dart';
import '../pages/camera_screen.dart'; */
import '../utils/MLColors.dart';

class CameraWidgets {
  Widget size(width, height, context, controller) {
    if (height == double.infinity) {
      return SizedBox(
        width: width,
        height: height,
        child: controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller),
              )
            : const Text('No camera found'),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10),
        width: width,
        height: height,
        child: controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller),
              )
            : const Text('No camera found'),
      );
    }
  }

  Widget buttonFlash(context, controller) {
    return GestureDetector(
      onTap: () {
        if (controller.value.flashMode == FlashMode.auto) {
          controller.setFlashMode(FlashMode.off);
          /* toast message "Flash off"*/
          /* ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Flash off'),
              duration: Duration(seconds: 1),
            ),
          ); */
          Fluttertoast.showToast(
              msg: "Flash off",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: appColorPrimary,
              textColor: appTextColorPrimary,
              fontSize: 16.0);
        } else if (controller.value.flashMode == FlashMode.off) {
          controller.setFlashMode(FlashMode.torch);
          /* toast message "Flash on"*/
          /* ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Flash on'),
              duration: Duration(seconds: 1),
            ),
          ); */
          Fluttertoast.showToast(
              msg: "Flash on",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: appColorPrimary,
              textColor: appTextColorPrimary,
              fontSize: 16.0);
        } else if (controller.value.flashMode == FlashMode.torch) {
          controller.setFlashMode(FlashMode.auto);
          /* toast message "Flash auto"*/
          /* ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Flash auto'),
              duration: Duration(seconds: 1),
            ),
          ); */
          Fluttertoast.showToast(
              msg: "Flash auto",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: appColorPrimary,
              textColor: appTextColorPrimary,
              fontSize: 16.0);
        }
      },
      child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: appColorPrimary,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: appColorPrimary, width: 5),
            boxShadow: const [
              BoxShadow(color: appColorPrimary, blurRadius: 10, spreadRadius: 5)
            ],
            /* gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [background, primary]), */
            backgroundBlendMode: BlendMode.darken,
          ),
          child: const Icon(
            Icons.flash_on_sharp,
            color: iconColorPrimary,
            size: 30,
          )),
    );
  }

  Widget buttonCapture(context, controller, ValueNotifier<bool> isLoading) {
    return GestureDetector(
      onTap: () async {
        if (!controller.value.isInitialized) {
          return;
        }
        if (controller.value.isTakingPicture) {
          return;
        }

        isLoading.value = true;

        try {
          await controller.setFlashMode(FlashMode.auto);
          XFile file = await controller.takePicture();

          AuthService authService = AuthService();

          File image = File(file.path);

          final response = await authService.compareImage(image: image);
          isLoading.value = false;

          if (response?['res'] == true) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
            toast('Ingreso exitoso');
          } else {
            toast('Error al ingresar');
          }
        } on CameraException catch (e) {
          isLoading.value = false;
          debugPrint("Error occurred while taking picture: $e");
          toast('Error al tomar la foto');
          return;
        }
        isLoading.value = false;
      },
      child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: appColorPrimary,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: appColorPrimary, width: 5),
            boxShadow: const [
              BoxShadow(color: appColorPrimary, blurRadius: 10, spreadRadius: 5)
            ],
            /* gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [background, primary]), */
            backgroundBlendMode: BlendMode.darken,
          ),
          child: const Icon(
            Icons.camera,
            color: iconColorPrimary,
            size: 30,
          )),
    );
  }

  Widget buttonCaptureRegister(context, controller, ci) {
    return GestureDetector(
      onTap: () async {
        print('camera');
        if (!controller.value.isInitialized) {
          return;
        }
        if (controller.value.isTakingPicture) {
          return;
        }

        try {
          await controller.setFlashMode(FlashMode.auto);
          final XFile xfile = await controller.takePicture();
          File file = File(xfile.path);
          /* RegisterController().compareFaces(file, ci, context); */
          /* tomarFoto(ci, context); */
          /* Uint8List bytes = await file.readAsBytes();
          String base64Image = base64Encode(bytes);
          String result = 'data:image/jpeg;base64,' + base64Image; */
          /* print("imagen convertida" + result.toString()); */
          /* AuthController().face_Recognition(result, context, controller); */
          /* Navigator.push(context,
              MaterialPageRoute(builder: (context) => ImagePreview(file))); */
        } on CameraException catch (e) {
          debugPrint("Error ocurred while taking picture: $e");
          return;
        }
      },
      child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: appColorPrimary,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: appColorPrimary, width: 5),
            boxShadow: const [
              BoxShadow(color: appColorPrimary, blurRadius: 10, spreadRadius: 5)
            ],
            /* gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [background, primary]), */
            backgroundBlendMode: BlendMode.darken,
          ),
          child: const Icon(
            Icons.camera,
            color: iconColorPrimary,
            size: 30,
          )),
    );
  }

  void tomarFoto(ci, context) async {
    final XFile? imagenSeleccionada =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (imagenSeleccionada != null) {
      File imagenFile = File(imagenSeleccionada.path);
      /* RegisterController().compareFaces(imagenFile, ci, context); */
      // Ahora puedes usar 'imagenFile' en tu lógica
    } else {
      // El usuario canceló la selección de la imagen
    }
  }

  /* Future<String?> urlCloudinary(file) async {
    File fileBytes = File(file.path);
    final cloudinary = Cloudinary.signedConfig(
      apiKey: "281217171317886",
      apiSecret: "SGcS7K5qbrJYq4pZ1HjcuJLC24Q",
      cloudName: "dg2ugi96k",
    );
    final response = await cloudinary.upload(
        file: file.path,
        fileBytes: fileBytes.readAsBytesSync(),
        resourceType: CloudinaryResourceType.image,
        folder: 'phone',
        progressCallback: (count, total) {
          print('Uploading image from file with progress: $count/$total');
        });
    if (response.isSuccessful) {
      print('Get your image from with ${response.secureUrl}');
      return (response.secureUrl);
    }
    return null;
  } */
  void urlCloudinary(file, context, controller) async {
    File fileBytes = File(file.path);
    final cloudinary = Cloudinary.signedConfig(
      apiKey: "281217171317886",
      apiSecret: "SGcS7K5qbrJYq4pZ1HjcuJLC24Q",
      cloudName: "dg2ugi96k",
    );
    final response = await cloudinary.upload(
      file: file.path,
      folder: 'phone',
      fileName: 'phone',
      resourceType: CloudinaryResourceType.image,
      optParams: {
        'public_id': 'phone',
        'overwrite': true,
      },
      publicId: 'phone',
      progressCallback: (count, total) {
        if (kDebugMode) {
          print('Uploading image from file with progress: $count/$total');
        }
      },
      fileBytes: fileBytes.readAsBytesSync(),
    );
    if (response.isSuccessful) {
      /* print('Get your image from with ${response.secureUrl}'); */
      late String? image = response.secureUrl;
      print("imagen url: " + image.toString());
      /* AuthController().face_Recognition(image, context, controller); */
    } else {
      print("error");
    }
  }
}
