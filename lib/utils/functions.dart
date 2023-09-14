String formatTime(int seconds) {
  final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
  final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
  final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
  if(hours == '00') return '$minutes:$remainingSeconds';
  return '$hours:$minutes:$remainingSeconds';
}

String formatRemainingTime(int seconds) {
  final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
  final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
  final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
  if(hours == '00') return '-$minutes:$remainingSeconds';
  return '-$hours:$minutes:$remainingSeconds';
}