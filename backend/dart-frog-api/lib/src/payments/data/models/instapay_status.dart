enum InstapayStatus {
  completed,
  expired,
  pending,
  concelled;

  factory InstapayStatus.fromString(String status) {
    switch (status) {
      case 'COMPLETED':
        return InstapayStatus.completed;
      case 'EXPIRED':
        return InstapayStatus.expired;
      case 'PENDING':
        return InstapayStatus.pending;
      case 'CANCELLED':
        return InstapayStatus.concelled;
      default:
        return InstapayStatus.pending;
    }
  }
}
