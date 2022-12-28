class PhoneFormatHelper {
  static bool isPhoneNumberValid(String phone) {
    //return RegExp(r"010([0-9]{8})").hasMatch(phone);
    return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(phone);
  }

  static String converToPhoneForm(String phone) {
    var first = phone.substring(0, 3);
    var second = phone.substring(3, 7);
    var third = phone.substring(7);

    return "$first-$second-$third";
  }
}
