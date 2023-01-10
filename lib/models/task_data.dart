class TaskData {
  String id;
  String title;
  String description;
  DateTime date;
  bool isDone;

  TaskData(
      {this.id = "",
      required this.title,
      required this.description,
      required this.date,
      this.isDone = false});

  Map<String, dynamic> toJason() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date.millisecondsSinceEpoch,
      "isDone": isDone
    };
  }

  TaskData.fromJason(Map<String, dynamic> json)
      : this(
            id: json["id"],
            title: json["title"],
            description: json["description"],
            date: DateTime.fromMillisecondsSinceEpoch(json["date"]),
            isDone: json["isDone"]);
}
