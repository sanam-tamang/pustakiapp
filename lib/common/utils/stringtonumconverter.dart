class PustakiConverter {
  static double stringToDoubleDivideBy100(String number) {
    try {
      ///to get 0 or 1 base on the value
      return (double.parse(number)) / 100;
    } catch (e) {
      ///##if it throws error I still need to send 0 to make sure app doesnot crash for that
      ///reason I am throwing
      return 0;
    }
  }

  static double stringToDouble(String number) {
    try {
      ///to get 0 or 1 base on the value
      return double.parse(number);
    } catch (e) {
      ///##if it throws error I still need to send 0 to make sure app doesnot crash for that
      ///reason I am throwing
      return 0;
    }
  }
}
