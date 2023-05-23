import 'package:coin_log/layout.dart';
import 'package:flutter/material.dart';

class ToggleableSettingsInputTile extends StatefulWidget {
  final String title;

  final dynamic initialValue;
  final bool initiallyEnabled;

  final String suffix;

  final TextInputType? type;

  final void Function(String value) onEdit;
  final void Function(bool value) onToggle;

  const ToggleableSettingsInputTile({
    Key? key,
    required this.initiallyEnabled,
    required this.title,
    this.type,
    required this.suffix,
    required this.onEdit,
    required this.onToggle,
    this.initialValue,
  }) : super(key: key);

  @override
  State<ToggleableSettingsInputTile> createState() =>
      _ToggleableSettingsInputTileState();
}

class _ToggleableSettingsInputTileState
    extends State<ToggleableSettingsInputTile> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  bool _enabled = false;

  @override
  void initState() {
    _controller.text = widget.initialValue?.toString() ?? "";
    _enabled = widget.initiallyEnabled;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.title,
        ),
        const SizedBox(width: Layout.padding),
        Expanded(
          child: TextField(
            controller: _controller,
            enabled: _enabled,
            focusNode: _focusNode,
            keyboardType: widget.type,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixText: widget.suffix,
            ),
            onChanged: widget.onEdit,
          ),
        ),
        const SizedBox(width: Layout.padding),
        Switch(
          activeColor: Colors.white,
          value: _enabled,
          onChanged: (bool value) async {
            widget.onToggle(value);
            setState(() {
              _enabled = value;
              if (value && _controller.text.isEmpty) {
                Future.delayed(const Duration(milliseconds: 100)).then(
                  (value) => _focusNode.requestFocus(),
                );
              }
            });
          },
        ),
      ],
    );
  }
}
