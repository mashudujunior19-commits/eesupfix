import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

class EESUpTextFormField extends StatefulWidget {
  const EESUpTextFormField({
    super.key,
    this.label,
    this.hintText,
    this.initialValue,
    this.isPassword = false,
    this.controller,
    this.margin,
    this.readOnly = false,
    this.visible = true,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.onSubmit,
    this.type,
    this.maxLines = 1,
    this.onTap,
    this.style,
    this.isRequired = false,
    this.isExpandalbe = false,
    this.textAlign,
    this.autoFocus = false,
  });
  final bool isRequired;
  final String? label;
  final String? hintText;
  final String? initialValue;
  final bool isPassword;
  final int maxLines;
  final bool readOnly;
  final TextEditingController? controller;
  final EdgeInsets? margin;
  final TextInputType? type;
  final TextStyle? style;
  final bool visible;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isExpandalbe;
  final TextAlign? textAlign;
  final bool autoFocus;
  final void Function(String)? onChanged;
  final void Function(String?)? onSubmit;
  final void Function()? onTap;

  @override
  State<EESUpTextFormField> createState() => _EESUpTextFormFieldState();
}

class _EESUpTextFormFieldState extends State<EESUpTextFormField> {
  bool _obscureText = true;

  bool mustAdgustPadding() {
    if (widget.isPassword) {
      return true;
    }

    if (widget.suffixIcon != null) {
      return true;
    }

    if (widget.prefixIcon != null) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.visible) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final textTheme = theme.textTheme.bodySmall;
    final labelTheme = theme.textTheme.labelMedium;

    return Container(
      margin: widget.margin ?? const EdgeInsets.only(top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Row(
              children: [
                Text(
                  widget.label!,
                  style: labelTheme!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (widget.isRequired)
                  Text(
                    ' *',
                    style: labelTheme.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.error,
                    ),
                  ),
              ],
            ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 10),
            padding: EdgeInsets.only(
              left: widget.prefixIcon != null ? 0 : 10,
              right:
                  (widget.suffixIcon != null) || mustAdgustPadding() ? 0 : 10,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(.03),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300,
                width: .5,
              ),
            ),
            child: TextFormField(
              autofocus: widget.autoFocus,
              autocorrect: true,
              obscuringCharacter: '·',
              controller: widget.controller,
              initialValue: widget.initialValue,
              maxLines: widget.maxLines,
              readOnly: widget.readOnly,
              obscureText: widget.isPassword ? _obscureText : false,
              onFieldSubmitted: widget.onSubmit,
              onChanged: widget.onChanged,
              keyboardType: widget.type,
              onTap: widget.onTap,
              textAlign: widget.textAlign ?? TextAlign.start,
              style: widget.style ??
                  textTheme!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                  ),
              decoration: InputDecoration(
                contentPadding: mustAdgustPadding()
                    ? const EdgeInsets.only(top: 14)
                    : const EdgeInsets.only(top: 5),
                hintText: widget.hintText,
                hintStyle: theme.textTheme.bodySmall!.copyWith(
                  color: Colors.grey.withOpacity(.8),
                  fontSize: 13.5,
                ),
                border: InputBorder.none,
                prefixIcon: widget.prefixIcon == null
                    ? null
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          widget.prefixIcon ?? const SizedBox.shrink(),
                        ],
                      ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? BootstrapIcons.eye
                              : BootstrapIcons.eye_slash,
                          color: theme.colorScheme.primary,
                          size: 19,
                        ),
                      )
                    : widget.suffixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
