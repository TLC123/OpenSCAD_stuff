"use strict"

var gShaderToy = null;
var gRes = null;

function ShaderToy( parentElement )
{
    if( parentElement==null ) return;

    this.mAudioContext = null;
    this.mCreated = false;
    this.mGLContext = null;
    this.mHttpReq = null;
    this.mEffect = null;
    this.mTo = null;
    this.mTOffset = gTime * 1000;
    this.mCanvas = null;
    this.mFpsFrame = 0;
    this.mFpsTo = null;
    this.mIsPaused = gPaused;
    this.mForceFrame = true;
    this.mInfo = null;
//    this.mCharCounter = document.getElementById("numCharacters");
    this.mCode = null;

    this.mCanvas = document.getElementById("demogl");
    this.mCanvas.tabIndex = "0";

    var ww = parentElement.offsetWidth;
    var hh = parentElement.offsetHeight;

    var me = this;
    this.mCanvas.width  = ww;
    this.mCanvas.height = hh;

    this.mHttpReq = new XMLHttpRequest();
    this.mTo = getRealTime();
    this.mTf = this.mTOffset;
    this.mFpsTo = this.mTo;
    this.mMouseIsDown = false;
    this.mMouseOriX = 0;
    this.mMouseOriY = 0;
    this.mMousePosX = 0;
    this.mMousePosY = 0;

    // --- rendering context ---------------------

    this.mGLContext = piCreateGlContext( this.mCanvas, false, false, false );
    if( this.mGLContext==null )
    {
        createNoWebGLMessage( parentElement, this.mCanvas );
        this.mIsPaused = true;
        this.mForceFrame = false;
        return;
    }


    // --- audio context ---------------------

    this.mAudioContext = piCreateAudioContext();

    if( this.mAudioContext==null )
    {
         //alert( "no audio!" );
    }

    // --- soundcloud ---------------------

    if (typeof SC !== "undefined") 
    {
        SC.client_id = 'b1275b704badf79d972d51aa4b92ea15';
        SC.initialize({
            client_id: SC.client_id
        });
    }
    else
    {
        SC = null;
    }


    this.mCanvas.onmousedown = function(ev)
    {
        var pos = piGetCoords( me.mCanvas );
        me.mMouseOriX =                     (ev.pageX - pos.mX)*me.mCanvas.width/me.mCanvas.offsetWidth;
        me.mMouseOriY = me.mCanvas.height - (ev.pageY - pos.mY)*me.mCanvas.height/me.mCanvas.offsetHeight;
        me.mMousePosX = me.mMouseOriX;
        me.mMousePosY = me.mMouseOriY;
        me.mMouseIsDown = true;
        if( me.mIsPaused ) me.mForceFrame = true;
    }
    this.mCanvas.onmousemove = function(ev)
    {
        if( me.mMouseIsDown )
        {
            var pos = piGetCoords( me.mCanvas );
            me.mMousePosX =                     (ev.pageX - pos.mX)*me.mCanvas.width/me.mCanvas.offsetWidth;
            me.mMousePosY = me.mCanvas.height - (ev.pageY - pos.mY)*me.mCanvas.height/me.mCanvas.offsetHeight;
            if( me.mIsPaused ) me.mForceFrame = true;
        }
    }
    this.mCanvas.onmouseup = function(ev)
    {
        me.mMouseIsDown = false;
        me.mMouseOriX = -Math.abs( me.mMouseOriX );
        me.mMouseOriY = -Math.abs( me.mMouseOriY );
        if( me.mIsPaused ) me.mForceFrame = true;
    }

    this.mCanvas.onkeydown = function(ev)
    {
        me.mEffect.SetKeyDown( 0, ev.keyCode );
        if( me.mIsPaused ) me.mForceFrame = true;
    }
    this.mCanvas.onkeyup = function(ev)
    {
        me.mEffect.SetKeyUp( 0, ev.keyCode );
        if( me.mIsPaused ) me.mForceFrame = true;
    }

    document.getElementById("myResetButton").onclick = function( ev )
    {
        me.resetTime();
    }
    document.getElementById("myPauseButton").onclick = function( ev )
    {
        me.pauseTime();
    }

    this.mCanvas.ondblclick = function( ev )
    {
        if( piIsFullScreen()==false )
        {
            piRequestFullScreen( me.mCanvas );
            me.mCanvas.focus(); // put mouse/keyboard focus on canvas
        }
        else
        {
            piExitFullScreen();
        }
    }

    document.getElementById("myFullScreen").onclick = function( ev )
    {
        piRequestFullScreen( me.mCanvas );
        me.mCanvas.focus(); // put mouse/keyboard focus on canvas
    }

    this.mEffect = new Effect( null, this.mAudioContext, this.mGLContext, this.mCanvas.width, this.mCanvas.height, this.RefreshTexturThumbail, this, gMuted, false );
    this.mCreated = true;

}

