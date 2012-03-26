package com.gdata.services.spreadsheet.requests
{
    /**
     * Describes the request command to gdata api<br>
     * 
     * @history create Mar 22, 2012 12:22:10 AM<br>
     * @author Smirnov Sergey
     */
    public interface IGDataRequest
    {
        /**
         * Sends the request.
         */        
        function send():void;
        
        /**
         * Destroys the command.
         */        
        function destroy():void;
    }
}