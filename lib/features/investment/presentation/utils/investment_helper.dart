class InvestmentHelper {
  String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor ingrese un monto';
    }

    final double? amount = double.tryParse(value.trim());
    if (amount == null) {
      return 'Ingrese un número válido';
    }

    if (amount <= 0) {
      return 'El monto debe ser mayor a 0';
    }

    if (amount > 999999999) {
      return 'El monto excede el límite máximo';
    }

    if (value.contains('.')) {
      final decimals = value.split('.')[1];
      if (decimals.length > 2) {
        return 'Máximo 2 decimales permitidos';
      }
    }

    return null;
  }
}
