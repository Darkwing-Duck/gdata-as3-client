package com.gdata.services.spreadsheet.requests
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    /**
     * ...<br>
     * 
     * @history create Mar 22, 2012 12:26:27 AM<br>
     * @author Smirnov Sergey
     */	
    public class GDataRequest extends EventDispatcher implements IGDataRequest
    {	
        //----------------------------------------------------------------------------------------------
        //
        //  Class constants
        //
        //----------------------------------------------------------------------------------------------
        
        //----------------------------------------------------------------------------------------------
        //
        //  Class variables
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * URLRequest instance for this request commnad. 
         */        
        protected var _urlRequest:URLRequest;
        
        /**
         * URLLoader instance for this request commnad.  
         */        
        protected var _urlLoader:URLLoader;
        
        /**
         * Url for request. 
         */        
        protected var _url:String;
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function GDataRequest(url:String)
        {
            _url = url;
            init();
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Public Methods
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * @inheritDoc 
         */        
        public function send():void
        {
            _urlLoader.load(_urlRequest);
        }
        
        /**
         * @inheritDoc 
         */ 
        public function destroy():void
        {
            removeEventListeners();
            
            _urlRequest = null;
            _urlLoader = null;
            _url = null;
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Private Methods
        //
        //----------------------------------------------------------------------------------------------
        
        //----------------------------------------------------------------------------------------------
        //
        //  Protected Methods
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Initializes the request command.<br>
         * Should be overriden by subclass to configurate the request.
         */        
        protected function init():void
        {
            _urlLoader = new URLLoader();
            _urlRequest = new URLRequest(_url);
            
            initEventListeners();
        }
        
        /**
         * Initializes the event listeners of request command.
         */        
        protected function initEventListeners():void
        {
            _urlLoader.addEventListener(Event.COMPLETE, onSuccessfulResponse);
            _urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
            _urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            _urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        }

        /**
         * Removes the event listeners of request command.
         */  
        protected function removeEventListeners():void
        {
            _urlLoader.addEventListener(Event.COMPLETE, onSuccessfulResponse);
            _urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
            _urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            _urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        }

        //----------------------------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Successful response handler.
         * @param event Event
         */        
        protected function onSuccessfulResponse(event:Event):void
        {
            dispatchEvent(event);
        }
        
        /**
         * Security error handler.
         * @param event SecurityErrorEvent
         */  
        protected function onSecurityError(event:SecurityErrorEvent):void
        {
            throw new Error(event.text);
        }
        
        /**
         * Error response handler.
         * @param event IOErrorEvent
         */  
        protected function onIOError(event:IOErrorEvent):void
        {
            trace(event.currentTarget.data);
            dispatchEvent(event);
        }
        
        /**
         * HTTP status handler.
         * @param event HTTPStatusEvent
         */ 
        protected function onHTTPStatus(event:HTTPStatusEvent):void
        {
            trace(event.status);
            dispatchEvent(event);
        }

        /**
         * URLLoader instance for request command.
         * @return 
         */        
        public function get loader():URLLoader
        {
            return _urlLoader;
        }

        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------
    }
}