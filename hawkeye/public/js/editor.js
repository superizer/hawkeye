var stage = new Kinetic.Stage({
	container : 'container',
	width : window.innerWidth ,
	height : window.innerHeight
});

var eDition = true;
var stageLayer = new Kinetic.Layer();
var stageBackground = new Kinetic.Rect({
	x : 0,
	y : 40,
	width : window.innerWidth ,
	height : window.innerHeight - 40,
	fill : '#ffffff'
});
stageLayer.add(stageBackground);
stage.add(stageLayer);

var sTatus = undefined;
var menu = new Menu();
var camera = new Camera();
var nodes = new Array();

if (oldoption != undefined) {
	function generate(tmpjson, tmpnode) {
		   if(tmpjson.processors != undefined){
				for (i in tmpjson.processors) {
					switch (tmpjson.processors[i].name) {
					case "Motion Detector":
						var tmp = new Processor("Motion Detector");
						nodes.push(tmp);
						tmpnode.next.push(tmp);
						tmp.pre.push(tmpnode);
						tmpnode.addLine(tmp);
						generate(tmpjson.processors[i], tmp);
						tmp.json = JSON.parse(JSON.stringify(tmpjson.processors[i]));
						break;
					case "Face Detector":
						var tmp = new Processor("Face Detector");
						nodes.push(tmp);
						tmpnode.next.push(tmp);
						tmp.pre.push(tmpnode);
						tmpnode.addLine(tmp);
						generate(tmpjson.processors[i], tmp);
						tmp.json = JSON.parse(JSON.stringify(tmpjson));
						break;
					case "Video Recorder":
						var tmp = new Processor("Video Recorder");
						nodes.push(tmp);
						tmpnode.next.push(tmp);
						tmp.pre.push(tmpnode);
						tmpnode.addLine(tmp);
						tmp.json = JSON.parse(JSON.stringify(tmpjson.processors[i]));
						break;
					case "Image Recorder":
						var tmp = new Processor("Image Recorder");
						nodes.push(tmp);
						tmpnode.next.push(tmp);
						tmp.pre.push(tmpnode);
						tmpnode.addLine(tmp);
						tmp.json = JSON.parse(JSON.stringify(tmpjson.processors[i]));
						break;
					case "Multimedia Recorder":
						var tmp = new Processor("Multimedia Recorder");
						nodes.push(tmp);
						tmpnode.next.push(tmp);
						tmp.pre.push(tmpnode);
						tmpnode.addLine(tmp);
						tmp.json = JSON.parse(JSON.stringify(tmpjson.processors[i]));
						break;
					}
				}
		   }
	}
	
	function generatepoint (nodes,level,offsetStart){
		var offsetEnd = offsetStart;
		for(i in nodes.next){
			offsetEnd = generatepoint(nodes.next[i],level+1,offsetEnd);
		}
		var offset;
		if(nodes.next != undefined){
			offset = offsetEnd;
			offsetEnd += 140;
		}else{
			offset = offsetStart + (offsetEnd - offsetStart - 140)/2;
		}
		nodes.shape.setX(offset);
		nodes.shape.setY(110 + level * 100);
		nodes.layer.draw();
		nodes.updateline();
		return offsetEnd;
	}
	
//	camera.shape.setX(window.innerWidth / 2 - camera.shape.getWidth() / 2);
//	camera.layer.draw();
	//oldoption.camera.processors = JSON.parse(oldoption.camera.processors);
	
	camera.json = JSON.parse(JSON.stringify(oldoption));
	camera.json.camera.processors.splice(0,camera.json.camera.processors.length);
	generate(oldoption.camera, camera);
	generatepoint(camera, 0, 100);
}else{
	eDition = false;
	camera.json.camera.project.id = projectid;
	camera.json.camera.user.id = userid;
	camera.json.camera.fps = parseInt($('#fps').val());
	camera.json.camera.model.name = $('#model').val();
	camera.json.camera.model.manufactory.name= $('#menufactory').val();
	camera.json.camera.image_size = $('#imagesize').val();
}

var tmpLine = undefined;
var tmpLayer = undefined;
var moving = false;

var rootNode = undefined;

stage.on('mousedown', function() {
	if (sTatus == "LINE") {
		if (moving) {
			moving = false;
		} else {
			var mousePos = stage.getMousePosition();
			var line = new Kinetic.Line({
				points : [ mousePos.x, mousePos.y, mousePos.x, mousePos.y ],
				stroke : "red",
				strokeWidth : 3
			});
			tmpLine = line;
			var layer = new Kinetic.Layer();
			tmpLayer = layer;
			tmpLayer.add(line);
			stage.add(tmpLayer);
			moving = true;
			tmpLayer.drawScene();
		}
	}
});

