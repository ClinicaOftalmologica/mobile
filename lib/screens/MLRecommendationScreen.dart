import 'package:flutter/material.dart';
import 'package:medilab_prokit/model/medication.dart';
import 'package:medilab_prokit/services/recommendation_service.dart';
import 'package:nb_utils/nb_utils.dart';

class MLRecommendationScreen extends StatefulWidget {
  final Medication medication;
  MLRecommendationScreen({super.key, required this.medication});

  @override
  State<MLRecommendationScreen> createState() => _MLRecommendationScreenState();
}

class _MLRecommendationScreenState extends State<MLRecommendationScreen> {
  RecommendationService recommendationService = RecommendationService();

  String recommendation = '';

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setState(() {
      isLoading = true;
    });
    recommendation = await recommendationService.getRecommendation(
        medicationId: widget.medication.id!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Recomendación'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: boxDecorationRoundedWithShadow(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.medication.title, style: boldTextStyle(size: 16)),
                  16.height,
                  Text(recommendation, style: secondaryTextStyle()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