ShaderToy.prototype.startRendering = function()
{
    var me = this;

    function renderLoop2()
    {
        if( me.mGLContext==null ) return;

        requestAnimFrame( renderLoop2 );

        if( me.mIsPaused && !me.mForceFrame )
        {
            me.mEffect.UpdateInputs( 0, false );
            return;
        }

        me.mForceFrame = false;
        var time = getRealTime();
        var ltime = me.mTOffset + time - me.mTo;

        if( me.mIsPaused ) ltime = me.mTf; else me.mTf = ltime;

        var dtime = 1000.0 / 60.0;

        me.mEffect.Paint(ltime/1000.0, dtime/1000.0, me.mMouseOriX, me.mMouseOriY, me.mMousePosX, me.mMousePosY, me.mIsPaused );

        me.mGLContext.flush();

        me.mFpsFrame++;

        document.getElementById("myTime").innerHTML = (ltime/1000.0).toFixed(2);
        if( (time-me.mFpsTo)>1000 )
        {
            var ffps = 1000.0 * me.mFpsFrame / (time-me.mFpsTo);
            document.getElementById("myFramerate").innerHTML = ffps.toFixed(1) + " fps";
            me.mFpsFrame = 0;
            me.mFpsTo = time;
        }
    }

    renderLoop2();
}

ShaderToy.prototype.resize = function( xres, yres )
{
    this.mCanvas.setAttribute("width", xres);
    this.mCanvas.setAttribute("height", yres);
    this.mCanvas.width = xres;
    this.mCanvas.height = yres;

    this.mEffect.SetSize(xres,yres);
    this.mForceFrame = true;
}

//---------------------------------

ShaderToy.prototype.Stop = function()
{
    document.getElementById("myPauseButton").style.background="url('/img/playEmbed.png')";
    this.mIsPaused = true;
    this.mEffect.StopOutputs();
}

ShaderToy.prototype.pauseTime = function()
{
    var time = getRealTime();
    if( !this.mIsPaused )
    {
        this.Stop();
     }
    else
    {
        document.getElementById("myPauseButton").style.background="url('/img/pauseEmbed.png')";
        this.mTOffset = this.mTf;
        this.mTo = time;
        this.mIsPaused = false;
        this.mEffect.ResumeOutputs();
        this.mCanvas.focus(); // put mouse/keyboard focus on canvas
    }
}

ShaderToy.prototype.resetTime = function()
{
    this.mTOffset = 0;
    this.mTo = getRealTime();
    this.mTf = 0;
    this.mFpsTo = this.mTo;
    this.mFpsFrame = 0;
    this.mForceFrame = true;
    this.mEffect.ResetTime();
    this.mCanvas.focus(); // put mouse/keyboard focus on canvas
}


ShaderToy.prototype.PauseInput = function( id )
{
    return this.mEffect.PauseInput( 0, id );
}

ShaderToy.prototype.MuteInput = function( id )
{
    return this.mEffect.MuteInput( 0, id );
}

ShaderToy.prototype.RewindInput = function( id )
{
    this.mEffect.RewindInput( 0, id );
    this.mCanvas.focus(); // put mouse/keyboard focus on canvas
}

ShaderToy.prototype.SetTexture = function( slot, url )
{
    this.mEffect.NewTexture( 0, slot, url );
}

ShaderToy.prototype.RefreshTexturThumbail = function( myself, slot, img, forceFrame, gui, guiID, time )
{
  myself.mForceFrame = forceFrame;
}

