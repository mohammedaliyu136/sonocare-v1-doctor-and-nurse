import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/provider/wallet_provider.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:doctor_v2/views/wallet/wallet_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Alerts {
  static showAlertDialog(BuildContext context, requestAmountController) {
    AlertDialog alert = AlertDialog(
      title: Text("Request Withdrawal"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            controller: requestAmountController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Amount',
              contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorResources.COLOR_PURPLE_DEEP),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorResources.COLOR_PURPLE_MID),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: normalButton(
              button_text: 'Withdraw',
              fontSize: 16,
              primaryColor: ColorResources.COLOR_WHITE,
              backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
              onTap: (){
                //walletProvider.withDrawFunds(token, amount).then((value) => null);
                //Alerts.showAlertDialog(context);
                String token = Provider.of<AuthProvider>(context, listen: false).token;
                Provider.of<WalletProvider>(context, listen: false).withDrawFunds(token, requestAmountController.text);
                print(requestAmountController.text);
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class WalletScreen extends StatelessWidget {
  WalletScreen();

  final requestAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [
      BackGround(),
      Padding(
        padding: const EdgeInsets.only(bottom:0.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: Image.asset('assets/icons/back-arrow_icon.png')),
            title: Text('Wallet', style: TextStyle(color: Colors.white),),
            elevation: 0,
            actions: [
              GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WalletSettings()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0, ),
                    child: Icon(Icons.settings),
                  ))
            ],
          ),
          body: Consumer<WalletProvider>(
              builder: (context, walletProvider, child) {
              return Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                  return ListView(children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              //width: MediaQuery.of(context).size.width-200,
                              decoration: BoxDecoration(
                                color: ColorResources.COLOR_WHITE,
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 30,),
                                  Text('Balance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
                                  SizedBox(height: 5,),
                                  Text('₦${authProvider.userInfoModel!.wallet}', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: Colors.black),),
                                    SizedBox(height: 20,),
                                  Text('Account Type', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black),),
                                  Text(authProvider.userInfoModel!.doctorType, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
                                    SizedBox(height: 5,),
                                   if(walletProvider.isLoading)Padding(
                                     padding: const EdgeInsets.all(18.0),
                                     child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
                                   ),
                                   if(!walletProvider.isLoading)
                                    Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: normalButton(
                                        button_text: 'Withdraw',
                                        fontSize: 16,
                                        primaryColor: ColorResources.COLOR_WHITE,
                                        backgroundColor: ColorResources.COLOR_PURPLE_DEEP,
                                        onTap: (){
                                          //walletProvider.withDrawFunds(token, amount).then((value) => null);
                                          Alerts.showAlertDialog(context, requestAmountController);
                                        },
                                    ),
                                  )
                                ],),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:18.0, left: 30, bottom: 10),
                      child: Row(
                        children: [
                          Text('Transaction History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                        ],
                      ),
                    ),
                    Consumer<WalletProvider>(
                        builder: (context, walletProvider, child) {
                          if(walletProvider.isLoading){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text('Loading transactions', style: TextStyle(color: Colors.white),),
                                )
                              ],);
                          }else{
                            if(walletProvider.transactions.length==0){
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text('You have no past transactions', style: TextStyle(color: Colors.white),),
                                  )
                                ],);
                            }else{
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: List.generate(walletProvider.transactions.length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                                    child: Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Row(children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    border: Border.all(
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(100))
                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(walletProvider.transactions[index].type, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                                                      SizedBox(width: 20,),
                                                      Text(walletProvider.transactions[index].status, style: TextStyle(color: Colors.green, fontWeight: FontWeight.w800),)
                                                    ],
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Row(
                                                    children: [
                                                      Text(walletProvider.transactions[index].createdAT, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                                                      SizedBox(width: 30,),
                                                      Text('₦'+walletProvider.transactions[index].amount, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                                                    ],
                                                  ),
                                                ],)
                                            ],),
                                          ),
                                        ),
                                      ),
                                    ],),
                                  );
                                }));
                            }
                          }
                          return Text('');
                        }),
                    //-----------------------------
                  ],);
                }
              );
            }
          ),
        ),
      ),
    ],);
  }
}
