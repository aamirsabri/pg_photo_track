  import 'error_handling.dart';

  class Failure {
    int code;
    String messege;
    Failure(this.code, this.messege);
  }

  class DefaultFailure extends Failure {
    DefaultFailure() : super(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
  }
