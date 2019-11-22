class SignInServiceCredentials {
  Map<String, String> credentials = Map<String, String>();
  
  void addCredential(String key, dynamic value) {
    credentials[key] = value;
  }

  dynamic getCredential(String key) {
    return credentials.containsKey(key) ? credentials[key] : null;
  }

  Map<String, dynamic> getAll() {
    return credentials.isNotEmpty ? credentials : null;
  }
}