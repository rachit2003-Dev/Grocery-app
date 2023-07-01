import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/screens/onboard_screen.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    bool _validPhoneNumber = false;
    var _phoneNumberController = TextEditingController();

    void showBottomSheet(context) {
      showModalBottomSheet(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, StateSetter myState) {
            // var _phoneNumberController = TextEditingController();
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'LOGIN',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Enter your phone number to proceed',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          prefixText: '+91',
                          labelText: '10 digit mobile number',
                          labelStyle:
                              const TextStyle(color: Colors.deepOrangeAccent),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepOrangeAccent),
                          )),
                      autofocus: true,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      controller: _phoneNumberController,
                      onChanged: (value) {
                        if (value.length == 10) {
                          myState(() {
                            _validPhoneNumber = true;
                          });
                        } else {
                          myState(() {
                            _validPhoneNumber = false;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AbsorbPointer(
                            absorbing: _validPhoneNumber ? false : true,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: _validPhoneNumber
                                    ? Colors.deepOrangeAccent
                                    : Colors.grey,
                              ),
                              child: Text(
                                _validPhoneNumber
                                    ? 'CONTINUE'
                                    : 'ENTER PHONE NUMBER',
                              ),
                              onPressed: () {
                                String number =
                                    '+91${_phoneNumberController.text}';
                                auth.verifyPhone(context, number);
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: OnBoardScreen(),
                ),
                const Text(
                  'Ready to order your Favourite drink',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                  child: const Text(
                    'SET DELIVERY LOCATION',
                  ),
                  onPressed: () {},
                ),
                TextButton(
                  child: RichText(
                    text: const TextSpan(
                        text: 'Already a Customer ? ',
                        style: TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrangeAccent))
                        ]),
                  ),
                  onPressed: () {
                    showBottomSheet(context);
                  },
                ),
              ],
            ),
            Positioned(
              right: 0.0,
              top: 10.0,
              child: TextButton(
                child: const Text(
                  'SKIP',
                  style: TextStyle(color: Colors.deepOrangeAccent),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
