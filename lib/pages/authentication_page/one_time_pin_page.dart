import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:megacloud/pages/home_page/home_page.dart';
import 'package:megacloud/shared_widgets/mega_cloud_logo.dart';
import 'package:megacloud/globals.dart' as globals;
import 'package:pin_code_fields/pin_code_fields.dart';

class OneTimePinPage extends StatefulWidget {
  const OneTimePinPage({Key? key}) : super(key: key);

  @override
  _OneTimePinPageState createState() => _OneTimePinPageState();

  static route() {
    return MaterialPageRoute(builder: (context) => const OneTimePinPage());
  }
}

class _OneTimePinPageState extends State<OneTimePinPage> {
  bool isDisable = false;
  bool isDisableResend = false;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 45;
  int time = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const numberTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Color(0xff2e2e2e),
      fontSize: 15,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    );

    return Scaffold(
      body: Row(
        children: [
          const Spacer(flex: 1),
          Expanded(
            flex: 10,
            child: Column(
              children: [
                // Например Еще один вариант SafeArea для top
                // чтобы уменьшить nesting widgets (но зависит от ситуации)
                // возможно SafeArea лучше если надо учитывать bottom, left, right
                SizedBox(height: MediaQuery.of(context).padding.top),
                const Spacer(flex: 2),
                const MegaCloudLogo(),
                const Spacer(flex: 2),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "enter_sms",
                    style: numberTextStyle,
                  ).tr(),
                ),
                const Spacer(flex: 1),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'sms_send_to',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ).tr(args: [globals.phone]),
                ),
                const Spacer(flex: 1),
                Row(
                  children: [
                    const Spacer(flex: 2),
                    Expanded(
                      flex: 5,
                      child: Form(
                        child: PinCodeTextField(
                          onChanged: _onPinCodeChange,
                          pinTheme: PinTheme(
                            inactiveColor: Colors.grey,
                            activeColor: const Color(0xFF71C343),
                            selectedColor: const Color(0xFF71C343),
                          ),
                          cursorColor: const Color(0xFF71C343),
                          keyboardType: TextInputType.number,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          appContext: context,
                          length: 4,
                        ),
                      ),
                    ),
                    const Spacer(flex: 2)
                  ],
                ),
                CountdownTimer(
                  endTime: endTime,
                  widgetBuilder: (_, time) {
                    if (time == null) {
                      return Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_rounded,
                            color: Colors.red,
                          ),
                          const Text(
                            'time_over',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ).tr(),
                        ],
                      );
                    }
                    return const Text(
                      'code_remain',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ).tr(args: ['${time.min ?? 0}', '${time.sec}']);
                  },
                  onEnd: () {
                    setState(() {
                      isDisableResend = true;
                    });
                  },
                ),
                const Spacer(flex: 1),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isDisable
                        ? () {
                            Navigator.of(context)
                                .pushReplacement(HomePage.route());
                          }
                        : null,
                    child: const Text(
                      'next',
                      style: TextStyle(color: Colors.white),
                    ).tr(),
                  ),
                ),
                const Spacer(flex: 1),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.grey,
                    textStyle: const TextStyle(
                      color: Color(0xFF97D3FF),
                      fontSize: 14,
                    ),
                  ),
                  onPressed: isDisableResend ? _resendOneTimePin : null,
                  child: const Text('send_again').tr(),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      // color: Color(0xFF97D3FF),
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'warning_enter',
                    style: TextStyle(color: Colors.blue),
                  ).tr(),
                ),
                const Spacer(flex: 11),
              ],
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }

  void _onPinCodeChange(pinCode) {
    if (pinCode.length == 4) {
      setState(() {
        isDisable = true;
      });
    } else {
      setState(() {
        isDisable = false;
      });
    }
  }

  _resendOneTimePin() {
    // TODO: call 3rd party service
    setState(() {
      endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 90;
      isDisableResend = false;
    });
  }
}
