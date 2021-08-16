"use strict"

var getTime = function ( timestamp )
{
    var monthstr=new Array();
    monthstr[0]="Jan";
    monthstr[1]="Feb";
    monthstr[2]="Mar";
    monthstr[3]="Apr";
    monthstr[4]="May";
    monthstr[5]="Jun";
    monthstr[6]="Jul";
    monthstr[7]="Aug";
    monthstr[8]="Sep";
    monthstr[9]="Oct";
    monthstr[10]="Nov";
    monthstr[11]="Dec";

 	var a = new Date(timestamp*1000);

//    var month = a.getMonth() + 1;
//    var time = a.getDate() + "/" + month + "/" + a.getFullYear();

    var time = a.getFullYear() + "-" + monthstr[a.getMonth()] + "-" + a.getDate();

    return time;
}


function setWheelEvent( myHandler )
{

  function wheel(event)
  {
  	var delta = 0;
  	if( !event ) event = window.event;
  	if( event.wheelDelta )
      {
  		delta = event.wheelDelta/120;
  	}
      else if( event.detail )
      {
  		delta = -event.detail/3;
  	}
  	if( delta )
  		myHandler( delta );
      if( event.preventDefault )
          event.preventDefault();
      event.returnValue = false;
  }

if (window.addEventListener) window.addEventListener('DOMMouseScroll', wheel, false);
window.onmousewheel = document.onmousewheel = wheel;

}

function createNoWebGLMessage( base, old )
{
      var div = document.createElement("div");
      div.style.left   = "0px";
      div.style.top    = "0px";
      div.style.width  = "100%";
      div.style.height = "100%";
      div.style.padding= "0px";
      div.style.margin = "0px";
      div.style.position="absolute";
      div.style.backgroundColor = "#202020";
      div.style.borderRadius = "8px";
      div.style.cursor = "pointer";
      div.style.visibilty = "hidden";
      base.replaceChild( div, old );

      var divText = document.createElement("div");
      divText.style.width  = "86%";
      divText.style.height = "90%";
      divText.style.paddingLeft="7%";
      divText.style.paddingRight="7%";
      divText.style.paddingTop = "10%";
      divText.style.paddingBottom="0px";
      divText.style.color = "#ffffff";
      var fontSize = (base.offsetWidth/32) | 0;
      if( fontSize< 6 ) fontSize =  6;
      if( fontSize>16 ) fontSize = 16;
      divText.style.font="italic bold " + fontSize + "px arial,serif";
      divText.innerHTML = 'Shadertoy needs a WebGL-enabled browser. Minimum Requirements: <ul><li>Firefox 17</li><li>Chrome 23</li><li>Internet Explorer 11</li><li>Safari 8</li></ul>';
      div.appendChild( divText );
}


// from stackoverflow
function strip_html( text )
{
    if( text===null ) return null;

    if( undefined===strip_html.htmlTagRegexp )
    {
        strip_html.htmlTagRegexp = new RegExp('</?(?:article|aside|bdi|command|'+
            'details|dialog|summary|figure|figcaption|footer|header|hgroup|mark|'+
            'meter|nav|progress|ruby|rt|rp|section|time|wbr|audio|'+
            'video|source|embed|track|canvas|datalist|keygen|output|'+
            '!--|!DOCTYPE|a|abbr|address|area|b|base|bdo|blockquote|body|'+
            'br|button|canvas|caption|cite|code|col|colgroup|dd|del|dfn|div|'+
            'dl|dt|em|embed|fieldset|figcaption|figure|footer|form|h1|h2|h3|h4|'+
            'h5|h6|head|hr|html|i|iframe|img|input|ins|kdb|keygen|label|legend|'+
            'li|link|map|menu|meta|noscript|object|ol|optgroup|option|p|param|'+
            'pre|q|s|samp|script|select|small|source|span|strong|style|sub|'+
            'sup|table|tbody|td|textarea|tfoot|th|thead|title|tr|u|ul|var|'+
            'acronym|applet|basefont|big|center|dir|font|frame|'+
            'frameset|noframes|strike|tt)(?:(?: [^<>]*)>|>?)', 'i');
    }

    for(;;)
    {
        var str = text.match( strip_html.htmlTagRegexp );
        if( str===null ) break;
        text = text.replace(str[0], '');
    }

    return text;
}

