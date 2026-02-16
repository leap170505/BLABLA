import 'package:blabla/ui/widgets/actions/bla_icon_button.dart';
import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class SeatSpinner extends StatefulWidget {
  final int initialValue;
  final int min;
  final int max;

  const SeatSpinner({
    super.key,
    required this.initialValue,
    this.min = 1,
    this.max = 8,
  });

  @override
  State<SeatSpinner> createState() => _SeatSpinnerState();
}

class _SeatSpinnerState extends State<SeatSpinner> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  void _onChanged(int newValue) {
    setState(() {
      _currentValue = newValue;
    });
  }

  void _onConfirm() {
    Navigator.of(context).pop(_currentValue);
  }

  void _onCancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: BlaSpacings.s,
                left: BlaSpacings.l,
              ),
              child: IconButton(
                icon: Icon(Icons.close, color: BlaColors.primary),
                onPressed: _onCancel,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.l),
              child: Center(
                child: Text(
                  "Number of seats to book",
                  style: BlaTextStyles.heading.copyWith(
                    fontSize: 20,
                    color: BlaColors.textNormal,
                  ),
                ),
              ) 
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: BlaSpacings.xxl),
                _buildSpinButton(
                  icon: Icons.remove,
                  onPressed: _currentValue > widget.min
                      ? () => _onChanged(_currentValue - 1)
                      : null,
                ),
                Text(
                  _currentValue.toString(),
                  textAlign: TextAlign.center,
                  style: BlaTextStyles.heading.copyWith(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: BlaColors.neutralDark,
                  ),
                ),
                _buildSpinButton(
                  icon: Icons.add,
                  onPressed: _currentValue < widget.max
                      ? () => _onChanged(_currentValue + 1)
                      : null,
                ),
                const SizedBox(width: BlaSpacings.xxl),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: BlaSpacings.m),
        child: SizedBox(
          width: 50,
          height: 50,
          child: FloatingActionButton(
            onPressed: _onConfirm,
            backgroundColor: BlaColors.primary,
            child: const Icon(Icons.arrow_forward, color: Colors.white),
            elevation: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildSpinButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    final bool isDisabled = onPressed == null;
    final color = isDisabled ? BlaColors.disabled : BlaColors.primary;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Center(
        child: BlaIconButton(icon: icon, onPressed: onPressed),
      ),
    );
  }
}
