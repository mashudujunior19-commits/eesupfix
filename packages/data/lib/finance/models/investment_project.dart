/// An investment project a Wealth wallet can commit funds to. The database only
/// returns projects that are approved and accepting funds.
class InvestmentProject {
  final int id;
  final String name;
  final String? description;

  const InvestmentProject({
    required this.id,
    required this.name,
    this.description,
  });

  factory InvestmentProject.fromJson(Map<String, dynamic> json) {
    return InvestmentProject(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
    );
  }
}
