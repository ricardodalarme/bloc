import 'package:analyzer/src/lint/registry.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:bloc_lint/src/rules/avoid_flutter_imports.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

@reflectiveTest
class AvoidFlutterImportsTest extends AnalysisRuleTest {
  @override
  void setUp() {
    Registry.ruleRegistry.registerLintRule(AvoidFlutterImports());
    super.setUp();
  }

  @override
  String get analysisRule => AvoidFlutterImports.rule;

  // Test cases go here.
  //   void test_has_await() async {
  //     await assertDiagnostics(
  //       r'''
  // void f(Future<int> p) async {
  //   await p;
  // }
  // ''',
  //       [lint(33, 5)],
  //     );
  //   }

  //   void test_no_await() async {
  //     await assertNoDiagnostics(r'''
  // void f(Future<int> p) async {
  //   // No await.
  // }
  // ''');
  //   }

  Future<void> test_imports_flutter() async {
    await assertDiagnostics(
      '''
import 'package:flutter/material.dart';
void f() {}
''',
      [lint(7, 31)],
    );
  }

  Future<void> test_does_not_import_flutter() async {
    await assertNoDiagnostics('''
import 'package:bloc/bloc.dart';
void f() {}
''');
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AvoidFlutterImportsTest);
  });
}
