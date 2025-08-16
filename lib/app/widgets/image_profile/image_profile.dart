import 'dart:io';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class ImageProfile extends StatelessWidget {
  const ImageProfile({super.key, this.selectedImage, required this.photoUrl});

  final File? selectedImage;
  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: selectedImage != null
          ? Image.file(
              selectedImage!,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            )
          : FadeInImage.assetNetwork(
              placeholder: ImagePath.profilePlaceholder,
              image: photoUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  ImagePath.profilePlaceholder,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                );
              },
            ),
    );
  }
}
