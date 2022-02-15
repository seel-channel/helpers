import 'package:helpers/helpers.dart';

extension MapMerging<K, V> on Map<K, V> {
  bool hasDifferencesWith(Map<K, V> value, {List<K> keys = const []}) {
    return Misc.hasMapDifference<K, V>(this, value, keys: keys);
  }
}
