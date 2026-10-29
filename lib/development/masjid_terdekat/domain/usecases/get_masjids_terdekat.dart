import 'package:alquran_new/development/masjid_terdekat/domain/entities/masjid.dart';
import 'package:alquran_new/development/masjid_terdekat/domain/repositories/masjid_repository.dart';

class GetMasjidsTerdekat {
  final MasjidRepository repository;

  GetMasjidsTerdekat(this.repository);

  Future<List<Masjid>> call(double lat, double lng, int radius) async {
    return await repository.getMasjidsTerdekat(lat, lng, radius);
  }
}
