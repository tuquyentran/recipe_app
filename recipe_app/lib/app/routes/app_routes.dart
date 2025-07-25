part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const splash = _Paths.splash;
  static const main = _Paths.main;
  static const home = _Paths.home;
  static const search = _Paths.search;
  static const mainsearch = _Paths.mainsearch;
  static const detail = _Paths.detail;
  static const favorites = _Paths.favorites;
}

abstract class _Paths {
  _Paths._();
  static const splash = '/splash';
  static const home = '/home';
  static const main = '/main';
  static const search = '/search';
  static const mainsearch = '/mainsearch';
  static const detail = '/detail';
  static const favorites = '/favorites';
  }