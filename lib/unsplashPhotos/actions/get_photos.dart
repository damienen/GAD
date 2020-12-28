import 'package:GADlab/unsplashPhotos/models/photo.dart';

class GetPhotos {
  GetPhotos(this.parameters);

  Map<String, String> parameters;
}

class GetPhotosSuccessful {
  GetPhotosSuccessful(this.photos);

  final List<Photo> photos;
}

class GetPhotosError {
  const GetPhotosError(this.error);

  final dynamic error;
}
