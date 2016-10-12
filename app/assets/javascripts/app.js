"use strict";
define([
  'jquery',
  'backbone',
  'models',
  'authentication',
  'vent',
  'components/login',
  'components/navigation',
  'views/admin',
  'views/public',
  'views/signup',
  'views/edit-details'
], function($, bb, models, authentication, vent, login, navigation, admin, pub, signup, editDetails) {

  var contentEl;

  var ApplicationRouter = bb.Router.extend({
    routes: {
      'admin' : 'showAdminScreen',
      'party/:id' : 'showPublicScreen',
      'sign_up' : 'showSignUpScreen',
      'forgot_password' : 'showForgotDialog',
      'edit-own-details' : 'showOwnDetailsEditor',
      'login'   : 'startingPage'
    },

    initialize: function() {
      _.bindAll(this);
      this.listenTo(vent.itself(), 'successful-login', this.afterSuccessfulLogin);
    },

    afterSuccessfulLogin: function() {
      this.createNavigation();
      var hash = authentication.getFollowUp();
      this.navigate(hash, {trigger: true});
    },

    createNavigation: function() {
      navigation.createNavigation();
      contentEl.html("<h3>Select interested event from the upper right corner navigation.</h3>");
    },

    startingPage: function() {
      pub.detach();
      admin.detach();
      initLogin();
    },

    showAdminScreen: function() {
      pub.detach();
      admin.initialize({el:contentEl});
    },

    showSignUpScreen: function() {
      signup.initialize({el:contentEl});
    },

    showForgotDialog: function() {
      var email = prompt("write here your account email");
      if (email) {
	sendResetMail(email);
      }
      window.location.hash = 'login';
    },

    showOwnDetailsEditor: function() {
      editDetails.initialize({el:contentEl, currentUser: authentication.currentUser});
    },

    showPublicScreen: function(title) {
      var party = new models.PartyFinder({title: title});
      admin.detach();
      pub.initialize({el:contentEl, party: party, currentUser: authentication.currentUser});
    }
  });

  var loginView;
  var initLogin = function() {
    loginView = loginView || login.createComponent({el:contentEl});
    loginView.render();
  };

  var sendResetMail = function(email) {
    $.get("/reset_password?email=" + email, function(data) {
      $('#reset-password-email .modal-body').html("Email has sent to email address, go check your mails");
      $('#reset-password-email').modal('show');
    }).fail(function(data) {
      $('#reset-password-email .modal-body').html("Something went wrong, contact webmaster@entropy.fi");
      $('#reset-password-email').modal('show');
    });
  };

  var afterAuth = function() {
    var router = new ApplicationRouter();
    if (!authentication.currentUser()) {
      initLogin();
    } else {
      router.createNavigation();
    }
    bb.history.start();
  };

  var initialize = function(options) {
    contentEl = options.el;
    authentication.initialize(afterAuth);
  };

  return {initialize: initialize};
});
