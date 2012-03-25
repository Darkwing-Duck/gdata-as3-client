package com.gdata.services.spreadsheet.requests
{
    import com.gdata.services.spreadsheet.authorization.AuthorizationProxy;
    
    import flash.net.URLRequestHeader;
    import flash.net.URLRequestMethod;

    /**
     * Update request command.<br>
     * 
     * @history create Mar 24, 2012 11:49:44 PM<br>
     * @author Smirnov Sergey
     */	
    public class Update extends GDataRequest
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
         * Data to send in request's body. 
         */
        protected var _data:XML;
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function Update(url:String, data:XML)
        {
            _data = data;
            super(url);
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //----------------------------------------------------------------------------------------------
        
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
         * @inheritDoc
         */ 
        override protected function init():void
        {
            super.init();
            
            var auth:String = AuthorizationProxy.getInstance().getAuth();
            
            _urlRequest.data = _data;
            _urlRequest.method = URLRequestMethod.POST;
            _urlRequest.requestHeaders = [new URLRequestHeader("X-HTTP-Method-Override", URLRequestMethod.PUT)];     
            _urlRequest.requestHeaders.push(new URLRequestHeader("Authorization", "GoogleLogin auth=" + auth));
            _urlRequest.contentType = "application/atom+xml";
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Public Methods
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * @inheritDoc
         */ 
        override public function destroy():void
        {
            super.destroy();
            _data = null;
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------
    }
}