function doSyntaxHighlight( str )
{
    str = str.replace( /\t/g, "    " );
    str = str.replace( /ivec4/g, "<span class='cCodeKeyWord'>ivec4</span>" );
    str = str.replace( /ivec3/g, "<span class='cCodeKeyWord'>ivec3</span>" );
    str = str.replace( /ivec2/g, "<span class='cCodeKeyWord'>ivec2</span>" );
    str = str.replace( /float/g, "<span class='cCodeKeyWord'>float</span>" );
    str = str.replace( /vec4/g, "<span class='cCodeKeyWord'>vec4</span>" );
    str = str.replace( /vec3/g, "<span class='cCodeKeyWord'>vec3</span>" );
    str = str.replace( /vec2/g, "<span class='cCodeKeyWord'>vec2</span>" );
    str = str.replace( /int/g, "<span class='cCodeKeyWord'>void</span>" );
    str = str.replace( /void/g, "<span class='cCodeKeyWord'>int</span>" );

    str = str.replace( /#define/g, "<span class='cCodePreprocessor'>#define</span>" );
    str = str.replace( /#ifdef/g, "<span class='cCodePreprocessor'>#ifdef</span>" );
    str = str.replace( /#if/g, "<span class='cCodePreprocessor'>#if</span>" );
    str = str.replace( /#else/g, "<span class='cCodePreprocessor'>#else</span>" );
    str = str.replace( /#endif/g, "<span class='cCodePreprocessor'>#endif</span>" );

    str = str.replace( /any/g, "<span class='cCodeInstruction'>any</span>" );
    str = str.replace( /all/g, "<span class='cCodeInstruction'>all</span>" );
    str = str.replace( /abs/g, "<span class='cCodeInstruction'>abs</span>" );
    str = str.replace( /acos/g, "<span class='cCodeInstruction'>acos</span>" );
    str = str.replace( /asin/g, "<span class='cCodeInstruction'>asin</span>" );
    str = str.replace( /atan/g, "<span class='cCodeInstruction'>atan</span>" );
    str = str.replace( /break/g, "<span class='cCodeInstruction'>break</span>" );
    str = str.replace( /ceil/g, "<span class='cCodeInstruction'>ceil</span>" );
    str = str.replace( /clamp/g, "<span class='cCodeInstruction'>clamp</span>" );
    str = str.replace( /continue/g, "<span class='cCodeInstruction'>continue</span>" );
    str = str.replace( /cos/g, "<span class='cCodeInstruction'>cos</span>" );
    str = str.replace( /cross/g, "<span class='cCodeInstruction'>cross</span>" );
    str = str.replace( /degrees/g, "<span class='cCodeInstruction'>degrees</span>" );
    str = str.replace( /distance/g, "<span class='cCodeInstruction'>distance</span>" );
    str = str.replace( /dot/g, "<span class='cCodeInstruction'>dot</span>" );
    str = str.replace( /dFdx/g, "<span class='cCodeInstruction'>dFdx</span>" );
    str = str.replace( /dFdy/g, "<span class='cCodeInstruction'>dFdy</span>" );
    str = str.replace( /equal/g, "<span class='cCodeInstruction'>equal</span>" );
    str = str.replace( /exp/g, "<span class='cCodeInstruction'>exp</span>" );
    str = str.replace( /exp2/g, "<span class='cCodeInstruction'>exp2</span>" );
    str = str.replace( /faceforward/g, "<span class='cCodeInstruction'>faceforward</span>" );
    str = str.replace( /floor/g, "<span class='cCodeInstruction'>floor</span>" );
    str = str.replace( /fract/g, "<span class='cCodeInstruction'>fract</span>" );
    str = str.replace( /fwidth/g, "<span class='cCodeInstruction'>fwidth</span>" );
    str = str.replace( /inversesqrt/g, "<span class='cCodeInstruction'>inversesqrt</span>" );
    str = str.replace( /length/g, "<span class='cCodeInstruction'>length</span>" );
    str = str.replace( /log/g, "<span class='cCodeInstruction'>log</span>" );
    str = str.replace( /log2/g, "<span class='cCodeInstruction'>log2</span>" );
    str = str.replace( /max/g, "<span class='cCodeInstruction'>max</span>" );
    str = str.replace( /mix/g, "<span class='cCodeInstruction'>mix</span>" );
    str = str.replace( /min/g, "<span class='cCodeInstruction'>min</span>" );
    str = str.replace( /mod/g, "<span class='cCodeInstruction'>mod</span>" );
    str = str.replace( /normalize/g, "<span class='cCodeInstruction'>normalize</span>" );
    str = str.replace( /not/g, "<span class='cCodeInstruction'>not</span>" );
    str = str.replace( /notEqual/g, "<span class='cCodeInstruction'>notEqual</span>" );
    str = str.replace( /pow/g, "<span class='cCodeInstruction'>pow</span>" );
    str = str.replace( /radians/g, "<span class='cCodeInstruction'>radians</span>" );
    str = str.replace( /reflect/g, "<span class='cCodeInstruction'>reflect</span>" );
    str = str.replace( /refract/g, "<span class='cCodeInstruction'>refract</span>" );
    str = str.replace( /sin/g, "<span class='cCodeInstruction'>sin</span>" );
    str = str.replace( /sign/g, "<span class='cCodeInstruction'>sign</span>" );
    str = str.replace( /sqrt/g, "<span class='cCodeInstruction'>sqrt</span>" );
    str = str.replace( /step/g, "<span class='cCodeInstruction'>step</span>" );
    str = str.replace( /smoothstep/g, "<span class='cCodeInstruction'>smoothstep</span>" );
    str = str.replace( /tan/g, "<span class='cCodeInstruction'>tan</span>" );
    str = str.replace( /texture2D/g, "<span class='cCodeInstruction'>texture2D</span>" );
    str = str.replace( /texture2DProj/g, "<span class='cCodeInstruction'>texture2DProj</span>" );
    str = str.replace( /textureCube/g, "<span class='cCodeInstruction'>textureCube</span>" );

    return str;
}


function isSpace( str, i )
{
    return (str[i]===' ') || (str[i]==='\t');
}
function isLine( str, i )
{
    return (str[i]==='\n');
}

function replaceChars(str)
{
    var dst = "";
    var num = str.length;
    for( var i=0; i<num; i++ )
    {
        if( str[i]==='\r' ) { dst = dst + " "; continue; }//continue;
        if( str[i]==='\t' ) { dst = dst + " "; continue; }

        dst = dst + str[i];
    }
    return dst;
}

function removeEmptyLines(str)
{
    var dst = "";
    var num = str.length;
    var isPreprocessor = false;
    for( var i=0; i<num; i++ )
    {
        if( str[i]==='#' ) isPreprocessor = true;
        var isDestroyableChar = isLine(str,i);

        if( isDestroyableChar && !isPreprocessor ) continue;
        if( isDestroyableChar &&  isPreprocessor ) isPreprocessor = false;

        dst = dst + str[i];
    }

    return dst;
}

function removeMultiSpaces(str)
{
    var dst = "";
    var num = str.length;
    for( var i=0; i<num; i++ )
    {
        if( isSpace(str,i) && (i===(num-1)) ) continue;
        if( isSpace(str,i) && isLine(str,i-1) ) continue;
        if( isSpace(str,i) && isLine(str,i+1) ) continue;
        if( isSpace(str,i) && isSpace(str,i+1) ) continue;
        dst = dst + str[i];
    }
    return dst;
}
function removeSingleSpaces(str)
{
    var dst = "";
    var num = str.length;
    for( var i=0; i<num; i++ )
    {
        if( i>0 )
        {
        if( isSpace(str,i) && ( ( str[i-1]===';' ) ||
                                ( str[i-1]===',' ) ||
                                ( str[i-1]==='}' ) ||
                                ( str[i-1]==='{' ) ||
                                ( str[i-1]==='(' ) ||
                                ( str[i-1]===')' ) ||
                                ( str[i-1]==='+' ) ||
                                ( str[i-1]==='-' ) ||
                                ( str[i-1]==='*' ) ||
                                ( str[i-1]==='/' ) ||
                                ( str[i-1]==='?' ) ||
                                ( str[i-1]==='<' ) ||
                                ( str[i-1]==='>' ) ||
                                ( str[i-1]==='[' ) ||
                                ( str[i-1]===']' ) ||
                                ( str[i-1]===':' ) ||
                                ( str[i-1]==='=' ) ||
                                ( str[i-1]==='^' ) ||
                                ( str[i-1]==='\n' ) ||
                                ( str[i-1]==='\r' )

                            ) ) continue;
        }

        if( isSpace(str,i) && ( ( str[i+1]===';' ) ||
                                ( str[i+1]===',' ) ||
                                ( str[i+1]==='}' ) ||
                                ( str[i+1]==='{' ) ||
                                ( str[i+1]==='(' ) ||
                                ( str[i+1]===')' ) ||
                                ( str[i+1]==='+' ) ||
                                ( str[i+1]==='-' ) ||
                                ( str[i+1]==='*' ) ||
                                ( str[i+1]==='/' ) ||
                                ( str[i+1]==='?' ) ||
                                ( str[i+1]==='<' ) ||
                                ( str[i+1]==='>' ) ||
                                ( str[i+1]==='[' ) ||
                                ( str[i+1]===']' ) ||
                                ( str[i+1]===':' ) ||
                                ( str[i+1]==='=' ) ||
                                ( str[i+1]==='^' ) ||
                                ( str[i+1]==='\n' ) ||
                                ( str[i+1]==='\r' )

                            ) ) continue;

        dst = dst + str[i];
    }
    return dst;
}

function removeSingleComments(str)
{
    var dst = "";
    var num = str.length;
    var detected = false;
    for( var i=0; i<num; i++ )
    {
        if( i<=(num-2) )
        {
        if( str[i]==='/' && str[i+1]==='/' )
            detected = true;
        }

        if( detected && (str[i]==="\n" || str[i]==="\r") )
            detected = false;

        if( !detected )
            dst = dst + str[i];
    }
    return dst;
}

function removeMultiComments(str)
{
    var dst = "";
    var num = str.length;
    var detected = false;
    for( var i=0; i<num; i++ )
    {
        if( i<=(num-2) )
        {
            if( str[i]==='/' && str[i+1]==='*' )
            {
                detected = true;
                continue;
            }

            if( detected && str[i]==="*" && str[i+1]==="/" )
            {
                detected = false;
                i+=2;
                continue;
            }
        }

        if( !detected )
            dst = dst + str[i];
    }
    return dst;
}

function minify( str )
{
    str = replaceChars( str );
    str = removeSingleComments( str );
    str = removeMultiComments( str );
    str = removeMultiSpaces( str );
    str = removeSingleSpaces( str );
    str = removeEmptyLines( str );
    return str;
}

//----------------------------------

function previewHide(me) {
    me.mBase.style.visibility = "hidden";
    me.mCanvas.style.visibility = "hidden";
    if (gUseScreenshots) me.mCanvas2D.style.visibility = "hidden";
    me.mNoWebGL.style.visibility = "hidden";
    me.mError.style.visibility = "hidden";
}

function previewShowRender(me) {
    me.mBase.style.visibility = "visible";
    me.mCanvas.style.visibility = "visible";
    if (gUseScreenshots) me.mCanvas2D.style.visibility = "hidden";
    me.mNoWebGL.style.visibility = "hidden";
    me.mError.style.visibility = "hidden";
}

function previewShowScreenshot(me) {
    me.mBase.style.visibility = "visible";
    me.mCanvas.style.visibility = "hidden";
    if (gUseScreenshots) me.mCanvas2D.style.visibility = "visible";
    me.mNoWebGL.style.visibility = "hidden";
    me.mError.style.visibility = "hidden";
}

function previewShowLoading(me) {
    me.mBase.style.visibility = "visible";
    me.mCanvas.style.visibility = "hidden";
    if (gUseScreenshots) me.mCanvas2D.style.visibility = "hidden";
    me.mNoWebGL.style.visibility = "hidden";
    me.mError.style.visibility = "hidden";
}

function previewShowNoWebGL(me, addEvents) {
    me.mBase.style.visibility = "visible";
    me.mCanvas.style.visibility = "hidden";
    if (gUseScreenshots) me.mCanvas2D.style.visibility = "hidden";
    me.mNoWebGL.style.visibility = "visible";
    me.mError.style.visibility = "hidden";
}

function previewShowError(me) {
    me.mBase.style.visibility = "visible";
    me.mCanvas.style.visibility = "hidden";
    if (gUseScreenshots) me.mCanvas2D.style.visibility = "hidden";
    me.mNoWebGL.style.visibility = "hidden";
    me.mError.style.visibility = "visible";
}

function previewCheckScreenshotAvailable(url) {
    var http = new XMLHttpRequest();
    http.open('HEAD', url, false);
    http.send();
    return http;
}

function previewRedraw(me) 
{
    if (gUseScreenshots && me.mScreenshot != null) 
    {
        var xres = me.mPreview.mBase.offsetWidth;
        var yres = me.mPreview.mBase.offsetHeight;

        var context = me.m2DContext;
        context.drawImage(me.mScreenshot, 0, 0, xres, yres);

        context.shadowBlur = 20;
        context.shadowColor = "black";
        context.fillStyle = "#FF0000";
        context.fillRect(xres - context.measureText("preview").width - context.measureText("p").width, 0, xres, yres / 5);

        context.shadowBlur = 0;
        context.fillStyle = "#FFFFFF";
        context.font = "8px verdana";
        context.fillText("preview", xres - context.measureText("preview").width - context.measureText("p").width / 2, yres / 6);
    }
    else 
    {
        me.gEffect.Paint(me.mTime, 0, 0, 0, 0, false);
    }
}

function previewLoadScreenshot(me) {
    var url = "/media/shaders/" + me.mShaderID + ".jpg";
    var prev = previewCheckScreenshotAvailable(url);
    if (prev.status != 404) {
        // load image from data url
        me.mScreenshot = new Image();
        me.mScreenshot.onload = function () {
            previewRedraw(me);
        };
        me.mScreenshot.src = url;

        return true;
    }
    return false;
}

function resizePreview(me, w, h) {
    var bar = me.mCanvas;
    bar.width = w;
    bar.height = h;
    bar.style.left = "0px";
    bar.style.top = "0px";
    bar.style.width = w + "px";
    bar.style.height = h + "px";
    bar.style.position = "absolute";

    if (gUseScreenshots) {
        var bar2D = me.mCanvas2D;
        bar2D.width = w;
        bar2D.height = h;
        bar2D.style.left = "0px";
        bar2D.style.top = "0px";
        bar2D.style.width = w + "px";
        bar2D.style.height = h + "px";
        bar2D.style.position = "absolute";
    }

    var cont = me.mCont;
    cont.style.width = w + "px";
    cont.style.left = "0px";
    cont.style.top = h + 2 + "px";
    cont.style.position = "absolute";
}

function createPreview(base, id, x, y, w, h) {
    w = base.offsetWidth;
    h = base.offsetHeight;
    base.mId = id;

    var bar = document.createElement("canvas");
    bar.width = w;
    bar.height = h;
    bar.style.width = w + "px";
    bar.style.height = h + "px";
    bar.style.left = "0px";
    bar.style.top = "0px";
    bar.style.padding = "0px";
    bar.style.margin = "0px";
    bar.style.position = "absolute";
    bar.style.cursor = "pointer";
    bar.mId = id;
    bar.style.visibility = "hidden";
    bar.style.borderRadius = "8px";
    base.appendChild(bar);
    bar.style.border = "0px solid #000000";

    var bar2D = null;
    if (gUseScreenshots) {
        bar2D = document.createElement("canvas");
        bar2D.width = w;
        bar2D.height = h;
        bar2D.style.width = w + "px";
        bar2D.style.height = h + "px";
        bar2D.style.left = "0px";
        bar2D.style.top = "0px";
        bar2D.style.padding = "0px";
        bar2D.style.margin = "0px";
        bar2D.style.position = "absolute";
        bar2D.style.cursor = "pointer";
        bar2D.mId = id;
        bar2D.style.visibility = "hidden";
        bar2D.style.borderRadius = "8px";
        //bar.style.border = "1px solid #606060";
        base.appendChild(bar2D);
        bar2D.style.border = "0px solid #000000";
    }

    var cont = document.createElement("div");
    cont.style.width = w + "px";
    cont.style.left = "0px";
    cont.style.top = h + 1 + "px";
    cont.style.position = "absolute";
    base.appendChild(cont);

    var textA = document.createElement("text");
    textA.className = "previewText";
    cont.appendChild(textA);

    var textC = document.createElement("text");
    textC.className = "previewStats";
    cont.appendChild(textC);

    //----------------
    var div = document.createElement("div");
    div.style.left = "0px";
    div.style.top = "0px";
    div.style.width = "100%";
    div.style.height = "100%";
    div.style.padding = "0px";
    div.style.margin = "0px";
    div.style.position = "absolute";
    div.style.backgroundColor = "#202020";
    div.style.borderRadius = "8px";
    div.style.cursor = "pointer";
    div.style.visibilty = "hidden";
    div.mId = bar.mId;
    base.appendChild(div);

    var divText = document.createElement("div");
    divText.style.width = "86%";
    divText.style.height = "90%";
    divText.style.paddingLeft = "7%";
    divText.style.paddingRight = "7%";
    divText.style.paddingTop = "10%";
    divText.style.paddingBottom = "0px";
    divText.style.color = "#ffffff";
    var fontSize = (w / 32) | 0;
    if (fontSize < 6) fontSize = 6;
    if (fontSize > 16) fontSize = 16;
    divText.style.font = "italic bold " + fontSize + "px arial,serif";
    divText.innerHTML = 'Shadertoy needs a WebGL-enabled browser. Minimum Requirements: <ul><li>Firefox 17</li><li>Chrome 23</li><li>Internet Explorer 11</li><li>Safari 8</li></ul>';
    divText.mId = bar.mId;
    div.appendChild(divText);

    //----------------

    var divError = document.createElement("div");
    divError.style.left = "0px";
    divError.style.top = "0px";
    divError.style.width = "100%";
    divError.style.height = "100%";
    divError.style.padding = "0px";
    divError.style.margin = "0px";
    divError.style.position = "absolute";
    divError.style.backgroundColor = "#000000";
    divError.style.borderRadius = "8px";
    divError.style.cursor = "pointer";
    divError.style.visibilty = "hidden";
    divError.mId = bar.mId;
    base.appendChild(divError);

    var divTextError = document.createElement("div");
    divTextError.style.top = "50%";
    divTextError.style.position = "absolute";
    divTextError.style.width = "100%";
    divTextError.style.textAlign = "center";
    divTextError.style.padding = "0";
    divTextError.style.margin = "auto";
    divTextError.style.color = "#ff0000";
    var fontSize = (w / 16) | 0;
    if (fontSize < 6) fontSize = 6;
    if (fontSize > 24) fontSize = 24;
    divTextError.style.font = "italic bold " + fontSize + "px arial,serif";
    divTextError.innerHTML = 'Shader Error';
    divTextError.mId = bar.mId;
    divError.appendChild(divTextError);

    return { mBase: base, mCanvas: bar, mTextA: textA, mTextC: textC, mCont: cont, mNoWebGL: div, mError: divError, mCanvas2D: bar2D };

}
