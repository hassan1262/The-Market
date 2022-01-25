import 'package:flutter/material.dart';
import 'package:super_market_application/shared/app_bar.dart';
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
      body: faq(),
    );
  }
}

class faq extends StatefulWidget {
  @override
  _faq createState() {
    return _faq();
  }
}

class _faq extends State<faq> {
  bool _expanded = false;
  bool _expanded1 = false;

  // var _test = "Full Screen";
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(15),
        color: Color(0xFF003566),
        child: ExpansionPanelList(
          animationDuration: Duration(milliseconds: 1000),
          children: [
            ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(
                    'What shall I do if I have been overcharged?',
                    style: TextStyle(color: Color(0xFF000814)),
                  ),
                );
              },
              body: Column(
                children: [
                  ListTile(
                    title: Text(
                        'Please consult our customer service desk or reach our customer service on 01xxxx.',
                        style: TextStyle(color: Color(0xFF000814))),
                  ),
                ],
              ),
              isExpanded: _expanded,
              canTapOnHeader: true,
            ),
            ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(
                    'I have been disappointed with the quality of a product I have purchased. What should I do ?',
                    style: TextStyle(color: Color(0xFF000814)),
                  ),
                );
              },
              body: Column(
                children: [
                  ListTile(
                    title: Text(
                        'We are very sorry you had a bad experience. Please consult our customer service desk or reach our customer services on16061. We will be happy to listen to you.',
                        style: TextStyle(color: Color(0xFF000814))),
                  ),
                ],
              ),
              isExpanded: _expanded1,
              canTapOnHeader: true,
            ),
          ],
          dividerColor: Color(0xFF000814),
          expansionCallback: (panelIndex, isExpanded) {
            if (panelIndex == 0) {
              _expanded = !_expanded;
            } else {
              _expanded1 = !_expanded1;
            }

            setState(() {});
          },
        ),
      ),
    ]);
  }
}
