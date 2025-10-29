import 'package:analyzer/src/lint/registry.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:bloc_lint/src/rules/prefer_cubit.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

@reflectiveTest
class PreferCubitTest extends AnalysisRuleTest {
  @override
  void setUp() {
    Registry.ruleRegistry.registerLintRule(PreferCubit());
    super.setUp();
  }

  @override
  String get analysisRule => PreferCubit.rule;

  void test_extends_bloc() async {
    await assertDiagnostics(
      r'''
import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decrement }
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);       
}
''',
      [lint(32, 7)],
    );
  }

  void test_no_await() async {
    await assertNoDiagnostics(r'''
void f(Future<int> p) async {
  // No await.
}
''');
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(PreferCubitTest);
  });
}
