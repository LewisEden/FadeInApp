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
    document.getElementById("sidenav").classList.toggle('sidenav-border');
    document.getElementById("overlay").style.width = "0";
    document.getElementById("main").style.marginLeft = "0";
    if (document.getElementById("actionbar") != null) {
      document.getElementById("actionbar").style.marginLeft = "0";
      document.getElementById("actionbar").style.paddingRight = "0";
    }
    if (document.getElementById('profile-card') != null) {
      document.getElementById('profile-card').style.marginLeft = '0';
    }
    toggleNav = 1;
  } else {
    document.getElementById("sidenav").style.width = "223px";
    document.getElementById("sidenav").classList.toggle('sidenav-border');
    toggleNav = 0;
    if (document.documentElement.clientWidth > 1200) {
      if (document.getElementById("actionbar") != null) {
        document.getElementById("actionbar").style.marginLeft = "223px";
        document.getElementById("actionbar").style.paddingRight = "223px";
      }
      if (document.getElementById('profile-card') != null) {
        document.getElementById('profile-card').style.marginLeft = '223px';
      }
      document.getElementById("main").style.marginLeft = "223px";
    } else {
      document.getElementById("overlay").style.width = "100%";
    }
  }
  
  burger();
}

function closeNav() {
  document.getElementById("sidenav").style.width = "0";
  document.getElementById("sidenav").classList.toggle('sidenav-border');
  document.getElementById("overlay").style.width = "0";
  document.getElementById("actionbar").style.marginLeft = "0";
  document.body.style.overflowY = "visible"
  toggleNav = 1;
  burger();
}

function checkNav() {
  if (toggleNav == 0) {
      document.getElementById("sidenav").style.width = "223px";
      document.getElementById("sidenav").classList.toggle('sidenav-border');
      document.body.style.overflowY = "hidden"
      if (document.documentElement.clientWidth > 768) {
        if (document.getElementById("actionbar") != null) {
          document.getElementById("actionbar").style.marginLeft = "223px";
          document.getElementById("actionbar").style.paddingRight = "223px";
        }
        document.getElementById("main").style.marginLeft = "223px";
        if (document.getElementById('profile-card') != null) {
          document.getElementById('profile-card').style.marginLeft = '223px';
        }
      } else {
        document.getElementById("overlay").style.width = "100%";
      }
      document.getElementById("nav-icon3").classList.add('open');
    }
}

function burger() {
  document.getElementById("nav-icon3").classList.toggle('open');
};

function openNotification() {
  if (document.getElementById("user-dropdown").classList.contains('openUser')) {
    document.getElementById("user-dropdown").classList.toggle('openUser')
  }
  document.getElementById("notification-dropdown").classList.toggle('openNotification');
};

function openUser() {
  if (document.getElementById("notification-dropdown").classList.contains('openNotification')) {
    document.getElementById("notification-dropdown").classList.toggle('openNotification')
  }
  document.getElementById("user-dropdown").classList.toggle('openUser')
}

