import 'package:medilab_prokit/config/dio_ia_recommendation_config.dart';

class RecommendationService {
  Future<String> getRecommendation(
      {required String medicationId}) async {
    try {
      final response = await DioConfig.dioWithoutAuthorization.get(
        '/api/recomendation/$medicationId',
      );
      if (response.statusCode == 200) {
        return response.data['description'].toString();
      } else {
        throw Exception('Error al obtener la recomendación');
      }
    } catch (e) {
      throw Exception('Error al obtener la recomendación');
    }
  }
}
