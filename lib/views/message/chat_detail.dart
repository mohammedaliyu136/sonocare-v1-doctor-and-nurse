import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/snack_bar.dart';
import 'package:doctor_v2/views/ui_kits/textFieldNotStyled.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'chatModel.dart';
import 'message_bubble.dart';

class ChatDetailScreen extends StatelessWidget {
  ChatDetailScreen({Key? key}) : super(key: key);

  final ImagePicker picker = ImagePicker();
  final TextEditingController _controller = TextEditingController();

  static const String image = 'assets/icons/image.png';
  static const String send = 'assets/icons/send.png';

  List<String> chatList = ['How are you feeling man?','Like a ','Well i don\'t see why that matters','it does','Okay','Bye'
    , 'Below, I briefly discuss the switch between TV cartoons and news shows. Here in the U.S., that hit me more than a few times as a kid watching PBS. I cannot tell you how many times, as an adolescent, I ended up watching The MacNeil/Lehrer NewsHour in hopes that after a few minutes of guy in suits being extraordinarily boring, something fun would re-emerge on the screen. -- Dan'
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      BackGround(),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Dr. Prince David'),
            elevation: 0,
            leading: GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: Image.asset('assets/icons/back-arrow_icon.png')),
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(Icons.call, size: 18,),
                    height: 38, width: 38,
                    decoration: BoxDecoration(
                        color: ColorResources.COLOR_PURPLE_DEEP,
                        borderRadius: BorderRadius.all(Radius.circular(100))
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: Icon(Icons.videocam, size: 18,),
                    height: 38, width: 38,
                      decoration: BoxDecoration(
                          color: ColorResources.COLOR_PURPLE_DEEP,
                          borderRadius: BorderRadius.all(Radius.circular(100))
                      ),
                  ),
                ],
              ),
              SizedBox(width: 10,),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: chatList.length > 0 ? Scrollbar(
                  child: SingleChildScrollView(
                    reverse: true,
                    physics: BouncingScrollPhysics(),
                    child: Center(
                      child: SizedBox(
                        width: 1170,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.all(10),
                          itemCount: chatList.length,
                          itemBuilder: (context, index) {
                            ChatModel chatModel = ChatModel(
                                id:"1",
                                userId:"1",
                                restaurantId:"1",
                                message:chatList[index],
                                reply:index%3==0?chatList[index]:null,
                                createdAt:"",
                                updatedAt:"",
                                checked:"",
                                image:null);
                            return MessageBubble(chat: chatModel, addDate: false);
                          },
                        ),
                      ),
                    ),
                  ),
                ) : SizedBox(),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 100),
                child: Ink(
                  color: Theme.of(context).accentColor,
                  child: Row(children: [

                    InkWell(
                      onTap: () async {
                        final PickedFile? pickedFile = await picker.getImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          //Provider.of<ChatProvider>(context, listen: false).setImage(pickedFile);
                        } else {
                          print('No image selected.');
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Image.asset(image, width: 25, height: 25, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                      child: VerticalDivider(width: 0, thickness: 1, color: Colors.white),
                    ),
                    SizedBox(width: 15),

                    Expanded(
                      child: TextField(
                        controller: _controller,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(fontSize: 16),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Type message here',
                          hintStyle: TextStyle(color: Color(0xFF25282B), fontSize: 16),
                        ),
                        onChanged: (String newText) {},
                      ),
                    ),

                    InkWell(
                      onTap: () async {
                        /*
                        if(Provider.of<ChatProvider>(context, listen: false).isSendButtonActive){
                          Provider.of<ChatProvider>(context, listen: false).sendMessage(
                            _controller.text, Provider.of<AuthProvider>(context, listen: false).getUserToken(),
                            Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id.toString(), context,
                          );
                          _controller.text = '';
                        }else {
                          showCustomSnackBar('Write something', context);
                        }
                        */
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Image.asset(
                          send,
                          width: 25, height: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),

                  ]),
                ),
              ),
            ],
          )
      ),
    ],);
  }
}
