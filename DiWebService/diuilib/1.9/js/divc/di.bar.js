/*
* di.bar.js
* 
*/


/*Create markup for visualizer container
function to draw bar chart */
function di_draw_bar_chart(title, uid, width, height, div_id, data, datatype, x_title, y_title, allowTabs, is_save, save_url, lngcodefile, isCloseBtn, hotFuncCloseBtn, shareHotSelection, vcType, settingFileUrl, chartCategory, sourceText, DCURL) {

	var subtitle='';
	var visu_height = height - 50;
	var visu_height_wsmenu = visu_height - 130;

	var div_obj = document.getElementById(div_id);
	var di_vc_libpath = 'http://dgps/di7poc/diuilib/1.1/';
//	var di_vc_libpath = 'http://www.devinfolive.info/di7beta_1/diwebservices/diuilib/1.1/';

	if(hotFuncCloseBtn==null || hotFuncCloseBtn=='' || lngcodefile==undefined) { 
		hotFuncCloseBtn = 'di_vcclose("'+uid+'")';
	}

	if(lngcodefile=='' || lngcodefile==null || lngcodefile==undefined) {
		lngcodefile = di_vc_libpath + 'library/store/lng.xml';
	}
	//var di_vcLangArray = setLangVars( lngcodefile );

	var visul_div_id = 'di_visulcontainer_chart'+uid;
		
	var html_data = di_getVisualizerMarkup(uid, title, subtitle, x_title, y_title, width, height, allowTabs, di_vc_libpath, isCloseBtn, hotFuncCloseBtn, shareHotSelection, 'bar', vcType,DCURL);

	div_obj.innerHTML = html_data; // render the html
	di_jq(document).ready(function() {

		di_createFontSizeDdl('di_vctfontlist'+uid);
		di_createFontSizeDdl('di_vclfontlist'+uid);
		di_createFontSizeDdl('di_vcslfontlist'+uid);	

		// calling function to initialize color pickers
		//initColorPickers(uid, 'bar');
		
		// create chart
		di_readDefaultChartSetting(settingFileUrl,title, uid, visul_div_id, data, datatype, x_title, y_title, subtitle,'bar',chartCategory,sourceText);
		/*********** Start for upload own data************/
		di_jq('#di_vcfrm1'+uid).ajaxForm({
			beforeSubmit: function() {
				//jq('#results').html('Submitting...');
				di_jq('#di_vcprogress_bar'+uid).show();
				di_jq('#di_vcproc1'+uid).removeClass('di_gui_proc_deactive');
				di_jq('#di_vcproc1'+uid).addClass('di_gui_proc_active');
			},
			success: function(filename) {
				/* calling parent application function for drawing grid an dchart
				   input: string data, divid
				*/
				drawOATGrid(filename, 'di_visulcontainer_grid'+uid);

				di_jq('#di_vcupbttn'+uid).attr('disabled', false); // enable upload button
				di_jq('#di_vcprogress_bar'+uid).hide(); // hide process text
				di_jq('#di_vcupfile'+uid).val(''); // empty file input field
				// end
				/*if(filename=='false') {
					alert("File upload error!");
					di_jq('#di_vcprogress_bar'+uid).hide();
					di_jq('#di_vcupbttn'+uid).attr('disabled', false);
					return false;
				}
				else if(filename=='ValidatingError') {
					di_jq('#di_vcproc1'+uid).removeClass('di_gui_proc_active');
					di_jq('#di_vcproc1'+uid).addClass('di_gui_proc_deactive');

					di_jq('#di_vcproc2'+uid).removeClass('di_gui_proc_deactive');
					di_jq('#di_vcproc2'+uid).addClass('di_gui_proc_active');

					alert("Validating error!");
					di_jq('#di_vcprogress_bar'+uid).hide();
					di_jq('#di_vcupbttn'+uid).attr('disabled', false);
					return false;
				}
				else if(filename=='ParsingError') {
					di_jq('#di_vcproc1'+uid).removeClass('di_gui_proc_active');
					di_jq('#di_vcproc1'+uid).addClass('di_gui_proc_deactive');

					di_jq('#di_vcproc2'+uid).removeClass('di_gui_proc_active');
					di_jq('#di_vcproc2'+uid).addClass('di_gui_proc_deactive');

					di_jq('#di_vcproc3'+uid).removeClass('di_gui_proc_deactive');
					di_jq('#di_vcproc3'+uid).addClass('di_gui_proc_active');

					alert("Parsing error!");
					di_jq('#di_vcprogress_bar'+uid).hide();
					di_jq('#di_vcupbttn'+uid).attr('disabled', false);
					return false;
				}
				else {
					di_jq('#di_vcupbttn'+uid).attr('disabled', true); // disabled upload button
					di_jq('#di_vcproc4'+uid).html('');

					if(vcType == 'map') {
						di_jq('#di_visulcontainer_chart'+uid).hide();
						di_jq('#di_visulcontainer_map'+uid).show();
						di_vcshowmap(di_vc_libpath+'library/', filename, visu_height, uid);
					}
					else if(vcType == 'chart') {
						di_jq('#di_visulcontainer_map'+uid).hide();
						di_jq('#di_visulcontainer_chart'+uid).show();
						di_readDefaultChartSetting(settingFileUrl,title, uid, visul_div_id, filename, 'j.str', x_title, y_title, subtitle,'bar',chartCategory,sourceText);
					}

					di_jq('#di_vcupbttn'+uid).attr('disabled', false); // disabled upload button
					di_jq('#di_vcprogress_bar'+uid).hide();
					di_jq('#di_vcupfile'+uid).val('');
				}*/
			}
		});
		/*********** End for upload own data************/
		if(jQuery.inArray('Data', allowTabs) > -1) {
		di_vc_changeTab('gtabm_0'+uid, 'Data', "'"+allowTabs+"'", uid, visu_height);
		}

	});
}


