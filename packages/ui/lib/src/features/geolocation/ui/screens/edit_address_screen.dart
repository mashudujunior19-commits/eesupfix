import 'package:auto_route/auto_route.dart';
import 'package:data/geolocation/models/address.dart';
import 'package:data/geolocation/repository/geo_repository.dart';
import 'package:data/utils/localize_south_african_phone.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/features/geolocation/bloc/auto_completion_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
  String type = 'Residential';
  String province = 'Province';
  bool isPrimary = false;
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
  var types = ['Residential', 'Business'];
  final _streetController = TextEditingController();
  final _buildingController = TextEditingController();
  final _phoneController = TextEditingController();
  final _recipientController = TextEditingController();
  double? latitude;
  double? longitude;

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
      type = widget.address!.type;
      province = widget.address!.province;
      isPrimary = widget.address!.isPrimary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AutoCompletionBloc(),
      child: BlocBuilder<AutoCompletionBloc, AutoCompletionState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: BackButton(onPressed: () => Navigator.pop(context)),
                title: Text(
                  widget.address != null ? 'Edit Address' : 'Add Address',
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: TextButton(
                      onPressed: () async {
                        if (_streetController.text.isEmpty) {
                          context.snackBarError('Street address is required');
                          return;
                        }

                        final phone =
                            localizeSAPhoneNumber(_phoneController.text);

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
                          context.snackBarSuccess('Address saved successfully');
                          Navigator.pop(context, r);
                        });
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  18.sW,
                ],
              ),
              body: ListView(
                padding: const EdgeInsets.only(
                  left: 22,
                  right: 22,
                  bottom: 400,
                ),
                children: [
                  EESUpTextFormField(
                    label: 'Street Address',
                    isRequired: true,
                    prefixIcon: const Icon(IconlyLight.search, size: 20),
                    hintText: '99 Street, City, Country',
                    controller: _streetController,
                    maxLines: 3,
                    onChanged: (p0) {
                      final chars = p0.split(',');

                      _autoCompleteSearch(chars, p0, context);
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
                                latitude = prediction.lat;
                                longitude = prediction.lng;
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
                  _type(context),
                  10.sH,
                  _isPrimary(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _autoCompleteSearch(List<String> chars, String p0, BuildContext context) {
         if (chars.length >= 2) {
      if (p0.isNotEmpty) {
        try {
          final key = dotenv.get('GOOGLE_API_KEY');
          context.read<AutoCompletionBloc>().add(
                AutoCompletionRequested(key, p0),
              );
        } catch (e) {
          context.read<AutoCompletionBloc>().add(
                AutoCompletionReseted(),
              );
        }
      }
    } else {
      context.read<AutoCompletionBloc>().add(
            AutoCompletionReseted(),
          );
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

  Widget _type(BuildContext context) {
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
            value: type,
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
            items: types.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                type = newValue!;
              });
            },
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
