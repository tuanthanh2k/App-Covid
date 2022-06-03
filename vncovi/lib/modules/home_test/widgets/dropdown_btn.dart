import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vncovi/modules/home/blocs/state_of_dropdownbutton.dart';
import 'package:vncovi/modules/home_test/widgets/monitor_covid.dart';

class DropdownBtn extends StatefulWidget {
  const DropdownBtn({Key? key}) : super(key: key);

  @override
  _DropdownBtnState createState() => _DropdownBtnState();
}

class _DropdownBtnState extends State<DropdownBtn> {
  late StateOfDropdown _state;
  @override
  void initState() {
    _state = StateOfDropdown();
    super.initState();
    _state.getItemCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider<StateOfDropdown>(
        create: (_)=>_state,
        child: Consumer<StateOfDropdown>(
          builder: (context, model, child){
             String value = model.selected;
            // print(value);
            // _state.getCovidCountry1();
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    child: DropdownButton<String>(
                      hint: const Text("Not selected"),
                      value: value,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          // value = newValue!;
                          // print(value);
                          model.setselected(newValue!);
                          model.getCovidCountry1();
                        });
                      },
                      items: model.items!
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 100,),
                  SizedBox(
                    child: MonitorCovid(
                      cases: model.caseCovid,
                      active: model.activeCovid,
                      recovered: model.recoverCovid,
                      deaths: model.dealtCovid,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
