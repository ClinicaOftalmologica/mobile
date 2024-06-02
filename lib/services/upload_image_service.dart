import 'package:cloudinary/cloudinary.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medilab_prokit/config/cloudinary_config.dart';
import 'package:medilab_prokit/constants/cloudinary_constants.dart';

class UploadImageService {
  Future<String> uploadImage(XFile image) async {
    final response = await CloudinaryConfig.signed.upload(
      file: image.path,
      folder: CloudinaryConstants.folder,
      resourceType: CloudinaryResourceType.image,
      progressCallback: (count, total) {
        print('Progress: $count / $total');
      },
    );

    if (response.secureUrl != null) {
      return response.secureUrl!;
    } else {
      throw Exception('Error al subir la imagen');
    }
  }

  Future<bool> deleteImage(String url) async {
    final response = await CloudinaryConfig.signed.destroy(url);

    if (response.result == 'ok') {
      return true;
    } else {
      throw Exception('Error al eliminar la imagen');
    }
  }
}
