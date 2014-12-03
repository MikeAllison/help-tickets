// ***************************************************************************
// Filters tbody rows based on content from a text input with id="filterText"
// ***************************************************************************

$(document).ready(function() {
	
	// Code to make :contains case-insensitive
	$.extend($.expr[':'], {
  	'containsi': function(elem, i, match, array) {
    	return (elem.textContent || elem.innerText || '').toLowerCase() .indexOf((match[3] || "").toLowerCase()) >= 0;
		}
	});

	$("#filterText").keyup(function(){
		var textVal = $("#filterText").val();
		
		if (textVal === "") {
			$("tbody tr").show();
		} else {
			$("tbody tr").hide();
			$("tr:containsi('" + textVal + "')").show();
		}	
	});  // End keyup
	
	$("#filterClear").click(function(event){
		event.preventDefault();
		$("#filterText").val() = "";
	});
	
}); // End ready

