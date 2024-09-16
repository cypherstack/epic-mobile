extension StringExtensions on String {
  String capitalize() {
    if (length == 1) {
      return toUpperCase();
    } else if (length > 1) {
      return "${substring(0, 1).toUpperCase()}${substring(1)}";
    } else {
      return this;
    }
  }
}