// function to create column chart
function di_create_bar_chart(title, uid, div_id, data, datatype, x_title, y_title, subtitle,defaultSettings,chartType,chartCategory,sourceText) 
{	
	var vc_data=new Object();	
	if(data !="")
	{
		if(datatype=="j.str")
		{
			vc_data = jQuery.parseJSON(data);
			vc_data = di_covertToProperInput(vc_data);
		}
		else
		{
			vc_data = di_covertToProperInput(data);
		}
	}
	else
	{
		vc_data.categoryCollection = [];
		vc_data.seriesCollection = [];
	}
	//di_createSeriesList(vc_data,'di_vcSelSeries'+uid);
    // Series ToolTip
    //var seriesToolTip = di_getToolTipObject();		
	//seriesToolTip.formatter = function() {return ''+this.x +': '+ this.y;};
	
	// Customize Settings
	defaultSettings = defaultSettings.replace("$renderDivId$",div_id);
	defaultSettings = defaultSettings.replace("$chartTitle$",title);
	defaultSettings = defaultSettings.replace("$chartSubTitle$",subtitle);
	defaultSettings = defaultSettings.replace("$category$",JSON.stringify(vc_data.categoryCollection));
	defaultSettings = defaultSettings.replace("$xAxisTitle$",x_title);
	defaultSettings = defaultSettings.replace("$seriesData$",JSON.stringify(vc_data.seriesCollection));
	defaultSettings = defaultSettings.replace("$yAxisTitle$",y_title);
	//defaultSettings = defaultSettings.replace("$dataToolTip$",JSON.stringify(seriesToolTip));	

	if(chartCategory=="normal")
	{
		defaultSettings = defaultSettings.replace("$plotOptionId$",JSON.stringify({bar: {pointPadding: 0.2,borderWidth: 0, shadow:false,dataLabels:{enabled:false,color:"#000000",style:{font:'normal 10px arial',color:'#000000',fontWeight:'normal',textDecoration:'none'}}}}));
	}
	else if(chartCategory == "stacking")
	{
		defaultSettings = defaultSettings.replace("$plotOptionId$",JSON.stringify({bar:{stacking:'normal',dataLabels:{enabled:false,color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'}, shadow:false,style:{font:'normal 10px arial',color:'#000000',fontWeight:'normal',textDecoration:'none'}}}));
	}
	else if(chartCategory == "percent")
	{
		defaultSettings = defaultSettings.replace("$plotOptionId$",JSON.stringify({bar:{stacking:'percent',dataLabels:{enabled:false,color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'}, shadow:false,style:{font:'normal 10px arial',color:'#000000',fontWeight:'normal',textDecoration:'none'}}}));
	}

	var chartDefSetting = jQuery.parseJSON(defaultSettings);		
	chartDefSetting.tooltip.formatter = function() {return '<b>'+this.x +': '+ this.y + "</b><br>" + di_replaceAll(this.series.name,"{@@}"," ");};
	chartDefSetting.legend.labelFormatter = function() {return di_replaceAll(this.name,"{@@}"," ");};
	var totalDataLabels = 0;
	totalDataLabels = vc_data.categoryCollection.length;
	var totalLegendItems = vc_data.seriesCollection.length;
	chartDefSetting = di_labelRotationSettings(totalDataLabels,totalLegendItems,chartDefSetting,chartType);	
	var sourceStyleObj = di_getStyle("","","","","","");
	var labelStyleObj = di_getStyle("","","","","","");
	var yPosStr = document.getElementById(div_id).style.height;
	yPosStr = parseInt(yPosStr.substr(0,yPosStr.length-2));
	var sourceFunObj = di_getTextDrawFunction(sourceText,20,yPosStr,'',50,50,sourceStyleObj,labelStyleObj);
	chartDefSetting.chart.events.load = sourceFunObj;
	chart = new Highcharts.Chart(chartDefSetting);
	chart.options.legend.layout="vertical";
	chart.options.legend.width = "";
	chart.options.tooltip.style.padding = 5;
	chart.options.yAxis.labels.formatter = function(){return this.value;}
	chart = new Highcharts.Chart(chart.options);
	var isUidExist=false;
	if(chartCollection.length>0)
	{
		for(var i=0;i<chartCollection.length;i++)
		{
			if(chartCollection[i].id==uid)
			{
				isUidExist = true;
				chartCollection[i].chartInstance = chart;				
				break;
			}
		}		
	}
	if(!isUidExist)
	{
		var item = new Object();
		item.id = uid;
		item.chartInstance = chart;
		item.source = sourceText;
		item.label = "";
		item.sourceStyle = sourceStyleObj;
		item.labelStyle = labelStyleObj;
		item.xPos = 50;
		item.yPos = 430;
		item.isYAxisSep = false;
		item.isDataLabelSep = false;
		item.YAxisSepDecimal = 0;
		item.isDataLabelSep = 0;
		item.chartBgcGS = "1";
		item.chartPBgcGS = "1";
		item.chartBorderWidth = 1;
		item.legendBorderWidth = 1;
		item.sourceXPos = 20;
		item.sourceYPos = yPosStr;
		item.isCommaSeperator = false;
		chartCollection.push(item);		
	}	

	/*di_setHideShowUI(uid);
	di_setBarDataLabelChkbox(uid);
	di_setLegendUI(uid);
	di_setChartAndPlotareaBgUI(uid);
	di_setDropdownlist('di_vcTitlesList'+uid,title);
	di_vcSelTitleVal(title,uid);
	var titleListCtrl = document.getElementById('di_vcTitlesList'+uid);
	di_setChartTitleUI(uid, titleListCtrl);
	di_setDropdownlist('di_vcSelLegend'+uid,'6');	*/
}

/* Show DataLabels
	Parameters: chartObj - chart object
	chartTyle - type (line, column and bar)*/
function di_showBarDataLabels(chartObj)
{
	var chartInput = chartObj.options;
	chartInput.plotOptions.bar.dataLabels.enabled = true;
	chartObj = new Highcharts.Chart(chartInput);
}

/* Hide DataLabels
	Parameters: chartObj - chart object*/
function di_hideBarDataLabels(chartObj)
{
	var chartInput = chartObj.options;
	chartInput.plotOptions.bar.dataLabels.enabled = false;
	chartObj = new Highcharts.Chart(chartInput);
}

/*Set datalabels checkbox
	Parameter:	chartObj - chart object*/
function di_setBarDataLabelChkbox(uid)
{
	var chartObj = di_getChartObject(uid);
	document.getElementById('di_vcpdatalbl'+uid).checked = chartObj.options.plotOptions.bar.dataLabels.enabled;
}


/*Change datalabels color
	Parameter:	chartObj - chart object
				color - font color*/
function di_changeBarDataLabelColor(uid,color)
{
	var chartObj = di_getChartObject(uid);
	var chartInput = chartObj.options;	
	//chartInput.plotOptions.column.dataLabels.color = color;
	var styleObj = di_getBarDataLabelStyle(chartObj);
	styleObj.color = color;
	di_setBarDataLabelStyle(chartObj,styleObj)	
}

/*Return Datalabel's style*/
function di_getBarDataLabelStyle(chartObj)
{
	var styleObj;	
	var chartInput = chartObj.options;
	styleObj = chartInput.plotOptions.bar.dataLabels.style;
	styleObj.color = chartInput.plotOptions.bar.dataLabels.color;
	return styleObj;
}

/*Set Datalabel's style*/
function di_setBarDataLabelStyle(chartObj,styleObj)
{
	var chartInput = chartObj.options;
	chartInput.plotOptions.bar.dataLabels.style = styleObj;
	chartInput.plotOptions.bar.dataLabels.color = styleObj.color;
	chartObj = new Highcharts.Chart(chartInput);
}


function di_changeBarDataLabelFontStyle(uid,styleStr,size)
{
	var chartObj = di_getChartObject(uid);	
	var styleObj = di_getBarDataLabelStyle(chartObj);
	if(styleStr=="underline" || styleStr=="none")
	{
		if(styleObj.textDecoration == "underline")
		{
			styleObj.textDecoration = "none";
		}
		else
		{
			styleObj.textDecoration = "underline";
		}
	}	
	else
	{
		if(styleStr == "bold")
		{
			if(styleObj.fontWeight == "bold")
			{
				styleObj.fontWeight = "normal";
			}
			else
			{
				styleObj.fontWeight = styleStr;
			}
		}
		else
		{
			if(styleObj.font.indexOf('italic')>-1)
			{
				styleStr = "normal";
			}
			styleObj.font = styleStr + " " + size + " Arial" ;
		}
	}
	di_setBarDataLabelStyle(chartObj,styleObj);
}
/* Chart Data Label rotation
		Parameter : uid - chart unique id*/
function di_changeBarDataLabelRotation(uid,angle)
{
	var chartObj = di_getChartObject(uid);	
	chartObj.options.plotOptions.bar.dataLabels.rotation = angle;
	chartObj = new Highcharts.Chart(chartObj.options);
}

/*datalabels font size
	Parameter:	chartObj - chart object*/
function di_setBarDataLabelFontSize(uid,val)
{
	var chartObj = di_getChartObject(uid);
	var chartInput = chartObj.options;	
	var fontStr = chartInput.plotOptions.bar.dataLabels.style.font;
	var fontArray = fontStr.split(' ');
	var newFontStr = "";
	newFontStr = fontArray[0]+ " " + val + " " + fontArray[2];
	chartInput.plotOptions.bar.dataLabels.style.font = newFontStr;
	chartObj = new Highcharts.Chart(chartInput);
}

/*increase/decrdatalabels font size
	Parameter:	chartObj - chart object*/
function di_toggleBarDataLabelFontSize(uid,isIncrease)
{
	var chartObj = di_getChartObject(uid);
	var chartInput = chartObj.options;	
	var fontStr = chartInput.plotOptions.bar.dataLabels.style.font;
	var fontArray = fontStr.split(' ');
	var newFontStr = "";
	var newFont = fontArray[1].substr(0,fontArray[1].length-2);
	if(isIncrease)
	{
		newFont = parseInt(newFont) + 1;
	}
	else
	{
		newFont = parseInt(newFont) - 1;
	}
	newFontStr = fontArray[0]+ " " + newFont + "px " + fontArray[2];
	chartInput.plotOptions.bar.dataLabels.style.font = newFontStr;
	chartObj = new Highcharts.Chart(chartInput);
}