abstract class PrintStateHelper {
  static String printState(String stateName, List<String> states) {
    if (states.isEmpty) {
      return '$stateName()';
    }

    return '$stateName(\n    ${states.join(',\n    ')}\n  )';
  }
}
