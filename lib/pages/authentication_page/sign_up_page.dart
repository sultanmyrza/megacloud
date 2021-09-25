import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:megacloud/globals.dart' as globals;
import 'package:megacloud/shared_widgets/mega_cloud_logo.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();

  static Route<MaterialPage> route() {
    return MaterialPageRoute(builder: (context) => const SignUpPage());
  }
}

class _SignUpPageState extends State<SignUpPage> {
  var _isDisable = false;

  @override
  Widget build(BuildContext context) {
    const numberTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Color(0xff2e2e2e),
      fontSize: 15,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    );

    var numberInputDecoration = const InputDecoration(
      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
      hintText: " 555 45 45 45 ",
      counterText: "",
      contentPadding: EdgeInsets.symmetric(vertical: 2),
      isDense: true, // and add this line
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    );

    var connectButtonStyle = TextButton.styleFrom(
      textStyle: const TextStyle(fontSize: 14),
    );

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            const Spacer(flex: 1),
            Expanded(
              flex: 10,
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  const MegaCloudLogo(),
                  const Spacer(flex: 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "enter_phone_number",
                      style: numberTextStyle,
                    ).tr(),
                  ),
                  const Spacer(flex: 1),
                  TextField(
                    onChanged: _onNumberChanged,
                    decoration: numberInputDecoration,
                    keyboardType: TextInputType.phone,
                    maxLength: 9,
                  ),
                  const Spacer(flex: 2),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('next').tr(),
                      onPressed: _isDisable
                          ? () {
                              // TODO: navigate to otp page
                            }
                          : null,
                    ),
                  ),
                  const Spacer(flex: 1),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: connectButtonStyle,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('back').tr(),
                    ),
                  ),
                  const Spacer(flex: 5),
                  ToggleSwitch(
                    initialLabelIndex: globals.initialIndex,
                    borderColor: const [Color(0xFFEAEAEA)],
                    minWidth: 40.0,
                    minHeight: 20.0,
                    cornerRadius: 4.0,
                    activeBgColors: const [
                      [Color(0xFFFFFFFF)],
                      [Color(0xFFFFFFFF)]
                    ],
                    activeFgColor: const Color(0xFF71C343),
                    inactiveBgColor: const Color(0xFFEAEAEA),
                    inactiveFgColor: const Color(0xFF8A8A8A),
                    totalSwitches: 2,
                    labels: const ['RU', 'KG'],
                    onToggle: (index) {
                      if (index == 0) {
                        context.setLocale(const Locale('ru', 'KG'));
                      } else {
                        context.setLocale(const Locale('ky', 'KG'));
                      }
                      setState(() {
                        globals.initialIndex = index;
                      });
                    },
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  void _onNumberChanged(text) {
    if (text.length == 9) {
      setState(() {
        globals.phone = text;
        _isDisable = true;
      });
    } else if (text.length < 9) {
      setState(() {
        _isDisable = false;
      });
    }
  }
}
