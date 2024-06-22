import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/domain/entities/qr_code_data.dart';
import 'package:cubik_club/domain/services/events_service.dart';
import 'package:cubik_club/domain/services/games_service.dart';
import 'package:cubik_club/ui/common/components/export/components.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/widgets/game_thumbnail.dart';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

enum CCQrCodePrefixType { game, event }

class CCQrCode {
  final CCQrCodePrefixType prefix;
  final int id;
  final String modificator;

  CCQrCode({
    required this.prefix,
    required this.id,
    this.modificator = '',
  });

  String getPrefix() {
    switch (prefix) {
      case CCQrCodePrefixType.game:
        return 'Настольная игра';
      case CCQrCodePrefixType.event:
        return 'Мероприятиe';
    }
  }
}

class QrScannerScreenViewModel extends ChangeNotifier {
  bool isScannedValid = false;
  final _cameraController = MobileScannerController(
    facing: CameraFacing.back,
    torchEnabled: false,
    detectionSpeed: DetectionSpeed.noDuplicates,
    returnImage: true,
  );
  MobileScannerController get cameraController => _cameraController;

  CCQrCode? validateQrCode(String code) {
    final parts = code.split(':');

    if (parts.length == 3) {
      if (int.tryParse(parts[1]) is int) {
        switch (parts[0].toLowerCase()) {
          case 'event':
            return CCQrCode(
              prefix: CCQrCodePrefixType.event,
              id: int.tryParse(parts[1])!,
            );
          case 'game':
            return CCQrCode(
              prefix: CCQrCodePrefixType.game,
              id: int.tryParse(parts[1])!,
            );
          default:
            return null;
        }
      }
    }

    return null;
  }

  Future<List<Map<dynamic, dynamic>>> loadEntityFromId(CCQrCode code) async {
    switch (code.prefix) {
      case CCQrCodePrefixType.game:
        final gamesService = GamesService();

        return await gamesService.getGamesListByIds([code.id]);
      case CCQrCodePrefixType.event:
        final eventsService = EventsService();

        return await eventsService.getEventsListFromIds([code.id]);
    }
  }

  Game parseGame(Map<dynamic, dynamic>? gameJson) {
    if (gameJson == null) {
      throw Error();
    }
    return Game.fromJson(gameJson);
  }

  Event parseEvent(Map<dynamic, dynamic>? eventJson) {
    if (eventJson == null) {
      throw Error();
    }
    return Event.fromJson(eventJson);
  }

  void onMobileScannerDetect(BuildContext context, BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    // final Uint8List? image = capture.image;
    for (final barcode in barcodes) {
      debugPrint('Barcode found! ${barcode.rawValue}');
    }

    final CCQrCode? qrCode = validateQrCode(barcodes.first.rawValue ?? '');

    if (qrCode != null) {
      isScannedValid = true;
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: FutureBuilder(
              future: loadEntityFromId(qrCode),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    break;
                }

                if (!snapshot.hasData || snapshot.hasError) {
                  return const Center(
                      child: Text('Не удалось получить данные'));
                }

                IQrCodeAble? entity;
                try {
                  switch (qrCode.prefix) {
                    case CCQrCodePrefixType.event:
                      entity = parseEvent(snapshot.data?[0]);
                      return ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              qrCode.getPrefix(),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          EventThumbnail(
                            event: entity as Event,
                            onTap: (event) async {
                              Navigator.of(context).pop();
                              await MainNavigation.toEventScreen(context,
                                  event: entity as Event, replacement: true);
                            },
                          ),
                        ],
                      );
                    case CCQrCodePrefixType.game:
                      entity = parseGame(snapshot.data?[0]);

                      return ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              qrCode.getPrefix(),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 15),
                          GameThumbnail(
                            game: entity as Game,
                            onTap: (game) async {
                              Navigator.of(context).pop();
                              await MainNavigation.toGameScreen(context,
                                  game: game, replacement: true);
                            },
                          ),
                        ],
                      );
                  }
                } catch (e) {
                  debugPrint(e.toString());
                  return const Center(
                    child: Text('Что-то пошло не так'),
                  );
                }
              },
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Ошибка'),
            content: Text('Qr Code не распознан'),
          );
        },
      );
    }
  }

  void onTorchButtonPressed() {
    _cameraController.toggleTorch();
  }

  void onCameraFacingButtonPressed() {
    _cameraController.switchCamera();
  }

  Widget createTorchButtonIcon({required Icon onIcon, required Icon offIcon}) {
    return ValueListenableBuilder(
      valueListenable: cameraController.torchState,
      builder: (context, state, child) {
        switch (state) {
          case TorchState.off:
            return onIcon;
          case TorchState.on:
            return offIcon;
        }
      },
    );
  }
}
