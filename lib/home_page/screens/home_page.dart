import 'package:flutter/material.dart';
import 'package:macro_sync_client/home_page/screens/widgets/exports_widgets.dart';
import 'package:macro_sync_client/shared/exports_shared.dart';
import 'package:macro_sync_client/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "home_screen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // IOWebSocketChannel? channel;

    // void onPressHandler() {
    //   debugPrint("Conectando al servidor . . .");
    //   IOWebSocketChannel.connect("ws://192.168.100.16:433");
    //   channel.sink.add("HOLA DESDE FLUTTER!!");
    // }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Image.asset(
              "assets/images/home_background.png",
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Macro Sync Mobile",
                    size: 22,
                    textColor: AppTheme.colors.borderYellow,
                    strokeColor: Colors.white.withOpacity(0.1),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_buildTitle()],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildForm(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildForm(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Stack(
          children: [
            _buildPanel(),
            _buildVerticalBar(),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 16, top: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.colors.borderGray,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CustomText(
                  text: "INGRESA LOS DATOS DE MACRO SYNC DESKTOP",
                  size: 12,
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 12),
              child: const CustomForm()),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, "stratagems"),
              child: const ConnectButton(),
            ),
          )
        ],
      ),
    );
  }

  _buildVerticalBar() {
    return const Positioned(
      top: 10,
      left: 8,
      child: VerticalBar(height: 148, side: VerticalBarSide.left),
    );
  }

  _buildPanel() {
    return Container(
      height: 210,
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.8)),
    );
  }

  _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Image.asset("assets/images/helldivers_title.png", width: 260),
    );
  }
}