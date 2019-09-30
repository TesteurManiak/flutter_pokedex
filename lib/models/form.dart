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

  Map<String, dynamic> toJson() => _formToJson(this);

  _formToJson(Form form) {
    return {"name": form.name, "url": form.url};
  }
}
