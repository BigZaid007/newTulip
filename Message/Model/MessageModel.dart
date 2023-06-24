class Message {
  final int id;
  final String messageTxt;
  final DateTime messageDate;
  final int userSenderId;
  final int userReciverId;
  final bool seen;
  final String personNameSender;

  Message({
    required this.id,
    required this.messageTxt,
    required this.messageDate,
    required this.userSenderId,
    required this.userReciverId,
    required this.seen,
    required this.personNameSender,
  });
}