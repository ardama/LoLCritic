$(document).ready(function() {

	// Collapse/expand review form
	$('.review-toggle').click(function() {
		if ($(this).html().trim() == "Write Review <i class=\"fa fa-caret-down\"></i>") {
			$(this).html("Hide Review <i class=\"fa fa-caret-up\"></i>");
		}
		else if ($(this).html().trim() == "Hide Review <i class=\"fa fa-caret-up\"></i>") {
			$(this).html("Write Review <i class=\"fa fa-caret-down\"></i>");
		}
	});

	// Review hover functionality
	$('.review').hover(function() {
		var id = $(this).data('id');
		var upvote = "#review-upvote-" + id;
		var downvote = "#review-downvote-" + id;
		var rating = "#review-rating-" + id;

		$(upvote).addClass("active-review");
		$(downvote).addClass("active-review");
		$(rating).addClass("active-review");
		$(this).addClass("active-review");

	}, function() {
		var id = $(this).data('id');
		var upvote = "#review-upvote-" + id;
		var downvote = "#review-downvote-" + id;
		var rating = "#review-rating-" + id;

		$(upvote).removeClass("active-review");
		$(downvote).removeClass("active-review");
		$(rating).removeClass("active-review");
		$(this).removeClass("active-review");

	});

	// Hover functionality on review flags
	// $('.review-flag').hover(function() {
	// 	var obj = $(this);
	// 	obj.addClass('flag-hover');
	// 	id = $(this).data('id');
	// 	holderId = '#flag-button-holder-' + id.toString();
	// 	buttonId = '#flag-button-' + id.toString();
	// 	setTimeout(function() {
	// 		if (obj.hasClass('flag-hover')) {
	// 			$(holderId).css('display', 'none');
	// 			$(buttonId).css('display', 'inline-block');
	// 		}
	// 	}, 150);

	// }, function() {
	// 	$(this).removeClass('flag-hover');
	// 	id = $(this).data('id');
	// 	holderId = '#flag-button-holder-' + id.toString();
	// 	buttonId = '#flag-button-' + id.toString();

	// 	$(holderId).css('display', 'inline-block');
	// 	$(buttonId).css('display', 'none');

	// });

	// Show more comments functionality
	$('.comment-show-toggle').click(function() {
		id = $(this).data('id');
		elemId = "#comment-list-" + id.toString();		
		count = 0;
		while ($(elemId).children('.comment-hidden').length > 0 && count < 4) {
			$(elemId).children('.comment-hidden').first().removeClass('comment-hidden');
			count += 1;
		}
		checkShowMoreComments(id);
		return false;
	});
	checkAllShowMoreComments();

	// Comment hover functionality
	$('.comment').hover(function() {
		var id = $(this).data('id');
		var upvote = "#comment-upvote-" + id;
		var downvote = "#comment-downvote-" + id;
		var rating = "#comment-rating-" + id;

		$(upvote).addClass("active-comment");
		$(downvote).addClass("active-comment");
		$(rating).addClass("active-comment");
		$(this).addClass("active-comment");

	}, function() {
		var id = $(this).data('id');
		var upvote = "#comment-upvote-" + id;
		var downvote = "#comment-downvote-" + id;
		var rating = "#comment-rating-" + id;

		$(upvote).removeClass("active-comment");
		$(downvote).removeClass("active-comment");
		$(rating).removeClass("active-comment");
		$(this).removeClass("active-comment");

	});

	$('.close-container').click(function(event) {
		console.log("here");
		event.stopPropagation();
	});
	initializeFlags();
	setFlagTooltips();
});


function initializeFlags() {
	$('.flag').click(function() {
		$('.active').each(function(i, flag) {
			$(flag).removeClass('active');
		});

		$('#flag_' + $(this).data('index')).addClass('active');
		player.seekTo($(this).data('time'));
	});
}

function updateStreamContainer() {
	$(".flag").each(function(index) {
		var time = $(this).data("time");
		if (player.getCurrentTime) {
			var videoTime = player.getCurrentTime();
			var diff = videoTime - time;
			if (diff > 0 && diff < 10) {
				$(this).addClass('active');
			} else {
				$(this).removeClass('active');
			}
		}
	});
}


function commentShowToggle(index) {
	var element = "#comment-show-toggle-" + index;
	if ($(element).html().trim() == "show comments") {
		$(element).html("hide comments");
	}
	else if ($(element).html().trim() == "hide comments") {
		$(element).html("show comments");
	}
};

function checkAllShowMoreComments() {
	$('.comment-show-toggle').each(function(index, value) {
		id = $(this).data('id');
		checkShowMoreComments(id);
	});
};
function checkShowMoreComments(index) {
	if ($("#comment-list-" + index.toString()).children('.comment-hidden').length > 0) {
		$('#comment-show-toggle-' + index.toString()).show();
	} else {
		$('#comment-show-toggle-' + index.toString()).hide();	
	}
}

function setFlagTooltips() {
	// reset tooltips
	$('.flag-button').tooltip('hide');
	$('.flag-button').data('tooltip', false);

	var removeTooltipOptions = {"delay": {"show":200, "hide": 0},
						  "animation":false,
						  "title":"Remove Note from Stream"};
	$('.flag-added').tooltip(removeTooltipOptions);

	var addTooltipOptions = {"delay": {"show":200, "hide": 0},
						  "animation":false,
						  "title":"Add Note to Stream"};
	$('.flag-button').tooltip(addTooltipOptions);
}