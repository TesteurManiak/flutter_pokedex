class Form {
  String name;
  String url;

  Form(this.name, this.url);

  factory Form.fromJson(json) {
    return Form(
      json['name'],
      json['url'],
    );
  }
}
