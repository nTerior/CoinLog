import 'package:coin_log/layout.dart';
import 'package:flutter/material.dart';

class ToggleableSettingsInputTile extends StatefulWidget {
  final String title;

  final bool initiallyEnabled;
  final String suffix;

  final TextInputType? type;

  const ToggleableSettingsInputTile({
    Key? key,
    required this.initiallyEnabled,
    required this.title,
    this.type, required this.suffix,
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
    _enabled = widget.initiallyEnabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: !_enabled ? Theme.of(context).disabledColor : null,
          ),
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
          ),
        ),
        const SizedBox(width: Layout.padding),
        Switch(
          activeColor: Colors.white,
          value: _enabled,
          onChanged: (bool value) async {
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
