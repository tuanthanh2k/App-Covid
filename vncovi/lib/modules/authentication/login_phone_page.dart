import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:vncovi/modules/authentication/otp_controller_page.dart';
import 'package:vncovi/modules/home/home_page.dart';
import 'package:vncovi/modules/home_test/widgets/button_directional.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String dialCodeDigits = "+84";
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Center(child: Text('Phone OTP Authentication')),
              Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2)),
                width: 350,
                height: 55,
                child: Row(
                  children: [
                    CountryCodePicker(
                      onChanged: (country) {
                        setState(() {
                          dialCodeDigits = country.dialCode!;
                        });
                      },
                      initialSelection: "Việt Nam",
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      favorite: ["VN"],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 25,
                      color: Colors.black,
                      width: 2,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Số điện thoại",
                        ),
                        keyboardType: TextInputType.number,
                       // maxLength: 13,
                        controller: phoneController,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OTPPage(
                          codeDigits: dialCodeDigits,
                          phone: phoneController.text,
                        ),
                      ),
                    );
                  },
                  child: Text('OTP'))
              // ButtonDirectional(
              //   label: 'Home',
              //   //  widget: HomePage(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
