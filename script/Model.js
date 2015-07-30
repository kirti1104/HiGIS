function Model()
{
  var Model = {};
  
  
  // =========================== H E A D E R =========================== //
  
  /* MEMBER FUNCTIONS */
  
  // constructor
  Model.initModel = initModel;

  // getter
  Model.getYearRange = getYearRange;                // get min[0]/max[1] year of data visualisation

  /* MEMBER VARIABLES */

  // range of year
  var myMinYear = 1960;             // min year of visualisation
  var myMaxYear = 2010;             // max year of visualisation

  // =================== I M P L E M E N T A T I O N =================== //  

  /** CONSTRUCTOR **/
  function initModel()
  {

    // fill datasets with values
    // --> when done, fill region data
    //~ makeDatasets();
  }

    // for each country, add iso2 code as country[3]
	/*
    $.ajax(
      {
        dataType: 'json',
        url: 'data/countries.json',
        async: false,
        success: function(data)
          {
            // for each country in return array
            $.each(data[1], function(key, val)
              {
                // get id and iso 2 code from country
                var id = val['id'];
                var iso2 = val['iso2Code'];

                // find id in countries and set iso2 code
                for (var i in myCountries)
                {
                  if (myCountries[i][0] == id)
                  {
                    myCountries[i].push(iso2);
                    break;
                  }
                }
              }
            );

            // proceed to next step!
            makeRegions();
          }
      }
    );
	*/

  /** GETTER **/
  function getYearRange()
  {
    return new Array(myMinYear, myMaxYear);
  }

  return Model;
}