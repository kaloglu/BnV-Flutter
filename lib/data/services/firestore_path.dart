class FirestorePath {
  static String raffle(String raffleId) => 'raffles/$raffleId';
  static String raffles() => 'raffles';
  static String enroll(String uid, String enrollId) => 'users/$uid/enrolls/$enrollId';
  static String ticket(String uid, String ticketId) => 'users/$uid/tickets/$ticketId';
  static String enrolls(String uid) => 'users/$uid/enrolls';
  static String tickets(String uid) => 'users/$uid/tickets';
}
