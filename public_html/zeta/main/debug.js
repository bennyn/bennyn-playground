// Generated by CoffeeScript 1.6.3
(function() {
  var email, property, pw, user;

  property = new Zeta.Registration.UserProperty("property");

  pw = new Zeta.Registration.UserPassword("password");

  email = new Zeta.Registration.UserEmailAddress("email");

  user = new Zeta.Registration.User("Benny", "benny@wearezeta.com", "abc123");

  alert(user.name.value);

}).call(this);

/*
//@ sourceMappingURL=debug.map
*/
