import 'package:peer_programing/src/utils/dev.dart';

String generateRandomGravatarUrl() =>
  "https://www.gravatar.com/avatar/${generateRandHex(32)}?s=256&d=identicon&r=PG";
