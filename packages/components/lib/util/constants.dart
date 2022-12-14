import 'package:components/components.dart';
import 'package:flutter/material.dart';

//
itemsFound({required int number}) {
  if (0 == number) {
    return Text('not found items', style: TxtStyle.itemsFound);
  } else if (1 < number) {
    return Text('found $number items', style: TxtStyle.itemsFound);
  } else {
    return Text('found a 1 items', style: TxtStyle.itemsFound);
  }
}

// for picking up image from gallery
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
}
