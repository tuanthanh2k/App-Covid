import 'package:flutter/material.dart';
import 'package:vncovi/repository/vaccination_repo.dart';

class Vaccination extends StatefulWidget {
  const Vaccination({Key? key}) : super(key: key);

  @override
  _VaccinationState createState() => _VaccinationState();
}

class _VaccinationState extends State<Vaccination> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<FormState> _key1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _key2 = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cccdController = TextEditingController();
  TextEditingController bhytController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController workplaceController = TextEditingController();
  TextEditingController ethnicController = TextEditingController();
  TextEditingController injectionsController = TextEditingController();
  TextEditingController injection_sessionController = TextEditingController();
  TextEditingController priority_groupController = TextEditingController();
  TextEditingController user_vaccinationController = TextEditingController();
  TextEditingController id_vaccineController = TextEditingController();

  int currentStep = 0;
  bool isComplete = false;

  String validateText(String? formText) {
    if (formText!.isEmpty) return 'Bắt buộc.';
    return '';
  }

  String validateEmail(String? formEmail) {
    if (formEmail!.isEmpty) return 'Email không để trống.';

    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail)) return 'Email không hợp lệ.';
    return '';
  }

  String validatePassword(String? formPassword) {
    if (formPassword!.isEmpty) return 'Chưa nhập mật khẩu.';
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formPassword))
      return '''
    Mật khẩu phải ít nhất 8 kí tự,
    bao gồm kí tự in hoa, số và kí tự đặc biệt.
    ''';
    return '';
  }

  List<Step> getSteps() => [
        Step(
            title: const Text('Thông tin chung'),
            content: Form(
              key: _key,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Họ tên',
                    ),
                    // validator: validateText,
                    controller: nameController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Giới tính',
                    ),
                    controller: genderController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Ngày sinh',
                    ),
                    controller: dobController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Số điện thoại',
                    ),
                    controller: phoneController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'CCCD',
                    ),
                    controller: cccdController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'BHYT',
                    ),
                    controller: bhytController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Địa chỉ',
                    ),
                    controller: addressController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            isActive: currentStep >= 0,
            state: currentStep > 0 ? StepState.complete : StepState.indexed),
        Step(
            title: const Text('Thông tin nghề nghiệp'),
            content: Form(
              key: _key1,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nghề nghiệp',
                    ),
                    controller: occupationController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nơi làm việc',
                    ),
                    controller: workplaceController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Dân tộc',
                    ),
                    controller: ethnicController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            isActive: currentStep >= 1,
            state: currentStep > 1 ? StepState.complete : StepState.indexed),
        Step(
            title: const Text('Thông tin đăng ký tiêm'),
            content: Form(
              key: _key2,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Loại Vaccine',
                    ),
                    controller: injectionsController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Buổi tiêm',
                    ),
                    controller: injection_sessionController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nhóm ưu tiên',
                    ),
                    controller: priority_groupController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'id user',
                    ),
                    controller: user_vaccinationController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Id vaccine',
                    ),
                    controller: id_vaccineController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            isActive: currentStep >= 2,
            state: currentStep > 2 ? StepState.complete : StepState.indexed),
      ];

  @override
  Widget build(BuildContext context) {
    final isLastStep = currentStep == getSteps().length - 1;
    return isComplete
        ? Container(
            child: ElevatedButton(
              onPressed: () async {
                // isComplete = false;
                // currentStep = 0;
              },
              child: Text('Reset'),
            ),
          )
        : Stepper(
            steps: getSteps(),
            type: StepperType.vertical,
            currentStep: currentStep,
            onStepContinue: () async {
              if (isLastStep) {
                if (_key.currentState!.validate()) {}
                // setState(() {
                //   isComplete = true;
                // });
                String name = nameController.text;
                String gender = genderController.text;
                String dob = dobController.text;
                String cccd = cccdController.text;
                String phone = phoneController.text;
                String bhyt = bhytController.text;
                String address = addressController.text;
                //
                String occupation = occupationController.text;
                String workplace = workplaceController.text;
                String ethnic = ethnicController.text;
                String injections = injectionsController.text;
                String injection_session = injection_sessionController.text;
                String priority_group = priority_groupController.text;
                String user_vaccination = user_vaccinationController.text;
                String id_vaccine = id_vaccineController.text;
                // await VaccinationPost()
                //     .postData(
                //         name,
                //         gender,
                //         dob,
                //         phone,
                //         cccd,
                //         bhyt,
                //         address,
                //         occupation,
                //         workplace,
                //         ethnic,
                //         injections,
                //         injection_session,
                //         priority_group,
                //         user_vaccination,
                //         id_vaccine)
                //     .then((value) => print(value));
                //send data to server
              } else {
                setState(() {
                  currentStep += 1;
                });
              }
            },
            onStepCancel: () {
              currentStep == 0
                  ? null
                  : setState(() {
                      currentStep -= 1;
                    });
            },
            onStepTapped: (step) => setState(
              () {
                currentStep = step;
              },
            ),
            controlsBuilder: (context, details) {
              return SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text(isLastStep ? 'Xác nhận' : 'Tiếp'),
                        onPressed: details.onStepContinue,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    if (currentStep != 0)
                      Expanded(
                        child: ElevatedButton(
                          child: Text('Quay lại'),
                          onPressed: details.onStepCancel,
                        ),
                      ),
                  ],
                ),
              );
            },
          );
  }
}
