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

/** Handlers and functions that need to get bound both on
document.ready() and document.ajaxComplete() */
function bindHandlers() {
  $('time.timeago').timeago();

  // The clear and reset buttons on edit modals
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

  // Auto-closing alerts
  $('.alert-dismissable.alert-autoclose-fast')
    .fadeTo(2000, 500).slideUp(500, function() {
      $(this).remove();
    });
  $('.alert-dismissable.alert-autoclose-slow')
    .fadeTo(5000, 500).slideUp(500, function() {
      $(this).remove();
    });

  // Prevent widows on page and item titles
  $('.no-widows').each(function() {
    var wordArray = $(this).text().split(' ');
    var length = wordArray.length;
    if (wordArray.length > 1) {
      wordArray[length - 2] += '&nbsp;' + wordArray[length - 1];
      wordArray.pop();
      $(this).html(wordArray.join(' '));
    }
  });
}

$(document).ajaxComplete(function() {
  bindHandlers();

  $('#todo-items-active li.todo-list-item')
    .sort(sortPriority).appendTo('#todo-items-active');
});

$(document).ready(function() {
  $.timeago.settings.allowFuture = true;
  bindHandlers();

  $('.slide-up-toggler').click(function(e) {
    e.stopPropagation();
    $('.slide-up-panel').slideToggle("slow");
  });

  $('.slide-up-panel').click(function(e) {
    e.stopPropagation();
  });

  $(window).click(function() {
    $('.slide-up-panel').slideUp("slow");
  });

  $('#todo-items-active li.todo-list-item')
    .sort(sortPriority).appendTo('#todo-items-active');
});

/* global dataConfirmModal */
dataConfirmModal.setDefaults({
  modalClass: 'type-danger',
  commitClass: 'btn-modal-default'
});

// Sort functions we want made available elsewhere, such as AJAX responses
/* eslint-disable no-unused-vars */

/**
 * Sorts using the default sortorder in the item's data attributes
 * @param {Object} a - The first DOM object with a data-sortorder attribute
 * @param {Object} b - The second DOM object with a data-sortorder attribute
 * @return {integer} - Either 1 or -1
 */
function sortPriority(a, b) {
  return ($(b).data('sortorder')) < ($(a).data('sortorder')) ? 1 : -1;
}
