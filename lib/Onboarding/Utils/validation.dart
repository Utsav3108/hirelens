bool isValidEmail(String value) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(value.trim());
}

/*
01ABCDE1234F1Z5
↑↑↑↑↑ ↑↑↑↑↑ ↑↑↑↑↑
└─2 digits for state code (01–37)
└─10-char PAN (ABCDE1234F)
└─1 entity code + Z + checksum
*/

bool isValidGST(String value) {
  final gstRegex = RegExp(
    r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$',
  );
  return gstRegex.hasMatch(value.trim());
}
