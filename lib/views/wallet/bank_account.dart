import 'package:doctor_v2/data/model/account_model.dart';
import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/provider/wallet_provider.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/dashboard/dashboard_screen.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/normalButton.dart';
import 'package:doctor_v2/views/ui_kits/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankAccountScreen extends StatefulWidget {
  BankAccountScreen({Key? key}) : super(key: key);

  @override
  _BankAccountScreenState createState() {
    return _BankAccountScreenState();
  }
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  final bankNameController = TextEditingController();
  final accountNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final bankCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        DarkBackGround(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Bank Account Info'),
            elevation: 0,
            leading: GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: Image.asset('assets/icons/back-arrow_icon.png')),
          ),
          body: Consumer<WalletProvider>(
              builder: (context, walletProvider, child) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(children: [
                  TextField(
                    textInputAction: TextInputAction.next,
                    controller: bankNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Bank Name',
                      contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    textInputAction: TextInputAction.next,
                    controller: accountNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Account Name',
                      contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    controller: accountNumberController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Account Number',
                      contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    controller: bankCodeController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Bank Code',
                      contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  if(walletProvider.isLoading)Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
                  if(!walletProvider.isLoading)normalButton(
                      backgroundColor: ColorResources.COLOR_PURPLE_MID,
                      button_text: 'Submit',
                      primaryColor: ColorResources.COLOR_WHITE,
                      fontSize: 16, onTap: () async {
                        AccountInfoModel accountInfo = AccountInfoModel(
                            accountName: accountNameController.text,
                            accountNumber: accountNumberController.text,
                            bankCode: bankCodeController.text,
                            accountBank: bankNameController.text);
                        String token = Provider.of<AuthProvider>(context, listen: false).token;
                        //token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvc29ub2NhcmUuYXBwXC9hcGlcL2RvY3RvcmxvZ2luIiwiaWF0IjoxNjM2NjU2NjgzLCJleHAiOjIyMzY2NTY2ODMsIm5iZiI6MTYzNjY1NjY4MywianRpIjoidTgwdVJodURFOWZTdW9rdiIsInN1YiI6NDgsInBydiI6IjdmNzA2MmMzZDlkOTdhMjg3YjZkY2Y2NTkzNWFkNmRkZjJhNzI0N2YifQ.n4Y_JFoT3KgQtrrqIuztckXmbQ1xsl8gRGf5oEFXdN0';
                        await walletProvider.setAccount(token, accountInfo).then((ResponseModel response){
                          if(response.isSuccess){
                            showCustomSnackBar(response.message, context, isError: false);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DashboardScreen()),
                            );
                          }
                        });

                  })
                ],),
              );
            }
          ),
        ),
      ],
    );
  }
}