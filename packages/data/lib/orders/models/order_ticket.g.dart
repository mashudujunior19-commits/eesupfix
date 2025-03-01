// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderTicket _$OrderTicketFromJson(Map<String, dynamic> json) => _OrderTicket(
      id: (json['id'] as num?)?.toInt(),
      orderId: (json['order_id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      customerComment: json['customer_comment'] as String?,
      eesupreneurComment: json['eesupreneur_comment'] as String?,
      itemsMissing: json['items_missing'] as bool,
      products:
          const OrderProductConverter().fromJson(json['products'] as List),
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => const MediaFileConverter()
                  .fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      eesupreneurConfirmedAt: json['eesupreneur_confirmed_at'] == null
          ? null
          : DateTime.parse(json['eesupreneur_confirmed_at'] as String),
      customerConfirmedAt: json['customer_confirmed_at'] == null
          ? null
          : DateTime.parse(json['customer_confirmed_at'] as String),
      eesupConfirmedAt: json['eesup_confirmed_at'] == null
          ? null
          : DateTime.parse(json['eesup_confirmed_at'] as String),
      resolution: const TicketResolutionTypeConverter()
          .fromJson(json['resolution'] as String),
    );

Map<String, dynamic> _$OrderTicketToJson(_OrderTicket instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'created_at': instance.createdAt.toIso8601String(),
      'customer_comment': instance.customerComment,
      'eesupreneur_comment': instance.eesupreneurComment,
      'items_missing': instance.itemsMissing,
      'products': const OrderProductConverter().toJson(instance.products),
      'attachments':
          instance.attachments.map(const MediaFileConverter().toJson).toList(),
      'eesupreneur_confirmed_at':
          instance.eesupreneurConfirmedAt?.toIso8601String(),
      'customer_confirmed_at': instance.customerConfirmedAt?.toIso8601String(),
      'eesup_confirmed_at': instance.eesupConfirmedAt?.toIso8601String(),
      'resolution':
          const TicketResolutionTypeConverter().toJson(instance.resolution),
    };