function imageSearch() {
  var typingTimer;
  var doneTypingInterval = 2000;
  var input = document.getElementById('unsplash');
  
  input.addEventListener('keyup', function () {
    clearTimeout(typingTimer);
    typingTimer = setTimeout(doneTyping, doneTypingInterval);
  });
  
  input.addEventListener('keydown', function () {
    clearTimeout(typingTimer);
  });
  
  function doneTyping () {
    if (input.value.length > 2) {
      var api = "https://api.unsplash.com/search/photos/?client_id=ca5b70a696bb7a2e58811ea474e8171ea0d9669c0bc0efdb034b7daffafe9e42&per_page=30&query=" + input.value;
      console.log(api);
      $.getJSON(api, function(data) {
        for (var i = 0; i < data.results.length; i++) {
          var elem = document.createElement("img");
          elem.setAttribute("src", data.results[i].urls.regular);
          
          var label = document.createElement("label");
          label.setAttribute("id", "label" + i);
          document.getElementById("image-container").appendChild(label);
          
          var radio = document.createElement("input");
          radio.setAttribute("type", "radio");
          radio.setAttribute("value", data.results[i].urls.regular);
          if(window.location.href.indexOf('projects') != -1) {
            radio.setAttribute("name", "project[header_url]");
          } else {
            radio.setAttribute("name", "challenge[header_url]");
          }
          document.getElementById("label" + i).appendChild(radio);
          
          document.getElementById("label" + i).appendChild(elem);
        }  
      });
    }
  }
}
function roleSelected() {
  document.getElementById("project_director").onchange = function() {
    if (this.value == 0) {
      // document.getElementById("role-requirements").classList.add("requirements-hide");
      document.getElementById("role-requirements").removeChild(document.getElementById("project_r_director"));
    } else {
      if (document.getElementById("project_r_director") == null) {
        document.getElementById("role-requirements").classList.remove("requirements-hide");
        var input = document.createElement("input");
        input.setAttribute("type", "text");
        input.setAttribute("id", "project_r_director");
        input.setAttribute("placeholder", "Enter the requirements for the director(s)");
        input.setAttribute("name", "project[r_director]");
        document.getElementById("role-requirements").appendChild(input);
      }
    }
  };
  
  document.getElementById("project_writer").onchange = function() {
    if (this.value == 0) {
      document.getElementById("role-requirements").removeChild(document.getElementById("project_r_writer"));
    } else {
      if (document.getElementById("project_r_writer") == null) {
        document.getElementById("role-requirements").classList.remove("requirements-hide");
        var input = document.createElement("input");
        input.setAttribute("type", "text");
        input.setAttribute("id", "project_r_writer");
        input.setAttribute("placeholder", "Enter the requirements for the writer(s)");
        input.setAttribute("name", "project[r_writer]");
        document.getElementById("role-requirements").appendChild(input);
      }
    }
  };
  
  document.getElementById("project_actor").onchange = function() {
    if (this.value == 0) {
      document.getElementById("role-requirements").removeChild(document.getElementById("project_r_actor"));
    } else {
      if (document.getElementById("project_r_actor") == null) {
        document.getElementById("role-requirements").classList.remove("requirements-hide");
        var input = document.createElement("input");
        input.setAttribute("type", "text");
        input.setAttribute("id", "project_r_actor");
        input.setAttribute("placeholder", "Enter the requirements for the actor(s)");
        input.setAttribute("name", "project[r_actor]");
        document.getElementById("role-requirements").appendChild(input);
      }
    }
  };
  
  document.getElementById("project_editor").onchange = function() {
    if (this.value == 0) {
      document.getElementById("role-requirements").removeChild(document.getElementById("project_r_editor"));
    } else {
      if (document.getElementById("project_r_editor") == null) {
        document.getElementById("role-requirements").classList.remove("requirements-hide");
        var input = document.createElement("input");
        input.setAttribute("type", "text");
        input.setAttribute("id", "project_r_editor");
        input.setAttribute("placeholder", "Enter the requirements for the editor(s)");
        input.setAttribute("name", "project[r_editor]");
        document.getElementById("role-requirements").appendChild(input);
      }
    }
  };
  
  document.getElementById("project_composer").onchange = function() {
    if (this.value == 0) {
      document.getElementById("role-requirements").removeChild(document.getElementById("project_r_composer"));
    } else {
      if (document.getElementById("project_r_composer") == null) {
        document.getElementById("role-requirements").classList.remove("requirements-hide");
        var input = document.createElement("input");
        input.setAttribute("type", "text");
        input.setAttribute("id", "project_r_composer");
        input.setAttribute("placeholder", "Enter the requirements for the composer(s)");
        input.setAttribute("name", "project[r_composer]");
        document.getElementById("role-requirements").appendChild(input);
      }
    }
  };
  
  document.getElementById("project_cinematographer").onchange = function() {
    if (this.value == 0) {
      document.getElementById("role-requirements").removeChild(document.getElementById("project_r_cinematographer"));
    } else {
      if (document.getElementById("project_r_cinematographer") == null) {
        document.getElementById("role-requirements").classList.remove("requirements-hide");
        var input = document.createElement("input");
        input.setAttribute("type", "text");
        input.setAttribute("id", "project_r_cinematographer");
        input.setAttribute("placeholder", "Enter the requirements for the cinematographer(s)");
        input.setAttribute("name", "project[r_cinematographer]");
        document.getElementById("role-requirements").appendChild(input);
      }
    }
  };
  
  document.getElementById("project_makeup").onchange = function() {
    if (this.value == 0) {
      document.getElementById("role-requirements").removeChild(document.getElementById("project_r_makeup"));
    } else {
      if (document.getElementById("project_r_makeup") == null) {
        document.getElementById("role-requirements").classList.remove("requirements-hide");
        var input = document.createElement("input");
        input.setAttribute("type", "text");
        input.setAttribute("id", "project_r_makeup");
        input.setAttribute("placeholder", "Enter the requirements for the makeup(s)");
        input.setAttribute("name", "project[r_makeup]");
        document.getElementById("role-requirements").appendChild(input);
      }
    }
  };
  
  document.getElementById("project_vfx").onchange = function() {
    if (this.value == 0) {
      document.getElementById("role-requirements").removeChild(document.getElementById("project_r_vfx"));
    } else {
      if (document.getElementById("project_r_vfx") == null) {
        document.getElementById("role-requirements").classList.remove("requirements-hide");
        var input = document.createElement("input");
        input.setAttribute("type", "text");
        input.setAttribute("id", "project_r_vfx");
        input.setAttribute("placeholder", "Enter the requirements for the vfx(s)");
        input.setAttribute("name", "project[r_vfx]");
        document.getElementById("role-requirements").appendChild(input);
      }
    }
  };
}

function documents() {
  gapi.load("auth:client,drive-realtime,drive-share", insertFile());
}

function insertFile(fileData, callback) {
  const boundary = '-------314159265358979323846';
  const delimiter = "\r\n--" + boundary + "\r\n";
  const close_delim = "\r\n--" + boundary + "--";

  var reader = new FileReader();
  reader.readAsBinaryString(fileData);
  reader.onload = function(e) {
    var contentType = fileData.type || 'application/octet-stream';
    var metadata = {
      'title': fileData.fileName,
      'mimeType': contentType
    };

    var base64Data = btoa(reader.result);
    var multipartRequestBody =
        delimiter +
        'Content-Type: application/json\r\n\r\n' +
        JSON.stringify(metadata) +
        delimiter +
        'Content-Type: ' + contentType + '\r\n' +
        'Content-Transfer-Encoding: base64\r\n' +
        '\r\n' +
        base64Data +
        close_delim;

    var request = gapi.client.request({
        'path': '/upload/drive/v2/files',
        'method': 'POST',
        'params': {'uploadType': 'multipart'},
        'headers': {
          'Content-Type': 'multipart/mixed; boundary="' + boundary + '"'
        },
        'body': multipartRequestBody});
    if (!callback) {
      callback = function(file) {
        console.log(file)
      };
    }
    request.execute(callback);
  }
}

