$(document).ready(function() {
	$('.review-toggle').click(function() {
		if ($(this).html().trim() == "Write Review <i class=\"fa fa-caret-down\"></i>") {
			$(this).html("Hide Review <i class=\"fa fa-caret-up\"></i>");
		}
		else if ($(this).html().trim() == "Hide Review <i class=\"fa fa-caret-up\"></i>") {
			$(this).html("Write Review <i class=\"fa fa-caret-down\"></i>");
		}
	});
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
		var videoTime = player.getCurrentTime();
		var diff = videoTime - time;
		if (diff > 0 && diff < 10) {
			$(this).addClass('active');
		} else {
			$(this).removeClass('active');
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
	console.log(index.toString());
}