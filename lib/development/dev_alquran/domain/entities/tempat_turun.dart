enum TempatTurun { mekah, madinah }

extension TempatTurunX on TempatTurun {
  String get label {
    switch (this) {
      case TempatTurun.mekah:
        return 'Mekah';
      case TempatTurun.madinah:
        return 'madinah';
    }
  }
}
