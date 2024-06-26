// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macro_sync_helldivers/home_page/providers/exports_providers.dart';
import 'package:macro_sync_helldivers/home_page/screens/widgets/exports_widgets.dart';
import 'package:macro_sync_helldivers/shared/services/connection_service.dart';
import 'package:macro_sync_helldivers/shared/ui/exports_shared.dart';
import 'package:macro_sync_helldivers/stratagems_page/screens/stratagems_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static String routeName = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );

    homeProvider.loadDataFromLocalStorate(context);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final HomeProvider provider = Provider.of<HomeProvider>(context);

    if (provider.state.error) {
      showMyDialog(context);
      provider.state.error = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            _buildBackground(context),
            _buildMacroSyncTitle(),
            _buildHelldiversTitle(),
            _buildForm(context),
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog(BuildContext context) async {
    await Future.delayed(Duration.zero);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        insetPadding: const EdgeInsets.all(24),
        contentPadding: const EdgeInsets.all(24),
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.amber, width: 1)),
        title: const CustomText(
            maxLines: 10,
            size: 16,
            textAlign: TextAlign.center,
            text: "No fue posible realizar la conexion."),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CustomText(
                maxLines: 20,
                size: 14,
                textAlign: TextAlign.center,
                text:
                    "Compruebe que la DIRECCION IP y EL PUERTO sean los mismos que figuran en"),
            SizedBox(height: 8),
            CustomText(
                maxLines: 20,
                size: 14,
                textAlign: TextAlign.center,
                strokeColor: Colors.black,
                textColor: Colors.amber,
                text: " MacroSync Desktop Helldivers."),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const CustomButton(
                color: CustomButtonColors.yellow, text: "CERRAR", height: 40),
          ),
        ],
      ),
    );
  }

  Padding _buildHelldiversTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/images/helldivers_title.png",
                width: 260,
                color: Colors.amber[400],
              ),
            ],
          )
        ],
      ),
    );
  }

  Padding _buildMacroSyncTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: "Macro Sync",
            size: 20,
            textColor: Colors.amber[400]!,
            strokeColor: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Image _buildBackground(BuildContext context) {
    return Image.asset(
      "assets/images/home_background.png",
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
    );
  }

  _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 2, right: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              _buildPanel(),
              _buildContent(context),
              Padding(
                padding: const EdgeInsets.only(top: 250, left: 16, right: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: "Instala en tu computadora",
                            size: 14,
                          ),
                          CustomText(
                            text: "Macro Sync Helldivers Desktop",
                            textColor: Colors.amber,
                            size: 14,
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.fromBorderSide(
                                BorderSide(width: 2, color: Colors.blue[300]!),
                              ),
                              color: Colors.blue[400]!.withOpacity(0.5),
                            ),
                            child: GestureDetector(
                              onTap: _launchURL,
                              child: CustomText(
                                text: "Desde aqui",
                                size: 18,
                                textColor: Colors.blue[300]!,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _launchURL() async {
    final url = Uri.https(
      'github.com',
      'symphonic15/macrosync-helldivers-desktop/releases/tag/v1.0.2',
    );

    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        children: [
          _buildPanelTitle(),
          Container(
            margin: const EdgeInsets.only(top: 12),
            child: const CustomForm(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: GestureDetector(
              onTap: () {
                final HomeProvider provider =
                    Provider.of<HomeProvider>(context, listen: false);

                if (provider.state.port.isEmpty ||
                    provider.state.ipAddrress.isEmpty ||
                    provider.state.isLoading) {
                  return;
                }

                try {
                  ConnectionService.instance
                      .connectToServer(
                    provider.state.ipAddrress,
                    provider.state.port,
                    context,
                  )
                      .then(
                    (value) {
                      if (value) {
                        Navigator.pushNamed(context, StratagemsPage.routeName);
                      } else {
                        if (kDebugMode) {
                          print(
                              "No se pudo conectar al servidor: ConnectionService return false.");
                        }
                        provider.setMessageError(true);
                      }
                    },
                  ).onError(
                    (error, stackTrace) => throw Exception(error),
                  );
                } catch (error) {
                  if (kDebugMode) {
                    print("No se pudo conectar al servidor: $error.");
                  }
                  provider.setMessageError(true);
                }
              },
              child: const ConnectButton(),
            ),
          )
        ],
      ),
    );
  }

  Container _buildPanelTitle() {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.amber[500]!.withOpacity(0.6),
            width: 2,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Container()),
            ],
          ),
          CustomText(
            text: "INGRESA LOS DATOS DE",
            size: 16,
            maxLines: 2,
            textColor: Colors.white,
            strokeColor: Colors.black.withOpacity(0.7),
            textAlign: TextAlign.center,
          ),
          CustomText(
            text: "MACRO SYNC HELLDIVERS DESKTOP",
            size: 16,
            maxLines: 2,
            textColor: Colors.amber,
            strokeColor: Colors.black.withOpacity(0.7),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  _buildPanel() {
    return Container(
      height: 230,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        border: Border.all(
          color: Colors.amber[500]!.withOpacity(0.6),
          width: 2,
          strokeAlign: StrokeAlign.inside,
        ),
      ),
    );
  }
}
