import 'dart:io';
import 'dart:typed_data';

import 'package:doctor_v2/data/model/response_model.dart';
import 'package:doctor_v2/nurse_provider/auth_provider.dart';
import 'package:doctor_v2/provider/auth_provider.dart';
import 'package:doctor_v2/utill/color_resources.dart';
import 'package:doctor_v2/views/shared/background.dart';
import 'package:doctor_v2/views/ui_kits/snack_bar.dart';
import 'package:doctor_v2/views/ui_kits/ui_kits.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';

class UploadImageScreen extends StatefulWidget {
  UploadImageScreen({Key? key}) : super(key: key);

  @override
  _UploadImageScreenState createState() {
    return _UploadImageScreenState();
  }
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  var _width;

  ImagePicker _picker2 = ImagePicker();
  bool convertingImage = false;

  File? _imageFile2;
  XFile? _imageFile3;
  String? _imageFile;

  onImageButtonPressed(ImageSource source,
      {required BuildContext context, capturedImageFile}) async {
    final ImagePicker _picker = ImagePicker();
    File val;

    final pickedFile = await _picker.getImage(
      source: source,
    );

    val = (await ImageCropper.cropImage(
      sourcePath: pickedFile!.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      maxHeight: 700,
      maxWidth: 700,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: Colors.white,
        toolbarTitle: "SonoCare",
      ),
    ))!;
    print("cropper ${val.runtimeType}");
    print("path ${val.path}");
    setState(() {
      _imageFile2=val;
    });
    capturedImageFile(val.path);

  }

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
    _width = MediaQuery.of(context).size.width;

    // TODO: implement build
    return Stack(children: [
      DarkBackGround(),
      Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Upload Profile'),
        elevation: 0,
        leading: GestureDetector(
            onTap: ()=>Navigator.pop(context),
            child: Image.asset('assets/icons/back-arrow_icon.png')),
      ),
        backgroundColor: Colors.transparent,
        body: Consumer<NurseAuthProvider>(
            builder: (context, authProvider, child) {
            return ListView(children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () async {
                        XFile? _imageFile6 = await _picker2.pickImage(source: ImageSource.camera);
                        print(_imageFile6!.name);
                        setState(() {
                          _imageFile3 = _imageFile6;
                          convertingImage = true;
                          //_imageFile2 = File(_imageFile3!.path);
                          //_imageFile2 = Image.file(File(_imageFile3!.path))
                          //_imageFile = _imageFile3!.path;
                        });
                        _imageFile2 = await File(_imageFile3!.path);
                        setState(() {
                          _imageFile2=_imageFile2;
                          convertingImage=false;
                        });
                      },
                      child: convertingImage?
                      Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Text('Processing Image', style: TextStyle(color: Colors.white),),
                          )
                        ],
                      )
                          :_previewImage(context)),
                ],
              ),
              SizedBox(height: 30,),
              if(authProvider.isLoading)Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Colors.red,),],),
              if(!authProvider.isLoading)Padding(
                padding: const EdgeInsets.all(18.0),
                child: normalButton(
                    backgroundColor: ColorResources.COLOR_PURPLE_MID,
                    button_text: 'Update Profile',
                    primaryColor: ColorResources.COLOR_WHITE,
                    fontSize: 16,
                    onTap: () async {
                      String token = Provider.of<NurseAuthProvider>(context, listen: false).token;
                      authProvider.uploadProfileImage(_imageFile2!, token).then((ResponseModel responseModel){
                        if(responseModel.isSuccess){
                          showCustomSnackBar(responseModel.message, context, isError: false);
                          Navigator.pop(context);
                        }else{
                          showCustomSnackBar(responseModel.message, context, isError: true);
                        }
                      });
                    }),
              )
            ],);
          }
        ),
      )
    ],);
  }

  Widget _previewImage(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    if (_imageFile3 != null) {
      print('wwww');
      /*
      return Container(
        height: 300,//_width * 0.34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(300),
          ),
          color: Colors.grey,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(300),
          child: Image.file(
            _imageFile2!,
            //"${_imageFile}",
            height: 300,//_width * 0.34,
            width: 300,//_width,
            alignment: Alignment.center,
            fit: BoxFit.fitWidth,
          ),
        ),
      );
      */
      return Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(300)),
          color: Colors.grey,

          image: DecorationImage(
            image: FileImage(_imageFile2!),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(300)),
                  color: ColorResources.COLOR_PURPLE_MID,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.camera_alt, size: 50, color: Colors.white,),
                )),
          ],
        ),
      );
    } else {
      /*
      return Container(
        height: 300,//_width * 0.34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(300),
          ),
          color: Colors.grey,
        ),
        child: Center(
          child: Image.asset(
            'assets/dummy/profile_dummy.png',
            width: 300,
            height: 300,
          ),
        ),
      );
      */
      return Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(300)),
          color: Colors.white,

          /*
          image: DecorationImage(
            image: AssetImage("assets/dummy/profile_dummy.png"),
            fit: BoxFit.cover,
          ),
          */
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(300)),
                  color: ColorResources.COLOR_PURPLE_MID,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.camera_alt, size: 50, color: Colors.white,),
                )),
          ],
        ),
      );
    }
  }
}








