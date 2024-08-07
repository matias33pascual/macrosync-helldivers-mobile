import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/shared/services/connection_service.dart';
import 'package:macros_to_helldivers/shared/translation/translation_provider.dart';
import 'package:macros_to_helldivers/shared/ui/custom_text.dart';
import 'package:macros_to_helldivers/stratagems_page/models/stratagems_model.dart';
import 'package:provider/provider.dart';

class StratagemListButton extends StatefulWidget {
  const StratagemListButton({
    Key? key,
    required this.stratagem,
  }) : super(key: key);

  final StratagemModel stratagem;

  @override
  State<StratagemListButton> createState() => _StratagemListButtonState();
}

class _StratagemListButtonState extends State<StratagemListButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final TranslationProvider translationProvider =
        Provider.of<TranslationProvider>(context, listen: false);

    return GestureDetector(
      onTapDown: (details) => setState(() {
        isPressed = true;

        final message = {
          "type": "use-stratagem",
          "value": widget.stratagem.id,
        };

        final jsonMessage = jsonEncode(message);

        ConnectionService.instance.sendMessage(message: jsonMessage);
      }),
      onTapUp: (details) => setState(() {
        isPressed = false;
      }),
      onTapCancel: () => setState(() {
        isPressed = false;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isPressed
              ? Colors.blue.withOpacity(0.5)
              : Colors.blue[800]!.withOpacity(0.4),
          border: Border.all(
            color: isPressed ? Colors.blue[400]! : Colors.blue.withOpacity(0.7),
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(2)),
        ),
        child: Transform.scale(
          scale: isPressed ? 0.99 : 1,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Image.asset(
                  widget.stratagem.icon,
                  height: 80,
                ),
              ),
              Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: CustomText(
                    textAlign: TextAlign.start,
                    text: translationProvider
                        .getTranslationOfStratagemName(widget.stratagem.id),
                    size: 17,
                    maxLines: 2,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
