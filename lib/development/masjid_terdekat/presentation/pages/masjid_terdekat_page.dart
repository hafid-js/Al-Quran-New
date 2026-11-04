import 'dart:async';

import 'package:alquran_new/core/constants/app_colors.dart';
import 'package:alquran_new/core/services/injection_container.dart';
import 'package:alquran_new/core/widgets/loading.dart';
import 'package:alquran_new/core/widgets/maps_loading.dart';
import 'package:alquran_new/development/home/controllers/prayer_time_controller.dart';
import 'package:alquran_new/development/masjid_terdekat/domain/entities/masjid.dart';
import 'package:alquran_new/development/masjid_terdekat/presentation/bloc/masjid_bloc.dart';
import 'package:alquran_new/development/masjid_terdekat/presentation/bloc/masjid_event.dart';
import 'package:alquran_new/development/masjid_terdekat/presentation/bloc/masjid_state.dart';
import 'package:alquran_new/core/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class MasjidTerdekatPage extends StatelessWidget {
  const MasjidTerdekatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MasjidBloc>(),
      child: const MasjidView(),
    );
  }
}

class MasjidView extends StatefulWidget {
  const MasjidView({super.key});

  @override
  State<MasjidView> createState() => _MasjidViewState();
}

class _MasjidViewState extends State<MasjidView> {
  GoogleMapController? _mapController;
  late final PrayerTimeController _prayerController;
  Masjid? _selectedMasjid;

  MasjidLoaded? _lastLoaded;

  Position? _userPosition;

  int _selectedRadius = 1000;
  bool _isResolvingLocation = false;
  String? _locationError;

  @override
  void initState() {
    super.initState();
    _prayerController = Get.isRegistered<PrayerTimeController>()
        ? Get.find<PrayerTimeController>()
        : Get.put(PrayerTimeController());
    _initLocationAndFetch();
  }

  Future<void> _initLocationAndFetch() async {
    if (_isResolvingLocation) return;

    setState(() {
      _isResolvingLocation = true;
      _locationError = null;
    });

    try {
      final position = await _resolvePosition();
      if (!mounted) return;

      _userPosition = position;
      _fetchMasjids();
    } on _LocationException catch (e) {
      if (!mounted) return;
      setState(() => _locationError = e.message);
    } catch (e) {
      if (!mounted) return;
      setState(() => _locationError = 'Gagal mendapatkan lokasi: $e');
    } finally {
      if (mounted) {
        setState(() => _isResolvingLocation = false);
      }
    }
  }

