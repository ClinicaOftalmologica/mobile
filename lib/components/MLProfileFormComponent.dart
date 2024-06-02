import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medilab_prokit/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLString.dart';

import 'MLCountryPIckerComponent.dart';

class MLProfileFormComponent extends StatefulWidget {
  static String tag = '/MLProfileFormComponent';

  final GlobalKey<FormState> formKey;

  MLProfileFormComponent({Key? key, required this.formKey}) : super(key: key);

  @override
  MLProfileFormComponentState createState() => MLProfileFormComponentState();
}

class MLProfileFormComponentState extends State<MLProfileFormComponent> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  /* TextEditingController phoneNumberController = TextEditingController(); */
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String dropdownValue = 'Mujer';
  String bloodGroupValue = 'None';
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    _genderController.text = dropdownValue;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    /* phoneNumberController.dispose(); */
    _addressController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  // Método para obtener los datos del formulario
  Map<String, String> getFormData() {
    return {
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      /* 'phoneNumber': phoneNumberController.text, */
      'address': _addressController.text,
      'gender': _genderController.text,
    };
  }

  // Merodo para obtener la imagen seleccionada
  XFile getImage() {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se seleccionó ninguna imagen'),
        ),
      );
      throw 'No se seleccionó ninguna imagen';
    } else {
      return _imageFile!;
    }
  }

  void selectImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = XFile(pickedFile.path);
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se seleccionó ninguna imagen'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* Container(
              padding: EdgeInsets.all(16.0),
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radius(30.0),
                backgroundColor: appStore.isDarkModeOn
                    ? scaffoldDarkColor
                    : Colors.grey.shade100,
              ),
              child: Icon(Icons.camera_alt_outlined, color: mlColorBlue)), */
          // Select Image
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: radius(30.0),
              backgroundColor: appStore.isDarkModeOn
                  ? scaffoldDarkColor
                  : Colors.grey.shade100,
            ),
            child: InkWell(
              onTap: () {
                selectImage();
              },
              child: Icon(Icons.camera_alt_outlined, color: mlColorBlue),
            ),
          ),
          _imageFile != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.all(16.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: boxDecorationWithRoundedCorners(
                      borderRadius: radius(30.0),
                      backgroundColor: appStore.isDarkModeOn
                          ? scaffoldDarkColor
                          : Colors.grey.shade100,
                    ),
                    child: Image.file(
                      File(_imageFile!.path),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: 100,
                    ),
                  ),
                )
              : Container(),
          16.height,
          Text('Nombre*', style: primaryTextStyle()),
          AppTextField(
            controller: _firstNameController,
            validator: (value) {
              if (value!.isEmpty) return 'Por favor, ingrese su nombre';
              return null;
            },
            decoration: InputDecoration(
              hintText: mlFirst_name!,
              hintStyle: secondaryTextStyle(size: 16),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
              ),
            ),
            textFieldType: TextFieldType.NAME,
          ),
          16.height,
          Text('Apellido*', style: primaryTextStyle()),
          AppTextField(
            controller: _lastNameController,
            validator: (value) {
              if (value!.isEmpty) return 'Por favor, ingrese su apellido';
              return null;
            },
            textFieldType: TextFieldType.NAME,
            decoration: InputDecoration(
              hintText: mlLast_name!,
              hintStyle: secondaryTextStyle(size: 16),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
              ),
            ),
          ),
          16.height,
          /* Text('Fecha de nacimiento*', style: primaryTextStyle()),
          AppTextField(
            controller: genderController,
            validator: (value) {
              if (value!.isEmpty)
                return 'Por favor, ingrese su fecha de nacimiento';
              return null;
            },
            textFieldType: TextFieldType.OTHER,
            decoration: InputDecoration(
              hintText: mlDate_format!,
              hintStyle: secondaryTextStyle(size: 16),
              suffixIcon:
                  Icon(Icons.calendar_today_outlined, color: mlColorBlue),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
              ),
            ),
          ),
          16.height, */
          /* Text('Numero de telefono*', style: primaryTextStyle()),
          Row(
            children: [
              MLCountryPickerComponent(),
              16.width,
              AppTextField(
                controller: phoneNumberController,
                validator: (value) {
                  if (value!.isEmpty) return 'Por favor, ingrese su numero';
                  return null;
                },
                textFieldType: TextFieldType.PHONE,
                decoration: InputDecoration(
                  labelText: mlPhoneNumber!,
                  labelStyle: secondaryTextStyle(size: 16),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: mlColorLightGrey.withOpacity(0.2))),
                ),
              ).expand(),
            ],
          ),
          16.height, */
          Text('Direccion*', style: primaryTextStyle()),
          AppTextField(
            controller: _addressController,
            validator: (value) {
              if (value!.isEmpty) return 'Por favor, ingrese su direccion';
              return null;
            },
            textFieldType: TextFieldType.OTHER,
            decoration: InputDecoration(
              hintText: mlAddress!,
              hintStyle: secondaryTextStyle(size: 16),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
              ),
            ),
          ),
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              genderDropDown().expand(flex: 5),
              /* 24.width,
              bloodGroupDropDown().expand(flex: 5), */
            ],
          ),
          16.height,
        ],
      ),
    );
  }

  Widget genderDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Genero', style: primaryTextStyle()),
        DropdownButton<String>(
          value: _genderController.text,
          icon: Icon(Icons.keyboard_arrow_down, color: mlColorBlue)
              .paddingOnly(left: 74.0),
          iconSize: 24,
          elevation: 16,
          style: secondaryTextStyle(size: 16),
          onChanged: (String? newValue) {
            setState(
              () {
                _genderController.text = newValue!;
              },
            );
          },
          items: <String>[
            'Mujer',
            'Hombre',
            'Other',
          ].map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: secondaryTextStyle(size: 16)));
            },
          ).toList(),
        ),
      ],
    );
  }

  Widget bloodGroupDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Blood Group', style: primaryTextStyle()),
        Container(
          constraints: BoxConstraints(minWidth: context.width() / 2.5),
          child: DropdownButton<String>(
            value: bloodGroupValue,
            icon: Icon(Icons.keyboard_arrow_down, color: mlColorBlue)
                .paddingOnly(left: 74.0),
            iconSize: 24,
            elevation: 16,
            style: secondaryTextStyle(size: 16),
            onChanged: (String? newValue) {
              setState(() {
                bloodGroupValue = newValue!;
              });
            },
            items: <String>[
              'None',
              'A+',
              'A-',
              'B+',
              'B-',
              'O+',
              'O-',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: secondaryTextStyle(size: 16)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
