import 'package:flutter/material.dart';

class MyFormField<T> extends StatefulWidget {
  const MyFormField({
    super.key,
    required this.fieldName,
    required this.value,
    this.onChanged,
    this.enabled = true,
    this.editable = true,
  });

  final String fieldName;
  final T value;
  final void Function(String)? onChanged;
  final bool enabled;
  final bool editable;

  @override
  State<MyFormField<T>> createState() => _MyFormFieldState<T>();
}

class _MyFormFieldState<T> extends State<MyFormField<T>> {
  late TextEditingController _controller;
  String? errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value?.toString() ?? '');
  }

  @override
  void didUpdateWidget(covariant MyFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.text = widget.value?.toString() ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Text(
            widget.fieldName,
          ),
        ),
        Expanded(
          child: TextFormField(
            enabled: widget.enabled,
            readOnly: !widget.editable,
            controller: _controller,
            onChanged: (text) {
              if (widget.onChanged != null) {
                try {
                  validate(_controller.text);
                  widget.onChanged!(text);
                } on (FormatException e,) {
                  errorText = 'Неправильный формат данных';
                }
              }
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: widget.fieldName,
              errorText: errorText,
            ),
          ),
        ),
      ],
    );
  }

  void validate(String text) {
    if (text.isEmpty) {
      errorText = 'Поле не может быть пустым';
    } else {
      errorText = null;
    }
  }
}
