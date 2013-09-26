$( document ).ready(function() {

	populateOptions('#video_champion',champArray);
	populateOptions('#video_opponent',champArray);
	populateOptions('#video_lane',laneArray);
	populateOptions('#video_position',positionArray);
	populateOptions('#video_focus',focusArray);

	$('#video_champion').chosen({allow_single_deselect: true, placeholder_text_single: "What champion were you playing?"});	
	$('#video_opponent').chosen({allow_single_deselect: true, placeholder_text_single: "Who were you laning against?"});	
	$('#video_lane').chosen({allow_single_deselect: true, placeholder_text_single: "What lane were you in?"});	
	$('#video_position').chosen({placeholder_text_multiple: "What was your role on the team?"});	
	$('#video_focus').chosen({placeholder_text_multiple: "What is the focus of this video?"});
});