stage.on("mousemove", function() {
	if (sTatus == "LINE") {
		if (moving) {
			var mousePos = stage.getMousePosition();
			tmpLine.getPoints()[1].x = mousePos.x;
			tmpLine.getPoints()[1].y = mousePos.y;
			moving = true;
			tmpLayer.drawScene();
		}
	}
});

stage.on("mouseup", function() {
	if (sTatus == "LINE") {
		tmpLine.remove();
		tmpLayer.remove();
		moving = false;
		tmpLine = undefined;
		tmpLayer = undefined;
	}
});

window.onresize = function() {
	stage.setWidth(window.innerWidth );
	stage.setHeight(window.innerHeight );
	stageBackground.setWidth(window.innerWidth );
	stageBackground.setHeight(window.innerHeight -40);
	menu.proBackground.setWidth(window.innerWidth );
	menu.menuBackground.setWidth(window.innerWidth );
	menu.save.setX(window.innerWidth -260);
	menu.cancel.setX(window.innerWidth -130);
	stageLayer.draw();
	menu.layer.draw();
};

function Camera() {
	// --- start camera arr ---
	this.next = new Array();
	this.nextline = new Array();
	this.json = {
		'camera' : {
			'username': '',
			'status': '',
			'create_date': '',
			'name': '',
			'storage_periods': 0,
			'video_url': '',
			'fps': 0,
			'image_size': '',
			'model': {'name': '', 
				      'manufactory': {'name': '', 
				    	              'id': 0
				    	              },
				      'id': 0},
			"password": '',
			'project' : {'id': 0}, 
			'user':{'id': 0},
			"id": 0,
			"host":'',
			"port":80,
			"processors" : []
		    }
		};
	this.shape = new Kinetic.Text({
		x : 10,
		y : 110,
		stroke : '#555',
		strokeWidth : 2,
		fill : '#ddd',
		text : 'Camera',
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
		draggable : true,
	});

	// --- end camera arr ---

	// --- shape ---
	this.layer = new Kinetic.Layer();
	this.layer.add(this.shape);
	stage.add(this.layer);

	var tmpthis = this;
	// --- start shape event ---
	tmpthis.shape.on('mouseover touchstart', function() {
		this.setFill('#232323');
		this.setTextFill('#fff');
		tmpthis.layer.draw();
	});
	tmpthis.shape.on('mouseout touchend', function() {
		this.setFill('#ddd');
		this.setTextFill('#555');
		tmpthis.layer.draw();
	});
	tmpthis.shape.on('mousedown', function() {
		if (sTatus == "LINE") {
			if (rootNode == undefined) {
				rootNode = tmpthis;
			}
		}
	});
	tmpthis.shape.on('mouseup', function() {
		if (sTatus == "LINE") {
			rootNode = undefined;
		}
	});
	tmpthis.shape.on('dragmove', function() {
		tmpthis.updateline();
	});
	tmpthis.shape.on('dblclick',function() {

						if (sTatus == undefined) {
							var name = $("#name"), url = $("#url"),manufactory=$("#menufactory"),recordstore=$("#recordstore"),imagesize = $("#imagesize"), fps = $("#fps"), model = $("#model"), username = $("#username"), password = $("#password"),
							host = $("#host"),port = $("#port"),
							allFields = $([]).add(name).add(url).add(fps).add(manufactory).add(recordstore).add(imagesize).add(model).add(username).add(password).add(host).add(port);
							    name.val(tmpthis.json.camera.name);
								url.val(tmpthis.json.camera.video_url);
								host.val(tmpthis.json.camera.host);
								port.val(tmpthis.json.camera.port);
								manufactory.val(tmpthis.json.camera.model.manufactory.name);
								recordstore.val(tmpthis.json.camera.storage_periods);
								imagesize.val(tmpthis.json.camera.image_size);
								fps.val(tmpthis.json.camera.fps);
								model.val(tmpthis.json.camera.model.name);
								username.val(tmpthis.json.camera.username);
								password.val(tmpthis.json.camera.password);
							$("#camera-form")
									.dialog(
											{
												autoOpen : false,
												height : 300,
												width : 400,
												modal : true,
												buttons : {
													"Save" : function() {
														allFields.removeClass("ui-state-error");

														tmpthis.json.camera.name = name.val();
														tmpthis.json.camera.video_url = url.val();
														tmpthis.json.camera.fps = parseInt(fps.val());
														tmpthis.json.camera.model.name = model.val();
														tmpthis.json.camera.model.manufactory.name= manufactory.val();
														tmpthis.json.camera.storage_periods = parseInt(recordstore.val());
														tmpthis.json.camera.image_size = imagesize.val();
															for(i in nodes){
																if(imagesize.val() == "320x240"){
																	if(nodes[i].json.name == "Video Recorder"){
																		nodes[i].json.width = 320;
																		nodes[i].json.height = 240;
																	}else if(nodes[i].json.name == "Image Recorder"){
																		nodes[i].json.width = 320;
																		nodes[i].json.height = 240;
																	}else if(nodes[i].json.name == "Multimedia Recorder"){
																		nodes[i].json.width = 320;
																		nodes[i].json.height = 240;
																	}
																}else{
																	if(nodes[i].json.name == "Video Recorder"){
																		nodes[i].json.width = 640;
																		nodes[i].json.height = 480;
																	}else if(nodes[i].json.name == "Image Recorder"){
																		nodes[i].json.width = 640;
																		nodes[i].json.height = 480;
																	}else if(nodes[i].json.name == "Multimedia Recorder"){
																		nodes[i].json.width = 640;
																		nodes[i].json.height = 480;
																	}
																}
															}
															function genWH(tmp){
																if(tmp.processors != undefined){
																for(i in tmp.processors){
																	if(imagesize.val() == "320x240"){
																		if(tmp.processors[i].json.name == "Video Recorder"){
																			tmp.processors[i].json.width = 320;
																			tmp.processors[i].json.height = 240;
																		}else if(tmp.processors[i].json.name == "Image Recorder"){
																			tmp.processors[i].json.width = 320;
																			tmp.processors[i].json.height = 240;
																		}else if(tmp.processors[i].json.name == "Multimedia Recorder"){
																			tmp.processors[i].json.width = 320;
																			tmp.processors[i].json.height = 240;
																		}
																	}else{
																		if(tmp.processors[i].json.name == "Video Recorder"){
																			tmp.processors[i].json.width = 640;
																			tmp.processors[i].json.height = 480;
																		}else if(tmp.processors[i].json.name == "Image Recorder"){
																			tmp.processors[i].json.width = 640;
																			tmp.processors[i].json.height = 480;
																		}else if(tmp.processors[i].json.name == "Multimedia Recorder"){
																			tmp.processors[i].json.width = 640;
																			tmp.processors[i].json.height = 480;
																		}
																	}
																	genWH(tmp.processors[i]);
																}
																}
															}
															genWH(tmpthis.json.camera);
														tmpthis.json.camera.username = username.val();
														tmpthis.json.camera.password = password.val();
														tmpthis.json.camera.host = host.val();
														tmpthis.json.camera.port = parseInt(port.val());
														$(this).dialog("close");

													},
													Cancel : function() {
														$(this).dialog("close");
													}
												},
												close : function() {
													allFields
															.val("")
															.removeClass(
																	"ui-state-error");
												}
											});
							$("#camera-form").dialog("open");
						}
					});
	this.addLine = function(tmpNext) {
		var connect = new Kinetic.Line({
			points : [ tmpthis.shape.getX() + tmpthis.shape.getWidth() / 2,
					tmpthis.shape.getY() + tmpthis.shape.getHeight(),
					tmpNext.shape.getX() + tmpNext.shape.getWidth() / 2,
					tmpNext.shape.getY() ],
			stroke : "red",
			strokeWidth : 3
		});
		connect.on('mouseover touchstart', function() {
			this.setStroke('#555');
			tmpthis.layer.draw();
		});
		connect.on('mouseout touchend', function() {
			this.setStroke('red');
			tmpthis.layer.draw();
		});
		connect.on('mousedown', function() {
			if (sTatus == "DEL") {
				tmpNext.pre.splice(tmpNext.pre.indexOf(tmpthis), 1);
				tmpNext.preline.splice(tmpNext.preline.indexOf(connect), 1);
				tmpthis.next.splice(tmpthis.next.indexOf(tmpNext), 1);
				tmpthis.nextline.splice(tmpthis.nextline.indexOf(connect), 1);
				connect.remove();
				tmpthis.layer.draw();
			}
		});
		tmpthis.layer.add(connect);
		tmpthis.nextline.push(connect);
		tmpNext.preline.push(connect);
		tmpthis.layer.draw();
	};
	tmpthis.genjson = function() {
		function regen(tmp){
			if (tmp.json.processors != undefined) {
				tmp.json.processors.splice(0, tmp.json.processors.length);
			}
			if (tmp.next != undefined) {
				for (i in tmp.next) {
					tmp.json.processors.push(tmp.next[i].json);
					regen(tmp.next[i]);
				}
			}
		}
		tmpthis.json.camera.processors.splice(0, tmpthis.json.camera.processors.length);
		for (i in tmpthis.next) {
			tmpthis.json.camera.processors.push(tmpthis.next[i].json);
			regen(tmpthis.next[i]);
		}
	};
	tmpthis.updateline=function(){
		if (tmpthis.nextline.length > 0) {
			for (i in tmpthis.nextline) {
				tmpthis.nextline[i].getPoints()[0].x = tmpthis.shape.getX()
						+ tmpthis.shape.getWidth() / 2;
				tmpthis.nextline[i].getPoints()[0].y = tmpthis.shape.getY()
						+ tmpthis.shape.getHeight();
				tmpthis.layer.draw();
			}
		}
	};
	// --- end shape event ---
	// --- end shape ---
}

