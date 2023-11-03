T? withAll<T>(List<T?> optionals, T Function(List<T>) callback) =>
    optionals.any((element) => element == null)
        ? null
        : callback(optionals.cast<T>());

String getFullName1(String? firstName, String? lastName) =>
    withAll([firstName, lastName], (names) => names.join(" ")) ??
    "Either first name or last name or both is null";

extension FlatMap<T> on T? {
  R? flatMap<R>(R? Function(T) callback) {
    final shadow = this;
    if (shadow == null) {
      return null;
    }
    return callback(shadow);
  }
}

String getFullName2(String? firstName, String? lastName) {
  return firstName.flatMap((first) {
        return lastName.flatMap((last) {
          return '$first $last';
        });
      }) ??
      'Either first name or last name or both is null';
}

extension Default<T> on T? {
  T get orDefault {
    final shadow = this;
    if (shadow != null) {
      return shadow;
    }
    switch (T) {
      case String:
        return 'X' as T; // X - to only check the terminal output: ''
      case int:
        return 0 as T;
      case double:
        return 0.0 as T;
      default:
        throw Exception('Unexpected type');
    }
  }
}

String getFullName3(String? firstName, String? lastName) {
  return '${firstName.orDefault} ${lastName.orDefault}';
}

void main(List<String> args) {
  // Unwrapping Multiple Optionals
  print(getFullName1(null, null));
  print(getFullName1("John", null));
  print(getFullName1(null, "Doe"));
  print(getFullName1("John", "Doe"));

  print("----------------------");

  // Optional FlatMap
  print(getFullName2(null, null));
  print(getFullName2("John", null));
  print(getFullName2(null, "Doe"));
  print(getFullName2("John", "Doe"));

  print("----------------------");

  // Extracting Default Values
  print(getFullName3(null, null));
  print(getFullName3("John", null));
  print(getFullName3(null, "Doe"));
  print(getFullName3("John", "Doe"));
}
