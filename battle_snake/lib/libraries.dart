library game;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:path_provider/path_provider.dart';


part 'snake.dart';
part 'laser.dart';
part 'game_state.dart';
part 'game_node.dart';
part 'villian.dart';
part 'coordinate_system.dart';
part 'render_coordinate_system.dart';
part 'components.dart';
part 'player_state.dart';
