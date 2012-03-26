package com.gdata.services.spreadsheet.requests
{
    import com.gdata.services.spreadsheet.authorization.AuthorizationProxy;
    
    import flash.net.URLRequestHeader;
    import flash.net.URLRequestMethod;

    /**
     * Get feed request command.<br>
     * 
     * @history create Mar 22, 2012 12:45:04 AM<br>
     * @author Smirnov Sergey
     */	
    public class GetFeed extends GDataRequest
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
        
        public function GetFeed(url:String)
        {
            super(url);
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Public Methods
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
            
            _urlRequest.method = URLRequestMethod.GET;
            _urlRequest.requestHeaders = [new URLRequestHeader("Authorization", "GoogleLogin auth=" + auth)];
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //----------------------------------------------------------------------------------------------
        
        //----------------------------------------------------------------------------------------------
        //
        //  Accessors
        //
        //----------------------------------------------------------------------------------------------
    }
}