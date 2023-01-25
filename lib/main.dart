import 'package:ember_quest_plaformer/actors/ember.dart';
import 'package:ember_quest_plaformer/overlays/game_over.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'actors/water_enemy.dart';
import 'ember_quest.dart';
import 'managers/segment_manager.dart';
import 'objects/ground_block.dart';
import 'objects/platform_block.dart';
import 'objects/star.dart';
import 'overlays/main_menu.dart';

void main(){
  runApp(
      GameWidget<EmberQuestGame>.controlled(
          gameFactory: EmberQuestGame.new,
        overlayBuilderMap: {
            'main_menu': (_, game) => MainMenu(game: game),
            'game_over': (_, game) => GameOver(game: game),
        },
        initialActiveOverlays: [ 'main_menu' ],
      )
  );

}