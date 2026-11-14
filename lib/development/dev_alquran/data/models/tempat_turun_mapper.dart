import 'package:alquran_new/development/dev_alquran/domain/entities/tempat_turun.dart';

TempatTurun tempatTurunFromString(String value) {
  switch (value.toLowerCase()) {
    case 'madinah':
      return TempatTurun.madinah;
    default:
      return TempatTurun.mekah;
  }
}
