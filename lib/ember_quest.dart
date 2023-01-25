import 'package:ember_quest_plaformer/actors/ember.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'actors/water_enemy.dart';
import 'managers/segment_manager.dart';
import 'objects/ground_block.dart';
import 'objects/platform_block.dart';
import 'objects/star.dart';
import 'package:flutter/material.dart';

import 'overlays/hud.dart';

class EmberQuestGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {

  late EmberPlayer _ember;
  double objectSpeed = 0.0;

  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;

  int starsCollected = 0;
  int health = 3;

  @override
  Future<void >onLoad() async {
    // Load your game here
    await loadImages();
    initializeGame(true);

  }

  @override
  void update(double dt) {
    if (health <= 0) {
      overlays.add('game_over');
    }
    super.update(dt);
  }

  Future<void> loadImages() async {

    await images.loadAll(<String>[
      'block.png',
      'ember.png',
      'ground.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
    ]);

  }

  void initializeGame(bool loadHud) {

    // Assume that size.x < 3200
    print("SIZE X: ${size.x}");

    // ceil arredonda pra cima
    final int segmentsToLoad = (size.x / 640).ceil();

    // clamp limita o valor entre 0 e o tamanho do array
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {

      loadGameSegments(i, (640 * i).toDouble());

    }

    _ember = EmberPlayer(
      position: Vector2(128, canvasSize.y - 128),
    );

    add(_ember);
    if (loadHud) {
      add(Hud());
    }

  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {

    for (final block in segments[segmentIndex]) {

      print("segmentIndex: $segmentIndex");
      print("xPositionOffset: $xPositionOffset");

      switch (block.blockType) {
        case GroundBlock:

          add(GroundBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));

          break;
        case PlatformBlock:

          add(PlatformBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));

          break;
        case Star:

          add(Star(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));

          break;
        case WaterEnemy:

          add(WaterEnemy(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));

          break;
      }

    }

  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }

  void reset() {
    starsCollected = 0;
    health = 3;
    initializeGame(false);
  }

}