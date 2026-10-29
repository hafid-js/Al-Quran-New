import 'package:alquran_new/development/masjid_terdekat/domain/entities/masjid.dart';

abstract class MasjidRepository {
  Future<List<Masjid>> getMasjidsTerdekat(double lat, double lng, int radius);
}
