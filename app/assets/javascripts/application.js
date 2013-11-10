// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require_tree .
var friends_loaded = false;
var friends = [];
$(document).ready(function() {
  $('#search_form').on("keyup", function(e) {
      e.preventDefault();
      console.log("chill");
      var data = { search_term: $('#search_search_term').val()};

      $.post('/search', data, function(response) {
          $("#results").html(response);
      });
  });

  $('#event_friends_search_input').on('focus', function(e) {
    if(friends_loaded)
    {
      return null;
    }
    else
    {
      e.preventDefault();
      console.log("click click");
      $.post('/load_friends', function(response){
        friends = response.friends;
        $('#event_friends_search_input').autocomplete({
          source: friends
        });
      });
      friends_loaded = true;
    }
  });

  // $('#event_friends_search_input').on("keyup", function(e) {
  //     e.preventDefault();
  //     console.log("chill");
  //     var data = { search_term: $('#event_friends_search_input').val()};

  //     $.post('/search', data, function(response) {
  //         $("#results").html(response);
  //     });
  // });


  $("#top_br_sch").click(function(e) {
    e.preventDefault();
    $("#search").show();
    $("#search").animate({right:'0'});
  });

  $("#go_back").click(function(e) {
    e.preventDefault();
    $("#search").animate({right:'-80%'})
  })


  $(document).on("click", ".add_friend_button", function(e) {
    e.preventDefault();
    var id = $(this).attr('id');
    console.log(id);
    var data = { pending_pal_id: id}
    $.post('/friend_request/' + id, data, function(response) {
      $('#' + id).replaceWith("~/");
    })
  })

});
