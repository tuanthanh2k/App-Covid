import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:vncovi/components/button_custom.dart';
import 'package:vncovi/modules/home/home_page.dart';
import 'package:vncovi/repository/account_repo.dart';
import 'package:vncovi/themes/app_assets.dart';
import 'package:vncovi/themes/app_colors.dart';
import 'package:vncovi/themes/app_styles.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key, required this.phone, required this.codeDigits})
      : super(key: key);
  final String phone;
  final String codeDigits;

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPController = TextEditingController();
  final FocusNode _pinOTPFocus = FocusNode();
  String? varificationCode;
  late bool isActiveVerification;

  final BoxDecoration pinOTPDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.grey,
      ));

  @override
  void initState() {
    super.initState();
    verifyPhoneNumber();
    isActiveVerification = false;
  }

  String? myUid;
  String? myPhone;

//String? token;
  verifyPhoneNumber() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    //print('Token user: $token ${token.runtimeType}');
    await auth.verifyPhoneNumber(
      phoneNumber: '${widget.codeDigits + widget.phone}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          if (value.user != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }
        });
      },
      verificationFailed: (FirebaseException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message.toString()),
            duration: const Duration(seconds: 3),
          ),
        );
      },
      codeSent: (String vID, int? resentToken) {
        setState(() {
          varificationCode = vID;
        });
        print('vID user: $vID');
      },
      codeAutoRetrievalTimeout: (String vID) {
        setState(() {
          varificationCode = vID;
        });
      },
      timeout: const Duration(
        seconds: 60,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0, //bỏ shadow
          backgroundColor: Colors.transparent,
          title: const Text(
            'Xác thực số điện thoại',
            style: AppStyle.kHeadingTextStyle,
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFF3383CD),
                  Color(0xFF11249F),
                ], begin: Alignment.topRight, end: Alignment.bottomLeft),
              ),
            ),
            Container(
              height: 350,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.virus),
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 190,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 90, right: 90),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                'Chúng tôi đã gửi SMS đến số điện thoại của bạn',
                            style: AppStyle.kSubTextStyle.copyWith(
                              color: AppColor.kBackgroundColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 90, right: 90),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: '${widget.phone}',
                            style: AppStyle.kSubTextStyle.copyWith(
                              color: AppColor.kSignColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: PinPut(
                          fieldsCount: 6,
                          textStyle: const TextStyle(
                            color: AppColor.kPrimaryColor,
                            fontSize: 25,
                          ),
                          eachFieldWidth: 50,
                          eachFieldHeight: 50,
                          submittedFieldDecoration: pinOTPDecoration,
                          selectedFieldDecoration: pinOTPDecoration,
                          followingFieldDecoration: pinOTPDecoration,
                          pinAnimationType: PinAnimationType.scale,
                          focusNode: _pinOTPFocus,
                          controller: _pinOTPController,
                          onSubmit: (pin) async {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithCredential(
                                PhoneAuthProvider.credential(
                                    verificationId: varificationCode!,
                                    smsCode: pin),
                              )
                                  .then((value) {
                                if (value.user != null) {
                                  Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => const HomePage(),
                                          ),
                                        )
                                      ;
                                }
                              });
                              await AccountRepo()
                                  .postAccountData(myUid!, myPhone!)
                                  .then((value) => print(value));
                            } catch (e) {
                              FocusScope.of(context).unfocus();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('OTP không hợp lệ'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyElevatedButton(
                          onPressed: () {
                            setState(() {
                              isActiveVerification = true;
                            });
                          },
                          child: Text(
                            'Xác thực',
                            style: AppStyle.kButtonTextStyle
                                .copyWith(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
