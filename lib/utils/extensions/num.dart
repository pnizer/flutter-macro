extension NumExtension on num {
  String toStringAsFixedIfHasDecimal(int fractionDigits) {
    String ending = "." + ("0" * fractionDigits);
    String resp = toStringAsFixed(fractionDigits);
    if (resp.endsWith(ending)) {
      return resp.substring(0, resp.length - (fractionDigits + 1));
    } else {
      return resp;
    }
  }
}
