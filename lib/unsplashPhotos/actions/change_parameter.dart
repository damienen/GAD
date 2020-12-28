class ChangeParameter {
  ChangeParameter(this.parameter, this.value);

  String parameter;
  String value;
}

class ChangeParameterSuccessful {
  const ChangeParameterSuccessful(this.parameters);

  final Map<String, String> parameters;
}

class ChangeParameterError {
  const ChangeParameterError(this.error);

  final dynamic error;
}
