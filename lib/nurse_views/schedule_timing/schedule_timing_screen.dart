import 'package:doctor_v2/nurse_data/model/response_model.dart';
import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/nurse_provider/schedule_provider.dart';
import 'package:doctor_v2/nurse_utill/color_resources.dart';
import 'package:doctor_v2/nurse_views/schedule_timing/time_picker.dart';
import 'package:doctor_v2/nurse_views/shared/background.dart';
import 'package:doctor_v2/nurse_views/ui_kits/snack_bar.dart';
import 'package:doctor_v2/nurse_views/ui_kits/ui_kits.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ScheduleTimingScreen extends StatefulWidget {
  ScheduleTimingScreen({Key? key}) : super(key: key);

  @override
  _ScheduleTimingScreenState createState() {
    return _ScheduleTimingScreenState();
  }
}

class _ScheduleTimingScreenState extends State<ScheduleTimingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String morningEvening = "morning";

  List<String> weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
  List months = ['Jan','Jeb','Mar','April','May','Jun','July','Aug','Sep','Oct','Nov','Dec'];

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Stack(
      children: [
        BackGround(),
        Consumer<NurseAuthProvider>(
            builder: (context, authProvider, child) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: ColorResources.COLOR_PURPLE_MID,
                  elevation: 0,
                  leading: GestureDetector(
                      onTap: ()=>Navigator.pop(context),
                      child: Image.asset('assets/icons/back-arrow_icon.png')),
                  title: Text('Schedule Timing', style: TextStyle(color: Colors.white),),
                ),
                body: ListView(
                  children: [
                    Container(
                      decoration: new BoxDecoration(
                        color: ColorResources.COLOR_PURPLE_MID,
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(
                                400, 110.0)
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 10),
                        child: Row(
                          children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  image:DecorationImage(
                                    fit:BoxFit.fill,
                                    image: AssetImage("assets/dummy/profile_dummy.png"),
                                  )
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(authProvider.userInfoModel!.firstName+' '+authProvider.userInfoModel!.lastName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
                              SizedBox(height: 5,),
                            Text('MBBS, FCPS, FRCS Ed', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white,),),
                              SizedBox(height: 5,),
                              Row(children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: Icon(Icons.star, color: Colors.amber, size: 18,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: Icon(Icons.star, color: Colors.amber, size: 18,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: Icon(Icons.star, color: Colors.amber, size: 18,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: Icon(Icons.star, color: Colors.grey, size: 18,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: Icon(Icons.star, color: Colors.grey, size: 18,),
                                ),
                              ],),
                          ],)
                        ],),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, left: 18, bottom: 4),
                      child: Text('Octoberrr 2021', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),),
                    ),
                    /*
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Container(
                        height: 90,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorResources.COLOR_WHITE,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Text('MON', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
                                  SizedBox(height: 10,),
                                  Text('17', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
                                ],),
                              ),
                            ),
                          ),
                        ],),
                      )
                    ),*/
                    Consumer<ScheduleProvider>(
                        builder: (context, scheduleProvider, child) {
                          if(scheduleProvider.isLoading){
                            return Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Loading...', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
                            ),);
                          }else{
                            return Column(children: [
                              Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Container(
                                    height: 90,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 7,
                                      itemBuilder: (context, index) {
                                        var today = DateTime.now();
                                        var daysFromNow = today.add(Duration(days: index));
                                        return GestureDetector(
                                          onTap: (){
                                            String token = Provider.of<NurseAuthProvider>(context, listen: false).token;
                                            scheduleProvider.getSchedules(context, token, day: daysFromNow.weekday.toString(), index: index);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: index!=scheduleProvider.selectedWeekDayIndex?ColorResources.COLOR_WHITE:ColorResources.COLOR_PURPLE_MID,
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(children: [
                                                  Text(weekdays[daysFromNow.weekday], style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: index!=scheduleProvider.selectedWeekDayIndex?ColorResources.COLOR_BLACK:ColorResources.COLOR_WHITE),),
                                                  SizedBox(height: 10,),
                                                  Text(daysFromNow.day.toString(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: index!=scheduleProvider.selectedWeekDayIndex?ColorResources.COLOR_BLACK:ColorResources.COLOR_WHITE),),
                                                ],),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      //morning
                                      setState(() {
                                        morningEvening = "morning";
                                      });
                                      scheduleProvider.filterSchedules('morning');
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: scheduleProvider.morningEvening=="morning"?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(children: [
                                          Container(height: 40, width: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Text('Morning',  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: scheduleProvider.morningEvening=="morning"?ColorResources.COLOR_WHITE:ColorResources.COLOR_BLACK),)
                                        ],),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  GestureDetector(
                                    onTap: (){
                                      //evening
                                      setState(() {
                                        morningEvening = "evening";
                                      });
                                      scheduleProvider.filterSchedules('evening');
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: scheduleProvider.morningEvening=="evening"?ColorResources.COLOR_PURPLE_MID:ColorResources.COLOR_WHITE,
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(children: [
                                          Container(height: 40, width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                color: Colors.grey
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Text('Evening',  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: scheduleProvider.morningEvening=="evening"?ColorResources.COLOR_WHITE:ColorResources.COLOR_BLACK,),)
                                        ],),
                                      ),
                                    ),
                                  ),
                                ],),

                              SizedBox(height: 20,),
                              Container(
                                height: 150,
                                child: GridView.count(
                                  // Create a grid with 2 columns. If you change the scrollDirection to
                                  // horizontal, this produces 2 rows.
                                  childAspectRatio: 4/2,
                                  crossAxisCount: 4,
                                  physics: NeverScrollableScrollPhysics(),
                                  // Generate 100 widgets that display their index in the List.

                                  children: List.generate(scheduleProvider.schedules.length, (index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                                          child: GestureDetector(
                                            onTap: (){
                                              print('----${scheduleProvider.schedules[index].id}');
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(children: [
                                                  Text(scheduleProvider.schedules[index].time,  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),)
                                                ],),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),

                                ),
                              ),

                              /*
                          Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: [
                                        Text('10:00 am',  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),)
                                      ],),
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: [
                                        Text('11:00 am',  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),)
                                      ],),
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: [
                                        Text('12:00 pm',  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),)
                                      ],),
                                    ),
                                  ),
                                ],),
                              */
                              SizedBox(height: 10,),
                              if(scheduleProvider.isLoadingSetTime)Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
                              if(!scheduleProvider.isLoadingSetTime)Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                child: normalButton(
                                  button_text: 'Set Time',
                                  fontSize: 18,
                                  primaryColor: ColorResources.COLOR_WHITE,
                                  backgroundColor: Colors.blue,
                                  onTap: (){
                                    DateTimeRangePicker(
                                        startText: "From",
                                        //endText: "To",
                                        doneText: "Set",
                                        cancelText: "Cancel",
                                        interval: 5,
                                        initialStartTime: DateTime.now(),
                                        initialEndTime: DateTime.now().add(Duration(days: 60)),
                                        mode: DateTimeRangePickerMode.dateAndTime,
                                        minimumTime: DateTime.now().subtract(Duration(days: 5)),
                                        maximumTime: DateTime.now().add(Duration(days: 60)),
                                        use24hFormat: false,
                                        onConfirm: (time, end) {
                                          print(time.day);
                                          String ampm = "AM";
                                          String day = "Morning";
                                          String selectedTime = "";
                                          if(time.hour-12>0){
                                            ampm="PM";
                                            day="Evening";
                                            selectedTime = "${time.hour-12}:${time.minute<10?'0${time.minute}':time.minute}";
                                          }else{
                                            selectedTime = "${time.hour}:${time.minute<10?'0${time.minute}':time.minute}";
                                          }
                                          print(ampm);
                                          print(selectedTime);
                                          print(day);
                                          String token = Provider.of<NurseAuthProvider>(context, listen: false).token;
                                          scheduleProvider.createSchedule(context, token, selectedTime+ampm, day).then((ResponseModelNurse responseModel){
                                            if(!responseModel.isSuccess){
                                              showCustomSnackBar(responseModel.message, context, isError: true);
                                            }else{
                                              showCustomSnackBar('Saved Successfully', context, isError: false);
                                            }
                                          });
                                        }).showPicker(context);
                                  },
                                ),
                              ),
                            ],);
                          }
                      }
                    ),
                    SizedBox(height: 200,),
                  ],),
                floatingActionButton: FloatingActionButton(
                  child: Consumer<ScheduleProvider>(
                      builder: (context, scheduleProvider, child) {
                      return Column(children: [
                        if(scheduleProvider.isLoadingSetTime)Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
                        if(!scheduleProvider.isLoadingSetTime)Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: normalButton(
                            button_text: 'Set Time',
                            fontSize: 18,
                            primaryColor: ColorResources.COLOR_WHITE,
                            backgroundColor: Colors.blue,
                            onTap: (){
                              DateTimeRangePicker(
                                  startText: "From",
                                  //endText: "To",
                                  doneText: "Set",
                                  cancelText: "Cancel",
                                  interval: 5,
                                  initialStartTime: DateTime.now(),
                                  initialEndTime: DateTime.now().add(Duration(days: 60)),
                                  mode: DateTimeRangePickerMode.dateAndTime,
                                  minimumTime: DateTime.now().subtract(Duration(days: 5)),
                                  maximumTime: DateTime.now().add(Duration(days: 60)),
                                  use24hFormat: false,
                                  onConfirm: (time, end) {
                                    print(time.day);
                                    String ampm = "AM";
                                    String day = "Morning";
                                    String selectedTime = "";
                                    if(time.hour-12>0){
                                      ampm="PM";
                                      day="Evening";
                                      selectedTime = "${time.hour-12}:${time.minute<10?'0${time.minute}':time.minute}";
                                    }else{
                                      selectedTime = "${time.hour}:${time.minute<10?'0${time.minute}':time.minute}";
                                    }
                                    print(ampm);
                                    print(selectedTime);
                                    print(day);
                                    String token = Provider.of<NurseAuthProvider>(context, listen: false).token;
                                    scheduleProvider.createSchedule(context, token, selectedTime+ampm, day).then((ResponseModelNurse responseModel){
                                      if(!responseModel.isSuccess){
                                        showCustomSnackBar(responseModel.message, context, isError: true);
                                      }else{
                                        showCustomSnackBar('Saved Successfully', context, isError: false);
                                      }
                                    });
                                  }).showPicker(context);
                            },
                          ),
                        ),
                      ],);
                    }
                  ),
                  backgroundColor: Colors.green,
                  onPressed: () {},
                ),
              ),
            );
          }
        ),
        /*
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: ColorResources.COLOR_PURPLE_DEEP,
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  child: Icon(Icons.home, color: Colors.white,),
                ),
                SizedBox(width: 10,),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: ColorResources.COLOR_PURPLE_DEEP,
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  child: Icon(Icons.chat, color: Colors.white,),
                ),
                SizedBox(width: 10,),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: ColorResources.COLOR_PURPLE_DEEP,
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  child: Icon(Icons.settings, color: Colors.white,),
                ),
              ],),
          ),
        )
        */
      ],
    );
  }
}
