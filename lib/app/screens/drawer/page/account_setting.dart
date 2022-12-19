import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';
import 'dart:math' as math;

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  Map<String, dynamic> data = {"emoji": "🇯🇵", "code": "+81"};
  Uint8List? _image;
  // Map<String, dynamic>? dataResult;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    // TODO
    setState(() {
      emailController.text = "Sudesh Bandara";
      passwordController.text = '';
      nameController.text = '';
      phoneController.text = '';
    });
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    if (mounted) {
      setState(() => _image = im);
    }
  }

  void update() {
    //  if (_image != null) {
    //       String photoUrl = await StorageMethods()
    //           .uploadImageToStorage('profilePics', _image!, false);
    //       users.doc(userData['uid']).update({'photoUrl': photoUrl});
    //     }
  }

  void getPhoneNumberData(String code, String emoji) {
    setState(() {
      data = {"emoji": emoji, "code": code};
    });
  }

  Container buildPhoneNumber() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(top: 2.w),
      decoration: BoxDeco.deco_5,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: showCuntryPicker,
            child: Row(
              children: [
                Text(data['emoji'], style: TxtStyle.b5B),
                SizedBox(width: 2.w),
                const Icon(Icons.keyboard_arrow_down_rounded),
                SizedBox(width: 2.w),
                Container(
                  width: 2,
                  height: 10.w,
                  color: AppColor.divider,
                )
              ],
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: TextFormField(
              controller: phoneController,
              style: TxtStyle.b5,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List countryCode = [
    {"name": "Japan", "dial_code": "+81", "emoji": "🇯🇵", "code": "JP"},
    {"name": "Sri Lanka", "dial_code": "+94", "emoji": "🇱🇰", "code": "LK"}
  ];
  void showCuntryPicker() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 20.h,
          margin: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: AppColor.white,
          ),
          child: Center(
            child: Column(
                children: countryCode
                    .map((e) => ListTile(
                          onTap: () {
                            getPhoneNumberData(e['dial_code'], e['emoji']);
                            Navigator.pop(context);
                          },
                          leading: Text(e['emoji']),
                          title: Text(e['name']),
                          trailing: Text(e['dial_code']),
                        ))
                    .toList()),
            // child: ShearchCountry(onTap: getPhoneNumberData),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'Account settings'),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(top: 5.w),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(4.w),
                width: double.infinity,
                decoration: BoxDeco.deco_2,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(radius: 10.h),
                    _image != null
                        ? CircleAvatar(
                            radius: 10.h,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 10.h,
                            backgroundImage: const NetworkImage('userData['),
                          ),
                    CustomPaint(
                      painter: MyPainter(),
                      size: Size(10.h, 10.h),
                    ),
                    Positioned(
                      top: 15.h,
                      child: InkWell(
                        onTap: selectImage,
                        child: SvgPicture.asset(
                          AppIcon.camera,
                          color: AppColor.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5.w),
              Text('Personal Information', style: TxtStyle.h7B),
              SizedBox(height: 2.w),
              _TextInput(controller: emailController, lable: 'Email'),
              SizedBox(height: 2.w),
              _TextInput(controller: nameController, lable: 'Full Name'),
              SizedBox(height: 2.w),
              buildPhoneNumber(),
              SizedBox(height: 2.w),
              Text('Password', style: TxtStyle.h7B),
              SizedBox(height: 2.w),
              _TextInput(controller: passwordController, lable: 'Password'),
              SizedBox(height: 2.w),
            ],
          )),
      bottomNavigationBar: bottomNavigationBar(
        onTap: () {
          // TODO
        },
        text: 'Save changes',
      ),
    );
  }
}

//
class _TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String lable;
  const _TextInput({Key? key, required this.controller, required this.lable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 13.h,
      padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(top: 2.w),
      decoration: BoxDeco.deco_5,
      child: TextFormField(
        controller: controller,
        style: TxtStyle.b5,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.black.withOpacity(0.5);
    // Paint paint2 = Paint()..color = Colors.green.withOpacity(0.2);
    var center = Offset(size.height / 2, size.width / 2);
    var drawArc = Rect.fromCenter(
        center: center, height: size.height * 2, width: size.width * 2);
    // canvas.drawCircle(center, size.width, paint2);

    canvas.drawArc(drawArc, -math.pi * 5.9, math.pi * 0.8, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
