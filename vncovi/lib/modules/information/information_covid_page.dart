import 'package:flutter/material.dart';
import 'package:vncovi/components/bottomnav.dart';
import 'package:vncovi/components/header/header.dart';
import 'package:vncovi/components/my_drawer.dart';
import 'package:vncovi/modules/Injections/injections_page.dart';
import 'package:vncovi/modules/information/widgets/prevent_card.dart';
import 'package:vncovi/modules/information/widgets/symptom_card.dart';
import 'package:vncovi/themes/app_assets.dart';
import 'package:vncovi/themes/app_colors.dart';
import 'package:vncovi/themes/app_styles.dart';

class InformationCovidPage extends StatelessWidget {
  InformationCovidPage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Header(
              image: AppAssets.coronadr,
              textTop: "Thông tin cần biết",
              textBottom: "về Covid-19.",
              onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Triệu chứng thường gặp",
                    style: AppStyle.kTitleTextStyle,
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        SymptomCard(
                          image: AppAssets.headache,
                          title: "Đau đầu",
                          isActive: true,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SymptomCard(
                          image: AppAssets.caugh,
                          title: "Ho",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SymptomCard(
                          image: AppAssets.fever,
                          title: "Sốt",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SymptomCard(
                          image: "assets/images/caugh.png",
                          title: "Mất vị giác",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SymptomCard(
                          image: "assets/images/fever.png",
                          title: "Mất khứu giác",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text("Phòng ngừa Covid-19",
                          style: AppStyle.kTitleTextStyle),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const InjectionsPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Thông tin vaccine",
                          style: TextStyle(
                            color: AppColor.kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const PreventCard(
                    text:
                        "Kể từ khi bắt đầu bùng phát virus coronavirus, một số nơi đã hoàn toàn chấp nhận đeo khẩu trang",
                    image: "assets/images/wear_mask.png",
                    title: "Đeo khẩu trang",
                  ),
                  const PreventCard(
                    text:
                        " Dung dịch sát khuẩn có cồn có thể gây ngộ độc nếu uống, nuốt. Nên để xa tầm tay trẻ nhỏ và giám sát việc sử dụng.",
                    image: "assets/images/wash_hands.png",
                    title: "Rửa tay bằng dung dịch sát khuẩn",
                  ),
                  const PreventCard(
                    text:
                        "Kể từ khi bắt đầu bùng phát virus coronavirus, một số nơi đã hoàn toàn chấp nhận đeo khẩu trang",
                    image: "assets/images/wear_mask.png",
                    title: "Giữ khoảng cách và không tụ tập nơi đông người",
                  ),
                  const PreventCard(
                    text:
                        " Dung dịch sát khuẩn có cồn có thể gây ngộ độc nếu uống, nuốt. Nên để xa tầm tay trẻ nhỏ và giám sát việc sử dụng.",
                    image: "assets/images/wash_hands.png",
                    title: "Khai báo y tế",
                  ),
                  const PreventCard(
                    text:
                        " Dung dịch sát khuẩn có cồn có thể gây ngộ độc nếu uống, nuốt. Nên để xa tầm tay trẻ nhỏ và giám sát việc sử dụng.",
                    image: "assets/images/wash_hands.png",
                    title: "Tiêm Vaccine",
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(
        activeButtonIndex: 1,
      ),
    );
  }
}
