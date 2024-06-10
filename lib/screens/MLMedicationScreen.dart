import 'package:flutter/material.dart';
import 'package:medilab_prokit/screens/MLRecommendationScreen.dart';
import 'package:medilab_prokit/services/medication_service.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/medication.dart';
import '../utils/MLColors.dart';

class MLMedicationScreen extends StatefulWidget {
  static String tag = '/MLMedicationScreen';

  @override
  State<MLMedicationScreen> createState() => _MLMedicationScreenState();
}

class _MLMedicationScreenState extends State<MLMedicationScreen> {
  MedicationService medicationService = MedicationService();

  List<Medication> medications = [];

  bool isLoading = false;

  //init
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    medications = (await medicationService.getMedications())!;
    setState(() {});
  }

  //dispose
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          Column(
            children: medications.map(
              (e) {
                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  padding: EdgeInsets.all(16),
                  decoration: boxDecorationRoundedWithShadow(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.title!, style: boldTextStyle(size: 16)),
                      8.height,
                      Text(e.detail!, style: secondaryTextStyle()),
                      8.height,
                      Text(e.recipe!, style: secondaryTextStyle()),
                      8.height,
                      Text('Doctor: ${e.doctor.name} ${e.doctor.lastName}',
                          style: secondaryTextStyle()),
                      8.height,
                      // Ver Recomedaciones
                      Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            MLRecommendationScreen(medication: e)
                                .launch(context);
                          },
                          child: Text('Ver Recomedaciones',
                              style: secondaryTextStyle(color: mlColorBlue)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
