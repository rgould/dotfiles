// NOTE: You need dotjs installed to use this: https://github.com/defunkt/dotjs
//
// You must name this file with your airbrakeapp subdomain prepended to the filename.
// Example: So myairbrakesubdomain.airbrakeapp.com.js

var login = "rgould";
var token = "d7f959fd3f13df572b48b69dc4c68f01";

var title = $("#notice_heading h2").text();
var link  = document.location.href;


var button = $('<button id="create-github-issue">Create Github Issue</button>');
button.appendTo("#resolved_toggle");


button.click(function() {
  var data = {"token": token, "login": login, "title": title, "body": link}

  // prevent accidental double submission
  button.attr("disabled", "disabled")

  $.ajax({
    method: "POST",
    data: data,
    url: "https://github.com/api/v2/json/issues/open/gaggleup/gaggleup",
    success: function() {
      button.html("Issue Created.")

      var issueUrl = data['issue']['html_url']
      button.after('<a href="'+issueUrl+'" target="_blank">Go to Issue</a>')
    }
  });
});
