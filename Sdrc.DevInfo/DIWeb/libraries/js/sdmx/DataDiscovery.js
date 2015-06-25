﻿function onPageLoad(hdsby, hdbnid, hselarea, hselind, hlngcode, hlngcodedb, hselindo, hselareao)
{	
	// ************************************************
	// create Form Tag with hidden input boxes
	// ************************************************
	createFormHiddenInputs("frm_sdmxDataDiscovery", "POST")

	// ************************************************1
	// set page level variables based on selections or defaults
	// ************************************************1
    setPostedData(hdsby, hdbnid, hselarea, hselind, hlngcode, hlngcodedb, hselindo, hselareao);

	// ************************************************1
	// Load Language Component
	// ************************************************1
	//ShowLanguageComponent(getAbsURL('stock'), 'lngcode_div', hlngcode);

    ShowIndicatorComponent(getAbsURL('stock').replace('SDMX/',''), 'indicator_div', '100', 'en', '','100%', '300');

    ShowAreaComponent(getAbsURL('stock').replace('SDMX/',''), 'area_div', '100' , 'en' ,'', '100%', '300');
	
	 document.getElementById('divProviders').style.display = "none";
	 document.getElementById('divData').style.display = "none";
   
}

function GetDataProvidersList()
{
    document.getElementById('divProviders').style.display = "block";
    document.getElementById('divData').style.display = "none";
}


function GetData()
{
    document.getElementById('divData').style.display = "block";
}

/* function to Post data from DataDiscovery.aspx to StructuralMD.aspx(Registry Start page) on click of Registry link*/
function onGotoRegistry()
{
     // Post the data
     PostData("frm_sdmxDataDiscovery", "RegStructure.aspx", "POST");
}

