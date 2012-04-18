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
//= require_tree .

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

$(document).ready(function() {
   $(".rule_type_select").live("change", function() {
	  switch($(this).val())
	  {
	  	case "daily":
	  		$(this).parents('div.fields').children(".interval_field").show();
	  		$(this).parents('div.fields').children(".day_field").hide();
	  		$(this).parents('div.fields').children(".day_of_month_field").hide();
	  		$(this).parents('div.fields').children(".month_of_year_field").hide();
	  		break;
	  	case "weekly":
	  		$(this).parents('div.fields').children(".interval_field").show();
	  		$(this).parents('div.fields').children(".day_field").show();
	  		$(this).parents('div.fields').children(".day_of_month_field").hide();
	  		$(this).parents('div.fields').children(".month_of_year_field").hide();
	  		break;
	  	case "monthly":
	  		$(this).parents('div.fields').children(".interval_field").show();
	  		$(this).parents('div.fields').children(".day_field").show();
	  		$(this).parents('div.fields').children(".day_of_month_field").show();
	  		$(this).parents('div.fields').children(".month_of_year_field").hide();
	  		break;
	  	case "yearly":
	  		$(this).parents('div.fields').children(".interval_field").show();
	  		$(this).parents('div.fields').children(".day_field").show();
	  		$(this).parents('div.fields').children(".day_of_month_field").show();
	  		$(this).parents('div.fields').children(".month_of_year_field").show();
	  		break;
	  } 
	});
 });