var stage = new Kinetic.Stage({
	container : 'container',
	width : window.innerWidth,
	height : window.innerHeight
});

var menulayer = new Kinetic.Layer();
var arealayer = new Kinetic.Layer();

var itemOnarea = new Array();

var statusProcesstool = false;
var statusLinetool = false;
var statusDeletetool = false;

function Camera() {

	this.nextprocess = new Array();
	this.json = {
		"camera" : {
			"username" : "",
			"name" : "",
			"url" : "",
			"height" : 0,
			"width" : 0,
			"fps" : 0,
			"model" : "",
			"password" : "",
			"id" : 0
		},
		"processors" : []
	};

	this.shape = new Kinetic.Text({
		x : 10,
		y : 110,
		stroke : '#555',
		strokeWidth : 2,
		fill : '#ddd',
		text : 'Video',
		fontFamily : 'Tahoma, Geneva, sans-serif',
		fontSize : 10,
		textFill : '#555',
		width : 130,
		padding : 14,
		align : 'center',
		shadow : {
			color : 'black',
			blur : 10,
			offset : [ 5, 5 ],
			opacity : 0.2
		},
		cornerRadius : 10,
		draggable : true
	});

	// camera event
	this.shape.on('mouseover touchstart', function() {
		this.setFill('#232323');
		this.setTextFill('#fff');
		arealayer.draw();
	});
	this.shape.on('mouseout touchend', function() {
		this.setFill('#ddd');
		this.setTextFill('#555');
		arealayer.draw();
	});
	// end camera event
	arealayer.add(this.shape);
	arealayer.draw();
}

function Processor(name) {
	this.json;
	this.preprocess = null;
	switch (name) {
	case "Motion Detector":
		this.json = {
			"name" : "Motion Detector",
			"interval" : 0,
			"resolution" : 0,
			"processors" : [],
			"drop_motion" : 0
		};
		this.shape = new Kinetic.Text({
			x : 10,
			y : 50,
			stroke : '#555',
			strokeWidth : 2,
			fill : '#ddd',
			text : 'Motion Detector',
			fontFamily : 'Tahoma, Geneva, sans-serif',
			fontSize : 10,
			textFill : '#555',
			width : 130,
			padding : 14,
			align : 'center',
			shadow : {
				color : 'black',
				blur : 10,
				offset : [ 5, 5 ],
				opacity : 0.2
			},
			cornerRadius : 10,
			draggable : true
		});
		this.nextprocess = new Array();
		break;
	case "Face Detector":
		this.json = {
			"name" : "Face Detector",
			"interval" : 0,
			"processors" : []
		};
		this.shape = new Kinetic.Text({
			x : 150,
			y : 50,
			stroke : '#555',
			strokeWidth : 2,
			fill : '#ddd',
			text : 'Face Detector',
			fontFamily : 'Tahoma, Geneva, sans-serif',
			fontSize : 10,
			textFill : '#555',
			width : 130,
			padding : 14,
			align : 'center',
			shadow : {
				color : 'black',
				blur : 10,
				offset : [ 5, 5 ],
				opacity : 0.2
			},
			cornerRadius : 10,
			draggable : true
		});
		this.nextprocess = new Array();
		break;
	case "Video Recorder":
		this.json = {
			"name" : "Video Recorder",
			"width" : 0,
			"height" : 0,
			"maximum_wait_motion" : -1,
			"fps" : 0,
			"record_motion" : false
		};
		this.shape = new Kinetic.Text({
			x : 290,
			y : 50,
			stroke : '#555',
			strokeWidth : 2,
			fill : '#ddd',
			text : 'Video Recorder',
			fontFamily : 'Tahoma, Geneva, sans-serif',
			fontSize : 10,
			textFill : '#555',
			width : 130,
			padding : 14,
			align : 'center',
			shadow : {
				color : 'black',
				blur : 10,
				offset : [ 5, 5 ],
				opacity : 0.2
			},
			cornerRadius : 10,
			draggable : true
		});
		break;
	case "Image Recorder":
		this.json = {
			"name" : "Image Recorder",
			"width" : 0,
			"height" : 0
		};
		this.shape = new Kinetic.Text({
			x : 430,
			y : 50,
			stroke : '#555',
			strokeWidth : 2,
			fill : '#ddd',
			text : 'Image Recorder',
			fontFamily : 'Tahoma, Geneva, sans-serif',
			fontSize : 10,
			textFill : '#555',
			width : 130,
			padding : 14,
			align : 'center',
			shadow : {
				color : 'black',
				blur : 10,
				offset : [ 5, 5 ],
				opacity : 0.2
			},
			cornerRadius : 10,
			draggable : true
		});
		break;
	}
	var tmp = this.shape;
	this.shape.on('click', function() {
        if(statusDeletetool){
        	tmp.remove();
        	arealayer.draw();
		}
	});
	
	arealayer.add(this.shape);
	arealayer.draw();
}

