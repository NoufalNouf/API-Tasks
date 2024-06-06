class United {
  List<String>? domains;
  String? country;
  String? stateProvince;
  String? alphaTwoCode;
  List<String>? webPages;
  String? name;

  United(
      {this.domains,
        this.country,
        this.stateProvince,
        this.alphaTwoCode,
        this.webPages,
        this.name});

  United.fromJson(Map<String, dynamic> json) {
    domains = json['domains'].cast<String>();
    country = json['country'];
    stateProvince = json['state-province'];
    alphaTwoCode = json['alpha_two_code'];
    webPages = json['web_pages'].cast<String>();
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domains'] = this.domains;
    data['country'] = this.country;
    data['state-province'] = this.stateProvince;
    data['alpha_two_code'] = this.alphaTwoCode;
    data['web_pages'] = this.webPages;
    data['name'] = this.name;
    return data;
  }
}
