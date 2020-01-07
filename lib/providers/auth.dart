import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

/*
  Authors: Suket Shah, Last Edit: 01/06/20
*/

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String userId;
  Timer _authTimer;

  // Returns if the Authentication token is null or not. 
  bool get isAuth {
    return _token != null;
  }

  // Returns the token sent by Firebase. 
  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return token;
    }
    return null;
  }

  // authenticates the user for both login and sign up when called. 
  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:${urlSegment}?key=AIzaSyDMW5PCZ2_QX1clwO9vvZiMM_g8fumhlFM';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        // checks for response.
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': userId,
        'expireyDate': _expiryDate.toIso8601String(),
      });
      prefs.setString(
        'userData',
        userData,
      );
    } catch (error) {
      print(error);
      var errorMessage = 'Authentication failed';

      // prints a series of errors based on what the user's issue is. 
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address already exists';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (errorMessage.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      print(errorMessage);
    }
  }

  // provides the keywords for the sign up url. 
  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, ('signUp'));
  }

  // provides the keywords fro the login url. 
  Future<void> login(String email, String password) async {
    return _authenticate(email, password, ('signInWithPassword'));
  }

  // uses the expirey date to determine if an auto login is possible or not.
  // if it is an autologin is attempted. 
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expireyDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  // logs the user out when called upon. 
  Future<void> logout() async {
    _token = null;
    _expiryDate = null;
    userId = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  // Checks the expiry date and logs user out if they are logged in past the date. 
  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpirey = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpirey), logout);
  }
}
