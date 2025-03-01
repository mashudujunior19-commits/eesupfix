// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:data/eesupools/models/eesupool_level.dart';
import 'package:data/eesupools/models/eesupool_type.dart';
import 'package:data/eesupools/repository/eesupool_members_repo.dart';
import 'package:data/eesupools/repository/eesupool_repo.dart';
import 'package:data/geolocation/models/address.dart';
import 'package:data/utils/double_ext.dart';
import 'package:data/utils/eesup_exception.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui/src/core/extensions/bg_image_deco_ext.dart';
import 'package:ui/src/core/extensions/context_alerts_ext.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:ui/src/core/widgets/eesup_form_field.dart';
import 'package:ui/src/core/widgets/fullscreen_error_widget.dart';
import 'package:ui/src/core/widgets/fullscreen_loading_shimmer.dart';
import 'package:ui/src/views/geolocation/ui/widgets/address_card.dart';
import 'package:ui/src/views/geolocation/ui/widgets/select_address_popup_button.dart';

@RoutePage()
class EESUpoolSearchScreen extends StatefulWidget {
  const EESUpoolSearchScreen({super.key, required this.type});
  final EESUpoolType type;

  @override
  State<EESUpoolSearchScreen> createState() => _EESUpoolSearchScreenState();
}

class _EESUpoolSearchScreenState extends State<EESUpoolSearchScreen> {
  final _controller = TextEditingController();
  Address? selectedAddress;
  @override
  Widget build(BuildContext context) {
    final repo = context.read<EESUpoolRepository>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: EESUpTextFormField(
            controller: _controller,
            onChanged: (p) {
              setState(() {});
            },
            margin: const EdgeInsets.only(top: 10, right: 15),
            hintText: 'Search EESUpool Names, Codes...',
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 13),
              child: Icon(
                IconlyLight.search,
                size: 21,
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ),
        body: Container(
          width: context.width,
          height: context.height,
          decoration: context.bgImage,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.type == EESUpoolType.trade)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 20),
                      child: AddressSelctionPopUpButton(
                        label: Row(
                          //mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              IconlyLight.location,
                              size: 17,
                              color: context.colorScheme.primary,
                            ),
                            5.sW,
                            Text(
                              'Select Address',
                              style: context.textTheme.labelMedium?.copyWith(
                                color: context.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        onAddressSelected: (address) {
                          if (address != null) {
                            setState(() {
                              selectedAddress = address;
                            });
                          }
                        },
                      ),
                    ),
                    if (selectedAddress != null)
                      AddressCard(address: selectedAddress!, allowDelete: false)
                  ],
                ),
              () {
                if (_controller.text.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: FullScreenError(
                      isError: false,
                      exception: EESUpException(
                        message: 'Search for EESUpool names or codes.',
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: FutureBuilder<Either<EESUpException, dynamic>>(
                      future: widget.type == EESUpoolType.trade &&
                              selectedAddress != null
                          ? repo.searchTradePools(
                              _controller.text,
                              50,
                              selectedAddress!.latitude!,
                              selectedAddress!.longitude!,
                            )
                          : repo.searchPoolsByType(
                              _controller.text,
                              EESUpoolType.kasi,
                              50,
                            ),
                      builder: (context, snap) {
                        if (snap.hasData) {
                          final results = snap.data;
                          return results?.fold((left) {
                                return FullScreenError(
                                  isError: false,
                                  exception: left,
                                );
                              }, (right) {
                                print(right);
                                final list = (right as List);

                                return ListView.builder(
                                  padding: const EdgeInsets.only(bottom: 500),
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    print(list[index]['type']);
                                    return _EESUpoolCard(
                                      pool: list[index],
                                      onRefresh: () {
                                        setState(() {});
                                      },
                                    );
                                  },
                                );
                              }) ??
                              Padding(
                                padding: const EdgeInsets.only(top: 150),
                                child: FullScreenError(
                                  isError: false,
                                  exception: EESUpException(
                                    message:
                                        'Search for EESUpool names or codes.',
                                  ),
                                ),
                              );
                        } else if (snap.connectionState ==
                            ConnectionState.waiting) {
                          return const FullScreenLoadingShimmer();
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(top: 150),
                            child: FullScreenError(
                              isError: false,
                              exception: EESUpException(
                                message: 'Search for EESUpool names or codes.',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                }
              }(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EESUpoolCard extends StatelessWidget {
  const _EESUpoolCard({required this.pool, required this.onRefresh});
  final Map<String, dynamic> pool;
  final void Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(right: 15, left: 15, top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: .5,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5,
            ),
            leading: CircleAvatar(
              radius: 28,
              backgroundColor: colorScheme.primary.withOpacity(.1),
              child: Image.asset("assets/images/kasi.png", width: 27),
            ),
            title: Text(
              pool['name'],
              style: context.textTheme.labelMedium,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (pool['distance'] != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      '${(double.parse(pool['distance'].toString())).toRounded()}'
                      ' km away',
                    ),
                  ),
                if (pool['parent_name'] != null)
                  Row(
                    children: [
                      const Icon(
                        IconlyLight.location,
                        size: 15,
                        color: Colors.black,
                      ),
                      5.sW,
                      Text('${pool['parent_name']}'),
                    ],
                  ),
                getActions(context, pool) ?? 0.sW
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget? getActions(BuildContext context, dynamic pool) {
    if (pool['membership_id'] != null) {
      return Text(
        'Member',
        style: context.textTheme.labelSmall?.copyWith(
          color: context.colorScheme.primary,
        ),
      );
    }

    final level = pool['level'];

    if (level == null && pool['invite_status'] == null) {
      return _sendRequest(context, pool);
    } else if (level == null && pool['invite_status'] != null) {
      return _revokeRequest(context, pool);
    } else {
      if (level == EESUpoolLevel.Street.toString()) {
        return _joinKasi(context, pool);
      } else {
        return _viewStreets(context, pool);
      }
    }
  }

  Padding _viewStreets(BuildContext context, pool) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: InkWell(
        onTap: () {
          // kasiStreetsDialog(
          //   context,
          //   parentId: pool['id'],
          //   parentName: pool['name'],
          // );
        },
        child: Text(
          'View Streets',
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colorScheme.primary,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Padding _joinKasi(BuildContext context, pool) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: InkWell(
        onTap: () async {
          context.loaderOverlay.show();
          final repo = context.read<EESUpoolRepository>();
          final results = await repo.joinEESUpoool(pool['id']);
          context.loaderOverlay.hide();

          results.fold((l) {
            context.snackBarError(l.message);
          }, (r) {
            Navigator.pop(context);
            context.snackBarSuccess('Joined ${pool['name']}');
            onRefresh?.call();
          });
        },
        child: Text(
          'Join',
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colorScheme.primary,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Padding _revokeRequest(BuildContext context, pool) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: InkWell(
        onTap: () async {
          context.loaderOverlay.show();
          final repo = context.read<EESUpoolRepository>();
          final results = await repo.deleteCurrentInviteOrRequest(pool['id']);
          context.loaderOverlay.hide();

          results.fold((l) {
            context.snackBarError(l.message);
          }, (r) {
            Navigator.pop(context);
            context.snackBarSuccess(
              'Request revoked for ${pool['name']}',
            );
            onRefresh?.call();
          });
        },
        child: Text(
          'Revoke Request',
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colorScheme.error,
            fontSize: 14.5,
          ),
        ),
      ),
    );
  }

  Padding _sendRequest(BuildContext context, pool) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: InkWell(
        onTap: () async {
          context.loaderOverlay.show();
          final repo = context.read<EESUpoolRepository>();
          final results = await repo.createEESUpooolRequest(pool['id']);
          context.loaderOverlay.hide();

          results.fold((l) {
            context.snackBarError(l.message);
          }, (r) {
            Navigator.pop(context);
            context.snackBarSuccess('Requested to join ${pool['name']}');
            onRefresh?.call();
          });
        },
        child: Text(
          'Request',
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colorScheme.primary,
            fontSize: 14.5,
          ),
        ),
      ),
    );
  }
}
