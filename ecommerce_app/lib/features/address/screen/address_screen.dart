import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/features/address/services/address_services.dart';
import 'package:ecommerce_app/features/address/widgets/address_form_fieled.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = "/address-screen";
  final String amount;

  const AddressScreen({super.key, required this.amount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressFormKey = GlobalKey<FormState>();
  final AddressServices addressServices = AddressServices();

  final TextEditingController flatBuildingController =
      TextEditingController();
  final TextEditingController areaController =
      TextEditingController();
  final TextEditingController pincodeController =
      TextEditingController();
  final TextEditingController cityController =
      TextEditingController();

  String addressToBeUsed = "";
  late Future<PaymentConfiguration> _googlePayConfigFuture;

  // ---------------- ADDRESS VALIDATION ----------------

  bool _prepareAddress(String addressFromProvider) {
    addressToBeUsed = "";

    final isFormFilled =
        flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isFormFilled) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, '
            '${areaController.text}, '
            '${pincodeController.text}, '
            '${cityController.text}';
        return true;
      } else {
        showSnackBar("Please fill all address fields", context);
        return false;
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
      return true;
    } else {
      showSnackBar("Please enter or select an address", context);
      return false;
    }
  }

  // ---------------- PAYMENT RESULT ----------------

  void _onPaymentResult(Map<String, dynamic> result) {
    debugPrint("PAYMENT RESULT: $result");

    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    if (userProvider.user.address.isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
    }

    // 👉 NEXT: place order, clear cart, navigate success screen
  }

  // ---------------- INIT ----------------

  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture = PaymentConfiguration.fromAsset(
      'gpay.json',
    );
  }

  @override
  void dispose() {
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    super.dispose();
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    final address = context.watch<UserProvider>().user.address;

    final paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: widget.amount,
        status: PaymentItemStatus.final_price,
      ),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          title: const Text("Checkout"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addressFormKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // -------- SAVED ADDRESS --------
                if (address.isNotEmpty)
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "OR",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),

                const SizedBox(height: 20),

                // -------- ADDRESS FORM --------
                AddressFormFieled(
                  hintText: "House no, Flat, Building",
                  controller: flatBuildingController,
                ),
                const SizedBox(height: 15),
                AddressFormFieled(
                  hintText: "Area, Street",
                  controller: areaController,
                ),
                const SizedBox(height: 15),
                AddressFormFieled(
                  hintText: "Pincode",
                  controller: pincodeController,
                ),
                const SizedBox(height: 15),
                AddressFormFieled(
                  hintText: "City",
                  controller: cityController,
                ),

                const SizedBox(height: 40),

                // -------- GOOGLE PAY BUTTON --------
                FutureBuilder<PaymentConfiguration>(
                  future: _googlePayConfigFuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    return GooglePayButton(
                      paymentConfiguration: snapshot.data!,
                      paymentItems: paymentItems,
                      type: GooglePayButtonType.buy,
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.only(top: 10),
                      onPressed: () {
                        final ok = _prepareAddress(address);
                        if (!ok) return;
                      },
                      onPaymentResult: _onPaymentResult,
                      loadingIndicator:
                          const CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
