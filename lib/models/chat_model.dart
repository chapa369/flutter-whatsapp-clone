class ChatModel {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;

  ChatModel({this.name, this.message, this.time, this.avatarUrl});
}

List<ChatModel> dummyData = [
  new ChatModel(
      name: "Hironori Matsumoto",
      message: "Hello",
      time: "15:30",
      avatarUrl:
          "https://img.icons8.com/material-two-tone/24/000000/delete-link.png"),
];
