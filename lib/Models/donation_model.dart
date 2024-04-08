class DonationModel {
  final dynamic id;
  final dynamic type;
  final List<SubDonation> subDonations;

  DonationModel({
    required this.id,
    required this.type,
    required this.subDonations,
  });

  factory DonationModel.fromJson(Map<dynamic, dynamic> json) {
    List<dynamic> subDonationsJson = json['subDonations'];
    List<SubDonation> subDonations = subDonationsJson
        .map((subDonationJson) => SubDonation.fromJson(subDonationJson))
        .toList();

    return DonationModel(
      id: json['id'],
      type: json['type'],
      subDonations: subDonations,
    );
  }
}

class SubDonation {
  final dynamic donationId;
  final dynamic subType;
  final dynamic amount;
  final dynamic dateRequired;
  final dynamic dateMandatory;
  final dynamic descriptionRequired;
  final dynamic descriptionMandatory;
  final dynamic description;
  final dynamic dropdownLabel;
  final dynamic dropdownRequired;
  final dynamic dropdownMandatory;
  final dynamic dropdownName; // This can be null

  SubDonation({
    required this.donationId,
    required this.subType,
    required this.amount,
    required this.dateRequired,
    required this.dateMandatory,
    required this.descriptionRequired,
    required this.descriptionMandatory,
    required this.description,
    required this.dropdownLabel,
    required this.dropdownRequired,
    required this.dropdownMandatory,
    this.dropdownName,
  });

  factory SubDonation.fromJson(Map<dynamic, dynamic> json) {
    return SubDonation(
      donationId: json['donation_id'],
      subType: json['sub_type'],
      amount: json['amount'],
      dateRequired: json['date_required'],
      dateMandatory: json['date_mandatory'],
      descriptionRequired: json['description_required'],
      descriptionMandatory: json['description_mandatory'],
      description: json['description'],
      dropdownLabel: json['dropdown_label'],
      dropdownRequired: json['dropdown_required'],
      dropdownMandatory: json['dropdown_mandatory'],
      dropdownName: json['dropdown_name'],
    );
  }
}
