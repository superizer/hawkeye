var canvas = document.getElementById("generator-box");
var ctx = canvas.getContext("2d");
ctx.canvas.width = window.innerWidth;
ctx.canvas.height = window.innerHeight;

var tmpX;
var tmpY;
var dragenable = false;
var lineenable = false;

function Camera(x, y) {
	this.name = "Video";
	this.x = x;
	this.y = y;
	this.height = 30;
	this.width = 100;
    this.nextprocess = new Array();
	this.json = {
		"camera" : {
			"username" : "",
			"name" : this.name, // set name = video
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
	

	this.draw = function() {
		ctx.beginPath();
		ctx.rect(this.x, this.y, this.width, this.height);
		ctx.closePath();
		ctx.fill();
		ctx.fillStyle = "#A0A0A0";
		ctx.font = "14px Tahoma, Geneva, sans-serif";
		ctx.textAlign = "center";
		ctx.textBaseline = "middle";
		ctx.fillText(this.name, this.x + this.width / 2, this.y + this.height / 2);
	}
}

function Processor(name, x, y) {
	
	this.name = name;
	this.height = 30;
	this.width = 120;
	this.x = x;
	this.y = y;
	this.json;
	this.preprocess = new Array();
	switch (name) {
		case "Motion Detector":
			this.json = {
				"name" : "Motion Detector",
				"interval" : 0,
				"resolution" : 0,
				"processors" : [],
				"drop_motion" : 0
			};
			this.nextprocess = new Array();
			break;
		case "Face Detector":
			this.json = {
				"name" : "Face Detector",
				"interval" : 0,
				"processors" : []
			};
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
			break;
		case "Image Recorder":
			this.json = {
				"name" : "Image Recorder",
				"width" : 0,
				"height" : 0
			};
			break;
	}
	
	this.draw = function() {
		ctx.beginPath();
		ctx.rect(x, y, this.width, this.height);
		ctx.closePath();
		ctx.fillStyle = "#232323";
		ctx.fill();
		ctx.fillStyle = "#ffffff";
		ctx.font = "14px Tahoma, Geneva, sans-serif";
		ctx.textAlign = "center";
		ctx.textBaseline = "middle";
		ctx.fillText(this.name, this.x + this.width / 2, this.y + this.height / 2);
	}

}

function Tool(name, x, y) {
	this.height = 40;
	this.width = 100;
	this.name = name;
	this.x = x;
	this.y = y;
	this.onover = false;

	if(name == "Processors"){
		this.processors = new Array();
		var processorNames = [ "Motion Detector", "Face Detector",
				"Video Recorder", "Image Recorder" ];
		for (i in processorNames) {
			this.processors.push(new Processor(processorNames[i],
					10 + (110 * i), 50));
		}
	}

	this.draw = function() {
		ctx.beginPath();
		ctx.rect(x, y, this.width, this.height);
		ctx.closePath();
		ctx.fillStyle = "#232323";
		ctx.fill();
		if (this.onover) {
			ctx.fillStyle = "#ffffff";
		} else {
			ctx.fillStyle = "#A0A0A0";
		}
		ctx.font = "14px Tahoma, Geneva, sans-serif";
		ctx.textAlign = "center";
		ctx.textBaseline = "middle";
		ctx.fillText(this.name, this.x + this.width / 2, this.y + this.height / 2);
	}
	
	this.active = function(){
		
		ctx.beginPath();
		ctx.rect(0, 40, canvas.width, this.height);
		ctx.closePath();
		ctx.fillStyle = "#ffffff";
		ctx.fill();
		
		for(tmp in this.processors){
			tmp.draw();
		}
		
	}

}

function Menus() {
	this.height = 40;
	this.width = canvas.width;

	this.tools = new Array();
	var toolsName = [ "Processors", "Line", "Delete" ];
	for (i in toolsName) {
		this.tools.push(new Tool(toolsName[i], (100 * i), 0));
	}

	this.draw = function() {

		// background
		ctx.beginPath();
		ctx.rect(0, 0, this.width, this.height);
		ctx.closePath();
		ctx.fillStyle = "#232323";
		ctx.fill();

		// tools
		for (i in this.tools) {
			this.tools[i].draw();
		}
	}
}
/*
 * Camera.prototype.draw = function() {
 * 
 * var boxcruve = 10;
 * 
 * ctx.beginPath(); ctx.moveTo(this.x + boxcruve, this.y); ctx.lineTo(this.x +
 * this.width - boxcruve, this.y); ctx.quadraticCurveTo(this.x + this.width,
 * this.y, this.x + this.width, this.y + boxcruve); ctx.lineTo(this.x +
 * this.width, this.y + this.hight - boxcruve); ctx.quadraticCurveTo(this.x +
 * this.width, this.y + this.hight, this.x + this.width - boxcruve, this.y +
 * this.hight); ctx.lineTo(this.x + boxcruve, this.y + this.hight);
 * ctx.quadraticCurveTo(this.x, this.y + this.hight, this.x, this.y + this.hight -
 * boxcruve); ctx.lineTo(this.x, this.y + boxcruve);
 * ctx.quadraticCurveTo(this.x, this.y, this.x + boxcruve, this.y);
 * ctx.closePath(); ctx.fillStyle = "#FFFFFF"; ctx.fill(); ctx.strokeStyle =
 * "#D8D8D8"; ctx.stroke(); ctx.fillStyle = "#000000"; ctx.font = "10pt
 * Calibri"; ctx.textAlign = "center"; ctx.textBaseline = "middle";
 * ctx.fillText(this.name, this.x + this.width / 2, this.y + this.hight / 2); }
 */

function Workspace() {
	this.width = canvas.width;
	this.height = canvas.height;
	
	this.menu = new Menus();
	this.processors = new Array();
	this.camera = new Camera(10, 100);
	
    this.drawSpace = function(){
		// background
		ctx.beginPath();
		ctx.rect(40, 0, this.width, this.height);
		ctx.closePath();
		ctx.fillStyle = "#ffffff";
		ctx.fill();
    }
    
    this.drawProcessors = function(tmp){
    	for(i in tmp){
    		tmp[i].draw();
    		if(tmp[i].json.processors != undefined){
    			this.drawProcessors(tmp[i].json.processors);
    		}
    	}
    }
    
    this.drawCamera = function(){
    	this.camera.draw();
    	this.drawProcessors(this.camera.json.processors);
    }
    
    this.clear = function(){
    	ctx.clearRect(40, 0, this.width, this.hight);
    }
    
    this.travelprocessor = function(tmp,x,y){
     	for(i in tmp.json.processors){
    		if ((x >= tmp.json.processors[i].x && x <= (tmp.json.processors[i].x + tmp.json.processors.width))
    				&& (y >= tmp.json.processors[i].y && y <= (tmp.json.processors[i].y + tmp.json.processors[i].height))){
    			return true;
    		}
    		if(tmp.json.processors[i].json.processors != undefined){
    			return 
    		}
    	}
    }
    
    this.travelcamera = function(x,y){
    	for(i in this.camera.json.processors){
    		if ((x >= this.camera.json.processors[i].x && x <= (this.camera.json.processors[i].x + this.camera.json.processors.width))
    				&& (y >= this.camera.json.processors[i].y && y <= (this.camera.json.processors[i].y + this.camera.json.processors[i].height))){
    			return true;
    		}
    		if(this.camera.json.processors.json.processors != undefined){
    			return 
    		}
    	}
    }
}


Workspace.prototype.travelchildren = function(tmpprocessor) {

	if ((tmpX >= tmpprocessor.x && tmpX <= (tmpprocessor.x + tmpprocessor.width))
			&& (tmpY >= tmpprocessor.y && tmpY <= (tmpprocessor.y + tmpprocessor.hight))) {
		return tmpprocessor;
	}
}

Workspace.prototype.traveltree = function() {

	var tmpprocessor;
	for (i in this.processor) {
		tmpprocessor = this.travelchildren(this.processor[i]);
		if (tmpprocessor != undefined) {
			return tmpprocessor;
		}
	}
	return undefined;

}

Workspace.prototype.drawChild = function(tmpprocessor) {
	tmpprocessor.draw();

}

Workspace.prototype.draw = function() {
	this.clear();
	menuTools.genProcessor(processorName);
	menuTools.draw();
	for (i in this.processor) {
		this.drawChild(this.processor[i]);
	}
}

Workspace.prototype.line = function() {
	this.draw();
	ctx.beginPath();
	ctx.moveTo(this.path.x + (this.path.width / 2), this.path.y
			+ (this.path.hight));
	ctx.lineTo(tmpX, tmpY);
	ctx.closePath();
	ctx.strokeStyle = "#000000";
	ctx.stroke();
}

Workspace.prototype.delchild = function(tmpprocessor, tmpchild) {
	for (i in tmpchild) {
		if (tmpprocessor == tmpchild[i]) {
			for (j in tmpchild[i].json.processors) {
				this.processor.push(tmpchild[i].json.processors[j]);
			}
		}
	}

}

Workspace.prototype.del = function(tmpprocessor) {
	for ( var i = 0; i < this.processor.length; ++i) {
		if (tmpprocessor == this.processor[i]) {
			for (i in this.processor[i].json.processors) {
				this.processor.push(this.processor[i].json.processors[i]);
			}
			this.processor.splice(i, 1);
			return true;
		} else {
			this.delchild(tmpprocessor, this.processor[i]);
		}
	}
}

function myMove(e) {
	if (dragenable) {
		space.drag.x = (e.pageX - canvas.offsetLeft) - (space.drag.width / 2);
		space.drag.y = (e.pageY - canvas.offsetTop) - (space.drag.hight / 2);
		space.draw();
	}

	if (lineenable) {
		tmpX = e.pageX - canvas.offsetLeft;
		tmpY = e.pageY - canvas.offsetTop;
		space.line();
	}
}

function myDown(e) {

	tmpX = e.pageX - canvas.offsetLeft;
	tmpY = e.pageY - canvas.offsetTop;

	var changemode = new Modes();

	for ( var i = 0; i < menuTools.modes.length; i++) {
		if ((tmpX >= menuTools.modes[i].x && tmpX <= (menuTools.modes[i].x + menuTools.modes[i].width))
				&& (tmpY >= menuTools.modes[i].y && tmpY <= (menuTools.modes[i].y + menuTools.modes[i].hight))) {

			for (j in menuTools.modes) {
				if (j != i) {
					menuTools.modes[j].enable = false;
				}
			}

			if (!menuTools.modes[i].enable) {
				menuTools.modes[i].enable = true;
			} else {
				menuTools.modes[i].enable = false;
			}
			space.draw();
		}
	}

	for (j in menuTools.modes) {
		if (menuTools.modes[j].enable) {
			changemode = menuTools.modes[j];
		}
	}

	// check mouse point on menus & when finded add it in space
	for ( var i = 0; i < menuTools.processor.length; i++) {
		if ((tmpX >= menuTools.processor[i].x && tmpX <= (menuTools.processor[i].x + menuTools.processor[i].width))
				&& (tmpY >= menuTools.processor[i].y && tmpY <= (menuTools.processor[i].y + menuTools.processor[i].hight))) {
			if (!changemode.enable) {

				space.add(menuTools.processor[i]);
				// alert(space.processor[1].json.name);
			}
		}
	}

	if (!changemode.enable) {

		space.drag = space.traveltree();
		if (space.drag != undefined) {
			space.drag.x = (e.pageX - canvas.offsetLeft)
					- (space.drag.width / 2);
			space.drag.y = (e.pageY - canvas.offsetTop)
					- (space.drag.hight / 2);
			space.draw();
			dragenable = true;
		}

	} else {

		space.path = space.traveltree();

		if (space.path != undefined) {
			switch (changemode.name) {
			case "Line":
				switch (space.path.name) {
				case "Motion Detector":
					lineenable = true;
					break;
				case "Face Detector":
					lineenable = true;
					break;
				}
				break;
			case "Delete":

				break;
			}
		}
	}

	canvas.onmousemove = myMove;

}

function myUp() {

	if (lineenable) {
		var tmpchild = space.traveltree();
		if (tmpchild != undefined) {
			space.path.push(tmpchild);

		}
	}

	dragenable = false;
	lineenable = false;
	canvas.onmousemove = null;
}
var processors = new Array();
var processorNames = [ "Motion Detector", "Face Detector",
		"Video Recorder", "Image Recorder" ];
for (i in processorNames) {
	processors.push(new Processor(processorNames[i],
			30 + (120 * i), 50));
}
for(i in processors){
	processors[i].draw();
}
canvas.onmousedown = myDown;
canvas.onmouseup = myUp;

window.onresize = function() {
	ctx.canvas.width  = window.innerWidth;
	ctx.canvas.height = window.innerHeight;
};
