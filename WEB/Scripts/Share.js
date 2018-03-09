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
            mURL = "http://friendfeed.com/share/bookmarklet/frame#title=" + title + "&amp;url=" + url;
            break;

        case "twitter":
            mURL = "http://twitter.com/?status=" + url;
            break;

        case "live":
            mURL = "https://login.live.com/login.srf?wa=wsignin1.0&rpsnv=10&ct=1203804025&rver=4.5.2135.0&wp=SAPI&wreply=" + url;
            break;

    }

    var wpen = window.open(mURL.replace(/amp;/gi, ''), null, options);
    wpen.focus();

}   