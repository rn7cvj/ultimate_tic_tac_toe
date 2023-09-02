class Message {
  final MessageType type;
  final MessageReciver reciver;
  final MessageInfo info;

  Message({required this.type, required this.reciver, required this.info});
}

enum MessageType { info, warning }

enum MessageReciver {
  FirstPlayer,
  SecondPlayer,
}

enum MessageInfo {
  IllegalMove,
  NoForceTile,
}
