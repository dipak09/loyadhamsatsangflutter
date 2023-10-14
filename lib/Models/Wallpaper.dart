class Wallpaper {
  String? id;
  String? image;

  Wallpaper({
    this.id,
    this.image,
  });

  factory Wallpaper.fromJson(Map<String, dynamic> json) => Wallpaper(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
