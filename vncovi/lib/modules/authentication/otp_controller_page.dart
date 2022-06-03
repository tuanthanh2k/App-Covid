import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:vncovi/modules/home/home_page.dart';
import 'package:vncovi/repository/account_repo.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key, required this.phone, required this.codeDigits})
      : super(key: key);
  final String phone;
  final String codeDigits;

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPController = TextEditingController();
  final FocusNode _pinOTPFocus = FocusNode();
  String? varificationCode;

  final BoxDecoration pinOTPDecoration = BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.grey,
      ));

  @override
  void initState() {
    super.initState();
    verifyPhoneNumber();
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child:
                      Text('Verifying: ${widget.codeDigits}-${widget.phone}'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: PinPut(
                fieldsCount: 6,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
                eachFieldWidth: 40,
                eachFieldHeight: 55,
                submittedFieldDecoration: pinOTPDecoration,
                selectedFieldDecoration: pinOTPDecoration,
                followingFieldDecoration: pinOTPDecoration,
                pinAnimationType: PinAnimationType.rotation,
                focusNode: _pinOTPFocus,
                controller: _pinOTPController,
                onSubmit: (pin) async {
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(
                      PhoneAuthProvider.credential(
                          verificationId: varificationCode!, smsCode: pin),
                    )
                        .then((value) {
                      if (value.user != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
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
          ],
        ),
      ),
    );
  }
}
