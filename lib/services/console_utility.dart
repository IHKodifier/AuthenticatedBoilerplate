class ConsoleUtility {
  static void printToConsole(String string) {
    // print('\n\n');
    print('\n =============================App Log==========================>>>\n'+
    DateTime.now().toIso8601String()+'\n'+
    string+'\n<<<==============================================================');
  }
}
