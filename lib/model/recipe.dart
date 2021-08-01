class Recipe {
  String? title;
  String? thumb;
  String? key;
  String? times;
  String? portion;
  String? dificulty;

  Recipe({
    this.title,
    this.thumb,
    this.key,
    this.times,
    this.portion,
    this.dificulty,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      thumb: json['thumb'],
      key: json['key'],
      times: json['times'],
      portion: json['portion'],
      dificulty: json['dificulty']
    );
  }
}