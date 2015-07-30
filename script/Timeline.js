function Timeline()
{
  var Timeline = {};


  // =========================== H E A D E R =========================== //
  
  /* MEMBER FUNCTIONS */
  
  // constructor
  Timeline.initTimeline = initTimeline;
  Timeline.initRange = initRange;
  Timeline.initNowMarker = initNowMarker;

  // nowMarker control
  Timeline.setNowMarker = setNowMarker;
  

  /* MEMBER VARIABLES */

  // important elements
  var myTimeline = $('#tlMain');
  var myPlayButt = $('#playButt');
  var myDirectVal = $('#directionVal');
  var mySpeedVal = $('#speedVal');
  var myNowMarker = null;

  // timeline
  var myDecadePos = [];             // array containing positions of decade year markers
  var myTlWidth = 0;              // width of timeline
  var myYearDist = 0;             // distance between two years on timeline [px]
  var myMinYear = 0;

  // animation
  var myDestPos = 0;            	// current destination position in timeline for animation
  var myAni = null;               // reference to interval animation
  var myAniRun = false;           // is animation running?
  var myAniSpeedValues;           // array containing range of possible animation speed values
  var myAniSpeed = 2;             // current animation speed (position in speed range array), normal = 2
  var myAniDirect = 1;            // current animation direction (forward or backward)
  
  
  // =================== I M P L E M E N T A T I O N =================== //

  
  /** CONSTRUCTOR  **/
  
  function initTimeline()
  {
    /* initially set nowMarker */
    myTimeline.append($('<div id="nowMarker"></div>'));
    myNowMarker = $('#nowMarker');
  }

  function initRange(inMinYear, inMaxYear)
  {
    myMinYear = inMinYear;                            
    myTlWidth = myTimeline.width();                       // total width of timeline [px]
    myYearDist = myTlWidth / (inMaxYear-inMinYear);       // distance between two years on timeline [px/year]
    var numMarkers = Math.floor((inMaxYear-inMinYear)/10);
    // set each 10-year marker yearDist*10 px further
    for (var i=0; i<=numMarkers; i++)
    {
      var markerYear = (i*10)+inMinYear;
      var id = markerYear;
      var pos = i*myYearDist*10;
      myTimeline.append($('<div id="'+id+'" class="yearMarker"><p>'+markerYear+'</p></div>'));
      $('#'+id).css('left', pos);
      myDecadePos.push(pos);
    }  
  }

  function initNowMarker(inYear)
  {
    setNowMarker(yearToPos(inYear));
  }

  /** NOW MARKER **/

  function setNowMarker(inPos, convert)
  {
    if (convert)
      inPos = toTlPos(inPos);
    
    // clip nowMarker position to tlMain and stop animation there
    if (inPos < 0)
    {
      inPos = 0;
    }
    if (inPos > myTlWidth)
    {
      inPos = myTlWidth;
    }

    // reset marker
    myNowMarker.css('left', inPos);

    // tell controller which year is now
    Controller.setNowYear(posToYear(inPos));
  }

  /** AUXILIARY FUNCTIONS **/

  function panToDecade(inPos)
  {
    // check if close to decade year markers
    for (var i in myDecadePos)
      if (Math.abs(inPos-myDecadePos[i]) < 12)
        inPos = myDecadePos[i];
    return inPos;
  }
  
  function posToYear(inPos)
  {
    // year ~ clickPos in tlMain
    return Math.round((inPos/myYearDist)+myMinYear);
  }
  
  function yearToPos (inYear)
  {
    return Math.round(myYearDist*(inYear-myMinYear));
  }
  
  return Timeline;
}