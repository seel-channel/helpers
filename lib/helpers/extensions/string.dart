import 'package:helpers/helpers.dart';

const kNumbersString = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
const String kDiacriticsString =
    'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
const String kNonDiacriticsString =
    'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

extension StringHelperExtension on String {
  String removeDiacriticalMarks() {
    return splitMapJoin(
      '',
      onNonMatch: (char) => char.isNotEmpty && kDiacriticsString.contains(char)
          ? kNonDiacriticsString[kDiacriticsString.indexOf(char)]
          : char,
    );
  }

  String removeLastWord([int amount = 1]) {
    final int cacheLenght = length;
    if (cacheLenght > amount) {
      return substring(0, cacheLenght - amount);
    } else {
      return "";
    }
  }

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

  String censorEmail({int begin = 4, int end = 4, int asterisks = 4}) {
    final int count = length;
    final StringBuffer censor = StringBuffer();
    asterisks.forEach((_) => censor.write("*"));

    if (count >= begin + end) {
      return "${substring(0, begin)}${censor.toString()}${substring(count - end, count)}";
    }
    return this;
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
