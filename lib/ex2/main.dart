import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

enum ButtonType { primary, secondary, disabled }
enum IconPosition { left, right }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EX2 - CustomButton Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('Custom buttons'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomButton(
                  label: 'Submit',
                  icon: Icons.check,
                  type: ButtonType.primary,
                  iconPosition: IconPosition.left,
                  onPressed: () {
                    // example action
                    debugPrint('Submit pressed');
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  label: 'Time',
                  icon: Icons.access_time,
                  type: ButtonType.secondary,
                  iconPosition: IconPosition.right,
                  onPressed: () {
                    debugPrint('Time pressed');
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  label: 'Account',
                  icon: Icons.account_box,
                  type: ButtonType.disabled,
                  iconPosition: IconPosition.right,
                  // onPressed omitted => disabled
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final ButtonType type;
  final IconPosition iconPosition;
  final VoidCallback? onPressed;

  const CustomButton({
    Key? key,
    required this.label,
    required this.icon,
    this.type = ButtonType.primary,
    this.iconPosition = IconPosition.left,
    this.onPressed,
  }) : super(key: key);

  // Disabled is authoritative when the enum says disabled.
  bool get _isDisabled => type == ButtonType.disabled;

  Color _backgroundColor() {
    switch (type) {
      case ButtonType.primary:
        return const Color(0xFF2196F3); // blue
      case ButtonType.secondary:
        return const Color(0xFF39A94A); // green
      case ButtonType.disabled:
        return Colors.grey.shade300;
    }
  }

  Color _contentColor() {
    // Use a dark desaturated color for enabled; light grey for disabled as requested.
    if (_isDisabled) return Colors.grey.shade500;
    return const Color(0xFF455A64); // blue-grey (not pure white)
  }

  @override
  Widget build(BuildContext context) {
    final bg = _backgroundColor();
    final contentColor = _contentColor();

    // A button is interactive only when the enum doesn't mark it disabled AND an onPressed callback is provided.
    final enabled = !_isDisabled && onPressed != null;

    return AbsorbPointer(
      absorbing: _isDisabled, // block gestures when disabled by enum
      child: Opacity(
        opacity: _isDisabled ? 0.95 : 1.0,
        child: Material(
          color: bg,
          borderRadius: BorderRadius.circular(28.0),
          child: InkWell(
            onTap: enabled ? onPressed : null,
            borderRadius: BorderRadius.circular(28.0),
            splashColor: enabled ? null : Colors.transparent,
            highlightColor: enabled ? null : Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 48,
              // Stretch to parent's width because Column.crossAxisAlignment = stretch
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: _buildChildren(contentColor),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChildren(Color contentColor) {
    // Make the icon sit closer to the text with a small gap (8px) between
    // them, regardless of whether the icon is on the left or right.
    final iconWidget = Padding(
      padding: iconPosition == IconPosition.left
          ? const EdgeInsets.only(right: 8.0)
          : const EdgeInsets.only(left: 8.0),
      child: Icon(icon, color: contentColor, size: 20),
    );

    // Build a compact row that groups icon + label together so the icon sits
    // directly beside the text, and then center that group inside the full-width button.
    const edgeSpacerWidth = 12.0;

    final labelGroup = Row(
      mainAxisSize: MainAxisSize.min,
      children: iconPosition == IconPosition.left
          ? [
              iconWidget,
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: contentColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ]
          : [
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: contentColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              iconWidget,
            ],
    );

    return [
      const SizedBox(width: edgeSpacerWidth),
      // Center the compact labelGroup inside the available width
      Expanded(child: Center(child: labelGroup)),
      const SizedBox(width: edgeSpacerWidth),
    ];
  }
}