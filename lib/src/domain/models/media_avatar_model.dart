class MediaAvatarModel {
  final String pathFile;
  final String urlFile;
  final bool isLoading;
  final bool isShow;
  final String typeFile;

  const MediaAvatarModel(
      {required this.pathFile,
        required this.urlFile,
        required this.isLoading,
        this.isShow = false,
        required this.typeFile});

  MediaAvatarModel copyWith({pathFile, urlFile, isLoading, isShow, typeFile}) =>
      MediaAvatarModel(
          pathFile: pathFile ?? this.pathFile,
          urlFile: urlFile ?? this.urlFile,
          isLoading: isLoading ?? this.isLoading,
          isShow: isShow ?? this.isShow,
          typeFile: typeFile ?? this.typeFile);

  @override
  List<Object> get props => [pathFile, urlFile, isLoading, isShow, typeFile];
}