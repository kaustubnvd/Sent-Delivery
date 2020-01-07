/*
  Authors: Suket Shah, Last Edit: 01/06/20
*/

// returns the http exception to caller. 
class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message;
    // return super.toString(); // Instance of HttpException
  }
}