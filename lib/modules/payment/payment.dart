// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../shared/components/components.dart';
import '../signin_screen/signin_screen.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var cardNumberController = TextEditingController();
  var cardHolderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 1- Icon
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: const Color(0XFF2CBBA9),
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
          ),
        ),
        // 2- App Bar Tittle
        title: defaultTextGabriola(
          text: 'Payment',
          fontSize: 35,
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1- Making Payment Photo
              Container(
                padding: const EdgeInsetsDirectional.only(
                  top: 60,
                  start: 40,
                ),
                alignment: Alignment.center,
                child: const Image(
                  image: AssetImage('assets/images/UI-UX-Photos/payment.png'),
                  width: 162,
                  height: 181,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              // 2- Making Form Fields
              // 2.1- Card Number
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 30,
                  end: 30,
                  bottom: 40,
                ),
                child: defaultTextFeild(
                  controller: cardNumberController,
                  type: TextInputType.number,
                  labelText: 'Card Number',
                  validFunction: (String? value) {
                    if (value!.isEmpty) {
                      return ('Card number mustn\'t be empty');
                    }
                    return null;
                  },
                  prefix: const AssetImage(
                    'assets/images/UI-UX-Icons/payment-page/card_number.png',
                  ),
                  opacity: const AlwaysStoppedAnimation(1),
                  borderRaduis: 20,
                ),
              ),
              // 2.1- Card Holder
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 30,
                  end: 30,
                  bottom: 80,
                ),
                child: defaultTextFeild(
                  controller: cardHolderController,
                  type: TextInputType.name,
                  labelText: 'Card Holder',
                  validFunction: (String? value) {
                    if (value!.isEmpty) {
                      return ('Card holder mustn\'t be empty');
                    }
                    return null;
                  },
                  prefix: const AssetImage(
                    'assets/images/UI-UX-Icons/payment-page/card_holder.png',
                  ),
                  borderRaduis: 20,
                ),
              ),
              // 3- Making Payment Button
              defaultButton(
                buttonFunction: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ),
                    );
                  }
                },
                buttonText: 'Pay Securely',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
