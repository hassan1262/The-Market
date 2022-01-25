import 'package:flutter/material.dart';
import 'package:super_market_application/shared/app_bar.dart';
import 'package:super_market_application/shared/rich_text.dart';
import 'package:super_market_application/shared/side_menu_bar.dart';

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: TopBar('FAQs'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              const SizedBox(height: 5.0),
              RichTextUpdated(
                text:
                    'Arcu sagittis posuere ridiculus massa. Nostra justo tincidunt iaculis vitae. Sed ridiculus taciti neque. Venenatis parturient habitant consequat ad quis nibh pede. Efficitur sapien platea est blandit accumsan suscipit felis.',
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Arcu sagittis posuere ridiculus massa. Nostra justo tincidunt iaculis vitae. Sed ridiculus taciti neque.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
