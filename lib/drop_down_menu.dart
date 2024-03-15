import 'package:flutter/material.dart';

void main() {
  runApp(const DropdownMenuExample());
}

enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Orange', Colors.orange),
  grey('Grey', Colors.grey),
  Red('Red', Color.fromARGB(255, 135, 27, 66)),
  black('Black', Colors.black);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud(
    'Cloud',
    Icons.cloud_outlined,
  ),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite),
  cricket('Cricket', Icons.airplay);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});
  @override
  State<DropdownMenuExample> createState() => _dropdownmenuState();
}

class _dropdownmenuState extends State<DropdownMenuExample> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  ColorLabel? selectedColor;
  IconLabel? selectedIcon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownMenu<ColorLabel>(
                    initialSelection: ColorLabel.green,
                    controller: colorController,
                    // requestFocusOnTap is enabled/disabled by platforms when it is null.
                    // On mobile platforms, this is false by default. Setting this to true will
                    // trigger focus request on the text field and virtual keyboard will appear
                    // afterward. On desktop platforms however, this defaults to true.
                    requestFocusOnTap: true,
                    label: const Text('COLOR'),
                    onSelected: (ColorLabel? color) {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    dropdownMenuEntries: ColorLabel.values
                        .map<DropdownMenuEntry<ColorLabel>>((ColorLabel color) {
                      return DropdownMenuEntry<ColorLabel>(
                        value: color,
                        label: color.label,
                        enabled: color.label != 'RED',
                        style: MenuItemButton.styleFrom(
                          foregroundColor: color.color,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 24),
                  DropdownMenu<IconLabel>(
                    controller: iconController,
                    enableFilter: true,
                    requestFocusOnTap: true,
                    leadingIcon: const Icon(Icons.search),
                    label: const Text('Icon'),
                    inputDecorationTheme: const InputDecorationTheme(
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                    ),
                    onSelected: (IconLabel? icon) {
                      setState(() {
                        selectedIcon = icon;
                      });
                    },
                    dropdownMenuEntries:
                        IconLabel.values.map<DropdownMenuEntry<IconLabel>>(
                      (IconLabel icon) {
                        return DropdownMenuEntry<IconLabel>(
                          value: icon,
                          label: icon.label,
                          leadingIcon: Icon(icon.icon),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
            if (selectedColor != null && selectedIcon != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      'You selected a ${selectedColor?.label} ${selectedIcon?.label}'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      selectedIcon?.icon,
                      color: selectedColor?.color,
                    ),
                  )
                ],
              )
            else
              const Text('Please select a color and an icon.')
          ],
        ),
      ),
    );
  }
}
