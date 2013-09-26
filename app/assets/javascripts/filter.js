$( document ).ready(function() {

	populateOptions('#champion',champArray);
	populateOptions('#opponent',champArray);
	populateOptions('#lane',laneArray);
	populateOptions('#position',positionArray);
	populateOptions('#focus',focusArray);

	$('#champion').chosen({allow_single_deselect: true, placeholder_text_single: "No Champion Selected"});	
	$('#opponent').chosen({allow_single_deselect: true, placeholder_text_single: "No Opponent Selected"});	
	$('#lane').chosen({allow_single_deselect: true, placeholder_text_single: "No Lane Selected"});	
	$('#position').chosen({placeholder_text_multiple: "No Roles Selected"});	
	$('#focus').chosen({placeholder_text_multiple: "No Tags Selected"});
});