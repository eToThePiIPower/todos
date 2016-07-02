// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery.timeago
//= require bootstrap-sprockets
//= require jquery_ujs
//= require data-confirm-modal
//= require turbolinks
//= require_tree .

$(document).ready(function() {
  $.timeago.settings.allowFuture = true;
  $("time.timeago").timeago();

  $('.clear-field-link').click(function() {
    var formid = $(this).attr('data-formid');
    var fieldid = $(this).attr('data-fieldid');
    $(formid + ' ' + fieldid)[0].value = '';
  });
  $('.reset-field-link').click(function() {
    var formid = $(this).attr('data-formid');
    var fieldid = $(this).attr('data-fieldid');
    var resetValue = $(this).attr('data-reset-value');
    $(formid + ' ' + fieldid)[0].value = resetValue;
  });
  $(".alert-dismissable.alert-success")
    .fadeTo(2000, 500).slideUp(500, function() {
      $(".alert-dismissable.alert-success").alert('close');
    });
  $(".alert-dismissable.alert-danger")
    .fadeTo(5000, 500).slideUp(500, function() {
      $(".alert-dismissable.alert-danger").alert('close');
    });
});

/* global dataConfirmModal */
dataConfirmModal.setDefaults({
  modalClass: 'type-danger'
});
