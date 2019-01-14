var JailbreakOptions = {

  show: function(success, error) {
    cordova.exec(
      success,
      error,
      "JailbreakOptions",
      "isJailbrokenDevice",
      []
    );
  }

};

module.exports = JailbreakOptions;