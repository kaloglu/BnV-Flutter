class FirestorePath {
  static String raffle(String uid, String raffleId) => 'users/$uid/raffles/$raffleId';
  static String raffles(String uid) => 'users/$uid/raffles';
  static String enroll(String uid, String enrollId) => 'users/$uid/enrolls/$enrollId';
  static String enrolls(String uid) => 'users/$uid/enrolls';
}
