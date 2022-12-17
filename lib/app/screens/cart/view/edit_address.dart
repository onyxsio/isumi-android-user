import 'package:flutter/material.dart';
import 'package:isumi/app/models/ship_to.dart';
import 'package:onyxsio/onyxsio.dart';

class EditAddress extends StatefulWidget {
  final ShipTo? shipTo;
  const EditAddress({Key? key, this.shipTo}) : super(key: key);

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  var name = TextEditingController();
  var street = TextEditingController();
  var city = TextEditingController();
  var state = TextEditingController();
  var postalCode = TextEditingController();

  @override
  void initState() {
    checkAvailableData();
    super.initState();
  }

  checkAvailableData() {
    if (widget.shipTo != null) {
      if (mounted) return;
      setState(() {
        name.text = widget.shipTo!.name;
        street.text = widget.shipTo!.street;
        city.text = widget.shipTo!.city;
        postalCode.text = widget.shipTo!.postalCode;
        state.text = widget.shipTo!.state;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'Add a shipping address'),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(top: 10.w),
          child: Column(
            children: [
              _InputFeild(hint: 'Full name', controller: name),
              _InputFeild(hint: 'Address Line', controller: street),
              _InputFeild(hint: 'State', controller: state),
              _InputFeild(hint: 'City', controller: city),
              _InputFeild(
                  hint: 'Zipcode (Postal Code)', controller: postalCode),
            ],
          )),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(bottom: 3.h),
        child: MainButton(text: 'Save Address', onTap: addDataTODatabase),
      ),
    );
  }

  void addDataTODatabase() async {
    Address address = Address(
      name: name.text,
      streetAddress: street.text,
      state: state.text,
      city: city.text,
      postalCode: postalCode.text,
    );
    await FirestoreRepository.setupAddress(address).then((value) {
      if (value == 'done') {
        DBox.autoClose(context,
            type: InfoDialog.successful,
            message: 'The address has been saved successfully.');
        clear();
      } else {
        DBox.autoClose(context, type: InfoDialog.error, message: value);
      }
    });
  }

  void clear() {
    name.clear();
    city.clear();
    postalCode.clear();
    street.clear();
    state.clear();
  }
}

class _InputFeild extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const _InputFeild({Key? key, required this.hint, required this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 15.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.w),
      margin: EdgeInsets.only(bottom: 5.w),
      decoration: BoxDeco.deco_5,
      child: Center(
        child: TextFormField(
          controller: controller,
          minLines: 1,
          maxLines: 5,
          // expands: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            hintText: hint,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
