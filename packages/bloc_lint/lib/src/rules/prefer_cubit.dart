import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// {@template prefer_cubit}
/// The prefer_cubit lint rule.
/// {@endtemplate}
class PreferCubit extends AnalysisRule {
  /// {@macro prefer_cubit}
  PreferCubit()
    : super(
        name: rule,
        description: 'A longer description of the rule.',
      );
  static const LintCode _code = LintCode(
    rule,
    'No await expressions',
    correctionMessage: "Try removing 'await'.",
  );

  /// The name of the lint rule.
  static const rule = 'prefer_cubit';

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

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final extendz = node.extendsClause;

    if (extendz == null) return;

    final superclazz = extendz.superclass;

    if (superclazz.name.lexeme.endsWith('Bloc')) {
      final prefix = superclazz.name.lexeme.split('Bloc').first;
      rule.reportAtNode(
        node,
        arguments: [
          'Avoid extending ${prefix}Bloc.',
          'Prefer extending ${prefix}Cubit instead.',
        ],
      );
    }
  }
}
