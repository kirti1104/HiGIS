function Controller()
{
  var Controller = {};
  
  
  // =========================== H E A D E R =========================== //
  
  /* MEMBER FUNCTIONS */
  
  // constructor
  Controller.initController = initController;

  // setter
  Controller.setNowYear = setNowYear;

  /* MEMBER VARIABLES */

  var myNowYear = 1989;               // current year of visualisation [!!!]

  // mouse interaction
  var myLastPos = 0;                // last position of click in the UI
  var myIsOnTimeline = false;       // mouse clicked on timeline? 
  var myIsOnNowMarker = false;      // mouse clicked on now marker?

  /* important elements */

  // timeline
  var myTimeline = $('#tlMain');
  var myNowMarker = $('#nowMarker');

  
  // =================== I M P L E M E N T A T I O N =================== //  

  /** CONSTRUCTOR **/
  
  function initController()
  {
    // initially set timeline range and now marker
    Timeline.initRange(Model.getYearRange()[0], Model.getYearRange()[1]);
    Timeline.initNowMarker(myNowYear);

    // initially update map
    // Map.update();
  }

  /** SETTER **/
  
  function setNowYear(inYear)
  {
    // if nowYear has actually changed
    if (inYear != myNowYear)
    {
      myNowYear = inYear;

	// put here what has to happen if the now date changes
		console.log(myNowYear);

      /* UPDATE VIEW */
      // Map.update(myDataValues, myDataScale, myIntervalValues, myIntervalColors);
    }
  }

  /** MOUSE INTERACTION **/

  /* for both timeline now marker:
    click -> change marker position once
    drag marker -> change marker position continuously */
  /* catch every mouse event happened in the whole window / document
   -> then forward to specific element */

  function eventUITarget(evt, node)
  {
    /* check if clicked on certain elements or
      if desired element is one of their parents
      syntax: "closest(desEl)" is an object containing all elements
      in the DOM tree of the node clicked on that match with desEl
      => if there is one element in this object, then it is
      the one we are looking for, so the length of the object is 1 
      (otherwise it is 0)
    */
    return $(evt.target).closest(node).length==1;
  }
   
  $(document).mousedown(function(evt)
    {
      // prevent mouse cursor to become pointer in Chrome
      evt.preventDefault();
    
      // only react on left mouse button
      if (evt.which != 1) return;

      // set last position user clicked on
      myLastPos = evt.pageX;

      // check in which part of the UI mouse interaction happened
      // -> redirect event there
        
      // clicked on timeline?
      if (eventUITarget(evt, myTimeline))
        myIsOnTimeline = true;
      // clicked on nowMarker?
      if (eventUITarget(evt, myNowMarker))
        myIsOnNowMarker = true;
    }
  );

  $(document).mousemove(function(evt)
    {
      // click position
      var xPos = evt.pageX;

      // check in which part of the UI mouse interaction happened
      // -> redirect event there
      if (eventUITarget(evt, myTimeline))
      {
        // distance moved since last event
        var xDist = evt.pageX-myLastPos;
        // clicked the nowMarker on the timeline? => drag it continuously!
        if (myIsOnNowMarker)
          Timeline.setNowMarker(toTlPos(xPos));
      }
    }
  );

  $(document).mouseup(function (evt)
    {
      // only react on left mouse button
      if (evt.which != 1) return

      // get click position
      var xPos = evt.pageX;

      // check in which part of the UI mouse interaction happened
      // -> redirect event there

      // mouse is not down on any element anymore
      myIsOnTimeline = false;
      myIsOnNowMarker = false;
    }
  );

  $(document).click(function(evt)
    {
      // only react on left mouse button
      if (evt.which != 1) return
      // check in which part of the UI mouse interaction happened
      // -> redirect event there
    }
  );

  /** KEYBOARD INTERACTION **/

  /* use the keyboard to control animation */
  $(document).keydown(function(evt)
    {
      // get key code
      var key = (evt.keyCode ? evt.keyCode : evt.which);
      
      // Space = toggle animation
      if (key == 32)
        Timeline.toggleAni();
          
      // + = faster
      else if ((key == 107) || (key == 43) || (key == 187) )
      {
        evt.preventDefault();   // for Opera to not zoom into site
        Timeline.changeSpeed(+1);
      }
      // - = slower
      else if ((key == 109) || (key == 45) || (key == 189) )
      {
        evt.preventDefault();   // for Opera to not zoom out of site
        Timeline.changeSpeed(-1);
      }
      
      // arrow left / right = change direction
      else if (key == 37 || key == 52)
        Timeline.changeDirection(-1);
      else if (key == 39 || key == 54)
        Timeline.changeDirection(1);
    }
  );

  /** PRIVATE FUNCTIONS **/

  
  /** AUXILIARY FUNCTIONS **/
  
  function toTlPos(inPos)
  {
    // clicked pos = x value of click in document - x position of div
    return outPos = Math.round(inPos - myTimeline.offset().left);
  }

  return Controller;
}