import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  final void Function(Color?) onSelectColor;
  final List<Color> availableColors;
  final Color? firstColor;

  const ColorPicker({key,
    required this.onSelectColor,
    required this.availableColors,
    this.firstColor})
      : super(key: key);

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color? _selectedColor;

  @override
  void initState() {
    _selectedColor = widget.firstColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ...widget.availableColors.map((itemColor) {
        return Padding(
            padding: const EdgeInsets.only(top: 20, right: 12),
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              onTap: () {
                if (_selectedColor?.value == itemColor.value) {
                  _selectedColor = null;
                } else {
                  _selectedColor = itemColor;
                }
                setState(() {
                  widget.onSelectColor(_selectedColor);
                });
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: itemColor,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.black12)),
                child: itemColor.value == widget.firstColor?.value
                    ? const Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
            ));
      })
    ]);
  }
}
