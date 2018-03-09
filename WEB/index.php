<?php
ob_start("ob_gzhandler");
require_once '../php/start.php';
if(isset($_GET['irbwrbwecrd'])){
	$issetted = mysql_fetch_row(mysql_query('SELECT count(*) FROM users WHERE id="'.intval($_GET['irbwrbwecrd']).'"'));
	if(!intval($issetted[0])){
		die(header("Location: http://www.ruffles.com.tr/enkafadar/w"));
	}else{
		//some staff	
	}
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Ruffles En Kafadar</title>
		<meta http-equiv="content-language" content="tr-TR" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta name="keywords" content="Ruffles, En Kafadar, Eğlence, Oyun" />
		<meta name="author" content="Wanda Digital" />
		<meta name="copyright" content="info@enkafadar.com" />		
		<meta name="robots" content="index,follow" />
		<meta name="revisit-after" content="1 Day" />
		<?php
		//print_r($_GET['share']);
		if(isset($_GET['share'])){
			$data = base64_decode($_GET['share']);
			//echo $data;
			$data = json_decode($data,true);
			//echo $data;
			$data['homefullname'];
			$data['awayfullname'];
			$data['homescore'];
			$data['awayscore'];
		?>
		<meta name="description" content="Sürpriz Sonuç <?=$data['homefullname']?>, <?=$data['awayfullname']?> maçı <?=$data['homescore']?>-<?=$data['awayscore']?> bitti." />
		<meta name="title" content="Ruffles En Kafadar" />
		<link rel="image_src" href="http://www.ruffles.com.tr/enkafadar/Images/Logo.png" />
		<?php
		}else{
		?>
		<meta name="description" content="Bu kafalar çok tutacak! Ruffles En Kafadar'la sahalara çıktı, kafalar rahatladı. Zemin futbola müsait, ödüller çeşit çeşit! Seni de En Kafadar'a bekliyoruz." />
		<meta name="title" content="Ruffles En Kafadar" />
		<link rel="image_src" href="http://www.ruffles.com.tr/enkafadar/Images/Logo.png" />
		<?php	
		}
		?>
		<base href="http://www.ruffles.com.tr/enkafadar/w/" />
		<link rel="shortcut icon" href="../Images/FavIcon.ico" type="image/x-icon" />
		<link rel="stylesheet" type="text/css" href="../Styles/Master.css.php"  media="screen" />
		<script type="text/javascript">
		/*
		  var _gaq = _gaq || [];
		  _gaq.push(['_setAccount', 'UA-5395522-10']);
		  _gaq.push(['_trackPageview']);
		  (function() {
			var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
			var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		  })();	
		  */
		</script>
	</head>
	<body>
		<div id="dvFlashContent">
			<noscript> 
				You need to upgrade your Flash Player
				<a href="http://get.adobe.com/flashplayer/">Get Adobe Flash Player</a>
			</noscript> 
		</div>	
		<script src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php" type="text/javascript"></script>	
		<script type="text/javascript" src="../Scripts/jscompress.js.php"></script>
		<script type="text/javascript"> 
		// <![CDATA[
			var Src = "../Swf/SwfLoader.swf";
			var Language = "tr-TR";
			var data = "<?php echo isset($_GET['kafakamerasi']) ? $_GET['kafakamerasi'] : '' ?>";
			so = new SWFObject(Src, "FL", "100%", "100%", "10", "#FFFFFF");
			so.addParam("wmode", "window");
			so.addParam("scale", "noscale");
			so.addParam("menu", "false");
			so.addParam("allowScriptAccess", "always");
			so.addParam("allowFullScreen", "true");
			so.addVariable("Language ", Language);
			so.addVariable("kafakamerasi ", data);
			so.write("dvFlashContent");
		// ]]>
		</script>		
	</body>
</html>