import 'package:analyzer/src/lint/registry.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:bloc_lint/src/rules/my_rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

@reflectiveTest
class MyRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    Registry.ruleRegistry.registerLintRule(MyRule());
    super.setUp();
  }

  @override
  String get analysisRule => 'my_rule';

  void test_has_await() async {
    await assertDiagnostics(
      r'''
void f(Future<int> p) async {
  await p;
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
    defineReflectiveTests(MyRuleTest);
  });
}
