import 'package:flutter/material.dart';

class ChartSwitch extends StatefulWidget {
  final bool showChart;
  final Function onSwitched;

  const ChartSwitch(
    this.showChart,
    this.onSwitched, {
    Key? key,
  }) : super(key: key);

  @override
  State<ChartSwitch> createState() => _ChartSwitchState();
}

class _ChartSwitchState extends State<ChartSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Show Chart",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Switch.adaptive(
            activeColor: Theme.of(context).colorScheme.secondary,
            value: widget.showChart,
            onChanged: (value) => widget.onSwitched(value)),
      ],
    );
  }
}
