import 'package:etmaen/core/ui/app_back.dart';
import 'package:etmaen/core/ui/app_button.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/home/pages/payment/payment_success_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final formKey = GlobalKey<FormState>();

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool showBackView = false;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 8.r),
          child: Column(
            children: [
              Row(
                children: [
                  AppBack(),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    'اضافة بطاقة جديدة',
                    style: AppStyle.regular20,
                  ),
                ],
              ),

              SizedBox(
                height: 10.h,
              ),

              CreditCardWidget(
                isHolderNameVisible: true,
                cardBgColor: AppColors.primiryColor,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: showBackView,
                onCreditCardWidgetChange: (value) {},
              ),
              Container(
                padding: EdgeInsets.all(20.r),
                height: 382.h,
                width: 340.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.avatarColor,
                ),
                child: Column(
                  children: [
                    CreditCardForm(
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      onCreditCardModelChange: (model) {
                        setState(() {
                          cardNumber = model.cardNumber;
                          expiryDate = model.expiryDate;
                          cvvCode = model.cvvCode;
                          cardHolderName = model.cardHolderName;
                          showBackView = model.isCvvFocused;
                        });
                      },
                      formKey: formKey,
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            activeColor: AppColors.primiryColor,
                            checkColor: AppColors.whiteColor,
                            value: isChecked,
                            onChanged: (value) {
                              isChecked = value!;

                              setState(() {});
                            },
                          ),
                        ),
                        Text(
                          'حفظ بيانات البطاقة',
                          style: AppStyle.bold12.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              AppButton(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => PaymentSuccessScreen(),
                    ),
                  );
                },
                title: 'دفع',
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
