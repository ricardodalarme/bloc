import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:bloc_lint/src/rules/my_rule.dart';
import 'package:bloc_lint/src/rules/rules.dart';

final plugin = BlocLintPlugin();

class BlocLintPlugin extends Plugin {
  @override
  String get name => 'bloc_lint';

  @override
  void register(PluginRegistry registry) {
    registry
      ..registerLintRule(AvoidFlutterImports())
      ..registerLintRule(MyRule());
  }
}
