import 'package:auto_route/auto_route.dart';
import 'package:data/geolocation/models/address.dart';
import 'package:data/geolocation/repository/geo_repository.dart';
import 'package:data/utils/localize_south_african_phone.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/views/geolocation/bloc/auto_completion_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

// Johannesburg — used as the map's default center until a real address is
// picked or the device location is known.
const _defaultLat = -26.2041;
const _defaultLng = 28.0473;

class _AddressTypeOption {
  final String label;
  final IconData icon;
  const _AddressTypeOption(this.label, this.icon);
}

const _addressTypeOptions = [
  _AddressTypeOption('House', Icons.home_outlined),
  _AddressTypeOption('Office', Icons.business_center_outlined),
  _AddressTypeOption(
    'Townhouse/Security Estate',
    Icons.holiday_village_outlined,
  ),
  _AddressTypeOption('Flat/Apartment', Icons.apartment_outlined),
];

String _normalizeType(String? value) {
  if (_addressTypeOptions.any((o) => o.label == value)) return value!;
  if (value == 'Business') return 'Office';
  return 'House';
}

@RoutePage()
class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({
    super.key,
    this.address,
    this.isPersonal = true,
  });
  final Address? address;
  final bool isPersonal;

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  String type = 'House';
  String province = 'Province';
  bool isPrimary = true;
  var provinces = [
    'Gauteng',
    'KwaZulu-Natal',
    'Western Cape',
    'Eastern Cape',
    'Limpopo',
    'Mpumalanga',
    'North West',
    'Free State',
    'Northern Cape',
    'Province',
  ];
  final _streetController = TextEditingController();
  final _buildingController = TextEditingController();
  final _phoneController = TextEditingController();
  final _recipientController = TextEditingController();
  double? latitude;
  double? longitude;

  MapboxMap? _mapboxMap;
  PointAnnotationManager? _pointAnnotationManager;
  PointAnnotation? _marker;
  Cancelable? _dragSubscription;

  bool isSearching = false;

  @override
  void initState() {
    super.initState();

    if (widget.address != null) {
      _streetController.text = widget.address!.streetAddress;
      _buildingController.text = widget.address!.buildingName ?? '';
      _phoneController.text = widget.address!.recipientPhone;
      _recipientController.text = widget.address!.recipientName;
      latitude = widget.address!.latitude;
      longitude = widget.address!.longitude;
      type = _normalizeType(widget.address!.type);
      province = widget.address!.province;
      isPrimary = widget.address!.isPrimary;
    }
  }

  @override
  void dispose() {
    _dragSubscription?.cancel();
    _streetController.dispose();
    _buildingController.dispose();
    _phoneController.dispose();
    _recipientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AutoCompletionBloc(),
      child: BlocBuilder<AutoCompletionBloc, AutoCompletionState>(
        builder: (context, state) {
          return SizedBox(
            child: Scaffold(
              appBar: AppBar(
                leading: BackButton(onPressed: () => Navigator.pop(context)),
                title: Text(
                  widget.address != null ? 'Edit Address' : 'Add Address',
                ),
              ),
              body: SafeArea(
                child: ListView(
                  padding: const EdgeInsets.only(
                    left: 22,
                    right: 22,
                    bottom: 60,
                  ),
                  children: [
                    10.sH,
                    _mapSection(context),
                    EESUpTextFormField(
                      label: 'Street Address',
                      isRequired: true,
                      prefixIcon: const Icon(IconlyLight.search, size: 20),
                      hintText: '99 Street, City, Country',
                      controller: _streetController,
                      maxLines: 3,
                      onChanged: (p0) {
                        if (p0.trim().length >= 3) {
                          EasyDebounce.debounce(
                            'auto_complete_search_debouncer',
                            const Duration(milliseconds: 500),
                            () => _autoCompleteSearch(p0, context),
                          );
                        } else {
                          context
                              .read<AutoCompletionBloc>()
                              .add(AutoCompletionReseted());
                        }
                      },
                    ),
                    () {
                      if (state is AutoCompletionsLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Suggestions',
                              style: context.textTheme.labelMedium?.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.primary,
                              ),
                            ),
                            for (final prediction in state.suggestions)
                              ListTile(
                                contentPadding: const EdgeInsets.only(),
                                onTap: () {
                                  _streetController.text = prediction.address;
                                  _moveMapTo(prediction.lat, prediction.lng);
                                  context.read<AutoCompletionBloc>().add(
                                        AutoCompletionReseted(),
                                      );
                                },
                                leading: const Icon(IconlyLight.location),
                                title: Text(
                                  prediction.address,
                                  style: context.textTheme.bodySmall?.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                          ],
                        );
                      } else {
                        return 0.sW;
                      }
                    }(),
                    EESUpTextFormField(
                      label: 'Building',
                      hintText: 'Building Name, Number, Floor',
                      controller: _buildingController,
                    ),
                    10.sH,
                    _typeChips(context),
                    10.sH,
                    _province(context),
                    EESUpTextFormField(
                      label: 'Phone',
                      isRequired: true,
                      hintText: '0712345678',
                      type: TextInputType.phone,
                      controller: _phoneController,
                    ),
                    EESUpTextFormField(
                      label: 'Recipient',
                      isRequired: true,
                      hintText: 'John Doe',
                      controller: _recipientController,
                    ),
                    10.sH,
                    _isPrimary(context),
                    20.sH,
                    _saveButton(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _mapSection(BuildContext context) {
    final lat = latitude ?? _defaultLat;
    final lng = longitude ?? _defaultLng;
    final mapHeight =
        (MediaQuery.sizeOf(context).height * 0.26).clamp(180.0, 260.0);
    return Container(
      height: mapHeight,
      margin: const EdgeInsets.only(bottom: 15),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: kIsWeb
                  ? _staticMapImage(lat, lng)
                  : MapWidget(
                      key: const ValueKey('address_map_widget'),
                      cameraOptions: CameraOptions(
                        center: Point(coordinates: Position(lng, lat)),
                        zoom: 15,
                      ),
                      styleUri: MapboxStyles.STANDARD,
                      onMapCreated: _onMapCreated,
                    ),
            ),
          ),
          if (!kIsWeb)
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: _recenterMap,
                  icon: Icon(
                    Icons.my_location,
                    size: 16,
                    color: context.colorScheme.primary,
                  ),
                  label: Text(
                    'Update Pin',
                    style: TextStyle(color: context.colorScheme.primary),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _staticMapImage(double lat, double lng) {
    final token = dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '';
    final primary = context.colorScheme.primary;
    final hex = primary.value.toRadixString(16).padLeft(8, '0').substring(2);
    final url = 'https://api.mapbox.com/styles/v1/mapbox/streets-v12/static/'
        'pin-s+$hex($lng,$lat)/$lng,$lat,14,0/640x440@2x'
        '?access_token=$token';
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        color: Colors.grey.shade200,
        child: const Center(
          child: Icon(Icons.map_outlined, size: 40, color: Colors.grey),
        ),
      ),
    );
  }

  Future<void> _onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;
    _pointAnnotationManager =
        await mapboxMap.annotations.createPointAnnotationManager();
    await _placeMarker();
    _dragSubscription = _pointAnnotationManager!.dragEvents(
      onEnd: (annotation) {
        final coords = annotation.geometry.coordinates;
        setState(() {
          latitude = coords.lat.toDouble();
          longitude = coords.lng.toDouble();
        });
      },
    );
  }

  Future<void> _placeMarker() async {
    final manager = _pointAnnotationManager;
    if (manager == null) return;
    final existing = _marker;
    if (existing != null) {
      await manager.delete(existing);
    }
    _marker = await manager.create(
      PointAnnotationOptions(
        geometry: Point(
          coordinates:
              Position(longitude ?? _defaultLng, latitude ?? _defaultLat),
        ),
        iconImage: 'marker-15',
        iconSize: 2,
        isDraggable: true,
      ),
    );
  }

  Future<void> _moveMapTo(double lat, double lng) async {
    setState(() {
      latitude = lat;
      longitude = lng;
    });
    if (kIsWeb) return;
    await _placeMarker();
    await _mapboxMap?.flyTo(
      CameraOptions(center: Point(coordinates: Position(lng, lat)), zoom: 16),
      MapAnimationOptions(duration: 800),
    );
  }

  void _recenterMap() {
    final lat = latitude ?? _defaultLat;
    final lng = longitude ?? _defaultLng;
    _mapboxMap?.flyTo(
      CameraOptions(center: Point(coordinates: Position(lng, lat)), zoom: 16),
      MapAnimationOptions(duration: 500),
    );
  }

  Widget _saveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveAddress,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colorScheme.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Save Delivery Address',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Future<void> _saveAddress() async {
    if (_streetController.text.isEmpty) {
      context.snackBarError('Street address is required');
      return;
    }

    final phone = localizeSAPhoneNumber(_phoneController.text);

    if (phone == null) {
      context.snackBarError(
        'Please provide a valid South African phone number',
      );
      return;
    }

    if (_recipientController.text.isEmpty) {
      context.snackBarError('Recipient name is required');
      return;
    }

    if (province == 'Province') {
      context.snackBarError('Select a province');
      return;
    }

    final address = Address(
      id: widget.address?.id,
      userId: widget.address?.userId,
      areaId: widget.address?.areaId,
      streetAddress: _streetController.text,
      buildingName: _buildingController.text,
      recipientPhone: phone,
      recipientName: _recipientController.text,
      latitude: latitude,
      longitude: longitude,
      type: type,
      province: province,
      isPrimary: isPrimary,
      createdAt: DateTime.now(),
    );

    context.loaderOverlay.show();

    final saveResults = await context
        .read<GeoRepository>()
        .saveAddress(address, widget.isPersonal);

    if (context.mounted) {
      context.loaderOverlay.hide();
    }

    saveResults.fold((l) {
      context.snackBarError(l.message);
    }, (r) {
      if (r != null && r.isPrimary && r.areaId == null) {
        context.snackBarWarning(
          r.latitude == null || r.longitude == null
              ? 'Address saved, but we could not find its location on the '
                  'map. Please pick an address from the suggestions list so '
                  'it can be confirmed.'
              : 'Address saved, but it is outside the areas TOWRIS currently '
                  'serves, so it cannot be verified yet.',
        );
      } else {
        context.snackBarSuccess('Address saved successfully');
      }
      Navigator.pop(context, r);
    });
  }

  void _autoCompleteSearch(String p0, BuildContext context) {
    if (p0.isNotEmpty) {
      try {
        final key = dotenv.get('GEOAPIFY_API_KEY');
        context
            .read<AutoCompletionBloc>()
            .add(AutoCompletionRequested(key, p0));
      } catch (e) {
        context.read<AutoCompletionBloc>().add(AutoCompletionReseted());
      }
    }
  }

  Widget _province(BuildContext context) {
    final theme = Theme.of(context);
    final labelTheme = theme.textTheme.labelMedium;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        5.sH,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Province/State',
              style: theme.textTheme.labelMedium!.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              ' *',
              style: labelTheme?.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.error,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(.03),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade300,
              width: .5,
            ),
          ),
          child: DropdownButton<String>(
            // Initial Value
            value: province,
            isExpanded: true,
            underline: const SizedBox(),
            dropdownColor: Colors.white,
            // Down Arrow Icon
            icon: const Icon(IconlyLight.arrowDown2, size: 18),
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            borderRadius: BorderRadius.circular(10),
            // Array list of items
            items: provinces.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                province = newValue!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _typeChips(BuildContext context) {
    final theme = Theme.of(context);
    final labelTheme = theme.textTheme.labelMedium;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Type',
              style: theme.textTheme.labelMedium!.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              ' *',
              style: labelTheme?.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.error,
              ),
            ),
          ],
        ),
        10.sH,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _addressTypeOptions.map((option) {
              final selected = type == option.label;
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () => setState(() => type = option.label),
                  child: Container(
                    width: 92,
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: selected
                          ? theme.colorScheme.primary.withOpacity(.1)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? theme.colorScheme.primary
                            : Colors.grey.shade300,
                        width: selected ? 1.5 : .5,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          option.icon,
                          color: selected
                              ? theme.colorScheme.primary
                              : Colors.black54,
                        ),
                        6.sH,
                        Text(
                          option.label,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: selected
                                ? theme.colorScheme.primary
                                : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _isPrimary(BuildContext context) {
    final theme = Theme.of(context);
    final labelTheme = theme.textTheme.labelMedium;
    if (!widget.isPersonal) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        5.sH,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Primary Address',
              style: theme.textTheme.labelMedium!.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              ' *',
              style: labelTheme?.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.error,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(.03),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade300,
              width: .5,
            ),
          ),
          child: DropdownButton<bool>(
            // Initial Value
            value: isPrimary,
            isExpanded: true,
            underline: const SizedBox(),
            dropdownColor: Colors.white,
            // Down Arrow Icon
            icon: const Icon(IconlyLight.arrowDown2, size: 18),
            borderRadius: BorderRadius.circular(10),
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            // Array list of items
            items: [true, false].map((bool items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items
                    ? "This is my primary address"
                    : "This is not my primary address"),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (bool? newValue) {
              setState(() {
                isPrimary = newValue!;
              });
            },
          ),
        ),
      ],
    );
  }
}
