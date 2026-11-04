import 'package:alquran_new/development/masjid_terdekat/domain/entities/masjid.dart';
import 'package:alquran_new/development/masjid_terdekat/domain/repositories/masjid_repository.dart';
import 'package:alquran_new/development/masjid_terdekat/data/datasources/masjid_remote_datasource.dart';

class MasjidRepositoryImpl implements MasjidRepository {
  final MasjidRemoteDatasource remoteDatasource;

  MasjidRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<Masjid>> getMasjidsTerdekat(
    double lat,
    double lng,
    int radius,
  ) async {
    final remoteModels = await remoteDatasource.fetchMasjidsTerdekat(
      lat,
      lng,
      radius,
    );
    return remoteModels.map((model) => model.toEntity()).toList();
  }
}
