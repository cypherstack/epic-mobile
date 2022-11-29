import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:epicmobile/models/stack_restoring_ui_state.dart';

final stackRestoringUIStateProvider =
    ChangeNotifierProvider<StackRestoringUIState>(
        (ref) => StackRestoringUIState());
