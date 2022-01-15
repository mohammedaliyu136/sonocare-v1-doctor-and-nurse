import 'package:doctor_v2/nurse_utill/app_constants.dart';
import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/nurse_views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
class CallingScreen extends StatefulWidget {
  String token = '';
  String remoteUID = '';
  String channel = '';
  CallingScreen({Key? key, required String this.token, required String this.remoteUID, required String this.channel}) : super(key: key);

  @override
  _CallingScreenState createState() {
    return _CallingScreenState();
  }
}

class _CallingScreenState extends State<CallingScreen> {
  bool _localUserJoined = false;
  bool _showStats = false;
  int? _remoteUid;
  late RtcEngine engine;
  //RtcStats _stats = RtcStats();
  bool activeVideo = true;
  bool activeAudio = true;

  @override
  void initState() {
    super.initState();
    initForAgora();
  }

  Future<void> initForAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    // create the engine for communicating with agora
    engine = await RtcEngine.create(AppConstants.appId);

    // set up event handling for the engine
    engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (String channel, int uid, int elapsed) {
        print('$uid successfully joined channel: $channel ');
        setState(() {
          _localUserJoined = true;
        });
      },
      userJoined: (int uid, int elapsed) {
        print('remote user $uid joined channel');
        setState(() {
          _remoteUid = uid;
        });
      },
      userOffline: (int uid, UserOfflineReason reason) {
        print('remote user $uid left channel');
        setState(() {
          _remoteUid = null;
        });
      },
        /*
      rtcStats: (stats) {
        //updates every two seconds
        if (_showStats) {
          _stats = stats;
          setState(() {});
        }
      },
      */
    ));
    // enable video
    await engine.enableVideo();

    String tokk2 = "NETLESSROOM_YWs9WW91ciUyMEFLJmV4cGlyZUF0PTE2MzMyMTEwODcyNTImbm9uY2U9YjAwNTFlNmEtMDExMy00MDlkLThmNzAtZGQ0ZjJjNDYyNTA4JnJvbGU9MiZzaWc9Y2Y4YjNkNTExMDAyMzBhMDdlYjhkOGIzNzMyMjMyY2M2ZjNlYzY3ZDc5ZTNhMTFkOGQ2NjZiNDZjNDBiMTY2NyZ1dWlkPTIy";
    String tokk3 = "006da2e58ec2ef84ca29aa5d23c7523fb82IACHoGHVb6wrGN+8e1AG62QV8s93wW2aU0RKkGU8+9e/3xO6hW010OTsEAB9xlP0k8BZYQEAAQAAAAAA";
    String tokk = "006da2e58ec2ef84ca29aa5d23c7523fb82IAA74L4p2MN79gd7SU4QarvUlh8qo5wU0biKYAPzqzFpNbkPl5oAAAAAEADSvifO8rpZYQEAAQDxullh";
    String chann = "mohammedtest";
    String chann1 = "kabbtest";

    await engine.joinChannel(widget.token, widget.channel, null, 0);
    //await engine.joinChannel(tokk2, chann, null, 22);
    //await engine.joinChannel(AppConstants.vid_chat_token, 'mohammed2_test', null, 0);
    //await engine.joinChannel(null, 'mohammed2_test', null, 0);

    /*
    engine.disableAudio();
    engine.enableAudio();
    engine.enableVideo();
    engine.disableVideo();
    engine.switchCamera();
    engine.destroy();
    */
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Center(
              child: _renderRemoteVideo(),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 28.0, top: 60),
                child: activeVideo?Container(
                  width: 130,
                  height: 170,
                  child: Center(
                    child: _renderLocalPreview(),
                  ),
                ):Container(
                  width: 130,
                  height: 170,
                  color: Colors.white,
                  child: Icon(activeVideo?Icons.videocam:Icons.videocam_off, color: Colors.purple, size: 30,),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 38.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        onTap: (){
                          engine.destroy();
                          Navigator.pop(context);
                          },
                        child: circleButton(icon: Icon(Icons.call_end, color: Colors.white, size: 30,), backgroundColor: Colors.red)),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: (){engine.switchCamera();},
                            child: circleButton(icon: Icon(Icons.camera_alt, color: Colors.white, size: 30,), backgroundColor: ColorResources.COLOR_PURPLE_DEEP)),
                        SizedBox(width: 50,),
                        GestureDetector(
                            onTap: (){
                              setState(() {
                                activeVideo=!activeVideo;
                              });
                              if(activeVideo){
                                engine.enableVideo();
                              }else{
                                engine.disableVideo();
                              }
                              },
                            child: circleButton(icon: Icon(activeVideo?Icons.videocam:Icons.videocam_off, color: Colors.white, size: 30,), backgroundColor: ColorResources.COLOR_PURPLE_DEEP)),
                        SizedBox(width: 50,),
                        GestureDetector(
                            onTap: (){
                              setState(() {
                                activeAudio=!activeAudio;
                              });
                              if(activeAudio){
                                engine.enableAudio();
                              }else{
                                engine.disableAudio();
                              }
                            },
                            child: circleButton(icon: Icon(activeAudio?Icons.mic:Icons.mic_off, color: Colors.white, size: 30,), backgroundColor: ColorResources.COLOR_PURPLE_DEEP))
                      ],),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // current user video
  Widget _renderLocalPreview() {
    if (_localUserJoined) {
      return RtcLocalView.SurfaceView();
    } else {
      return Text(
        'Joining Chat',
        textAlign: TextAlign.center,
      );
    }
  }

  // remote user video
  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid??0);
    } else {
      return Text(
        'Please wait for patient to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
/*
class CallingScreen extends StatelessWidget {
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: "da2e58ec2ef84ca29aa5d23c7523fb82",
      channelName: "mohammed123457",
    ),
    enabledPermission: [
      Permission.camera,
      Permission.microphone,
    ],
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: SafeArea(
        child: Stack(
          children: [
            /*
            SizedBox(height: 70,),
            Center(child: Text('Patients', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20,),)),
            SizedBox(height: 10,),
            Center(child: Text('Incoming video call...', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),)),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom:60.0),
              child: Column(
                children: [
                  circleButton(icon: Icon(Icons.call_end, color: Colors.white, size: 30,), backgroundColor: Colors.red),
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    circleButton(icon: Icon(Icons.camera_alt, color: Colors.white, size: 30,), backgroundColor: ColorResources.COLOR_PURPLE_DEEP),
                    SizedBox(width: 50,),
                    circleButton(icon: Icon(Icons.video_call, color: Colors.white, size: 30,), backgroundColor: ColorResources.COLOR_PURPLE_DEEP),
                    SizedBox(width: 50,),
                    circleButton(icon: Icon(Icons.mic, color: Colors.white, size: 30,), backgroundColor: ColorResources.COLOR_PURPLE_DEEP)
                  ],),
                ],
              ),
            )
            */
            AgoraVideoViewer(client: client),
            AgoraVideoButtons(client: client),
        ],),
      ),
    );
  }
}
 */
