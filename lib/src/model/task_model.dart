class TaskModel {
  final String taskId;
  String description;
  bool isComplete;

  TaskModel({
    required this.taskId,
    required this.description,
    required this.isComplete,
  });

  void markComplete(bool v){
    isComplete = v;
  }


  // Convert JSON data to TaskModel object
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskId: json['taskId'] ?? '',
      description: json['description'] ?? '',
      isComplete: json['isComplete'] ?? false,
    );
  }

  // Convert TaskModel object to a Map
  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'description': description,
      'isComplete': isComplete,
    };
  }
}

