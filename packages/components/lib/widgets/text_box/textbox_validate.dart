import 'dart:async';

class TextBoxValidate {
  var textController = StreamController<String?>();
  Stream<String?> get textStream => textController.stream;

  void dispose() {
    textController.close();
  }

  //
  void email(String? text) {
    final RegExp regExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );
    if (text == null) {
    } else if (!regExp.hasMatch(text)) {
      textController.sink.addError("Invalid format");
    } else {
      textController.sink.add(text);
    }
  }

  //
  void address(String? text) {
    if (text == null) {
    } else if (text.isEmpty) {
    } else if (text.length < 5) {
      textController.sink.addError("Text is too short");
    } else {
      textController.sink.add(text);
    }
  }

  //
  void name(String? text) {
    if (text == null) {
      textController.sink.addError("*Required Field");
    } else if (text.isEmpty) {
      textController.sink.addError("Text Field is Empty");
    } else if (text.length < 4) {
      textController.sink.addError("Text is too short");
    } else {
      textController.sink.add(text);
    }
  }

//
  void password(String? text) {
    if (text == null) {
      textController.sink.addError("*Required Field");
    } else if (text.isEmpty) {
      textController.sink.addError("Text Field is Empty");
    } else if (text.length < 8) {
      textController.sink.addError("Text is too short");
    } else {
      textController.sink.add(text);
    }
  }

//
  void description(String? text) {
    if (text == null) {
      textController.sink.addError("*Required Field");
    } else if (text.isEmpty) {
      textController.sink.addError("Text Field is Empty");
    } else if (text.length < 10) {
      textController.sink.addError("Text is too short");
    } else {
      textController.sink.add(text);
    }
  }

  //
  void phone(String? value) {
    if (value == null) {
      textController.sink.addError("*Required Field");
    } else if (value.isEmpty) {
      textController.sink.addError("Text Field is Empty");
    } else {
      textController.sink.add(value);
    }
  }

  //
  void quantity(String? value) {
    if (value == null) {
      textController.sink.addError("*Required Field");
    } else if (value.isEmpty) {
      textController.sink.addError("Text Field is Empty");
    } else {
      textController.sink.add(value);
    }
  }

  //
  void price(String? value) {
    // textController.sink.add(value);
    // !
    if (value == null) {
      textController.sink.addError("*Required Field");
    } else if (value.isEmpty) {
      textController.sink.addError("Text Field is Empty");
    } else {
      textController.sink.add(value);
    }
    // !
  }

  //
  void optionPrice(String? value) {
    if (value == null) {
      textController.sink.add(value);
    } else if (value.isEmpty) {
      textController.sink.add(value);
    } else {
      textController.sink.add(value);
    }
  }

  //
  days(String? value) {
    if (value == null) {
      textController.sink.add(value);
    } else if (value.isEmpty) {
    } else {
      textController.sink.add(value);
    }
  }

  //
  textvalue(String? value) {
    if (value == null) {
      textController.sink.addError("*Required Field");
    } else if (value.isEmpty) {
      textController.sink.addError("Text Field is Empty");
    } else {
      textController.sink.add(value);
    }
  }
}
