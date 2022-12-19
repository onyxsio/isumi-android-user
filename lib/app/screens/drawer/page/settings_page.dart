import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool switchValue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'Settings'),
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TXTHeader.settingsHeader('Notifications'),
            SizedBox(height: 3.w),
            SettingsTile(
              title: 'Sales',
              subtitle: 'If you want to be notified when available offers',
              switchValue: switchValue,
              onChanged: (bool? value) {
                setState(() {
                  switchValue = value ?? false;
                });
              },
            ),
            SettingsTile(
              title: 'New arrivals',
              subtitle:
                  'If you want to be notified when available new arrivals',
              switchValue: switchValue,
              onChanged: (bool? value) {
                setState(() {
                  switchValue = value ?? false;
                });
              },
            ),
            SettingsTile(
              title: 'Delivery status',
              subtitle: 'If you need to know the delivery status',
              switchValue: switchValue,
              onChanged: (bool? value) {
                setState(() {
                  switchValue = value ?? false;
                });
              },
            ),
            SizedBox(height: 3.w),
            TXTHeader.settingsHeader('General'),
            SizedBox(height: 3.w),
            SettingsTile(
              title: 'Theme',
              subtitle: 'There is a dark or light theme to change',
              switchValue: switchValue,
              onChanged: (bool? value) {
                setState(() {
                  switchValue = value ?? false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    Key? key,
    required this.switchValue,
    required this.onChanged,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final Function(bool?) onChanged;
  final bool switchValue;
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 20.h,
      padding:
          EdgeInsets.symmetric(vertical: 2.w).copyWith(left: 5.w, right: 2.w),
      margin: EdgeInsets.symmetric(vertical: 2.w),
      decoration: BoxDeco.deco_5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TxtStyle.h7B),
                Text(subtitle, style: TxtStyle.b2),
              ],
            ),
          ),
          SizedBox(width: 3.w),
          Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              // This bool value toggles the switch.
              value: switchValue,
              activeColor: CupertinoColors.activeGreen,
              onChanged: onChanged,
            ),
          )
        ],
      ),
    );
  }
}