function Menu() {

	var processSelector = new Array();

	// start menu item

	this.background = new Kinetic.Rect({
		x : 0,
		y : 0,
		width : window.innerWidth,
		height : 40,
		fill : '#232323'
	});
	menulayer.add(this.background);

	var selectBackground = new Kinetic.Rect({
		x : 0,
		y : 40,
		width : window.innerWidth,
		height : 0,
		fill : '#555'
	});
	menulayer.add(selectBackground);

	// strat selector processor menu
	this.processtools = new Kinetic.Text({
		x : 0,
		y : 14,
		text : 'Processors',
		width : 130,
		height : 40,
		align : 'center',
		fontFamily : 'Tahoma, Geneva, sans-serif',
		textFill : '#A0A0A0',
	});
	menulayer.add(this.processtools);

	this.proMotionDetector = new Kinetic.Text({
		x : 10,
		y : 50,
		stroke : '#555',
		strokeWidth : 2,
		fill : '#ddd',
		text : 'Motion Detector',
		fontFamily : 'Tahoma, Geneva, sans-serif',
		fontSize : 10,
		textFill : '#555',
		width : 130,
		padding : 14,
		align : 'center',
		shadow : {
			color : 'black',
			blur : 10,
			offset : [ 5, 5 ],
			opacity : 0.2
		},
		cornerRadius : 10,
		visible : false
	});
	menulayer.add(this.proMotionDetector);
	processSelector.push(this.proMotionDetector);

	this.proFaceDetector = new Kinetic.Text({
		x : 150,
		y : 50,
		stroke : '#555',
		strokeWidth : 2,
		fill : '#ddd',
		text : 'Face Detector',
		fontFamily : 'Tahoma, Geneva, sans-serif',
		fontSize : 10,
		textFill : '#555',
		width : 130,
		padding : 14,
		align : 'center',
		shadow : {
			color : 'black',
			blur : 10,
			offset : [ 5, 5 ],
			opacity : 0.2
		},
		cornerRadius : 10,
		visible : false
	});
	menulayer.add(this.proFaceDetector);
	processSelector.push(this.proFaceDetector);

	this.proVideoRecorder = new Kinetic.Text({
		x : 290,
		y : 50,
		stroke : '#555',
		strokeWidth : 2,
		fill : '#ddd',
		text : 'Video Recorder',
		fontFamily : 'Tahoma, Geneva, sans-serif',
		fontSize : 10,
		textFill : '#555',
		width : 130,
		padding : 14,
		align : 'center',
		shadow : {
			color : 'black',
			blur : 10,
			offset : [ 5, 5 ],
			opacity : 0.2
		},
		cornerRadius : 10,
		visible : false
	});
	menulayer.add(this.proVideoRecorder);
	processSelector.push(this.proVideoRecorder);

	this.proImageRecorder = new Kinetic.Text({
		x : 430,
		y : 50,
		stroke : '#555',
		strokeWidth : 2,
		fill : '#ddd',
		text : 'Image Recorder',
		fontFamily : 'Tahoma, Geneva, sans-serif',
		fontSize : 10,
		textFill : '#555',
		width : 130,
		padding : 14,
		align : 'center',
		shadow : {
			color : 'black',
			blur : 10,
			offset : [ 5, 5 ],
			opacity : 0.2
		},
		cornerRadius : 10,
		visible : false
	});
	menulayer.add(this.proImageRecorder);
	processSelector.push(this.proImageRecorder);

	this.linetools = new Kinetic.Text({
		x : 130,
		y : 14,
		text : 'Line',
		width : 130,
		height : 40,
		align : 'center',
		fontFamily : 'Tahoma, Geneva, sans-serif',
		textFill : '#A0A0A0',
	});
	menulayer.add(this.linetools);

	this.deletetools = new Kinetic.Text({
		x : 260,
		y : 14,
		text : 'Delete',
		width : 130,
		height : 40,
		align : 'center',
		fontFamily : 'Tahoma, Geneva, sans-serif',
		textFill : '#A0A0A0',
	});
	menulayer.add(this.deletetools);

	// end menu item

	// start menu event

	this.processtools.on('mouseover touchstart', function() {
		this.setTextFill('#ffffff');
		menulayer.draw();
	});
	this.processtools.on('mouseout touchend', function() {
		this.setTextFill('#A0A0A0');
		menulayer.draw();
	});

	this.processtools.on('click', function() {
		if (statusProcesstool) {
			for (i in processSelector) {
				processSelector[i].hide();
			}
			menulayer.draw();
			selectBackground.transitionTo({
				height : 0,
				duration : 0.3,
				easing : 'ease-in-out',
			});
			statusProcesstool = false;
		} else {
			selectBackground.transitionTo({
				height : 60,
				duration : 0.3,
				easing : 'ease-in-out',
				callback : function() {
					for (i in processSelector) {
						processSelector[i].show();
					}
					menulayer.draw();
				}
			});
			statusProcesstool = true;
		}
	});

	this.proMotionDetector.on('mouseover touchstart', function() {
		this.setFill('#232323');
		this.setTextFill('#fff');
		menulayer.draw();
	});
	this.proMotionDetector.on('mouseout touchend', function() {
		this.setFill('#ddd');
		this.setTextFill('#555');
		menulayer.draw();
	});
	this.proMotionDetector.on('click', function() {
		for (i in processSelector) {
			processSelector[i].hide();
		}
		statusProcesstool = false;
		selectBackground.setHeight(0);
		menulayer.draw();
		itemOnarea.push(new Processor("Motion Detector"));
	});

	this.proFaceDetector.on('mouseover touchstart', function() {
		this.setFill('#232323');
		this.setTextFill('#fff');
		menulayer.draw();
	});
	this.proFaceDetector.on('mouseout touchend', function() {
		this.setFill('#ddd');
		this.setTextFill('#555');
		menulayer.draw();
	});
	this.proFaceDetector.on('click', function() {
		for (i in processSelector) {
			processSelector[i].hide();
		}
		statusProcesstool = false;
		selectBackground.setHeight(0);
		menulayer.draw();
		itemOnarea.push(new Processor('Face Detector'));
	});

	this.proVideoRecorder.on('mouseover touchstart', function() {
		this.setFill('#232323');
		this.setTextFill('#fff');
		menulayer.draw();
	});
	this.proVideoRecorder.on('mouseout touchend', function() {
		this.setFill('#ddd');
		this.setTextFill('#555');
		menulayer.draw();
	});
	this.proVideoRecorder.on('click', function() {
		for (i in processSelector) {
			processSelector[i].hide();
		}
		statusProcesstool = false;
		selectBackground.setHeight(0);
		menulayer.draw();
		itemOnarea.push(new Processor('Video Recorder'));
	});

	this.proImageRecorder.on('mouseover touchstart', function() {
		this.setFill('#232323');
		this.setTextFill('#fff');
		menulayer.draw();
	});
	this.proImageRecorder.on('mouseout touchend', function() {
		this.setFill('#ddd');
		this.setTextFill('#555');
		menulayer.draw();
	});
	this.proImageRecorder.on('click', function() {
		for (i in processSelector) {
			processSelector[i].hide();
		}
		statusProcesstool = false;
		selectBackground.setHeight(0);
		menulayer.draw();
		itemOnarea.push(new Processor('Image Recorder'));
	});

	this.linetools.on('mouseover touchstart', function() {
		this.setTextFill('#ffffff');
		menulayer.draw();
	});
	this.linetools.on('mouseout touchend', function() {
		this.setTextFill('#A0A0A0');
		menulayer.draw();
	});

	this.deletetools.on('mouseover touchstart', function() {
		if(!statusDeletetool){
		this.setTextFill('#ffffff');
		menulayer.draw();
		}
	});
	this.deletetools.on('mouseout touchend', function() {
		if(!statusDeletetool){
		this.setTextFill('#A0A0A0');
		menulayer.draw();
		}
	});
	this.deletetools.on('click', function() {
		if (statusDeletetool) {
			statusDeletetool = false;
		} else {
			this.setTextFill('#ffffff');
			menulayer.draw();
			statusDeletetool = true;
		}
	});
	// end of event

	stage.add(menulayer);
}

function Editor() {
	this.background = new Kinetic.Rect({
		x : 0,
		y : 40,
		width : window.innerWidth,
		height : window.innerHeight,
		fill : '#ffffff'
	});
	arealayer.add(this.background);
	stage.add(arealayer);
	this.menu = new Menu();
	this.camera = new Camera();
}

var tmp = new Editor();