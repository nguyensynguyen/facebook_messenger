class Room{
  final String roomId;
  final String roomTitle;
  final String img;
  final bool isNewMess;
  final bool isNewStory;
  final bool isOnline;
  final bool isSend;
  final String documentId;
  final String time;

  Room({this.roomId,this.roomTitle,this.img,this.isSend,this.isNewStory,this.isOnline,this.isNewMess,this.documentId,this.time});
}