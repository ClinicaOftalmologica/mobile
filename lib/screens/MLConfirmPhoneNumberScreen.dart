import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/components/MLCountryPIckerComponent.dart';
import 'package:medilab_prokit/screens/MLUpdateProfileScreen.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLCommon.dart';
import 'package:medilab_prokit/utils/MLImage.dart';
import 'package:medilab_prokit/utils/MLString.dart';
import 'package:medilab_prokit/main.dart';

class MLConfirmPhoneNumberScreen extends StatefulWidget {
  static String tag = '/MLConfirmPhoneNumberScreen';
  TextEditingController emailController = TextEditingController();
  /* TextEditingController usernameController = TextEditingController(); */
  TextEditingController passwordController = TextEditingController();

  MLConfirmPhoneNumberScreen(
      {super.key,
      required this.emailController,
      /* required this.usernameController, */
      required this.passwordController});

  @override
  _MLConfirmPhoneNumberScreenState createState() =>
      _MLConfirmPhoneNumberScreenState();
}

class _MLConfirmPhoneNumberScreenState
    extends State<MLConfirmPhoneNumberScreen> {
  //Key form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    changeStatusColor(appStore.isDarkModeOn ? scaffoldDarkColor : white);
  }

  void validateAndSave() async {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      // El formulario es válido, recupera los datos
      Map<String, String> formData = {
        'phoneNumber': phoneNumberController.text,
      };
      print('Formulario válido, guardando datos');
      print('Datos del formulario: $formData');
      // Aquí puedes guardar los datos o realizar otra acción
      MLUpdateProfileScreen(
        emailController: widget.emailController,
        /* usernameController: widget.usernameController, */
        passwordController: widget.passwordController,
        phoneNumberController: phoneNumberController,
      ).launch(context);
    } else {
      // El formulario no es válido o el estado del formulario es nulo
      print('Formulario no válido o estado del formulario es nulo');
    }
  }

  @override
  void dispose() {
    super.dispose();
    changeStatusColor(mlPrimaryColor);
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 24.0),
            decoration: boxDecorationWithRoundedCorners(
                backgroundColor: context.cardColor),
            padding: EdgeInsets.all(16.0),
            height: context.height(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  56.height,
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: commonCachedNetworkImage(
                      ml_ic_verifyindicator!,
                      alignment: Alignment.centerLeft,
                      width: 200,
                      height: 200,
                    ),
                  ),
                  32.height,
                  Text(mlContact_msg!, style: boldTextStyle(size: 24)),
                  8.height,
                  Text(mlContact_sub_msg!, style: secondaryTextStyle(size: 16)),
                  16.height,
                  Row(
                    children: [
                      MLCountryPickerComponent(),
                      16.width,
                      Form(
                        key: formKey,
                        child: AppTextField(
                          controller: phoneNumberController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese su número de teléfono';
                            }
                            return null;
                          },
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
                      ),
                    ],
                  ),
                  24.height,
                  AppButton(
                    width: double.infinity,
                    color: mlColorDarkBlue,
                    onTap: validateAndSave,
                    child: Text(mlSend!, style: boldTextStyle(color: white)),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 30,
              child: mlBackToPrevious(
                  context, appStore.isDarkModeOn ? white : blackColor)),
        ],
      ),
    );
  }
}
