String formatPhoneNumber(String phone) {
  if (phone.startsWith('0')) {
    phone = phone.substring(1);
  }

  final part1 = phone.substring(0, 3);
  final part2 = phone.substring(3, 6);
  final part3 = phone.substring(6, 9);

  return '(+84) $part1 $part2 $part3';
}
