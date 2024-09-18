import 'package:flutter/material.dart';
import 'package:web_accessibility_demo/dialog_example.dart';

enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  orange('Orange', Colors.orange),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  static const _headerStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      width: 340,
      child: ListView(
        children: [
          Semantics(
            container: true,
            child: const Column(
              children: [
                Text(
                  'Dialog Dismissal Issue',
                  style: _headerStyle,
                ),
                SizedBox(height: 20),
                DialogExample(),
                SizedBox(height: 20),
                DialogExample(withFix: true),
              ],
            ),
          ),
          const SizedBox(height: 60),
          Semantics(
            container: true,
            child: Column(
              children: [
                const Text(
                  'DropdownMenu Issue',
                  style: _headerStyle,
                ),
                const Text(
                  '(tap the icon button or space between the text and icon)',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Cannot use with a mouse when ensureSemantics is enabled
                _dropdownMenu,
              ],
            ),
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Semantics(
                container: true,
                child: Column(
                  children: [
                    const Text(
                      'DropdownButton',
                      style: _headerStyle,
                    ),
                    const Text('(Default)'),
                    const SizedBox(height: 20),
                    _dropdownButton,
                  ],
                ),
              ),
              const SizedBox(width: 30),
              Semantics(
                container: true,
                child: Column(
                  children: [
                    const Text(
                      'DropdownButton',
                      style: _headerStyle,
                    ),
                    const Text('(Styled)'),
                    const SizedBox(height: 20),
                    _dropdownButtonStyled,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ColorLabel? _selectedDropdownValue;

  ColorLabel? _selectedDropdownStyledValue;

  Widget get _dropdownMenu => DropdownMenu<ColorLabel>(
        label: const Text('Color'),
        dropdownMenuEntries: ColorLabel.values.map<DropdownMenuEntry<ColorLabel>>(
          (ColorLabel color) {
            return DropdownMenuEntry<ColorLabel>(
              value: color,
              label: color.label,
              style: MenuItemButton.styleFrom(
                foregroundColor: color.color,
              ),
            );
          },
        ).toList(),
      );

  Widget get _dropdownButton => DropdownButton(
        hint: const Text('Color'),
        items: ColorLabel.values.map<DropdownMenuItem<ColorLabel>>(
          (ColorLabel color) {
            return DropdownMenuItem<ColorLabel>(
              value: color,
              child: Text(color.label),
            );
          },
        ).toList(),
        onChanged: (value) {
          setState(() {
            _selectedDropdownValue = value;
          });
        },
        value: _selectedDropdownValue,
      );

  Widget get _dropdownButtonStyled => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButton(
          hint: const Text('Color'),
          items: ColorLabel.values.map<DropdownMenuItem<ColorLabel>>(
            (ColorLabel color) {
              return DropdownMenuItem<ColorLabel>(
                value: color,
                child: Text(color.label),
              );
            },
          ).toList(),
          onChanged: (value) {
            setState(() {
              _selectedDropdownStyledValue = value;
            });
          },
          value: _selectedDropdownStyledValue,
          menuWidth: 250,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          underline: Container(color: Colors.transparent),
          focusColor: Colors.transparent,
        ),
      );
}
