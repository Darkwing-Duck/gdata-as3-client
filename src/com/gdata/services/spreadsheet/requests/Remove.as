package com.gdata.services.spreadsheet.requests
{
    import com.gdata.services.spreadsheet.authorization.AuthorizationProxy;
    
    import flash.net.URLRequestHeader;
    import flash.net.URLRequestMethod;

    /**
     * Remove request command.<br>
     * 
     * @history create Mar 24, 2012 5:24:12 PM<br>
     * @author Smirnov Sergey
     */	
    public class Remove extends GDataRequest
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
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function Remove(url:String)
        {
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
            
            _urlRequest.method = URLRequestMethod.POST;
            _urlRequest.requestHeaders = [new URLRequestHeader("X-HTTP-Method-Override", URLRequestMethod.DELETE)];
            _urlRequest.requestHeaders.push(new URLRequestHeader("Authorization", "GoogleLogin auth=" + auth));
            _urlRequest.contentType = "application/atom+xml";
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Public Methods
        //
        //----------------------------------------------------------------------------------------------
        
        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------
    }
}