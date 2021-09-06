const kNumbersString = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
const String kDiacriticsString =
    'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
const String kNonDiacriticsString =
    'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

extension StringHelperExtension on String {
  String get removeDiacriticalMarks => splitMapJoin('',
      onNonMatch: (char) => char.isNotEmpty && kDiacriticsString.contains(char)
          ? kNonDiacriticsString[kDiacriticsString.indexOf(char)]
          : char);

  String capitalizeFirstWordFromSentence() {
    return isNotEmpty
        ? "${this[0].toUpperCase()}${substring(1, length).toLowerCase()}"
        : this;
  }

  String removeAllNotNumber({List<String> exclude = const []}) {
    final List<String> valid = kNumbersString.toList()..addAll(exclude);
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < length; i++) {
      final String character = this[i];
      if (valid.contains(character)) buffer.write(character);
    }
    return buffer.toString();
  }

  String removeAllNumbers({List<String> include = const []}) {
    final List<String> invalid = kNumbersString.toList()..addAll(include);
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < length; i++) {
      final String character = this[i];
      if (!invalid.contains(character)) buffer.write(character);
    }
    return buffer.toString();
  }
}
