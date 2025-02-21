import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_text_field.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/address/services/address_services.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pay/pay.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, required this.totalAmount});
  static const String routeName = "/addresss";
  final String totalAmount;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  final _addressFromKey = GlobalKey<FormState>();

  List<PaymentItem> paymentItems = [];
  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: "Total Amount",
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  final Future<PaymentConfiguration> _applePayConfiguration =
      PaymentConfiguration.fromAsset('gpay.json');

  String addressToBeUsed = "";
  final AddressServices addressServices = AddressServices();

  void onGpayResult(Map<String, dynamic> res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, userAddress: addressToBeUsed);
    }
  }

  void checker(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFromKey.currentState!.validate()) {
        addressToBeUsed =
            "${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}";
      } else {
        throw Exception("Please Enter all the values");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, "Error AA GAYA! Form DHANG SE BHAR");
      return;
    }
    // showSnackBar(context, addressToBeUsed);
    if (isForm) {
      addressServices.saveUserAddress(
          context: context, userAddress: addressToBeUsed);
      showSnackBar(context,
          Provider.of<UserProvider>(context, listen: false).user.address);
      // showSnackBar(context, addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        addresss: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFromKey.currentState!.validate()) {
        addressToBeUsed =
            "${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}";
      } else {
        throw Exception("Please Enter all the values");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
      if (Provider.of<UserProvider>(context).user.address.isEmpty) {
        addressServices.saveUserAddress(
            context: context, userAddress: addressToBeUsed);
        showSnackBar(context, Provider.of<UserProvider>(context).user.address);
      }
    } else {
      showSnackBar(context, "Error AA GAYA! Form DHANG SE BHAR");
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = Provider.of<UserProvider>(context).user.address;

    // address = P;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (address.isNotEmpty)
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        address,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "OR",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8),
              child: Form(
                key: _addressFromKey,
                child: Column(
                  children: [
                    CustomTextField(
                      textEditingController: flatBuildingController,
                      hint: "Flat, House no, Building",
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                        textEditingController: areaController,
                        hint: "Area, Street"),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      textEditingController: pincodeController,
                      hint: "Pincode",
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      textEditingController: cityController,
                      hint: "Town/City",
                    ),
                  ],
                ),
              ),
            ),
            // FutureBuilder<PaymentConfiguration>(
            //   future: _applePayConfiguration,
            //   builder: (context, snapshot) => snapshot.hasData
            //       ? ApplePayButton(
            //           paymentConfiguration: snapshot.data!,
            //           paymentItems: paymentItems,
            //           style: ApplePayButtonStyle.automatic,
            //           type: ApplePayButtonType.buy,
            //           margin: const EdgeInsets.only(top: 15.0),
            //           onPaymentResult: (payDetail) {
            //             onApplePayResult();
            //           },
            //           loadingIndicator: const Center(
            //             child: CircularProgressIndicator(
            //               color: Colors.black,
            //             ),
            //           ),
            //           width: double.infinity,
            //           height: double.infinity,
            //         )
            //       : const CircularProgressIndicator(
            //           color: Colors.black,
            //         ),
            // ),
            FutureBuilder<PaymentConfiguration>(
              future: _applePayConfiguration,
              builder: (context, snapshot) => snapshot.hasData
                  ? GooglePayButton(
                      onPressed: () {
                        payPressed(address);
                      },
                      paymentConfiguration: snapshot.data!,
                      paymentItems: paymentItems,
                      type: GooglePayButtonType.buy,
                      margin: const EdgeInsets.only(top: 15.0),
                      onPaymentResult: (val) {
                        onGpayResult(val);
                      },
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                      width: double.infinity,
                    )
                  : const CircularProgressIndicator(
                      color: Colors.black,
                    ),
            ),
            CustomButton(
                text: "Checker",
                onTap: () {
                  checker(address);
                })
          ],
        ),
      ),
    );
  }
}
