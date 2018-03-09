<?php
header("Content-type: text/javascript; charset= UTF-8");
ob_start ("ob_gzhandler");
header("Cache-Control: public, max-age=183");
$offset = 60 * 60 * 60 * 3;
$ExpStr = "Expires: " . "Mon, 21 Jun 2011 01:02:00 GMT";

header($ExpStr);
?>
/*swfobject*/
if(typeof deconcept=="undefined"){var deconcept=new Object();}
if(typeof deconcept.util=="undefined"){deconcept.util=new Object();}
if(typeof deconcept.SWFObjectUtil=="undefined"){deconcept.SWFObjectUtil=new Object();}
deconcept.SWFObject=function(_1,id,w,h,_5,c,_7,_8,_9,_a,_b){if(!document.getElementById){return;}
this.DETECT_KEY=_b?_b:"detectflash";
this.skipDetect=deconcept.util.getRequestParameter(this.DETECT_KEY);
this.params=new Object();
this.variables=new Object();
this.attributes=new Array();
if(_1){this.setAttribute("swf",_1);}
if(id){this.setAttribute("id",id);}
if(w){this.setAttribute("width",w);}
if(h){this.setAttribute("height",h);}
if(_5){this.setAttribute("version",new deconcept.PlayerVersion(_5.toString().split(".")));}
this.installedVer=deconcept.SWFObjectUtil.getPlayerVersion();
if(c){this.addParam("bgcolor",c);}
var q=_8?_8:"high";
this.addParam("quality",q);
this.setAttribute("useExpressInstall",_7);
this.setAttribute("doExpressInstall",false);
var _d=(_9)?_9:window.location;
this.setAttribute("xiRedirectUrl",_d);
this.setAttribute("redirectUrl","");
if(_a){this.setAttribute("redirectUrl",_a);}};
deconcept.SWFObject.prototype={setAttribute:function(_e,_f){
this.attributes[_e]=_f;
},getAttribute:function(_10){
return this.attributes[_10];
},addParam:function(_11,_12){
this.params[_11]=_12;
},getParams:function(){
return this.params;
},addVariable:function(_13,_14){
this.variables[_13]=_14;
},getVariable:function(_15){
return this.variables[_15];
},getVariables:function(){
return this.variables;
},getVariablePairs:function(){
var _16=new Array();
var key;
var _18=this.getVariables();
for(key in _18){_16.push(key+"="+_18[key]);}
return _16;},getSWFHTML:function(){var _19="";
if(navigator.plugins&&navigator.mimeTypes&&navigator.mimeTypes.length){
if(this.getAttribute("doExpressInstall")){
this.addVariable("MMplayerType","PlugIn");}
_19="<embed type=\"application/x-shockwave-flash\" src=\""+this.getAttribute("swf")+"\" width=\""+this.getAttribute("width")+"\" height=\""+this.getAttribute("height")+"\"";
_19+=" id=\""+this.getAttribute("id")+"\" name=\""+this.getAttribute("id")+"\" ";
var _1a=this.getParams();
for(var key in _1a){_19+=[key]+"=\""+_1a[key]+"\" ";}
var _1c=this.getVariablePairs().join("&");
if(_1c.length>0){_19+="flashvars=\""+_1c+"\"";}_19+="/>";
}else{if(this.getAttribute("doExpressInstall")){this.addVariable("MMplayerType","ActiveX");}
_19="<object id=\""+this.getAttribute("id")+"\" classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" width=\""+this.getAttribute("width")+"\" height=\""+this.getAttribute("height")+"\">";
_19+="<param name=\"movie\" value=\""+this.getAttribute("swf")+"\" />";
var _1d=this.getParams();
for(var key in _1d){_19+="<param name=\""+key+"\" value=\""+_1d[key]+"\" />";}
var _1f=this.getVariablePairs().join("&");
if(_1f.length>0){_19+="<param name=\"flashvars\" value=\""+_1f+"\" />";}_19+="</object>";}
return _19;
},write:function(_20){
if(this.getAttribute("useExpressInstall")){
var _21=new deconcept.PlayerVersion([6,0,65]);
if(this.installedVer.versionIsValid(_21)&&!this.installedVer.versionIsValid(this.getAttribute("version"))){
this.setAttribute("doExpressInstall",true);
this.addVariable("MMredirectURL",escape(this.getAttribute("xiRedirectUrl")));
document.title=document.title.slice(0,47)+" - Flash Player Installation";
this.addVariable("MMdoctitle",document.title);}}
if(this.skipDetect||this.getAttribute("doExpressInstall")||this.installedVer.versionIsValid(this.getAttribute("version"))){
var n=(typeof _20=="string")?document.getElementById(_20):_20;
n.innerHTML=this.getSWFHTML();return true;
}else{if(this.getAttribute("redirectUrl")!=""){document.location.replace(this.getAttribute("redirectUrl"));}}
return false;}};
deconcept.SWFObjectUtil.getPlayerVersion=function(){
var _23=new deconcept.PlayerVersion([0,0,0]);
if(navigator.plugins&&navigator.mimeTypes.length){
var x=navigator.plugins["Shockwave Flash"];
if(x&&x.description){_23=new deconcept.PlayerVersion(x.description.replace(/([a-zA-Z]|\s)+/,"").replace(/(\s+r|\s+b[0-9]+)/,".").split("."));}
}else{try{var axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7");}
catch(e){try{var axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.6");
_23=new deconcept.PlayerVersion([6,0,21]);axo.AllowScriptAccess="always";}
catch(e){if(_23.major==6){return _23;}}try{axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash");}
catch(e){}}if(axo!=null){_23=new deconcept.PlayerVersion(axo.GetVariable("$version").split(" ")[1].split(","));}}
return _23;};
deconcept.PlayerVersion=function(_27){
this.major=_27[0]!=null?parseInt(_27[0]):0;
this.minor=_27[1]!=null?parseInt(_27[1]):0;
this.rev=_27[2]!=null?parseInt(_27[2]):0;
};
deconcept.PlayerVersion.prototype.versionIsValid=function(fv){
if(this.major<fv.major){return false;}
if(this.major>fv.major){return true;}
if(this.minor<fv.minor){return false;}
if(this.minor>fv.minor){return true;}
if(this.rev<fv.rev){
return false;
}return true;};
deconcept.util={getRequestParameter:function(_29){
var q=document.location.search||document.location.hash;
if(q){var _2b=q.substring(1).split("&");
for(var i=0;i<_2b.length;i++){
if(_2b[i].substring(0,_2b[i].indexOf("="))==_29){
return _2b[i].substring((_2b[i].indexOf("=")+1));}}}
return "";}};
deconcept.SWFObjectUtil.cleanupSWFs=function(){if(window.opera||!document.all){return;}
var _2d=document.getElementsByTagName("OBJECT");
for(var i=0;i<_2d.length;i++){_2d[i].style.display="none";for(var x in _2d[i]){
if(typeof _2d[i][x]=="function"){_2d[i][x]=function(){};}}}};
deconcept.SWFObjectUtil.prepUnload=function(){__flash_unloadHandler=function(){};
__flash_savedUnloadHandler=function(){};
if(typeof window.onunload=="function"){
var _30=window.onunload;
window.onunload=function(){
deconcept.SWFObjectUtil.cleanupSWFs();_30();};
}else{window.onunload=deconcept.SWFObjectUtil.cleanupSWFs;}};
if(typeof window.onbeforeunload=="function"){
var oldBeforeUnload=window.onbeforeunload;
window.onbeforeunload=function(){
deconcept.SWFObjectUtil.prepUnload();
oldBeforeUnload();};
}else{window.onbeforeunload=deconcept.SWFObjectUtil.prepUnload;}
if(Array.prototype.push==null){
Array.prototype.push=function(_31){
this[this.length]=_31;
return this.length;};}
var getQueryParamValue=deconcept.util.getRequestParameter;
var FlashObject=deconcept.SWFObject;
var SWFObject=deconcept.SWFObject;
/*swfobject*/
/*fbflashbridge*/
/*
 * fbFlashBridge - Facebook Connect Flash Bridge
 * 
 * Copyright (c) 2009 Pieter Michels
 *
 * ---------------------------------------------
 *
 * Custom javascript calls
 * 
 * FBFlashBridgeLogIn
 * FBFlashBridgeLogOut
 * FBFlashBridgeSetStatus
 * FBFlashBridgeGetFriendsList
 * FBFlashBridgeGetUsersInfo
 * FBFlashBridgePromptPermission
 * FBFlashBridgePublishFeedStory
 * FBFlashBridgeShowShare
 * FBFlashBridgeUserInfo
 * FBFlashBridgeInviteFriends
 * FBFlashBridgeGetStream
 *
 *
 * Custom event listening
 *
 * FBFlashBridgeListener("LOGGED_IN", onLoggedIn); 
 * FBFlashBridgeListener("LOGGED_OUT", onLoggedOut); 
 * FBFlashBridgeListener("STATUS_SET", onStatusSet); 
 * FBFlashBridgeListener("FRIENDS_LIST", onFriendsList); 
 * FBFlashBridgeListener("USERS_INFO", onUsersInfo);
 * FBFlashBridgeListener("USER_INFO", onUserInfo);
 * FBFlashBridgeListener("APP_USERS", onUserInfo);
 * FBFlashBridgeListener("STREAM_GET", onStreamGet);
 *
 */

var sAppName = "EnKafadar";
var SwfID = "FL";
var sAppKey = "02cda27c0946cccbb3c5f64f27691821";
var xd_receiverPath = "xd_receiver.htm";

var api;
var friendResult;
var userResult;
var usersResult;
var oFlash = null;
var isFlashReady = false;
var isLoggedIn = false;

//***********************************************************************************************************//

function FBFlashBridgeInviteFriends(title, actionTitle, messageCopy)
{
	trace("INVITE FRIENDS");

	// FB.Connect.inviteConnectUsers(); doesn't work
	FB.ensureInit(function() 
	{
        var dialog = new FB.UI.FBMLPopupDialog(title, "");
        var fbml = "<fb:fbml>" + 
        				"<fb:request-form " + 
        							"method=\"GET\" " +
        							"action=\"" + "http://stream.microsite.be/cecemel/index.html" + "\" " + 
        							"invite=\"false\" " + 
      								"type=\"" + sAppName + "\" " + 
       								"content=\"" + messageCopy + " " +        										
    	   									"<fb:req-choice url='http://stream.microsite.be/cecemel' label='Confirm' />\"" + 
    	   							">" + 
  							"<fb:multi-friend-selector showborder=\"false\" exclude_ids=\"\" actiontext=\"" + actionTitle + "\" rows=\"5\" bypass=\"cancel\" showborder=\"true\" />" + 
        				"</fb:request-form>" + 
        			"</fb:fbml>";
        /*
        var fbml = "<fb:fbml>" + 
        				"<fb:iframe " +  
        						"src=\"http://stream.microsite.be/cecemel/assets/popup/invite.html?fb_force_mode=fbml&sAppName=" + sAppName + "&actionTitle=" + actionTitle + "&messageCopy=" + messageCopy + "\"" + 
        						"smartsize=\"true\" " + 
        						">" +  
        				"</fb:iframe>" + 
        			"</fb:fbml>";
        */
        dialog.setFBMLContent(fbml);
        dialog.setContentWidth(630); 
        dialog.setContentHeight(500);
        
        dialog.show();
    });
}

function FBFlashBridgeSetStatus(status)
{
	//trace("SETTING STATUS (" + status + ")");

	api.users_setStatus(status, false, false, function()
	{
		trace("STATUS_SET");
		
		FBFlashBridgeDispatcher("STATUS_SET");
		
		FBFlashBridgeFlashDispatcher("onStatusSet");
	});
}

function FBFlashBridgeGetCurrentStatus(userId, limit)
{
	api.status_get(userId, limit, function(result, ex)
	{
		trace(result);
		
		//trace("CURRENT_STATUS");
		
		FBFlashBridgeDispatcher("CURRENT_STATUS");
		
		FBFlashBridgeFlashDispatcher("onCurrentStatus", result);
	});
}

function FBFlashBridgeUserInfo(userId, arrProfileData)
{
	//trace("GETTING USER INFO OF LOGGED IN USER OR USER WITH GIVEN UID");

	// ["timezone", "status", "sex", "proxied_email", "profile_url", "pic_square_with_logo", "pic_square", "pic_small_with_logo", "pic_small", "pic_big_with_logo", "pic_big", "pic_with_logo", "pic", "name", "first_name", "last_name", "is_app_user", "hometown_location", "birthday", "about_me", "uid"]
	
	api.users_getInfo([userId > 0 ? userId : api._session.uid], arrProfileData, function(result, ex) 
	{	
		userResult = result[0];

		trace("USER_INFO");
		
		FBFlashBridgeDispatcher("USER_INFO");
		
		FBFlashBridgeFlashDispatcher("onUserInfo", userResult);
	});
}

function FBFlashBridgeGetFriendsList()
{
	api.friends_get(null, function(result, ex) 
	{					
		friendResult = result;
		
		trace("FRIENDS_LIST");
		
		if(!$.isArray(friendResult))
			friendResult = [];
		
		FBFlashBridgeDispatcher("FRIENDS_LIST");
		
		FBFlashBridgeFlashDispatcher("onFriendsList", friendResult);
	});
}

function FBFlashBridgeGetUsersInfo(arrUsers, arrProfileData)
{
	api.users_getInfo(arrUsers, arrProfileData, function(result, ex) 
	{	
		usersResult = result;

		trace("USERS_INFO");
		
		if(!$.isArray(usersResult))
			usersResult = [];
		
		FBFlashBridgeDispatcher("USERS_INFO");
		
		FBFlashBridgeFlashDispatcher("onUsersInfo", usersResult);
	});
}

function FBFlashBridgeGetAppUsers()
{
	api.friends_getAppUsers(function(result, ex) 
	{					
		usersResult = result;
		
		trace("APP_USERS");
		
		if(!$.isArray(usersResult))
			usersResult = [];
			
		FBFlashBridgeDispatcher("APP_USERS");
		
		FBFlashBridgeFlashDispatcher("onAppUsers", usersResult);
	});
}

function FBFlashBridgeGetStream(userId)
{
	trace("GET STREAM OF " + userId);
	
	api.stream_get(userId, '', '', '', '', function(result) 
	{
		trace("STREAM_GET");

		trace(result.posts[0]);
		
		FBFlashBridgeDispatcher("STREAM_GET");
		
		FBFlashBridgeFlashDispatcher("onStreamGet", result);
	});
}

function FBFlashBridgePromptPermission(permission) 
{
	FB.ensureInit(function() 
	{
    	FB.Connect.showPermissionDialog(permission);
	});
}

function FBFlashBridgePublishFeedStory(templateBundleId, templateData) 
{
	FB.ensureInit(function() 
	{
        FB.Connect.showFeedDialog(parseInt(templateBundleId), templateData, null, null, FB.FeedStorySize.shortStory, FB.RequireConnect.promptConnect);
	});
}

function FBFlashBridgeShowShare(link)
{
	FB.Connect.showShareDialog(link, function()
	{
		alert("Share Test");
	});
}

function FBFlashBridgeSendNotification(arrUsers, sNotification)
{
	api.notifications_send(arrUsers, sNotification, function(result, ex)
	{
		FBFlashBridgeDispatcher("NOTIFICATION_SENT");
		
		FBFlashBridgeFlashDispatcher("onNotificationSent");
	}); 
}

function FBFlashBridgeSendEMail(arrRecipients, sSubject, sText, sFbml)
{
	api.notifications_sendEmail(arrRecipients, sSubject, sText, sFbml, function(result, ex)
	{
		if(result)
		{
			FBFlashBridgeDispatcher("EMAIL_SENT");
		
			FBFlashBridgeFlashDispatcher("onEmailSent");
		}
		else
		{
			FBFlashBridgeDispatcher("EMAIL_SENT_FAILED_AUTH");
		
			FBFlashBridgeFlashDispatcher("onEmailSentFailedAuth");
		}
	}); 
}

function FBFlashBridgeGetAlbums(uid)
{	
	trace("GET ALBUMS OF " + uid);
	
	api.photos_getAlbums(uid, null, function(result) {
		
		trace(result);
		
		FBFlashBridgeDispatcher("ALBUMS_GET");
		FBFlashBridgeFlashDispatcher("onAlbumsGet", result);
	})	
}

//function FBFlashBridgeGetPhotos(aid){
	//trace("s");
	//api.photos_get('', aid > 0 ? aid : null, '', function(result, ex){
		//trace(aid);
		//FBFlashBridgeDispatcher("PHOTOS_GET");
		//FBFlashBridgeFlashDispatcher("onPhotosOfAlbumGet", result);
	//});
//}

function FBFlashBridgeGetPhotos(albumId) {
	trace("Get photos of albums " + albumId);
	
	api.photos_get(null, albumId, null, function(result) {
		
		trace(1);
		trace(result);
		
		FBFlashBridgeDispatcher("PHOTOS_GET");
		FBFlashBridgeFlashDispatcher("onPhotosOfAlbumGet", result);
	});	
}



//***********************************************************************************************************//

function FBFlashBridgeLogOut()
{
	FB.Connect.logout(function() 
	{ 
		trace("LOGGED_OUT");
		
		isLoggedIn = false;
		
		FBFlashBridgeDispatcher("LOGGED_OUT");
		
		FBFlashBridgeFlashDispatcher("onLoggedOut");
	});
}

function FBFlashBridgeLogIn()
{
	FB.Connect.requireSession(function() 
	{
		trace("LOG IN READY");
		FBFlashBridgeLoggedIn();
	}, true);
}


function FBFlashBridgeLoggedIn()
{
	api = FB.Facebook.apiClient;

	trace("LOGGED_IN");

	if(!isLoggedIn)
	{
		isLoggedIn = true;
		FBFlashBridgeDispatcher("LOGGED_IN");
	
		FBFlashBridgeFlashDispatcher("onLoggedIn", api._session);
	}
}

function FBFlashBridgeOnLoad() 
{
	FB.ensureInit(function() 
	{
		FB.Facebook.get_sessionState().waitUntilReady(function(session) 
		{
			inspect(session);
			
			if(session)
				FBFlashBridgeLoggedIn();
		});
	});
}

window.onload = function() { FBFlashBridgeOnLoad(false); };

//***********************************************************************************************************//	

if(!("console" in window) || !("firebug" in console)) 
{
    var names = ["log", "debug", "info", "warn", "error", "assert", "dir", "dirxml", "group", "groupEnd", "time", "timeEnd", "count", "trace", "profile", "profileEnd"];

    window.console = {};

    for(var i = 0; i < names.length; ++i) window.console[names[i]] = function() {};
}

function trace(msg)
{
	 //alert(msg);
	
	if(console)	
		console.debug(msg);
}

function inspect(obj)
{
	if(console)	
		console.dir(obj);
}

//***********************************************************************************************************//

function FBFlashBridgeDispatcher(eventType, data)
{
	$(document).trigger(eventType, data);
}	

function FBFlashBridgeListener(eventType, func)
{
	$(document).bind(eventType, function(e, data) { func(data); });
}

function FBFlashBridgeFlashDispatcher(func)
{
	if(oFlash && isFlashReady) // && typeof obj.JStoASviaExternalInterface != "undefined")
	{			
		if(arguments.length > 1) {
			try {
				oFlash[func](Array.prototype.slice.call(arguments).slice(1)[0]); 
			}
			catch(err) {
				oFlash[func](new Array());
				trace(err);
			}
		}
		else
			oFlash[func]();
	}
}

function FBFlashBridgeInit()
{
	oFlash = document.getElementById(SwfID);
	//FB.XdComm.Server.init(xd_receiverPath);
	FB.init(sAppKey, xd_receiverPath);	
}

function FBFlashBridgeFlashLoaded()
{	
	trace("FLASH LOADED");
	isFlashReady = true;
	if(isLoggedIn) // NOTIFY FLASH
	{
		trace("FB WAS ALLREADY LOGGED IN");
		
		FBFlashBridgeFlashDispatcher("onLoggedIn", api._session);
	}else
	{
		trace("not logged in");
	}
}

//***********************************************************************************************************//
/*fbflashbridge*/
/*custom*/
function Popup(PageName, W, H) {
	var Features = 'width= ' +  W + ', height=' + H;
	var wpen = window.open(PageName, 'EnKafadar', Features);
	wpen.focus();
}
/*custom*/
/*share*/
function Share(Site) {

    var title = escape(document.title);
    var url = escape(document.URL);
    var options = "height=700, width=800, titlebar=no, status=no, toolbar=no, menubar=no, location=no, resizable=no, scrollbars=1";
    var mURL = '';

    switch (Site) {
        case "facebook":
            mURL = "http://www.facebook.com/sharer.php?title=" + title + "&amp;u=" + url;
            break;

        case "google":
            mURL = "http://www.google.com/bookmarks/mark?op=edit&amp;bkmk=" + url + "&amp;title=" + title;
            break;

        case "yahoo":
            mURL = "http://myweb2.search.yahoo.com/myresults/bookmarklet?&amp;u=" + url + "&amp;t=" + title;
            break;

        case "mixx":
            mURL = "http://www.mixx.com/submit/story?title=" + title + "&amp;page_url=" + url + "&amp;partner=&amp;description=";
            break;

        case "digg":
            mURL = "http://digg.com/submit?url=" + url + "&amp;title=" + title;
            break;

        case "stumbleupon":
            mURL = "http://www.stumbleupon.com/submit?url=" + url + "&amp;title=" + title;
            break;

        case "delicious":
            mURL = "http://del.icio.us/post?url=" + url + "&amp;title=" + title;
            break;

        case "reddit":
            mURL = "http://reddit.com/submit?url=" + url + "&amp;title=" + title;
            break;

        case "myspace":
            mURL = "http://www.myspace.com/Modules/PostTo/Pages/?l=2&amp;u=" + url + "&amp;t=" + title + "&amp;c=" + title;
            break;

        case "friendfeed":
            mURL = "http://friendfeed.com/share/bookmarklet/frame#title=Bu kafalar çok tutacak! Ruffles En Kafadar'la sahalara çıktı, kafalar rahatladı. Zemin futbola müsait, ödüller çeşit çeşit! Seni de En Kafadar'a bekliyoruz. http://bit.ly/bAacfK";
         	break;

        case "twitter":
            mURL = "http://twitter.com/?status=Top bekleme, topa koş: En Kafadar’da zıpla coş! Siteye gel, oyunu oyna, Ruffles’dan ödülleri topla! http://bit.ly/bAacfK";
            break;

        case "live":
            mURL = "https://login.live.com/login.srf?wa=wsignin1.0&rpsnv=10&ct=1203804025&rver=4.5.2135.0&wp=SAPI&wreply=" + url;
            break;

    }

    var wpen = window.open(mURL.replace(/amp;/gi, ''), null, options);
    wpen.focus();
}
function socialShare(url,site) {

    var options = "height=700, width=800, titlebar=no, status=no, toolbar=no, menubar=no, location=no, resizable=no, scrollbars=1";
    var mURL = '';

    switch (site) {
        case "facebook":
            mURL = "http://www.facebook.com/sharer.php?u=" + url;
            break;
	}

    var wpen = window.open(mURL.replace(/amp;/gi, ''), null, options);
    wpen.focus();
	console.log(url);
}
 
/*share*/
function FlashFocus()
{
	document.getElementById("dvFlashContent").focus();	
	document.getElementById("FL").focus();
}