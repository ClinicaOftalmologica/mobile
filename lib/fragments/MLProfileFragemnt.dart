import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:medilab_prokit/components/MLProfileBottomComponent.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/utils/MLImage.dart';

import '../share_preferens/user_preferences.dart';

class MLProfileFragment extends StatefulWidget {
  static String tag = '/MLProfileFragment';

  @override
  MLProfileFragmentState createState() => MLProfileFragmentState();
}

class MLProfileFragmentState extends State<MLProfileFragment> {
  final prefs = UserPreferences();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 225,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: mlColorDarkBlue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          child: Image.asset(ml_ic_profile_picture!),
                          radius: 40.0,
                          backgroundColor: mlColorCyan),
                      8.height,
                      Text('Kaixa Pham',
                          style: boldTextStyle(color: white, size: 24)),
                      4.height,
                      Text(prefs.email,
                          style: secondaryTextStyle(color: white, size: 16)),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return MLProfileBottomComponent();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