ShaderToy.prototype.newScriptJSON = function( jsn )
{
    try
    {
        var res = this.mEffect.newScriptJSON( jsn );
        this.mCode = res.mShader;

        if( res.mFailed==false )
        {
            //this.resetTime();
            this.mForceFrame = true;
        }

        this.mInfo = jsn.info;

        return { mFailed      : false,
                 mDate        : jsn.info.date,
                 mViewed      : jsn.info.viewed,
                 mName        : jsn.info.name,
                 mUserName    : jsn.info.username,
                 mDescription : jsn.info.description,
                 mLikes       : jsn.info.likes,
                 mPublished   : jsn.info.published,
                 mHasLiked    : jsn.info.hasliked,
                 mTags        : jsn.info.tags };

    }
    catch( e )
    {
        return { mFailed:true };
    }
}

function loadShader()
{
    <!-- shader -------------------------------------------------------- -->

    var xmlS = null;
    try
    {
        var httpReq = new XMLHttpRequest();
        httpReq.open( "POST", "/shadertoy", false );
        httpReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        var str = "{ \"shaders\" : [\"" + gShaderID + "\"] }";
        str = "s=" + encodeURIComponent( str );

        httpReq.send( str  );
        xmlS = httpReq.responseText;
    }
    catch(e)
    {
    }

    return { mShader:xmlS };
}

function watchResize()
{
    var srdiv = document.getElementById("demogl");
    if( srdiv )
    {
    var xres = srdiv.offsetWidth;
    var yres = srdiv.offsetHeight;
    gShaderToy.resize( xres, yres );
    }
}



function watchInit()
{
      //-- shadertoy --------------------------------------------------------
    var viewerParent = document.getElementById("player");

    if( gShowGui==false )
    {
        document.getElementById('shaderInfo').className='isNotVisible';
        document.getElementById('playerBar').className='isNotVisible';
    }

    viewerParent.addEventListener( "mouseover", function(e)
    {
        document.getElementById('shaderInfo').className='isVisible';
        document.getElementById('playerBar').className='isVisible';
    }, true );

    viewerParent.addEventListener( "mouseout", function(e)
    {
      var tt = e.relatedTarget || e.toElement;

      //console.log( "OUT   t: " + e.target.id + "    ct: " + e.currentTarget.id + "    this: " + this.id + "    target: " + ((tt==null)?"none":tt.id) );
      if( tt!=null ) return;

      document.getElementById('shaderInfo').className='isNotVisible';
      document.getElementById('playerBar').className='isNotVisible';
    }, true );

    document.body.addEventListener( "keydown", function(e)
                                               {
                                                     var ele = piGetSourceElement(e)
                                                     if( e.keyCode==8 && ele===document.body )
                                                         e.preventDefault();
                                               } );

    gShaderToy = new ShaderToy( viewerParent, null );
    if( !gShaderToy.mCreated )
    {
        if( gInvisIfFail!=null )
        {
          var div = document.createElement("img");
          div.src = gInvisIfFail;
          var root = document.getElementsByTagName( "body" )[0];
          root.replaceChild( div, viewerParent );
        }
        return;
    }

    //-- get info --------------------------------------------------------

    var res = { mShader:null };

    if( gShaderID==null )
    {
         console.log( "Shader error." );
    }
    else
    {
         res = loadShader( gShaderID );
    }
    //-- shader --------------------------------------------------------

    if( res.mShader==null ) return;

    var jsnShader = null;
    try { jsnShader = JSON.parse( res.mShader ); } catch(e) { alert( "ERROR in JSON: " + res.mShader ); return; }

    gRes = gShaderToy.newScriptJSON( jsnShader[0] )

    if( gRes.mFailed )
    {
        gShaderToy.pauseTime();
        gShaderToy.resetTime();
    }
    else
    {
        var st = document.getElementById( "shaderTitle" );
        var str  = "<a class=\"shaderTitle\" target=\"_blank\" href=\"https://www.shadertoy.com/view/" + gShaderID + "\">" + gRes.mName + "</a>";
            str += "<span>by " + gRes.mUserName + " in " + getTime(gRes.mDate) + "</span>";
        st.innerHTML = str;

        var shaderStats  = document.getElementById( "shaderStats" );
        shaderStats.innerHTML = "<img src='/img/viewsEmbed.png' class='viewsIcon'></img><span>" + gRes.mViewed + "</span>    &nbsp;&nbsp;  <img src='/img/likesEmbed.png' class='likesIcon'></img><span>" + gRes.mLikes + "</span>";

        if( gShaderToy.mIsPaused )
        {
            gShaderToy.Stop();
        }


        gShaderToy.startRendering();
    }
}
