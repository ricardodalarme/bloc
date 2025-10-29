import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

class MyRule extends AnalysisRule {
  MyRule()
    : super(
        name: 'my_rule',
        description: 'A longer description of the rule.',
      );
  static const LintCode code = LintCode(
    'my_rule',
    'No await expressions',
    correctionMessage: "Try removing 'await'.",
  );

  @override
  LintCode get diagnosticCode => code;

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
  void visitAwaitExpression(AwaitExpression node) {
    if (context.isInLibDir) {
      rule.reportAtNode(node);
    }
  }
}
