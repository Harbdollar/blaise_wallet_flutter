import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/svg_repaint.dart';
import 'package:flutter/material.dart';

class IntroBackupConfirmPage extends StatefulWidget {
  @override
  _IntroBackupConfirmPageState createState() => _IntroBackupConfirmPageState();
}

class _IntroBackupConfirmPageState extends State<IntroBackupConfirmPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // The main scaffold that holds everything
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      backgroundColor: StateContainer.of(context).curTheme.backgroundPrimary,
      body: LayoutBuilder(
        builder: (context, constraints) => Column(
              children: <Widget>[
                //A widget that holds welcome animation + paragraph
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Container for the header
                      Container(
                        padding: EdgeInsetsDirectional.only(
                          top: (MediaQuery.of(context).padding.top) +
                              (24 - (MediaQuery.of(context).padding.top) / 2),
                        ),
                        decoration: BoxDecoration(
                          gradient: StateContainer.of(context)
                              .curTheme
                              .gradientPrimary,
                        ),
                        // Row for back button and the header
                        child: Row(
                          children: <Widget>[
                            // The header
                            Container(
                              width: MediaQuery.of(context).size.width - 60,
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(30, 24, 30, 24),
                              child: AutoSizeText(
                                "Backup Your Key!",
                                style: AppStyles.header(context),
                                maxLines: 3,
                                stepGranularity: 0.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container for the illustration
                      Container(
                        margin: EdgeInsetsDirectional.only(
                            top: MediaQuery.of(context).size.height * 0.1),
                        child: SvgRepaintAsset(
                            asset: 'assets/illustration_backup.svg',
                            width: MediaQuery.of(context).size.width / 1.75),
                      ),
                      //Container for the paragraph
                      Container(
                        alignment: Alignment(-1, 0),
                        margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                        child: AutoSizeText(
                          "Are you sure that you have backed up your new wallet’s private key?",
                          maxLines: 5,
                          stepGranularity: 0.1,
                          style: AppStyles.paragraph(context),
                        ),
                      ),
                    ],
                  ),
                ),

                //A column with "I've Backed It Up" and "No, Go Back" buttons
                Column(
                  children: <Widget>[
                    // "I've Backed It Up" button
                    Row(
                      children: <Widget>[
                        AppButton(
                          type: AppButtonType.Primary,
                          text: "YES, I'M SURE",
                          buttonTop: true,
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/accounts');
                          },
                        ),
                      ],
                    ),
                    // "No, Go Back" button
                    Row(
                      children: <Widget>[
                        AppButton(
                          type: AppButtonType.PrimaryOutline,
                          text: "NO, GO BACK",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}