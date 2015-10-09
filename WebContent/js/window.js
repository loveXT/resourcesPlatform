/*
* @fileOverview Window Javascript Component v1.0
*
* Copyright (c) 2011, libing
* Dual licensed under the MIT or GPL Version 2 licenses.
*
* Build on jQuery JavaScript Library v1.5.1
* Date: 2011.08.12
* 
* Depends:
*   lib.ui.button.js
*	lib.ui.drag.js
* 
* all CSS sizing (width,height) is done in pixels (px)
*
*/
(function($){

	/**
	 * 给jQuery添加类实例方法：window
	 */
	$.fn.window = function(options){
		var windowId = '',
			DATA_NAME = 'lib-window',
			config = options || {};

		this.each(function(){

			//创建window对象
			var window = new lib.Window(config,$(this));
			windowId = window.getId();

			//设置window对象的缓存
			$(this).data(DATA_NAME + windowId,window);

		});

		//返回缓存的window对象
		return $(this).data(DATA_NAME + windowId);
	};

	//定义命名空间
	var lib = lib || {};
		
	/**
	 * 面板（Window）类
	 */
	lib.Window = function(options,container){
		$.extend(true,this,lib.Window.defaults,options,{'container':container});

		//面板的唯一标识
		this.id = this.getId();		

		//初始化面板
		this._init();
	};

	/**
	 * 面板的默认属性
	 */
	lib.Window.defaults = {
		/**
		 * 面板的唯一标识
		 * @type {string}
		 */
		id: '',

		/**
		 * 面板的内容
		 * @type {string | html}
		 */
		content: '',

		/**
		 * 面板的标题
		 * @type {string | html}
		 */
		title: '',

		/**
		 * 面板标题的图标
		 * @type {object}
		 *
		 * @example 
		 *	icon: {
		 *		cls: '',
		 *		url: ''
		 *	}
		 *
		 *	注意：如果同时设置了cls属性和url属性，那么url会覆盖cls。
		 */
		icon: null,

		/**
		 * 面板显示的位置
		 * @type {object}
		 */
		position: {
			type: 'absolute',
			top: null,	//可以是数字、字符串，与css中的top属性相同。
			left: null	//可以是数字、字符串，与css中的left属性相同。
		},

		/**
		 * 面板的宽度
		 * @type {string | number}
		 *
		 */
		width: '500px',

		/**
		 * 面板的高度
		 * @type {string | number}
		 *
		 */
		height: '400px',

		/**
		 * 面板是否可以最小化
		 * @type {boolean}
		 *
		 */
		minimizable: true,

		/**
		 * 面板是否可以最大化
		 * @type {boolean}
		 *
		 */
		maximizable: true,

		/**
		 * 面板是否有关闭按钮
		 * @type {boolean}
		 *
		 */
		closable: true,
		
		/**
		 * 面板关闭时，是否需要确认
		 * @type {boolean}
		 *
		 */
		confirmClose: true,

		/**
		 * 面板是否是模式窗口
		 * @type {boolean}
		 *
		 */
		isModal: false,

		/**
		 * 面板是否可以拖动
		 * @type {boolean}
		 *
		 */
		draggable: false,

		/**
		 * 面板的顶层工具栏
		 * @type {lib.ui.toolbar}
		 *
		 */
		topBar: null,

		/**
		 * 面板的底层状态栏
		 * @type {lib.ui.toolbar}
		 *
		 */
		bottomBar: null,

		/**
		 * 承载面板的容器
		 * @type {jQuery object}
		 */
		container: $(document.body),

		/**
		 * 面板的事件
		 * @type {function}
		 */
		handler: $.noop
		
	};

	lib.Window.AUTO_ID = 100;

	lib.Window.Z_INDEX = 100;

	lib.Window.prototype = {
		/**
		 * private
		 *
		 * 初始化面板
		 *
		 */
		_init: function(){
			var self = this;

			var _winHtml = [];
			_winHtml.push('<div class="window" id="' + self.id + '">');
			_winHtml.push('		<div class="window-header">');
			_winHtml.push('			<div class="icon"></div>');
			_winHtml.push('			<div class="title"></div>');
			_winHtml.push('			<div class="operate">');
			_winHtml.push('				<div class="close"></div>');
			_winHtml.push('				<div class="max"></div>');
			_winHtml.push('				<div class="min"></div>');
			_winHtml.push('			</div>');
			_winHtml.push('		</div>');
			_winHtml.push('		<div class="window-body">');
			_winHtml.push('			<div class="window-topbar"></div>');
			_winHtml.push('			<div class="window-content"></div>');
			_winHtml.push('			<div class="window-bottombar"></div>');
			_winHtml.push('		</div>');
			_winHtml.push('</div>');

			var _doc = self._doc = $(_winHtml.join(''));
			self._doc.appendTo(self.container);

			var _window = self._window = $('#' + self.id);
			self._win_header = $('.window-header',_doc);
			self._win_icon = $('.icon',_doc);
			self._win_title = $('.title',_doc);
			self._win_operate = $('.operate',_doc);
			self._win_close = $('.close',_doc);
			self._win_max = $('.max',_doc);
			self._win_min = $('.min',_doc);
			self._win_body = $('.window-body',_doc);
			self._win_tbar = $('.window-topbar',_doc);
			self._win_content = $('.window-content',_doc);
			self._win_bbar = $('.window-bottombar',_doc);

			//加载面板背景
			self._loadBackground();

			//加载面板内容
			self._loadWindow();

		},

		/**
		 * private
		 *
		 * 加载面板
		 *
		 */
		_loadWindow: function(){
			var self = this;
			
			//设置面板的宽度、高度
			self.setHeight(self.height)
				.setWidth(self.width);

			//设置面板的图标
			self.addIcon(self.icon);
			
			//设置面板的标题
			self.addTitle(self.title);

			//设置面板的内容
			self.addContent(self.content);				

			//设置面板的顶部、底部工具栏
			self.addBar('top', self.topBar);
			self.addBar('bottom', self.bottomBar);

			var _tbarHgt = self.topBar ? self.topBar.getOuterHeight() : 0;
			var _bbarHgt = self.bottomBar ? self.bottomBar.getOuterHeight() : 0;

			//设置面板内容层的高度
			self._win_content.height((self.getHeight() - self._win_header.outerHeight() - _tbarHgt - _bbarHgt - 1) + 'px');

			//设置面板的显示位置
			self.position.top = parseInt(self.position.top) || (self.container.height() - self.getOuterHeight()) * 0.5;
			self.position.left = parseInt(self.position.left) || (self.container.width() - self.getOuterWidth()) * 0.5;
			self.setPosition(self.position);

			if(self.draggable){
				self._win_header.css('cursor','move');
				self._window.drag({
					trigger: self._win_title
				});
			}

			//设置面板的最小化、最大化、关闭按钮
			if(self.minimizable){
				self._win_min.show();
				self._win_min.bind('click',{'scope':self},self.min);
			}
			if(self.maximizable){
				self._win_max.show();
				self._win_max.bind('click',{'scope':self},self.max);
			}
			if(self.closable){
				self._win_close.show();
				self._win_close.bind('click',{'scope':self},self.close);
			}

			//设置面板堆叠顺序
			self._window.bind('mousedown',{'scope':self},self.moveTop);
			
		},

		/**
		 * private
		 *
		 * 加载面板的背景层
		 *
		 */
		_loadBackground: function(){
			var self = this;
			
			if(self.isModal){
				var modalDiv = $('.window-background').size() 
					? $('.window-background') 
					: $('<div class="window-background" />');
				modalDiv.appendTo(self.container).fadeTo(500,0.33);
			}
		},

		/**
		 * public
		 *
		 * 移动面板到最顶层
		 *
		 */
		moveTop: function(e){
			var self = e && e.data.scope || this,
				zIndex = self.container.data('zIndex') || lib.Window.Z_INDEX;

			++zIndex;
			self._window.css('z-index',zIndex);
			self.container.data('zIndex',zIndex);
		},

		/**
		 *	public
		 *
		 *	面板最小化
		 *
		 */
		min: function(e){
			var self = e && e.data.scope || this;

			self.setHeight(self.getHeight() - self._win_body.outerHeight());
			self.setWidth(160);
			
			self._window.css({
				'position': 'absolute',
				'top': self.container.height() - self.getOuterHeight(),
				'left': 0
			});

			self._win_body.hide();
			self._win_title.width(90);

			self._win_min
				.removeClass('min')
				.addClass('restore')
				.unbind('click')
				.bind('click',{'scope':self},self.restore);
			self._win_max
				.removeClass()
				.addClass('max')
				.unbind('click')
				.bind('click',{'scope':self},self.max);
		},

		/**
		 *	public
		 *
		 *	面板最大化
		 *
		 */
		max: function(e){
			var self = e && e.data.scope || this;

			//“2”是边框的宽度，“4”是内边距padding的宽度
			self.setHeight(self.container.height() - 2 - 4);
			self.setWidth(self.container.width() - 2 - 4);

			self._window.css({
				'top': 0,
				'left': 0
			});

			if(self._win_body.is(':hidden'))
				self._win_body.show();

			//“45”是最小化、最大化、关闭按钮的宽度
			self._win_title.width(self._win_header.width() - self._win_icon.outerWidth(true) - 45);

			var _tbarHgt = self.topBar ? self.topBar.getOuterHeight() : 0;
			var _bbarHgt = self.bottomBar ? self.bottomBar.getOuterHeight() : 0;
			self._win_content.height((self.getHeight() - self._win_header.outerHeight() - _tbarHgt - _bbarHgt - 1) + 'px');

			self._win_max
				.removeClass('max')
				.addClass('restore')
				.unbind('click')
				.bind('click',{'scope':self},self.restore);
			self._win_min
				.removeClass()
				.addClass('min')
				.unbind('click')
				.bind('click',{'scope':self},self.min);
		},

		/**
		 *	public
		 *
		 *	还原面板
		 *
		 */
		restore: function(e){
			var self = e && e.data.scope || this;

			self.setHeight(self.height);
			self.setWidth(self.width);

			self.setPosition(self.position);

			if(self._win_body.is(':hidden'))
				self._win_body.show();

			//“45”是最小化、最大化、关闭按钮的宽度
			self._win_title.width(self._win_header.width() - self._win_icon.outerWidth(true) - 45);

			var _tbarHgt = self.topBar ? self.topBar.getOuterHeight() : 0;
			var _bbarHgt = self.bottomBar ? self.bottomBar.getOuterHeight() : 0;
			self._win_content.height((self.getHeight() - self._win_header.outerHeight() - _tbarHgt - _bbarHgt - 1) + 'px');

			self._win_min
				.removeClass()
				.addClass('min')
				.unbind('click')
				.bind('click',{'scope':self},self.min);
			self._win_max
				.removeClass()
				.addClass('max')
				.unbind('click')
				.bind('click',{'scope':self},self.max);
		},

		/**
		 *	public
		 *
		 *	关闭面板
		 *
		 */
		close: function(e){
			var self = e && e.data.scope || this;
			
			if(!self.confirmClose
				|| (self.confirmClose && confirm('是否关闭窗口？'))){
				
				if(self.isModal){
					$('.window-background').hide();
				}
				if(self.afterCloseHandler){
					self.afterCloseHandler.call(self,self);
				}
				self.destroy();
			}
		},

		/**
		 *	public
		 *
		 *	添加工具栏
		 *
		 *	@param	position {string} 需要添加的位置，‘top’或者‘bottom’
		 *			bar {object} 需要添加的toolbar
		 *
		 */
		addBar: function(position,bar){
			var self = this;

			if(bar && $.isPlainObject(bar)){
				switch(position){
					case 'top':
						self._win_tbar.show();
						self.topBar = self._win_tbar.toolbar(bar);	//对topBar重新赋值，变成toolbar对象
						$("#"+self.topBar.getId(),self._win_tbar).css({
							'border-top': '0px',
							'border-left': '0px',
							'border-right': '0px'
						});	
						break;
					case 'bottom':
						self._win_bbar.show();
						self.bottomBar = self._win_bbar.toolbar(bar);	//对bottomBar重新赋值，变成toolbar对象
						$("#"+self.bottomBar.getId(),self._win_bbar).css({
							'border-bottom': '0px',
							'border-left': '0px',
							'border-right': '0px'
						});	
						break;
				}
			}

			return self;
		},

		/**
		 *	public
		 *
		 *	添加工具栏图标
		 *
		 *	@param	icon {object} 需要添加的图标
		 *
		 */
		addIcon: function(icon){
			var self = this;

			if(icon){
				if(icon.cls)
					self._win_icon.addClass(icon.cls);
				if(icon.url)
					self._win_icon.css('background','url(' + icon.url + ') no-repeat center center');
			}

			return self;
		},

		/**
		 *	public
		 *
		 *	添加工具栏标题
		 *
		 *	@param	title {string} 需要添加的标题
		 *
		 */
		addTitle: function(title){
			var self = this;

			self._win_title.width(self._win_header.width() - self._win_icon.outerWidth(true) - 45);

			if(title){
				self._win_title.html(title);
				self._win_title.attr('title',title);
			}

			return self;
		},

		/**
		 *	public
		 *
		 *	添加工具栏内容
		 *
		 *	@param	content {string | html} 需要添加的内容
		 *
		 */
		addContent: function(content){
			var self = this;

			if(content)
				self._win_content.html(content);

			return self;
		},

		/**
		 *	public
		 *
		 *	获取顶部的工具栏
		 *
		 *	@return	{null | toolbar Object}
		 *
		 */
		getTopBar: function(){
			return this.topBar;
		},

		/**
		 *	public
		 *
		 *	获取底部的工具栏
		 *
		 *	@return	{null | toolbar Object}
		 *
		 */
		getBottomBar: function(){
			return this.bottomBar;
		},

		/**
		 *	public
		 *
		 *	销毁面板
		 *
		 */
		destroy: function(){
			this._window.remove();
		},

		/**
		 *	public
		 *
		 *	获取面板的高度（包括面板的内边距和边框）
		 *
		 *	@return {number}
		 */
		getOuterHeight: function(){
			return this._window.outerHeight();
		},

		/**
		 *	public
		 *
		 *	获取面板的宽度（包括面板的内边距和边框）
		 *
		 *	@return {number}
		 */
		getOuterWidth: function(){
			return this._window.outerWidth();
		},

		/**
		 *	public
		 *
		 *	获取面板的高度
		 *
		 *	@return {number}
		 */
		getHeight: function(){
			return this._window.height();
		},

		/**
		 *	public
		 *
		 *	获取面板的宽度
		 *
		 *	@return {number}
		 */
		getWidth: function(){
			return this._window.width();
		},

		/**
		 *	public
		 *
		 *	设置面板的高度
		 *
		 *	@param height {number | string}
		 *
		 *	@return {number}
		 */
		setHeight: function(height){
			this._window.css('height',typeof height === 'number' ? height+'px' : height);
			return this;
		},

		/**
		 *	public
		 *
		 *	设置面板的宽度
		 *
		 *	@param width {number | string}
		 *
		 *	@return {number}
		 */
		setWidth: function(width){
			this._window.css('width',typeof width === 'number' ? width+'px' : width);
			return this;
		},

		/**
		 *	public
		 *
		 *	设置面板的位置
		 *
		 *	@param position {object}
		 *
		 *	@return {number}
		 */
		setPosition: function(position){
			this._window.css({
				'position': position.type ? position.type : 'absolute',
				'top': typeof position.top === 'number' ? position.top+'px' : position.top,
				'left': typeof position.left === 'number' ? position.left+'px' : position.left
			});
			return this;
		},

		/**
		 * public
		 *
		 * 获得面板的容器
		 *
		 * @return {jQuery Object}
		 *
		 */
		getContainer: function () {
			return this.container;
		},

		/**
		 *	public
		 *
		 * 获得面板的唯一标识（id）
		 *
		 * @return {string}
		 *
		 */
		getId: function () {
			return this.id || (this.id = 'autoId-window-' + (++lib.Window.AUTO_ID));
		}

	};

})(jQuery);