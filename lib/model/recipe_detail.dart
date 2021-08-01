class RecipeDetail {
  String? title;
  String? thumb;
  String? key;
  String? times;
  String? portion;
  String? dificulty;

  RecipeDetail({
    this.title,
    this.thumb,
    this.key,
    this.times,
    this.portion,
    this.dificulty,
  });

  factory RecipeDetail.fromJson(Map<String, dynamic> json) {
    return RecipeDetail(
      title: json['title'],
      thumb: json['thumb'],
      key: json['key'],
      times: json['times'],
      portion: json['portion'],
      dificulty: json['dificulty']
    );
  }
}