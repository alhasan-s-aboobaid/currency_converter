

abstract class LatestConversionsEvent{
}

class GetLatestConversionsEvent extends LatestConversionsEvent {
  final String currency;

  GetLatestConversionsEvent({required this.currency});
}
