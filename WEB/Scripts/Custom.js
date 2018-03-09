function Popup(PageName, W, H) {
	var Features = 'width= ' +  W + ', height=' + H;
	var wpen = window.open(PageName, 'EnKafadar', Features);
	wpen.focus();
}

function FlashFocus()
{	

	(navigator.appName != 'Microsoft Internet Explorer') ? 
		document.getElementById("tempObj").focus() : 
		document.getElementById("dvFlashContent").focus();
		
	document.getElementById("FL").focus();
	
}