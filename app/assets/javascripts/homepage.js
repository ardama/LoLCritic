$(document).ready(function() {

	var dur = 300;
	var anim = "drop"
	$("#signup-button").click(function() {

		var showSignup = $("#signup-form").css("display");
		var showSignin = $("#signin-form").css("display");

		if (showSignup == "none") {
			$("#signup-form").show(anim, { direction: "left" }, dur);
			$("#signup-email-field").focus();
		}
		else {
			$("#signup-form").hide(anim, { direction: "left" }, dur);
		}

		if (showSignin != "none") {
			$("#signin-form").hide(anim, { direction: "right" }, dur);
		}		
	});
	$("#signin-button").click(function() {
		var showSignin = $("#signin-form").css("display");
		var showSignup = $("#signup-form").css("display");

		if (showSignin == "none") {
			$("#signin-form").show(anim, { direction: "right" }, dur);
			$("#signin-email-field").focus();
		}
		else {
			$("#signin-form").hide(anim, { direction: "right" }, dur);
		}

		if (showSignup != "none") {
			$("#signup-form").hide(anim, { direction: "left" }, dur);
		}
	});
});
