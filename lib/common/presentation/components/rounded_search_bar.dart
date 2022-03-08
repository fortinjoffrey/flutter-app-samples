import 'package:flutter/material.dart';

class RoundedSearchBar extends StatefulWidget {
  const RoundedSearchBar({
    Key? key,
    this.onChanged,
    this.onSubmit,
    this.onClear,
    this.enabled = true,
    this.hintText,
    this.initialText,
  }) : super(key: key);

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmit;
  final VoidCallback? onClear;
  final bool enabled;
  final String? hintText;
  final String? initialText;
  @override
  _RoundedSearchBarState createState() => _RoundedSearchBarState();
}

class _RoundedSearchBarState extends State<RoundedSearchBar> {
  String lastSearchedText = '';
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: widget.initialText,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          color: widget.enabled ? Colors.grey[300] : Colors.grey[500],
          height: 55,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  enabled: widget.enabled,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: _buildInputDecoration(),
                  onChanged: (text) {
                    widget.onChanged?.call(text);

                    if (lastSearchedText.isNotEmpty && text.isEmpty) {
                      setState(() {
                        lastSearchedText = '';
                      });
                    } else {
                      setState(() {});
                    }
                  },
                  onFieldSubmitted: (text) {
                    setState(() {
                      lastSearchedText = text;
                    });
                    widget.onSubmit?.call(text);
                  },
                ),
              ),
              // ---------------------------------------------------------------
              // CLEAR BUTTON
              // ---------------------------------------------------------------
              if (controller.text.isNotEmpty) ...[
                IgnorePointer(
                  ignoring: !widget.enabled,
                  child: IconButton(
                    // we do want any splash since we don't have a background
                    splashRadius: 1,
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      widget.onClear?.call();
                      setState(() {
                        controller.text = '';
                        lastSearchedText = '';
                      });
                    },
                  ),
                ),
              ],
              // ---------------------------------------------------------------
              // SEARCH BUTTON
              // ---------------------------------------------------------------
              IgnorePointer(
                ignoring: !widget.enabled,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      lastSearchedText = controller.text;
                    });
                    widget.onSubmit?.call(controller.text);
                  },
                  child: const Icon(Icons.search),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      isDense: true,
      hintText: widget.hintText,
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    );
  }
}
