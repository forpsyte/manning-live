class SignInServiceCredentials {
  Map<String, dynamic> credentials = Map<String, dynamic>();
  
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