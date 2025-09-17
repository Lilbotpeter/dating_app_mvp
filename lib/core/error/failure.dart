abstract class Failure {
  final String message;
  
  const Failure(this.message);
}

class NetworkFailure extends Failure{
  final int? statusCode;
  const NetworkFailure(super.message,{this.statusCode});
}

class UnknowFailure extends Failure{
  const UnknowFailure(super.message);
}

