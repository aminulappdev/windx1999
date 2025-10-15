class Urls {
  static const String _baseUrl = 'http://74.118.168.203:5011/api/v1';
  //static const String _baseUrl = 'http://10.10.10.16:5011/api/v1';
  static const String socketUrl = 'http://74.118.168.203:4011/';
  // static const String socketUrl = 'http://192.168.10.144:4001/';
  static const String createUserUrl = '$_baseUrl/users/register';
  static const String otpVerifyUrl = '$_baseUrl/otp/verify-otp';
  static const String loginUrl = '$_baseUrl/auth/login';
  static const String forgotEmailUrl = '$_baseUrl/auth/forgot-password';
  static const String changePasswordUrl = '$_baseUrl/auth/change-password';
  static const String resetPasswordUrl = '$_baseUrl/auth/reset-password';
  static const String resendOtpUrl = '$_baseUrl/otp/resend-otp';
  static const String userUpdateProfileUrl =
      '$_baseUrl/users/update-my-profile';
  static const String allPackageUrl = '$_baseUrl/packages';
  static const String getMyProfleUrl = '$_baseUrl/users/my-profile';
  static const String orderUrl = '$_baseUrl/orders';
  static const String paymentCheckoutUrl = '$_baseUrl/payments/checkout';
  static const String allPostUrl = '$_baseUrl/feeds/public';
  static const String myOrderUrl = '$_baseUrl/orders/my-order';
  static const String allReelsUrl = '$_baseUrl/reels';
  static const String hidePostUrl = '$_baseUrl/feeds/hide-post';
  static const String savePostUrl = '$_baseUrl/watch-later';
  static const String addChatUrl = '$_baseUrl/chats';
  static const String feedPostUrl = '$_baseUrl/feeds';
  static const String reelsPostUrl = '$_baseUrl/reels';
  static const String createWishListUrl = '$_baseUrl/wishlists';
  static const String allWishListUrl = '$_baseUrl/wishlists/my-wishlist';
  static const String allFriendsChatnUrl = '$_baseUrl/chats/my-chat-list';
  static const String reportUserUrl = '$_baseUrl/reports';
  static const String sendMessageUrl = '$_baseUrl/messages/send-messages';
  static const String notificationUrl = '$_baseUrl/notification';
  static const String mySavePostUrl = '$_baseUrl/watch-later/my-watch-later';
  static const String allBlockersUrl = '$_baseUrl/profile-block/my-block';
  static const String allUserssUrl = '$_baseUrl/users/public';
  static const String sendCommentUrl = '$_baseUrl/comments';
  static const String contentUrl = '$_baseUrl/contents';
  static const String refundWishlistUrl = '$_baseUrl/refund-requests';
  static const String scrapingUrl = '$_baseUrl/wishlists/scrap-link';

  static String updateUserByUrl(
    String id,
  ) {
    return '$_baseUrl/users/update/$id';
  }

  static String commentByContentId(
    String id,
  ) {
    return '$_baseUrl/comments/content/$id';
  }

  static String postDetailsById(
    String id,
  ) {
    return '$_baseUrl/feeds/$id';
  }

  static String allFollowersById(
    String id,
  ) {
    return '$_baseUrl/connection/followers/$id';
  }

  static String allFollowingById(
    String id,
  ) {
    return '$_baseUrl/connection/following/$id';
  }

  static String othersWishlistById(
    String id,
  ) {
    return '$_baseUrl/wishlists/user/$id';
  }

  static String allFeedById(
    String id,
  ) {
    return '$_baseUrl/feeds/user/$id';
  }

  static String otherUserByUrl(
    String id,
  ) {
    return '$_baseUrl/users/$id';
  }

  static String confirmedPaymentUrlsById(
    String id,
  ) {
    return '$_baseUrl/payments/reference/$id';
  }

  static String followRequestById(
    String id,
  ) {
    return '$_baseUrl/connection/follow/$id';
  }

  static String unfollowRequestById(
    String id,
  ) {
    return '$_baseUrl/connection/unfollow/$id';
  }

  static String reactById(
    String id,
  ) {
    return '$_baseUrl/content-meta/like/$id';
  }

  static String disReactById(
    String id,
  ) {
    return '$_baseUrl/content-meta/unlike/$id';
  }

  static String wishlistById(
    String id,
  ) {
    return '$_baseUrl/wishlists/$id';
  }

  static String blockUserById(
    String id,
  ) {
    return '$_baseUrl/profile-block/block/$id';
  }

  static String getMessagesUrl(
    String id,
  ) {
    return '$_baseUrl/messages/my-messages/$id';
  }

  static String deleteAccountById(
    String id,
  ) {
    return '$_baseUrl/users/$id';
  }

  static String deleteWishlistById(
    String id,
  ) {
    return '$_baseUrl/wishlists/$id';
  }

  static String deleteSavePostById(
    String id,
  ) {
    return '$_baseUrl/watch-later/$id';
  }

  static String deleteChatDataById(
    String id,
  ) {
    return '$_baseUrl/messages/chat/$id';
  }

  static String unSavePostById(
    String id,
  ) {
    return '$_baseUrl/watch-later/content/$id';
  }

  static String userUnblockById(
    String id,
  ) {
    return '$_baseUrl/profile-block/unblock/$id';
  }
}
