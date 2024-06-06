import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
/* import 'package:medilab_prokit/components/MLCountryPIckerComponent.dart'; */
import 'package:medilab_prokit/components/MLSocialAccountComponent.dart';
import 'package:medilab_prokit/screens/MLConfirmPhoneNumberScreen.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:medilab_prokit/utils/MLImage.dart';
import 'package:medilab_prokit/utils/MLString.dart';

class MLRegistrationScreen extends StatefulWidget {
  static String tag = '/MLRegistrationScreen';

  @override
  _MLRegistrationScreenState createState() => _MLRegistrationScreenState();
}

class _MLRegistrationScreenState extends State<MLRegistrationScreen> {
  // Key Form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  /* TextEditingController usernameController = TextEditingController(); */
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    changeStatusColor(mlPrimaryColor);
    /* usernameController.dispose(); */
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> init() async {
    //
  }

  void validateAndSave() async {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      // El formulario es válido, recupera los datos
      Map<String, String> formData = {
        /* 'username': usernameController.text, */
        'email': emailController.text,
        'password': passwordController.text,
      };
      print('Formulario válido, guardando datos');
      print('Datos del formulario: $formData');
      MLConfirmPhoneNumberScreen(
              emailController: emailController,
              /* usernameController: usernameController, */
              passwordController: passwordController)
          .launch(context);
      // Aquí puedes guardar los datos o realizar otra acción
    } else {
      // El formulario no es válido o el estado del formulario es nulo
      print('Formulario no válido o estado del formulario es nulo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 250),
              padding: const EdgeInsets.only(right: 16.0, left: 16.0),
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radiusOnly(topRight: 32),
                backgroundColor: context.cardColor,
              ),
              height: context.height(),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      48.height,
                      Text(mlRegister!, style: boldTextStyle(size: 28)),
                      8.height,
                      Text('Registrarse para continuar',
                          style: secondaryTextStyle()),
                      16.height,
                      /* Row(
                        children: [
                          MLCountryPickerComponent(),
                          16.width,
                          AppTextField(
                            textFieldType: TextFieldType.PHONE,
                            decoration: InputDecoration(
                              labelText: mlPhoneNumber,
                              labelStyle: secondaryTextStyle(size: 16),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: mlColorLightGrey.withOpacity(0.2)),
                              ),
                            ),
                          ).expand(),
                        ],
                      ), */
                      AppTextField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Por favor, introduce un email';
                          if (!value.validateEmail())
                            return 'Por favor, introduce un email válido';
                          return null;
                        },
                        textFieldType: TextFieldType.EMAIL,
                        decoration: InputDecoration(
                          labelText: mlEmail!,
                          labelStyle: secondaryTextStyle(size: 16),
                          prefixIcon:
                              const Icon(Icons.email_outlined, size: 20),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: mlColorLightGrey.withOpacity(0.2)),
                          ),
                        ),
                      ),
                      /* 16.height,
                      AppTextField(
                        controller: usernameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, introduce un nombre de usuario';
                          }
                          return null;
                        },
                        textFieldType: TextFieldType.USERNAME,
                        decoration: InputDecoration(
                          labelText: mlUsername!,
                          labelStyle: secondaryTextStyle(size: 16),
                          prefixIcon:
                              const Icon(Icons.person_outline, size: 20),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: mlColorLightGrey.withOpacity(0.2)),
                          ),
                        ),
                      ), */
                      16.height,
                      AppTextField(
                        textFieldType: TextFieldType.PASSWORD,
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, introduce una contraseña';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: mlPassword!,
                          labelStyle: secondaryTextStyle(size: 16),
                          prefixIcon: const Icon(Icons.lock_outline, size: 20),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: mlColorLightGrey.withOpacity(0.2)),
                          ),
                        ),
                      ),
                      /* 16.height,
                      AppTextField(
                        textFieldType: TextFieldType.PASSWORD,
                        decoration: InputDecoration(
                          labelText: mlReenter_password!,
                          labelStyle: secondaryTextStyle(size: 16),
                          prefixIcon: const Icon(Icons.lock_outline, size: 20),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: mlColorLightGrey.withOpacity(0.2)),
                          ),
                        ),
                      ), */
                      32.height,
                      AppButton(
                        width: double.infinity,
                        color: mlPrimaryColor,
                        onTap: validateAndSave,
                        child: Text(mlRegister!,
                            style: boldTextStyle(color: white)),
                      ),
                      20.height,
                      Align(
                        alignment: Alignment.center,
                        child: Text(mlLogin_with!,
                            style: secondaryTextStyle(size: 16)),
                      ),
                      20.height,
                      MLSocialAccountsComponent(),
                      32.height,
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 75),
              width: double.infinity,
              child: commonCachedNetworkImage(ml_ic_register_indicator!,
                  alignment: Alignment.center, width: 200, height: 200),
            ),
            Positioned(top: 30, child: mlBackToPrevious(context, whiteColor)),
          ],
        ).center(),
      ),
    );
  }
}