  Future<Position> _resolvePosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const _LocationException(
        'Layanan lokasi (GPS) belum aktif. Aktifkan lokasi perangkat lalu coba lagi.',
      );
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw const _LocationException(
        'Izin lokasi ditolak. Berikan izin lokasi agar masjid terdekat bisa dicari.',
      );
    }

    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 12),
        ),
      );
    } on TimeoutException {
      final lastKnown = await Geolocator.getLastKnownPosition();
      if (lastKnown != null) return lastKnown;

      throw const _LocationException(
        'Gagal mendapatkan lokasi (timeout). Pastikan GPS aktif dan berada di area terbuka.',
      );
    }
  }

  void _fetchMasjids() {
    final position = _userPosition;
    if (position == null) return;

    context.read<MasjidBloc>().add(
      FetchMasjidEvent(
        lat: position.latitude,
        lng: position.longitude,
        radius: _selectedRadius,
      ),
    );
  }

  void _onRadiusSelected(int value) {
    setState(() {
      _selectedRadius = value;
      _selectedMasjid = null;
    });

    if (_userPosition != null) {
      _fetchMasjids();
    } else {
      _initLocationAndFetch();
    }
  }

  double _getZoomLevel(int radius) {
    if (radius <= 1000) return 14.5;
    if (radius <= 3000) return 13.5;
    return 12.8;
  }

  MapType _mapType = MapType.hybrid;
  void _toggleMapType() {
    setState(() {
      _mapType = _mapType == MapType.hybrid ? MapType.normal : MapType.hybrid;
    });
  }

  void _retry() {
    _userPosition = null;
    _initLocationAndFetch();
  }

  Future<void> _openDirections(double lat, double lng) async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving',
    );
    final canOpen = await canLaunchUrl(url);
    final opened =
        canOpen && await launchUrl(url, mode: LaunchMode.externalApplication);

    if (!opened && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak dapat membuka Google Maps di perangkat ini.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Masjid Terdekat',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.radar),
            color: Theme.of(context).cardColor,
            onSelected: _onRadiusSelected,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1000,
                child: Text(
                  'Radius 1 KM',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              PopupMenuItem(
                value: 3000,
                child: Text(
                  'Radius 3 KM',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              PopupMenuItem(
                value: 5000,
                child: Text(
                  'Radius 5 KM',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocConsumer<MasjidBloc, MasjidState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (masjids, userPosition) {
              if(masjids.isNotEmpty) {
                _mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    LatLng(userPosition.latitude, userPosition.longitude),
                    _getZoomLevel(_selectedRadius)
                  ),
                );
              }
            },
            // error: (message) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text('Gagal memuat masjidd: $message'))
            //   );
            // },
            orElse: () {}
          );
        },
        builder: (context, state) {

          state.maybeWhen(
            loaded: (masjids, userPosition) {
              _lastLoaded = MasjidLoaded(masjids: masjids, userPosition: userPosition);
            },
            orElse: () {}
          );

          final data = state.maybeWhen(
            loaded: (masjids, userPosition) => MasjidLoaded(masjids: masjids, userPosition: userPosition),
            orElse: () => _lastLoaded
          );

          if (data == null) {
            return state.maybeWhen(
              error: (message) => _buildErrorView(message),
              orElse: () {
                if(_locationError != null) {
                  return _buildErrorView(_locationError!);
                }
                return MapsLoading();
              }
            );
          }

          final isRefreshing = state.maybeWhen(
            loading: () => true,
            orElse: () => false
          );
          

          Set<Marker> markers = data.masjids.map((masjid) {
            final isSelected = _selectedMasjid?.id == masjid.id;

            return Marker(
              markerId: MarkerId(masjid.id),
              position: LatLng(masjid.latitude, masjid.longitude),
              // infoWindow: InfoWindow(
              //   title: masjid.name,
              //   snippet: masjid.address,
              // ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                isSelected
                    ? BitmapDescriptor.hueAzure
                    : BitmapDescriptor.hueRed,
              ),
              onTap: () {
                setState(() {
                  _selectedMasjid = masjid;
                });
              },
            );
          }).toSet();
          return Stack(
            children: [
              GoogleMap(
                mapType: _mapType,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    data.userPosition.latitude,
                    data.userPosition.longitude,
                  ),
                  zoom: _getZoomLevel(_selectedRadius),
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                markers: markers,
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                onTap: (_) {
                  setState(() {
                    _selectedMasjid = null;
                  });
                },
              ),


              Positioned(
                top: 16,
                right: 16,
                child: Material(
                  color: Theme.of(context).cardColor,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: _toggleMapType,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _mapType == MapType.hybrid
                                ? Icons.layers
                                : Icons.map_outlined,
                            color: AppColors.secondary,
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _mapType == MapType.normal ? 'Normal' : 'Hybrid',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                right: 16,
                bottom: _selectedMasjid != null ? 180 : 24,
                child: FloatingActionButton(
                  heroTag: 'my_location_button',
                  mini: true,
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  onPressed: () async {
                    final position = _userPosition;
                    if (position == null || _mapController == null) return;

                    await _mapController!.animateCamera(
                      CameraUpdate.newLatLngZoom(
                        LatLng(position.latitude, position.longitude),
                        15,
                      ),
                    );
                  },
                  child: const Icon(Icons.my_location),
                ),
              ),

              if (isRefreshing)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: LinearProgressIndicator(
                    minHeight: 3,
                    color: AppColors.primary,
                  ),
                ),

              if (_selectedMasjid != null)
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _selectedMasjid!.name,
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _selectedMasjid!.address,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          const SizedBox(height: 8),

                          if (_userPosition != null)
                            Builder(
                              builder: (context) {
                                final status = calculateIqamahStatus(
                                  _selectedMasjid!,
                                  _userPosition!,
                                  _prayerController,
                                );

                                if (status['available'] != true) {
                                  return Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: AppColors.secondary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        status['message'] ??
                                            'Jadwal salat belum tersedia.',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelSmall,
                                      ),
                                    ),
                                  );
                                }

                                final bool isLate = status['isLate'] as bool;
                                final bool showWarning =
                                    status['shouldShowWarning'] == true ||
                                    isLate;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.route, size: 16),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            'Jarak ${status['distanceKm']} km • '
                                            'estimasi perjalanan ±${status['etaMinutes']} menit',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.labelSmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),

                                    if (showWarning) ...[
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: !isLate
                                              ? Colors.red.withAlpha(70)
                                              : AppColors.primary.withAlpha(70),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              isLate
                                                  ? Icons.warning_rounded
                                                  : Icons.check_circle_rounded,
                                              color: isLate
                                                  ? Colors.red
                                                  : Colors.greenAccent,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                isLate
                                                    ? 'Perkiraan tiba pukul ${status['arrivalTime']}.\n\n'
                                                          'Kemungkinan terlambat ${status['diffMinutes']} menit '
                                                          'dari iqamah ${status['prayerName']} pukul '
                                                          '${status['iqamahTime']}. \n'
                                                    : 'Masih memungkinkan untuk Sholat '
                                                          '${status['prayerName']} Berjamaah!\n\n'
                                                          'Perkiraan tiba pukul ${status['arrivalTime']},\n'
                                                          '(${status['diffMinutes']} menit sebelum iqamah '
                                                          '${status['prayerName']} pukul '
                                                          '${status['iqamahTime']}). ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall
                                                    ?.copyWith(
                                                      color: Colors.white,
                                                      height: 1.5,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                );
                              },
                            ),

                          const SizedBox(height: 8),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              icon: const Icon(Icons.directions),
                              label: const Text('Buka di Google Maps'),
                              onPressed: () => _openDirections(
                                _selectedMasjid!.latitude,
                                _selectedMasjid!.longitude,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_off, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.labelSmall!.copyWith(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isResolvingLocation ? null : _retry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).cardColor,
                foregroundColor: Colors.white,
              ),
              icon: Icon(Iconsax.refresh),
             label: _isResolvingLocation
    ? const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      )
    : const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationException implements Exception {
  final String message;

  const _LocationException(this.message);

  @override
  String toString() => message;
}
