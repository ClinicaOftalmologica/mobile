import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/components/MLProfileFormComponent.dart';
import 'package:medilab_prokit/screens/MLLoginScreen.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:medilab_prokit/main.dart';

import '../services/auth_service.dart';
import '../services/upload_image_service.dart';

class MLUpdateProfileScreen extends StatefulWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  MLUpdateProfileScreen(
      {super.key,
      required this.emailController,
      required this.usernameController,
      required this.passwordController,
      required this.phoneNumberController});

  @override
  _MLUpdateProfileScreenState createState() => _MLUpdateProfileScreenState();
}

class _MLUpdateProfileScreenState extends State<MLUpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<MLProfileFormComponentState> _profileFormKey =
      GlobalKey<MLProfileFormComponentState>();

  bool _loading = false;

  AuthService authService = AuthService();
  UploadImageService uploadImageService = UploadImageService();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  void validateAndSave() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      try {
        setState(() {
          _loading = true;
        });

        Map<String, String> formData =
            _profileFormKey.currentState!.getFormData();
        print('Formulario válido, guardando datos');
        print('Datos del formulario: $formData');

        print('Datos tercer formulario: ${widget.emailController.text}');
        print('Datos tercer formulario: ${widget.usernameController.text}');
        print('Datos tercer formulario: ${widget.passwordController.text}');
        print('Datos tercer formulario: ${widget.phoneNumberController.text}');

        final responseImage = await uploadImageService
            .uploadImage(_profileFormKey.currentState!.getImage());

        print('Response image: $responseImage');

        /* final response = await authService.registerUser(
          email: widget.emailController.text,
          password: widget.passwordController.text,
          username: widget.usernameController.text,
          phoneNumber: widget.phoneNumberController.text,
          firstName: formData['firstName']!,
          lastName: formData['lastName']!,
          address: formData['address']!,
          image: responseImage,
          gender: formData['gender']!);
      if (response != null) {
        print('Datos guardados correctamente');
        MLLoginScreen().launch(context);
      } else {
        print('Error al guardar los datos');
      } */

        setState(() {
          _loading = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Datos guardados correctamente'),
          ));
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _loading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
          ));
        }
      }
    } else {
      // El formulario no es válido o el estado del formulario es nulo
      print('Formulario no válido o estado del formulario es nulo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24.0),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: context.cardColor,
            ),
            height: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  54.height,
                  Text('Tu información personal',
                      style: boldTextStyle(size: 24)),
                  32.height,
                  /* MLProfileFormComponent(formKey: _formKey), */
                  MLProfileFormComponent(
                      formKey: _formKey, key: _profileFormKey),
                  42.height,
                ],
              ),
            ),
          ),
          Positioned(
              top: 30,
              child: mlBackToPrevious(
                  context, appStore.isDarkModeOn ? white : blackColor)),
          Positioned(
            bottom: 8,
            left: 16,
            right: 16,
            child: AppButton(
              height: 50,
              width: context.width(),
              color: mlPrimaryColor,
              /* onTap: () {
                /* finish(context);
                finish(context);
                finish(context);
                finish(context);
                return MLLoginScreen().launch(context); */
                validateAndSave();
              }, */
              onTap: validateAndSave,
              child: Text('Save', style: boldTextStyle(color: white)),
            ),
          ),
          if (_loading)
            Container(
              height: context.height(),
              width: context.width(),
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: SpinKitSquareCircle(
                  color: mlPrimaryColor,
                  size: 50.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
