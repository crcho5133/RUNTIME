interface class DestinationHelper {
  static String _getForSend(String type, String uuid) => '/pub/$type/$uuid';
  static String getForSub(String type, String uuid) => '/topic/$type/$uuid';

  static String getBattleDestination(String mode, String uuid) {
    if (mode == BattleModeHelper.matching) {
      return _getForSend('matchingRoom', uuid);
    }
    if (mode == BattleModeHelper.userMode) {
      return _getForSend('room', uuid);
    } else {
      return _getForSend('practice', uuid);
    }
  }

  static String getStartMatching(String userId) => '/queue/member/$userId';
  static String getMatchingReady(String uuid) => '/topic/matchingRoom/$uuid';
}

interface class BattleModeHelper {
  static String get matching => 'matching';
  static String get userMode => 'userMode';
  static String get practiceMode => 'practiceMode';
}

interface class ActionHelper {
  static get matchingStartAction => 'matching';
  static get battleStartAction => 'start';
  static get battleRejectedAction => 'notstart';
  static get battleGiveUpAction => 'exit';
  static get roomInforAction => 'member';
  static get battleRealTimeAction => 'realtime';
}
