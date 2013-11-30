$(document).ready(function() {
	$('.review-accordion-toggle').click(function() {
		if ($(this).html().trim() == "Write Review") {
			$(this).html("Hide Review");
		}
		else if ($(this).html().trim() == "Hide Review") {
			$(this).html("Write Review");
		}
	});
});

function flagClick(time, index) {
	$(".active").each(function(i, flag) {
		$(flag).removeClass("active");
	});

	$("#flag_" + index).addClass("active");
	player.seekTo(time);
};



function commentShowToggle(index) {
	var element = "#comment-show-toggle-" + index;
	if ($(element).html().trim() == "show comments") {
		$(element).html("hide comments");
	}
	else if ($(element).html().trim() == "hide comments") {
		$(element).html("show comments");
	}
};

function showMoreComments(index) {


};
