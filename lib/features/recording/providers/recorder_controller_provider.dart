import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/features/recording/domain/recorder_controller.dart';
import 'package:pedali/features/recording/domain/recorder_state.dart';

final recorderControllerProvider =
    NotifierProvider<RecorderController, RecorderState>(RecorderController.new);
