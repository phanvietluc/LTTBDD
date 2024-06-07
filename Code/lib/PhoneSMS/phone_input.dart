import 'package:flutter/material.dart';
import 'phone_sms.dart';
class PhoneInput extends StatefulWidget {
  const PhoneInput({super.key});

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  TextEditingController txtPhone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Call"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: txtPhone,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "SMS"
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      openPhoneDial(txtPhone.text);
                    },
                    child: Text("Gọi")
                ),
                SizedBox(width: 50,),
                ElevatedButton(
                    onPressed: () {
                      openSMS(txtPhone.text);
                    },
                    child: Text("Nhắn tin")
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
