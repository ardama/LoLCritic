function flagClick(time, index) {
	$(".active").each(function(i, flag) {
		$(flag).removeClass("active");
	});

	$("#flag_" + index).addClass("active");
	player.seekTo(time);
}