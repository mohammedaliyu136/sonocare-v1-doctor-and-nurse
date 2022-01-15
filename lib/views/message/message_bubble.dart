import 'package:doctor_v2/utill/color_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'chatModel.dart';

class MessageBubble extends StatelessWidget {
  final ChatModel chat;
  final bool addDate;
  MessageBubble({required this.chat, required this.addDate});

  @override
  Widget build(BuildContext context) {
    bool isMe = chat.reply == null;

    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        addDate ? Padding(
          padding: EdgeInsets.all(10),
          child: Align(alignment: Alignment.center, child: Text("_date", textAlign: TextAlign.center)),
        ) : SizedBox(),
        Padding(
          padding: isMe ?  EdgeInsets.fromLTRB(50, 5, 10, 5) : EdgeInsets.fromLTRB(10, 5, 50, 5),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: isMe ? Radius.circular(10) : Radius.circular(0),
                            bottomRight: isMe ? Radius.circular(0) : Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: isMe ? Color(0xFF52575C) : Color(0xFFF4F7FC),
                        ),
                        child: Column(
                          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              child: isMe ?Text(chat.message??'', style: TextStyle(color: isMe ? Colors.white
                                  : Theme.of(context).textTheme.bodyText1!.color)):Text(chat.reply??'', style: TextStyle(color: isMe ? Theme.of(context).accentColor
                                  : Theme.of(context).textTheme.bodyText1!.color)),
                            ),

                            chat.image != null ? ClipRRect(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(isMe ? 10 : 0), bottomRight: Radius.circular(isMe ? 0 : 10)),
                              child: FadeInImage.assetNetwork(
                                placeholder: "Images.placeholder_image",
                                image: 'chat.image',
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fitWidth,
                              ),
                            ) : SizedBox(),
                          ],
                        ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 3),
              Text("9:23AM", style: TextStyle(fontSize: 10, color: ColorResources.COLOR_GREY_BUNKER)),
            ],
          ),
        ),
      ],
    );
  }
}
