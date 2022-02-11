import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesRepository extends ChangeNotifier {
  final List<Message> messages = [
    Message(
        "Hello", "Lory", DateTime.now().subtract(const Duration(minutes: 4))),
    Message("Hi", "Harry", DateTime.now().subtract(const Duration(minutes: 3))),
    Message("How are you?", "Lory",
        DateTime.now().subtract(const Duration(minutes: 2))),
    Message("Thanks Lory, I'm fine, you?", "Harry", DateTime.now()),
  ];
}

final messagesProvider = ChangeNotifierProvider((ref) => MessagesRepository());

class NewMessageCount extends StateNotifier<int> {
  NewMessageCount(int state) : super(state);

  void reset() {
    state = 0;
  }
}

final newMessageCountProvider =
    StateNotifierProvider<NewMessageCount,int>((ref) => NewMessageCount(4));

class Message {
  String text;
  String sender;
  DateTime time;
  Message(this.text, this.sender, this.time);
}
