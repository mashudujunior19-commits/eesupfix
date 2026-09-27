/// A Contact Person's role in the order workflow: who is allowed to load an
/// order (add items) versus who approves it and processes payment.
enum ContactPersonRole {
  orderLoader,
  orderApprover;

  @override
  String toString() {
    switch (this) {
      case ContactPersonRole.orderLoader:
        return 'order_loader';
      case ContactPersonRole.orderApprover:
        return 'order_approver';
    }
  }

  String get label {
    switch (this) {
      case ContactPersonRole.orderLoader:
        return 'Order Loader';
      case ContactPersonRole.orderApprover:
        return 'Order Approver';
    }
  }

  factory ContactPersonRole.fromString(String value) {
    switch (value) {
      case 'order_loader':
        return ContactPersonRole.orderLoader;
      case 'order_approver':
        return ContactPersonRole.orderApprover;
      default:
        throw Exception('Unknown contact person role: $value');
    }
  }
}
