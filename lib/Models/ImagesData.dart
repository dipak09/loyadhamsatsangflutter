class Dashboardata {
  String? id;
  String? name;
  String? image;
  String? routename;

  Dashboardata({
    this.id,
    this.name,
    this.image,
    this.routename,
  });

  factory Dashboardata.fromJson(Map<String, dynamic> json) => Dashboardata(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        routename: json["routename"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "routename": routename,
      };
}
