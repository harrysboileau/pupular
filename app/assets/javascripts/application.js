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
var friends_to_add = [];

function inviteFriendsToEventError(errorMessage) {
  $("#adding_friends_error").text(errorMessage);
}

$(document).ready(function() {
  // Global search function (partial)
  $('#search_form').on("keyup", function(e) {
      e.preventDefault();
      var data = { search_term: $('#search_search_term').val()};

      $.post('/search', data, function(response) {
          $("#results").html(response);
      });
  });

  // Autocomplete search for adding friends to events
  $('#event_friends_search_input').on('focus', function(e) {
    if(friends_loaded)
    {
      return null;
    }
    else
    {
      e.preventDefault();
      $.post('/load_friends', function(response){
        friends = response.friends;
        $('#event_friends_search_input').autocomplete({
          source: friends
        });
      });
      friends_loaded = true;
    }
  });

  // Queueing friends to invite to events
  $(document).on("click", "#event_friends_search_button", function(e){
    e.preventDefault();
    var form = this.parentNode;
    var friend_input = $(form).find("#event_friends_search_input").val();
    var event_id = $(".invite_friends").attr("id");
    console.log(event_id);
    if( $.inArray(friend_input, friends_to_add) == -1 )
    {
      $.post("/verify_friend", {"friend_name": friend_input, "event_id": event_id}, function(response){
        if(response.verification == "friend")
        {
          friends_to_add.push(friend_input);
          $("#friends_list").append("<li>" + friend_input + "</li>");
          inviteFriendsToEventError("");
        }
        else if (response.verification == "not_friend")
        {
          inviteFriendsToEventError("That's not one of your friends!");
        }
        else if (response.verification == "already_invited")
        {
          inviteFriendsToEventError("This friend was already invited!");
        }
        else if (response.verification == "self")
        {
          inviteFriendsToEventError("You're already attending!");
        }
        else
        {
          inviteFriendsToEventError("Something went wrong!");
        }
      });
    }
    else
    {
      inviteFriendsToEventError("You already added that friend!");
    }

  });

  // Sending invitations to queued friends
  $(document).on("click", ".invite_friends", function(e){
    e.preventDefault();
    $.post("/add_friends_to_event", {"friends_to_add" : friends_to_add, "event_id" : this.id }, function(response){
      if(response.errorMessage)
      {

      }
      else
      {
        // Re-direct to show event page once it lists friends.
        inviteFriendsToEventError("Pals invited!");
        $("#friends_list").replaceWith("<ul id='friends_list'></ul>");
      }
    });
  });

  // Accepting event invitations in Doghouse
  // $(document).on("click", ".accept_invitation", function(e){
  //   var event_id = this.id;
  //   $.post("/accept_invitation", {"event_id" : event_id});
  // });

  // Declining event invitations in Doghouse
  // $(document).on("click", ".decline_invitation", function(e){
  //   var event_id = this.id;
  //   $.post("/decline_invitation", {"event_id" : event_id});
  // });

  // Fading in hangout/walk button on New Event page
  $(".walk_or_hangout").fadeIn("slow");

  // On click of Walk/Hangout buttons, update hidden field (for event type) value
  // appropriately and fade out the walk_or_hangout div

  $(document).on("click", ".walk_or_hangout button", function(e){
    e.preventDefault();
    var type = $(this).attr("class");
    $("#event_type").val(type);
    $(".walk_or_hangout").fadeOut("slow");
  });

  // Makes date picker for event date field
  $("input#event_date").datepicker();

  // On submission of new event form, ask about inviting friends.
  $(document).on("submit", "#new_event", function(e){
    e.preventDefault();
    var form = $(this).serialize();
    var url = $(this).attr("action");
    $.post(url, form, function(response){
      if(response.error)
      {
        $(".errorMessage").html("<h2>Please fill out all fields!</h2>");
      }
      else
      {
        $(".container").replaceWith(response);
      }
    });
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
    $("#search").animate({right:'-80%'});
    // IntervalTime thing it $("#search").hide();
  });


  $(document).on("click", ".add_friend_button", function(e) {
    e.preventDefault();
    var id = $(this).attr('id');
    console.log(id);
    var data = { pending_pal_id: id};
    $.post('/friend_request/' + id, data, function(response) {
      $('#' + id).replaceWith("~/");
    });
  })

});
