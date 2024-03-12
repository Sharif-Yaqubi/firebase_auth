import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final obscureProvider = StateProvider<bool>((ref) => true);

class CustomInputField extends ConsumerStatefulWidget {
  const CustomInputField(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.validator,
      required this.controller,
      this.suffixIcon = false,
      this.isDense,
      this.obscureText = false});

  final TextEditingController controller;
  final String hintText;
  final bool? isDense;
  final String labelText;
  final bool obscureText;
  final bool suffixIcon;
  final String? Function(String?) validator;

  @override
  ConsumerState<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends ConsumerState<CustomInputField> {
  //

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final obscureState = ref.watch(obscureProvider);
    return Container(
      width: size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.labelText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            controller:widget.controller,
            obscureText: (widget.obscureText && obscureState),
            decoration: InputDecoration(
              isDense: (widget.isDense != null) ? widget.isDense : false,
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon
                  ? IconButton(
                      icon: Icon(
                        obscureState
                            ? Icons.remove_red_eye
                            : Icons.visibility_off_outlined,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        ref
                            .read(obscureProvider.notifier)
                            .update((state) => !state);
                      },
                    )
                  : null,
              suffixIconConstraints: (widget.isDense != null)
                  ? const BoxConstraints(maxHeight: 33)
                  : null,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
          ),
        ],
      ),
    );
  }
}
