package com.gdata.services.spreadsheet.entries
{
    /**
     * Feed's entry entity.<br>
     * 
     * @history create Mar 23, 2012 1:58:21 AM<br>
     * @author Smirnov Sergey
     */
    public interface IEntry
    {
        /**
         * Title of entry.
         * @return 
         */        
        function getTitle():String;
        
        /**
         * Destroys the entry. 
         */        
        function destroy():void;
    }
}