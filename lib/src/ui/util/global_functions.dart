String formatDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}

String formatDateApi(DateTime date) {
  return "${date.year}-${date.month}-${date.day}";
}
