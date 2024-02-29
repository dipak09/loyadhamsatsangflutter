class GetDonationList {
  List<Donation>? donation;

  GetDonationList({this.donation});

  GetDonationList.fromJson(Map<String, dynamic> json) {
    if (json['donation'] != null) {
      donation = <Donation>[];
      json['donation'].forEach((v) {
        donation!.add(new Donation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.donation != null) {
      data['donation'] = this.donation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Donation {
  String? id;
  String? type;
  List<SubDonations>? subDonations;

  Donation({this.id, this.type, this.subDonations});

  Donation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    if (json['subDonations'] != null) {
      subDonations = <SubDonations>[];
      json['subDonations'].forEach((v) {
        subDonations!.add(new SubDonations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.subDonations != null) {
      data['subDonations'] = this.subDonations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubDonations {
  String? donationId;
  String? subType;
  String? amount;
  String? dateRequired;
  String? dateMandatory;
  String? descriptionRequired;
  String? descriptionMandatory;
  String? description;
  String? dropdownLabel;
  String? dropdownRequired;
  String? dropdownMandatory;
  List<String>? dropdownName;

  SubDonations(
      {this.donationId,
      this.subType,
      this.amount,
      this.dateRequired,
      this.dateMandatory,
      this.descriptionRequired,
      this.descriptionMandatory,
      this.description,
      this.dropdownLabel,
      this.dropdownRequired,
      this.dropdownMandatory,
      this.dropdownName});

  SubDonations.fromJson(Map<String, dynamic> json) {
    donationId = json['donation_id'];
    subType = json['sub_type'];
    amount = json['amount'];
    dateRequired = json['date_required'];
    dateMandatory = json['date_mandatory'];
    descriptionRequired = json['description_required'];
    descriptionMandatory = json['description_mandatory'];
    description = json['description'];
    dropdownLabel = json['dropdown_label'];
    dropdownRequired = json['dropdown_required'];
    dropdownMandatory = json['dropdown_mandatory'];
    dropdownName = json['dropdown_name'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['donation_id'] = this.donationId;
    data['sub_type'] = this.subType;
    data['amount'] = this.amount;
    data['date_required'] = this.dateRequired;
    data['date_mandatory'] = this.dateMandatory;
    data['description_required'] = this.descriptionRequired;
    data['description_mandatory'] = this.descriptionMandatory;
    data['description'] = this.description;
    data['dropdown_label'] = this.dropdownLabel;
    data['dropdown_required'] = this.dropdownRequired;
    data['dropdown_mandatory'] = this.dropdownMandatory;
    data['dropdown_name'] = this.dropdownName;
    return data;
  }
}
