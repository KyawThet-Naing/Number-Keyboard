class NumberKeyModel {
  final String primaryLabel;
  final String secondaryLabel;
  final String value;
  final bool isBlank;
  final bool isBackspace;
  NumberKeyModel({
    this.primaryLabel = "",
    this.secondaryLabel = "",
    this.isBlank = false,
    this.isBackspace = false,
    this.value = "",
  });
}
