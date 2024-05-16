class ImageQoutes {
  String? id;
  String? image;
  String? thumbImage;

  ImageQoutes({this.id, this.image, this.thumbImage});

  ImageQoutes.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    thumbImage = json["thumb_image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["image"] = image;
    _data["thumb_image"] = thumbImage;
    return _data;
  }

  static List<ImageQoutes> motivationalStorie(List books) {
    return books.map((e) => ImageQoutes.fromJson(e)).toList();
  }
}
