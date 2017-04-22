// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require cable
//= require_tree .

// document.addEventListener("turbolinks:load", function() {
//   $(function () {
//     $('[data-toggle="tooltip"]').tooltip()
//   })

//   // Material Select Initialization
//   $(document).ready(function() {
//     $('.mdb-select').material_select();
//   });
// })

$(document).on('turbolinks:load', function() {
  jQuery(document).ready(function ($) {
  
    var $toggle = $('#nav-toggle');
    var $menu = $('#nav-menu');
  
    $toggle.click(function() {
      $(this).toggleClass('is-active');
      $menu.toggleClass('is-active');
    });
  
    $('.modal-button').click(function() {
      var target = $(this).data('target');
      $('html').addClass('is-clipped');
      $(target).addClass('is-active');
    });
  
    $('.modal-background, .modal-close').click(function() {
      $('html').removeClass('is-clipped');
      $(this).parent().removeClass('is-active');
    });
  
    $('.modal-card-head .delete, .modal-card-foot .button').click(function() {
      $('html').removeClass('is-clipped');
      $('#modal-ter').removeClass('is-active');
    });
  
    $(document).on('keyup',function(e) {
      if (e.keyCode == 27) {
        $('html').removeClass('is-clipped');
        $('.modal').removeClass('is-active');
      }
    });
  
    var $highlights = $('.highlight');
  
    $highlights.each(function() {
      var $el = $(this);
      var copy = '<button class="copy">Copy</button>';
      var expand = '<button class="expand">Expand</button>';
      $el.append(copy);
  
      if ($el.find('pre code').innerHeight() > 600) {
        $el.append(expand);
      }
    });

    var $highlightButtons = $('.highlight .copy, .highlight .expand');
    
    $highlightButtons.hover(function() {
      $(this).parent().css('box-shadow', '0 0 0 1px #ed6c63');
    }, function() {
      $(this).parent().css('box-shadow', 'none');
    });
    
    $('.highlight .expand').click(function() {
      $(this).parent().children('pre').css('max-height', 'none');
    });
    
    new Clipboard('.copy', {
      target: function(trigger) {
        return trigger.previousSibling;
      }
    });
    
    });
})

var toggleNav = 1;

function openNav() {
  if (toggleNav == 0) {
    document.getElementById("sidenav").style.width = "0";
    document.getElementById("overlay").style.width = "0";
    document.getElementById("main").style.marginLeft = "0";
    if (document.getElementById("actionbar") != null) {
      document.getElementById("actionbar").style.marginLeft = "0";
    }
    toggleNav = 1;
  } else {
    document.getElementById("sidenav").style.width = "223px";
    toggleNav = 0;
    if (document.documentElement.clientWidth > 768) {
      document.getElementById("actionbar").style.marginLeft = "223px";
      document.getElementById("main").style.marginLeft = "223px";
    } else {
      document.getElementById("overlay").style.width = "100%";
    }
  }
  
  burger();
}

function closeNav() {
  document.getElementById("sidenav").style.width = "0";
  document.getElementById("overlay").style.width = "0";
  document.getElementById("actionbar").style.marginLeft = "0";
  document.body.style.overflowY = "visible"
  toggleNav = 1;
  burger();
}

function checkNav() {
  if (toggleNav == 0) {
      document.getElementById("sidenav").style.width = "223px";
      document.body.style.overflowY = "hidden"
      if (document.documentElement.clientWidth > 768) {
        document.getElementById("actionbar").style.marginLeft = "223px";
      } else {
        document.getElementById("overlay").style.width = "100%";
      }
      document.getElementById("nav-icon3").classList.add('open');
    }
}

function burger() {
  document.getElementById("nav-icon3").classList.toggle('open');
};
// $(document).on('turbolinks:load', function() {
//   $(function () {
//     $('[data-toggle="tooltip"]').tooltip()
//   })

//   // Material Select Initialization
//   $(document).ready(function() {
//     $('.mdb-select').material_select();
//   });
// })
