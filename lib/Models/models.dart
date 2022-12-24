class TodoModel{
  final int? id;
  final String? title;
  final String? desc;
  final String? dateAndTime;

  TodoModel(
        {
          this.id,
          this.title,
          this.desc,
          this.dateAndTime
        }
      );
  TodoModel.fromMap(Map<String, dynamic>result)
      : id = result['id'],
        title = result['title'],
        desc = result['desc'],
        dateAndTime = result['dateAndTime'];

      Map<String, Object?> toMap(){
        return {
          "id" : id,
          "title" : title,
          "desc" : desc,
          "dateAndTime" : dateAndTime,
        };
      }
}

