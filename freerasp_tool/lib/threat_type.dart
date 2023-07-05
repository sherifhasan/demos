class ThreatType {
  ThreatType(this._text);

  final String _text;
  bool _isSecure = true;

  void threatFound() => _isSecure = false;

  String get state => '$_text: ${_isSecure ? "Secured" : "Detected"}\n';
}
