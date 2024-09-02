
class TaskModel {
  String? id;
  String title;
  String description;
  int priority;
  DateTime dueDate;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
  });

  // Converts a TaskModel into a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'dueDate': dueDate.toIso8601String(),
    };
  }

  // Creates a TaskModel from a map.
  factory TaskModel.fromMap(Map<String, dynamic> map, String documentId) {
    return TaskModel(
      id: documentId,
      title: map['title'],
      description: map['description'],
      priority: map['priority'],
      dueDate: DateTime.parse(map['dueDate']),
    );
  }

  // CopyWith method to create a new instance with updated properties
  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    int? priority,
    DateTime? dueDate,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
