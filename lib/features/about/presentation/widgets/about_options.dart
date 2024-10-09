import 'package:flutter/material.dart';

class AboutOptions extends StatelessWidget {
  const AboutOptions({
    super.key,
    this.onTapTermsofUse,
    this.onTapPrivacyPolicy,
  });

  final VoidCallback? onTapTermsofUse;
  final VoidCallback? onTapPrivacyPolicy;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        child: Column(
          children: [
            const ListTile(
              minTileHeight: 40,
              title: Text(
                "Application",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              trailing: Text(
                "HaBIT Note",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
            const ListTile(
              minTileHeight: 40,
              title: Text(
                "Version",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              trailing: Text(
                "V1.0.0",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
            ListTile(
              minTileHeight: 40,
              onTap: onTapPrivacyPolicy,
              title: const Text(
                "Privacy Policy",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            ListTile(
              minTileHeight: 40,
              onTap: onTapTermsofUse,
              title: const Text(
                "Terms of Use",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
