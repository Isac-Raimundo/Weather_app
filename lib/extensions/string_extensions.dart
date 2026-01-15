extension ExtensiosString on String {
  String toFirstCharToUpperCase(){
    return this[0].toUpperCase() + this.substring(1);
  }
}