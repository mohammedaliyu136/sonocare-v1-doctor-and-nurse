import 'package:doctor_v2/data/model/review_model.dart';
import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/provider/reviews_provider.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/accept_appointment/accept_appointment_screen.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my_patient_screen
class RatingModel{
  String name = '';
  double rating = 0.0;
  String message = '';
  String days = '';
  RatingModel({required this.name, required this.rating, required this.message, required this.days});
}
class ReviewsScreen extends StatefulWidget {
  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  List<RatingModel> ratings = [
    RatingModel(name: 'Ewada Omakwu', rating: 4.0, message: 'I like the app and the interface is easy to navigate. Also option of being able to choose a doctor of your choice based on price and specialty makes it great. But , there should be space a person can search or request for a specialist in a particular health care need one would be recommended. That will be great.', days: '1 days ago'),
    RatingModel(name: 'Emmanuel Adepoju', rating: 5.0, message: 'The doctor was professional and very easy to converse with. The voice feature wasn\'t working so that was a bummer, we had to make do with just the chat feature. The UI is user friendly and pretty easy to navigate The UX could use some improvements. Being able to reply specific messages for example, being able to copy messages if the former isn\'t', days: '2 days ago'),
    RatingModel(name: 'Euginho Cortez', rating: 3.5, message: 'Smooth sign-up process. Well-designed layout. I ordered medication and got it in some hours. App works rather well.', days: '10 days ago'),
    RatingModel(name: 'Tudix- Arewa', rating: 3.0, message: 'I don\'t really understand this app, because I was having a trouble after the registration is about to be done, it asks about my country and clicked the following line underneath \'Nigeria\' my country, yet, it keeps loading and brings an error. Why is it so?', days: '20 days ago'),
  ];

  @override
  void initState() {
    String token = Provider.of<NurseAuthProvider>(context, listen: false).token;
    Provider.of<ReviewsProvider>(context, listen: false).getReviews(token:token, account:'nurse');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      DarkBackGround(),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Reviews'),
          elevation: 0,
          leading: GestureDetector(
              onTap: ()=>Navigator.pop(context),
              child: Image.asset('assets/icons/back-arrow_icon.png')),
        ),
        //body: Center(child: Text('Reviews Screen is in progress...', style: TextStyle(color: Colors.white, fontSize: 16),),)
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<ReviewsProvider>(
              builder: (context, reviewsProvider, child) {
                if(reviewsProvider.isLoadingReviews){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
                    ],
                  );
                }else{
                  if(reviewsProvider.totalRating.toString()=='NaN'){
                    return Center(child: Text('You don\'t any reviews.', style: TextStyle(color: Colors.white, fontSize: 18),));
                  }else{
                    return ListView(children: [
                      Column(children: [
                        Text(reviewsProvider.totalRating.toString(), style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: /*Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(Icons.star, color: Color(0xFFEF7822),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(Icons.star, color: Color(0xFFEF7822),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(Icons.star, color: Color(0xFFEF7822),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(Icons.star, color: Colors.grey,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(Icons.star, color: Colors.grey,),
                            ),
                          ],
                        ),*/stars_list(rating: reviewsProvider.totalRating, size:24)
                        ),
                        Text('based on ${reviewsProvider.totalReviews} reviews', style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.7)
                        ),),
                      ],),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                        child: SizedBox(height: 2, width: MediaQuery.of(context).size.width, child: Container(color: Colors.white.withOpacity(0.1),),),
                      ),
                      reviews_list(ratings:reviewsProvider.reviews)
                    ],);
                  }
                }
            }
          ),
        ),
      ),
    ],);
  }
}

reviews_list({required List<ReviewModel> ratings}) {
  return Column(
    children: ratings.map((ReviewModel rating){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(100))
            ),
            child: Icon(Icons.account_circle_rounded, size: 50, color: Colors.white,),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rating.patientName, style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 1.5,),
                /*
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(Icons.star, color: Color(0xFFEF7822), size: 18,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(Icons.star, color: Color(0xFFEF7822), size: 18,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(Icons.star, color: Color(0xFFEF7822), size: 18,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(Icons.star, color: Colors.grey, size: 18,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(Icons.star, color: Colors.grey, size: 18,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('5.0', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                    )
                  ],
                ),
                */
                stars_list(rating: double.parse(rating.rating))
              ],),
          ),
          Spacer(),
          Align(
              alignment: Alignment.bottomCenter,
              child: Text(rating.createdAT, style: TextStyle(color: Colors.white.withOpacity(0.7)),textAlign: TextAlign.center,)),
        ],),
        SizedBox(height: 8,),
        Text(rating.comment,
          maxLines: 4, overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
          style: TextStyle(
            height: 1.35,
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,),
        )
      ],),
    );
  }).toList(),);
}

stars_list({required double rating, double? size}){
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Icon(Icons.star, color: rating>0?Color(0xFFEF7822):Colors.grey, size: size??18,),
      ),
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Icon(Icons.star, color: rating>1.9?Color(0xFFEF7822):Colors.grey, size: size??18,),
      ),
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Icon(Icons.star, color: rating>2.9?Color(0xFFEF7822):Colors.grey, size: size??18,),
      ),
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Icon(Icons.star, color: rating>3.9?Color(0xFFEF7822):Colors.grey, size: size??18,),
      ),
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Icon(Icons.star, color: rating>4.9?Color(0xFFEF7822):Colors.grey, size: size??18,),
      ),
      size==null?Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(rating.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
      ):SizedBox(height: 0,)
    ],
  );
}
