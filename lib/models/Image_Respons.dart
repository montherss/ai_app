class ImageResponse {
  int? created;
  List<Data>? data;

  ImageResponse({this.created, this.data});

  ImageResponse.fromJson(Map<dynamic, dynamic> json) {
    created = json['created'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['created'] = this.created;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? url;

  Data({this.url});

  Data.fromJson(Map<dynamic, dynamic> json) {
    url = json['url'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