function Processor(name) {
	// --- arr processor ---
	this.pre = new Array();
	this.preline = new Array();
	switch (name) {
	case "Motion Detector":
		this.next = new Array();
		this.nextline = new Array();
		this.json = {
			"name" : "Motion Detector",
			"interval" : 3,
			"sensitive" : 0.0,
			"processors" : [],
			"drop_motion" : 10,
			"motion_analysis_method":"",
			"region_of_interest":{"point1":{"x":0,"y":0},"point2":{"x":0,"y":0}}
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
		break;
	case "Face Detector":
		this.next = new Array();
		this.nextline = new Array();
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
		break;
	case "Video Recorder":
		this.json = {
			"name" : "Video Recorder",
			"width" : 0,
			"height" : 0,
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
			"height" : 0,
			"interval" : 1
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
	case "Multimedia Recorder":
		this.json = {
			"name" : "Multimedia Recorder",
			"width" : 0,
			"height" : 0,
			"url" : '',
			"fps" : 0,
			"record_motion" : false
		};
		this.shape = new Kinetic.Text({
			x : 570,
			y : 50,
			stroke : '#555',
			strokeWidth : 2,
			fill : '#ddd',
			text : 'Multimedia Recorder',
			fontFamily : 'Tahoma, Geneva, sans-serif',
			fontSize : 10,
			textFill : '#555',
			width : 180,
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
	// --- end arr processor ---
	// --- start Shape ---
	this.layer = new Kinetic.Layer();
	this.layer.add(this.shape);
	stage.add(this.layer);

	var tmpthis = this;

	tmpthis.shape.on('mouseover touchstart', function() {
		this.setFill('#232323');
		this.setTextFill('#fff');
		tmpthis.layer.draw();
	});
	tmpthis.shape.on('mouseout touchend', function() {
		this.setFill('#ddd');
		this.setTextFill('#555');
		tmpthis.layer.draw();
	});
	tmpthis.shape
			.on(
					'mousedown',
					function() {
						if (sTatus == "LINE") {
							if (tmpthis.next != undefined) {
								if (rootNode == undefined) {
									rootNode = tmpthis;
								}
							}
						}
						if (sTatus == "DEL") {
							for (i in tmpthis.pre) {
								tmpthis.pre[i].next.splice(tmpthis.pre[i].next
										.indexOf(tmpthis), 1);
								for (j in tmpthis.pre[i].nextline) {
									for (k in tmpthis.preline) {
										if (tmpthis.pre[i].nextline[j] == tmpthis.preline[k]) {
											tmpthis.pre[i].nextline[j].remove();
											tmpthis.pre[i].nextline
													.splice(j, 1);
											tmpthis.pre[i].layer.draw();
											break;
										}
									}
								}
							}
							if (tmpthis.next != undefined) {
								for (i in tmpthis.next) {
									tmpthis.next[i].pre.splice(
											tmpthis.next[i].pre
													.indexOf(tmpthis), 1);
									for (j in tmpthis.next[i].preline) {
										for (k in tmpthis.nextline) {
											if (tmpthis.next[i].preline[j] == tmpthis.nextline[k]) {
												tmpthis.next[i].preline.splice(
														j, 1);
												tmpthis.nextline[k].remove();
												tmpthis.layer.draw();
												break;
											}
										}
									}
								}
							}
							tmpthis.shape.remove();
							tmpthis.layer.draw();
							nodes.splice(nodes.indexOf(tmpthis), 1);
						}
					});
	tmpthis.shape.on('mouseup', function() {
		if (sTatus == "LINE") {
			if (rootNode != undefined) {
				if (rootNode != tmpthis) {
					if (rootNode.next.indexOf(tmpthis) < 0) {
						tmpthis.pre.push(rootNode);
						rootNode.next.push(tmpthis);
						rootNode.addLine(tmpthis);
					}
					rootNode = undefined;
				} else {
					rootNode = undefined;
				}
			}
		}
	});
	tmpthis.shape.on('dragmove', function() {
		tmpthis.updateline();
	});
	if (tmpthis.next != undefined) {
		this.addLine = function(tmpNext) {
			var connect = new Kinetic.Line({
				points : [ tmpthis.shape.getX() + tmpthis.shape.getWidth() / 2,
						tmpthis.shape.getY() + tmpthis.shape.getHeight(),
						tmpNext.shape.getX() + tmpNext.shape.getWidth() / 2,
						tmpNext.shape.getY() ],
				stroke : "red",
				strokeWidth : 3
			});
			connect.on('mouseover touchstart', function() {
				this.setStroke('#555');
				tmpthis.layer.draw();
			});
			connect.on('mouseout touchend', function() {
				this.setStroke('red');
				tmpthis.layer.draw();
			});
			connect
					.on('mousedown',
							function() {
								if (sTatus == "DEL") {
									tmpNext.pre.splice(tmpNext.pre
											.indexOf(tmpthis), 1);
									tmpNext.preline.splice(tmpNext.preline
											.indexOf(connect), 1);
									tmpthis.next.splice(tmpthis.next
											.indexOf(tmpNext), 1);
									tmpthis.nextline.splice(tmpthis.nextline
											.indexOf(connect), 1);
									connect.remove();
									tmpthis.layer.draw();
								}
							});
			tmpthis.layer.add(connect);
			tmpthis.nextline.push(connect);
			tmpNext.preline.push(connect);
			tmpthis.layer.draw();
		};
	}

	tmpthis.shape
			.on(
					'dblclick',
					function() {
						if (sTatus == undefined) {
							if (tmpthis.json.name == "Motion Detector") {
								var interval = $("#mminterval"), sensitive = $("#mmsensitive"), dropmotion = $("#mmdropmotion"), choprocess = $("#mmchoprocess"),
								allFields = $([]).add(interval).add(sensitive).add(dropmotion);
								choprocess.val(tmpthis.json.motion_analysis_method);
								interval.val(tmpthis.json.interval);
								sensitive.val(tmpthis.json.sensitive);
								dropmotion.val(tmpthis.json.drop_motion);
//===============================================================================================================================================================================
								$("#cregion").css('background', 'url(' + imUrl + ') no-repeat');
								var rearea = new Kinetic.Stage({
								    container : 'cregion',
									width : 640 ,
									height : 480
								});
								var reclayer = new Kinetic.Layer();
								var baclayer = new Kinetic.Layer();
								var back = new Kinetic.Rect({
							        x: 0,
							        y: 0,
							        width: 640,
							        height: 480
							      });
								
								var rect = new Kinetic.Rect({
							        x: tmpthis.json.region_of_interest.point1.x,
							        y: tmpthis.json.region_of_interest.point1.y,
							        width: tmpthis.json.region_of_interest.point2.x - tmpthis.json.region_of_interest.point1.x,
							        height: tmpthis.json.region_of_interest.point2.y - tmpthis.json.region_of_interest.point1.y,
							        stroke: 'red',
							        strokeWidth: 2
							      });
								baclayer.add(back);
								reclayer.add(rect);
								rearea.add(reclayer);
								rearea.add(baclayer);
								var mousestat = "";
								
								rearea.on('mousedown', function() {
									if(mousestat == ""){
										var mousePas = rearea.getMousePosition();
										rect.setX(mousePas.x);
										rect.setY(mousePas.y);
										mousestat = "down";
									}
								});
								
								rearea.on('mouseup', function() {
									mousestat = "";
								});
								
								rearea.on('mousemove', function() {
									if(mousestat == "down"){
										var mousePas = rearea.getMousePosition();
										rect.setWidth(Math.abs(rect.getX() - mousePas.x));
										rect.setHeight(Math.abs(rect.getY() - mousePas.y));
										reclayer.drawScene();
									}
								});
							
								
								$("#region-of-interest-form").dialog({  
									autoOpen : false,
									height : 640,
									width : 680,
									modal : true,
									buttons : {
										"Save" : function() {
											tmpthis.json.region_of_interest.point1.x = parseInt(rect.getX());
											tmpthis.json.region_of_interest.point1.y = parseInt(rect.getY());
											tmpthis.json.region_of_interest.point2.x = parseInt(rect.getX() + rect.getWidth());
											tmpthis.json.region_of_interest.point2.y = parseInt(rect.getY() + rect.getHeight());
											
											$(this).dialog("close");
										},
										Cancel : function() {
											$(this).dialog("close");
										}
									},
									close : function() {
										allFields.val("").removeClass("ui-state-error");
									}
								});
								
								$("#bregion").button({ disabled: true }).click(function() {
							        $( "#region-of-interest-form" ).dialog( "open" );
							    });
								if(eDition){
									$("#bregion").button({ disabled: false });
								}
								$("#Motion-Detector-form").dialog({
													autoOpen : false,
													height : 300,
													width : 400,
													modal : true,
													buttons : {
														"Save" : function() {
															allFields.removeClass("ui-state-error");
															tmpthis.json.interval = parseInt(interval.val());
															tmpthis.json.sensitive = parseFloat(sensitive.val());
															tmpthis.json.drop_motion = parseInt(dropmotion.val());
															tmpthis.json.motion_analysis_method = choprocess.val();
															$(this).dialog("close");
														},
														Cancel : function() {
															$(this).dialog("close");
														}
													},
													close : function() {
														allFields.val("").removeClass("ui-state-error");
													}
												});
								$("#Motion-Detector-form").dialog("open");
							} else if (tmpthis.json.name == "Face Detector") {
								var interval = $("#fdinterval"), allFields = $([]).add(interval);

								interval.val(tmpthis.json.interval);

								$("#Face-Detector-form").dialog({
													autoOpen : false,
													height : 300,
													width : 400,
													modal : true,
													buttons : {
														"Save" : function() {
															allFields.removeClass("ui-state-error");

															tmpthis.json.interval = parseInt(interval.val());
															$(this).dialog("close");
														},
														Cancel : function() {
															$(this).dialog("close");
														}
													},
													close : function() {
														allFields.val("").removeClass("ui-state-error");
													}
												});
								$("#Face-Detector-form").dialog("open");
							} else if (tmpthis.json.name == "Video Recorder") {
								var fps = $("#vrfps"), recordmotion = $("#vrrecordmotion"), 
								allFields = $([]).add(fps).add(recordmotion);
								
								fps.val(tmpthis.json.fps);
								recordmotion.val(tmpthis.json.record_motion);

								$("#Video-Recorder-form").dialog({
													autoOpen : false,
													height : 300,
													width : 400,
													modal : true,
													buttons : {
														"Save" : function() {
															allFields.removeClass("ui-state-error");

															if(camera.json.camera.image_size == "320x240"){
																tmpthis.json.width = 320;
																tmpthis.json.height = 240;
															}else{
																tmpthis.json.width = 640;
																tmpthis.json.height = 480;
															}
															
															tmpthis.json.fps = parseInt(fps.val());
															tmpthis.json.record_motion = recordmotion.val() == "true";
															$(this).dialog("close");
														},
														Cancel : function() {
															$(this).dialog("close");
														}
													},
													close : function() {
														allFields.val("").removeClass("ui-state-error");
													}
												});
								$("#Video-Recorder-form").dialog("open");
							} else if (tmpthis.json.name == "Image Recorder") {
								var interval = $("#irinterval"), 
								allFields = $([]).add(interval);
								interval.val(tmpthis.json.interval);
								$("#Image-Recorder-form").dialog({
													autoOpen : false,
													height : 300,
													width : 400,
													modal : true,
													buttons : {
														"Save" : function() {
															allFields.removeClass("ui-state-error");
															if(camera.json.camera.image_size == "320x240"){
																tmpthis.json.width = 320;
																tmpthis.json.height = 240;
															}else{
																tmpthis.json.width = 640;
																tmpthis.json.height = 480;
															}
															tmpthis.json.interval = parseInt(interval.val());
															$(this).dialog("close");
														},
														Cancel : function() {
															$(this).dialog("close");
														}
													},
													close : function() {
														allFields.val("").removeClass("ui-state-error");
													}
												});
								$("#Image-Recorder-form").dialog("open");
							} else if (tmpthis.json.name == "Multimedia Recorder") {
								var url=$("#murl"), fps = $("#mfps"), recordmotion = $("#mrecordmotion"), 
								allFields = $([]).add(url).add(fps).add(recordmotion);
								
								url.val(tmpthis.json.url);
								fps.val(tmpthis.json.fps);
								recordmotion.val(tmpthis.json.record_motion);

								$("#Mutimedia-form").dialog({
													autoOpen : false,
													height : 300,
													width : 400,
													modal : true,
													buttons : {
														"Save" : function() {
															allFields.removeClass("ui-state-error");

															if(camera.json.camera.image_size == "320x240"){
																tmpthis.json.width = 320;
																tmpthis.json.height = 240;
															}else{
																tmpthis.json.width = 640;
																tmpthis.json.height = 480;
															}
															
															tmpthis.json.fps = parseInt(fps.val());
															tmpthis.json.record_motion = recordmotion.val() == "true";
															var turl = url.val();
															if(turl != tmpthis.json.url){
																turl = turl.substr(0,turl.lastIndexOf('/'));
							            				        turl = turl.substr(0,turl.lastIndexOf('/'));
							            				        tmpthis.json.url = turl;
															}
															$(this).dialog("close");
														},
														Cancel : function() {
															$(this).dialog("close");
														}
													},
													close : function() {
														allFields.val("").removeClass("ui-state-error");
													}
												});
								$("#Mutimedia-form").dialog("open");
							}
						}
					});
	// --- end shape ---
	tmpthis.updateline=function(){
		if (tmpthis.nextline != undefined) {
			if (tmpthis.nextline.length > 0) {
				for (i in tmpthis.nextline) {
					tmpthis.nextline[i].getPoints()[0].x = tmpthis.shape.getX()
							+ tmpthis.shape.getWidth() / 2;
					tmpthis.nextline[i].getPoints()[0].y = tmpthis.shape.getY()
							+ tmpthis.shape.getHeight();
					tmpthis.layer.draw();
				}
			}
		}
		if (tmpthis.preline.length > 0) {
			for (i in tmpthis.preline) {
				tmpthis.preline[i].getPoints()[1].x = tmpthis.shape.getX()
						+ tmpthis.shape.getWidth() / 2;
				tmpthis.preline[i].getPoints()[1].y = tmpthis.shape.getY();
				tmpthis.pre[i].layer.draw();
			}
		}
	};
}

function Menu() {

	this.layer = new Kinetic.Layer();

	// --- start item ---
	// --- start pro item ---
	this.prostatus = false;
	this.dataSubInPro = new Array();
	this.proIcon = new Kinetic.Text({
		x : 0,
		y : 14,
		text : 'Processors',
		width : 130,
		height : 40,
		align : 'center',
		fontFamily : 'Tahoma, Geneva, sans-serif',
		textFill : '#A0A0A0',
	});

	// --- subitem ---
	this.proBackground = new Kinetic.Rect({
		x : 0,
		y : 40,
		width : window.innerWidth,
		height : 0,
		fill : '#555'
	});
	this.motionDetector = new Kinetic.Text({
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
	this.dataSubInPro.push(this.motionDetector);
	this.faceDetector = new Kinetic.Text({
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
	this.dataSubInPro.push(this.faceDetector);
	this.videoRecorder = new Kinetic.Text({
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
	this.dataSubInPro.push(this.videoRecorder);
	this.imageRecorder = new Kinetic.Text({
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
	this.dataSubInPro.push(this.imageRecorder);
	this.multimediaRecorder = new Kinetic.Text({
		x : 570,
		y : 50,
		stroke : '#555',
		strokeWidth : 2,
		fill : '#ddd',
		text : 'Multimedia Recorder',
		fontFamily : 'Tahoma, Geneva, sans-serif',
		fontSize : 10,
		textFill : '#555',
		width : 180,
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
	this.dataSubInPro.push(this.multimediaRecorder);
	// --- end subitem ---
	// --- end pro item ---

	// --- Line item ---
	this.linestatus = false;
	this.lineIcon = new Kinetic.Text({
		x : 130,
		y : 14,
		text : 'Line',
		width : 130,
		height : 40,
		align : 'center',
		fontFamily : 'Tahoma, Geneva, sans-serif',
		textFill : '#A0A0A0',
	});
	// --- end Line item ---
	// --- start Delete ---
	this.deletestatus = false;
	this.deleteIcon = new Kinetic.Text({
		x : 260,
		y : 14,
		text : 'Delete',
		width : 130,
		height : 40,
		align : 'center',
		fontFamily : 'Tahoma, Geneva, sans-serif',
		textFill : '#A0A0A0',
	});
	// --- end Delete ---
	// --- start save gen ---
	this.save = new Kinetic.Text({
		x : window.innerWidth - 260,
		y : 14,
		text : 'Save',
		width : 130,
		height : 40,
		align : 'center',
		fontFamily : 'Tahoma, Geneva, sans-serif',
		textFill : '#A0A0A0',
	});
	// --- end gen ---
	// --- start cancel ---
	this.cancel = new Kinetic.Text({
		x : window.innerWidth - 130,
		y : 14,
		text : 'Cancel',
		width : 130,
		height : 40,
		align : 'center',
		fontFamily : 'Tahoma, Geneva, sans-serif',
		textFill : '#A0A0A0',
	});
	// --- end cancel ---
	// --- end item ---

	// --- start method ---
	var tmp = this;
	function proReset() {
		tmp.prostatus = false;
		tmp.proIcon.setTextFill('#A0A0A0');
		for (i in tmp.dataSubInPro) {
			tmp.dataSubInPro[i].hide();
		}
		tmp.layer.draw();
		tmp.proBackground.transitionTo({
			height : 0,
			duration : 0.3,
			easing : 'ease-in-out',
		});
	}
	function lineReset() {
		tmp.linestatus = false;
		tmp.lineIcon.setTextFill('#A0A0A0');
		tmp.layer.draw();
	}
	function deleteReset() {
		tmp.deletestatus = false;
		tmp.deleteIcon.setTextFill('#A0A0A0');
		tmp.layer.draw();
	}
	// --- end method ---

	// --- start event ---
	// --- start pro event ---

	tmp.proIcon.on('mouseover touchstart', function() {
		if (!tmp.prostatus) {
			this.setTextFill('#fff');
			tmp.layer.draw();
		}
	});
	tmp.proIcon.on('mouseout touchend', function() {
		if (!tmp.prostatus) {
			this.setTextFill('#A0A0A0');
			tmp.layer.draw();
		}
	});
	for (i in tmp.dataSubInPro) {
		tmp.dataSubInPro[i].on('mouseover touchstart', function() {
			this.setFill('#232323');
			this.setTextFill('#fff');
			tmp.layer.draw();
		});
		tmp.dataSubInPro[i].on('mouseout touchend', function() {
			this.setFill('#ddd');
			this.setTextFill('#555');
			tmp.layer.draw();
		});
	}

	tmp.proIcon.on('click', function() {
		if (tmp.prostatus) {
			sTatus = undefined;
			proReset();
		} else {
			tmp.proBackground.transitionTo({
				height : 60,
				duration : 0.3,
				easing : 'ease-in-out',
				callback : function() {
					tmp.proIcon.setTextFill('#fff');
					for (i in tmp.dataSubInPro) {
						tmp.dataSubInPro[i].show();
					}
					sTatus = "SPRO";
					tmp.prostatus = true;
					tmp.layer.draw();
				}
			});
			lineReset();
			deleteReset();
		}
	});
	tmp.motionDetector.on('click', function() {
		nodes.push(new Processor('Motion Detector'));
		sTatus = undefined;
		proReset();
	});
	tmp.faceDetector.on('click', function() {
		nodes.push(new Processor('Face Detector'));
		sTatus = undefined;
		proReset();
	});
	tmp.videoRecorder.on('click', function() {
		nodes.push(new Processor('Video Recorder'));
		sTatus = undefined;
		proReset();
	});
	tmp.imageRecorder.on('click', function() {
		nodes.push(new Processor('Image Recorder'));
		sTatus = undefined;
		proReset();
	});
	tmp.multimediaRecorder.on('click', function() {
		nodes.push(new Processor('Multimedia Recorder'));
		sTatus = undefined;
		proReset();
	});

	// --- end pro event ---
	// --- start line event ---
	tmp.lineIcon.on('mouseover touchstart', function() {
		if (!tmp.linestatus) {
			this.setTextFill('#ffffff');
			tmp.layer.draw();
		}
	});
	tmp.lineIcon.on('mouseout touchend', function() {
		if (!tmp.linestatus) {
			this.setTextFill('#A0A0A0');
			tmp.layer.draw();
		}
	});
	tmp.lineIcon.on('click', function() {
		if (tmp.linestatus) {
			lineReset();
			sTatus = undefined;
		} else {
			this.setTextFill('#ffffff');
			tmp.linestatus = true;
			sTatus = "LINE";
			tmp.layer.draw();
			proReset();
			deleteReset();
		}
	});
	// --- end line event ---
	// --- start Delete event ---
	tmp.deleteIcon.on('mouseover touchstart', function() {
		if (!tmp.deletestatus) {
			this.setTextFill('#ffffff');
			tmp.layer.draw();
		}
	});
	tmp.deleteIcon.on('mouseout touchend', function() {
		if (!tmp.deletestatus) {
			this.setTextFill('#A0A0A0');
			tmp.layer.draw();
		}
	});
	tmp.deleteIcon.on('click', function() {
		if (tmp.deletestatus) {
			deleteReset();
			sTatus = undefined;
		} else {
			this.setTextFill('#ffffff');
			tmp.deletestatus = true;
			sTatus = "DEL";
			tmp.layer.draw();
			lineReset();
			proReset();
		}
	});
	// --- end Delete event ---
	// --- start save event ---
	// ***************************************************************************************************
	tmp.save.on('mouseover touchstart', function() {
		this.setTextFill('#fff');
		tmp.layer.draw();
	});
	tmp.save.on('mouseout touchend', function() {
		this.setTextFill('#A0A0A0');
		tmp.layer.draw();
	});
	tmp.save.on('mousedown', function() {
		sTatus = undefined;
		lineReset();
		proReset();
		deleteReset();
		camera.json.camera.model.id = document.getElementById("model").name;
		camera.json.camera.model.manufactory.id = document.getElementById("menufactory").name;
		camera.genjson();
		document.getElementById("camera_json").value = JSON.stringify(camera.json);
		document.forms["formsave"].submit();
	});
	// --- end save event ---
	// --- start cancel event ---
	tmp.cancel.on('mouseover touchstart', function() {
		this.setTextFill('#fff');
		tmp.layer.draw();
	});
	tmp.cancel.on('mouseout touchend', function() {
		this.setTextFill('#A0A0A0');
		tmp.layer.draw();
	});
	tmp.cancel.on('mousedown', function() {
		sTatus = undefined;
		lineReset();
		proReset();
		deleteReset();
		document.forms["formcancel"].submit();
	});
	// --- end cancel event ---
	// ***************************************************************************************************
	// --- end event ---

	// --- arr menu ---
	this.menuBackground = new Kinetic.Rect({
		x : 0,
		y : 0,
		width : window.innerWidth,
		height : 40,
		fill : '#232323'
	});

	// --- end arr menu ---
	tmp.layer.add(tmp.menuBackground);
	tmp.layer.add(tmp.proIcon);
	tmp.layer.add(tmp.proBackground);
	for (i in tmp.dataSubInPro) {
		tmp.layer.add(tmp.dataSubInPro[i]);
	}
	tmp.layer.add(tmp.lineIcon);
	tmp.layer.add(tmp.deleteIcon);
	tmp.layer.add(tmp.save);
	tmp.layer.add(tmp.cancel);
	stage.add(tmp.layer);
}
