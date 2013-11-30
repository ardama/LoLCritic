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

function updateStreamContainer() {
	$(".flag").each(function(index) {
		var time = getTime(this);
		var videoTime = player.getCurrentTime();
		var diff = videoTime - time;
		if (diff > 0 && diff < 10) {
			$(this).addClass('active');
		} else {
			$(this).removeClass('active');
		}
	});
}

function getTime(flag) {
	var time = 0
	var minute = parseInt($(flag).find(".flag-minute").html().trim());
	var second = parseInt($(flag).find(".flag-second").html().trim());
	if (minute) {
		time += 60 * minute;
	}
	if (second) {
		time += second;
	}
	return time;
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

function showMoreComments(index) {


};
