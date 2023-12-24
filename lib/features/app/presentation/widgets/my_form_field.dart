import 'package:flutter/material.dart';

class MyFormField<T> extends StatefulWidget {
  const MyFormField({super.key, required this.fieldName, required this.value});

  final String fieldName;
  final T value;

  @override
  State<MyFormField<T>> createState() => _MyFormFieldState<T>();
}

class _MyFormFieldState<T> extends State<MyFormField<T>> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value.toString());
  }

  @override
  void didUpdateWidget(covariant MyFormField<T> oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _controller.text = widget.value.toString();
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
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.fieldName,
          ),
        )),
      ],
    );
  }
}
