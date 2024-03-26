class Certificate {
  Data? data;

  Certificate({this.data});

  Certificate.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? certificationNumber;
  String? consumerAddharnumber;
  String? doctorSubmitDate;
  String? lastvalidDate;
  String? consumername;
  String? companyName;
  String? gender;
  String? profilePic;
  String? result;

  Data(
      {this.certificationNumber,
      this.consumerAddharnumber,
      this.doctorSubmitDate,
      this.lastvalidDate,
      this.consumername,
      this.companyName,
      this.gender,
      this.profilePic,
      this.result});

  Data.fromJson(Map<String, dynamic> json) {
    certificationNumber = json['certification_number'];
    consumerAddharnumber = json['consumer_addharnumber'];
    doctorSubmitDate = json['doctor_submit_date'];
    lastvalidDate = json['lastvalid_date'];
    consumername = json['consumername'];
    companyName = json['company_name'];
    gender = json['gender'];
    profilePic = json['profile_pic'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['certification_number'] = this.certificationNumber;
    data['consumer_addharnumber'] = this.consumerAddharnumber;
    data['doctor_submit_date'] = this.doctorSubmitDate;
    data['lastvalid_date'] = this.lastvalidDate;
    data['consumername'] = this.consumername;
    data['company_name'] = this.companyName;
    data['gender'] = this.gender;
    data['profile_pic'] = this.profilePic;
    data['result'] = this.result;
    return data;
  }
}
