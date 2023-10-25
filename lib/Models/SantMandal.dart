class SantMandal {
  String? id;
  String? saintName;
  String? dateOfBirth;
  String? dateOfParshadDiksha;
  String? dateOfBhagvatiDiksha;
  String? photopath;

  SantMandal({
    this.id,
    this.saintName,
    this.dateOfBirth,
    this.dateOfParshadDiksha,
    this.dateOfBhagvatiDiksha,
    this.photopath,
  });

  factory SantMandal.fromJson(Map<String, dynamic> json) => SantMandal(
        id: json["id"],
        saintName: json["saint_name"],
        dateOfBirth: json["date_of_birth"],
        dateOfParshadDiksha: json["date_of_parshad_diksha"],
        dateOfBhagvatiDiksha: json["date_of_bhagvati_diksha"],
        photopath: json["photopath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "saint_name": saintName,
        "date_of_birth": dateOfBirth,
        "date_of_parshad_diksha": dateOfParshadDiksha,
        "date_of_bhagvati_diksha": dateOfBhagvatiDiksha,
        "photopath": photopath,
      };
}
