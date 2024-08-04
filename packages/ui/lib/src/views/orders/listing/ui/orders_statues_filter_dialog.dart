import 'package:data/orders/models/order.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';

class OrdersStatuesFilterDialog extends StatefulWidget {
  const OrdersStatuesFilterDialog({super.key, required this.selected});
  final List<OrderStatus> selected;

  @override
  State<OrdersStatuesFilterDialog> createState() =>
      _OrdersStatuesFilterDialogState();
}

class _OrdersStatuesFilterDialogState extends State<OrdersStatuesFilterDialog> {
  final List<OrderStatus> _selectedStatues = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedStatues.addAll(widget.selected);
    });
  }

  bool _selected(OrderStatus value) {
    bool isSelected = false;
    for (final v in _selectedStatues) {
      if (v.index == value.index) {
        isSelected = true;
      }
    }
    return isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          BackButton(
            onPressed: () {
              Navigator.pop(context, _selectedStatues);
            },
          ),
          Text(
            'Filter by Statuses',
            style: context.textTheme.labelMedium?.copyWith(
              fontSize: 18,
            ),
          )
        ]),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 1),
            itemCount: OrderStatus.values.length,
            itemBuilder: (context, index) {
              final v = OrderStatus.values[index];

              return ListTile(
                onTap: () {
                  setState(() {
                    if (_selected(v)) {
                      _selectedStatues.remove(v);
                    } else {
                      _selectedStatues.add(v);
                    }
                  });
                },
                title: Text(
                  v.toString(),
                  style: context.textTheme.labelMedium,
                ),
                trailing: Checkbox(
                  value: _selectedStatues.map((e) => e.index).contains(v.index),
                  onChanged: (value) {
                    setState(() {
                      if (_selected(v)) {
                        _selectedStatues.remove(v);
                      } else {
                        _selectedStatues.add(v);
                      }
                    });
                  },
                ),
              );
            },
          ),
        ),
        15.sH,
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _selectedStatues);
            },
            child: const Text("Done"),
          ),
        ),
        20.sH,
      ],
    );
  }
}
