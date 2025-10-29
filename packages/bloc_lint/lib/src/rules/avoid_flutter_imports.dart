import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// {@template avoid_flutter_imports}
/// The avoid_flutter_imports lint rule.
/// {@endtemplate}
class AvoidFlutterImports extends AnalysisRule {
  /// {@macro avoid_flutter_imports}
  AvoidFlutterImports()
    : super(
        name: rule,
        description: 'Avoid importing Flutter packages.',
      );

  static const LintCode _code = LintCode(
    rule,
    'Avoid importing Flutter packages.',
    correctionMessage: "Try removing 'await'.",
  );

  /// The name of the lint rule.
  static const rule = 'avoid_flutter_imports';

  @override
  LintCode get diagnosticCode => _code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _Visitor(this, context);
    registry.addAwaitExpression(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule, this.context);
  final AnalysisRule rule;

  final RuleContext context;

  static const flutterImport = 'package:flutter/';

  @override
  void visitImportDirective(ImportDirective node) {
    final uri = node.libraryImport?.importedLibrary?.uri.toString();
    if (uri == null) return;
    if (uri.startsWith(flutterImport)) return;

    rule.reportAtNode(
      node,
      arguments: [
        'Dalarme - Avoid importing Flutter packages.',
        'Try removing the import of Flutter packages.',
      ],
    );
    // context.reportErrorForNode(
    //   rule.diagnosticCode,
    //   node.uri,
    //   [],
    //   message: 'Avoid importing Flutter packages.',
    //   correction: 'Try removing the import of Flutter packages.',
    // );
  }
}
