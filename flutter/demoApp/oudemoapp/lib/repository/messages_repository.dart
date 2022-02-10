class MessagesRepository {
  final List<Message> messages = [

    Message("Hello", "Lory", DateTime.now().subtract(const Duration(minutes: 4)) ),
    Message("Hi", "Harry", DateTime.now().subtract(const Duration(minutes:3)) ),
    Message("How are you?", "Lory", DateTime.now().subtract(const Duration(minutes: 2)) ),
    Message("Thanks Lory, I'm fine, you?", "Harry", DateTime.now()),

  ];
}

class Message {
  String text;
  String sender;
  DateTime time;
  Message(this.text, this.sender, this.time);
}
