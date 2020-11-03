import 'package:meta/meta.dart';
import 'package:date_util/date_util.dart';

class Month {
  final int number;
  final int year;
  String name;
  int numberOfDays;

  Month({@required this.number, @required this.year}) {
    final dateUtil = DateUtil();
    name = dateUtil.month(number);
    numberOfDays = dateUtil.daysInMonth(number, year);
  }

  @override
  String toString() => '${name.substring(0, 3)} $year';

  @override
  bool operator ==(Object other) {
    return other is Month && '$this' == '$other';
  }

  @override
  int get hashCode => super.hashCode;
}
