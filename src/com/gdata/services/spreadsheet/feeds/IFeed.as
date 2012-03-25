package com.gdata.services.spreadsheet.feeds
{
    import com.gdata.services.spreadsheet.entries.IEntry;

    /**
     * Spreadsheet feed entity.<br>
     * 
     * @history create Mar 22, 2012 1:25:41 AM<br>
     * @author Smirnov Sergey
     */
    public interface IFeed
    {
        /**
         * Starts the loading of feed.
         * 
         * @param url feed url
         */        
        function load(url:String):void;
        
        /**
         * List of feed's entries.
         * @return 
         */        
        function getEntries():Vector.<IEntry>;
        
        /**
         * Specific feed's entry by entry's title.
         * 
         * @param title entry's title.
         * @return 
         */        
        function getEntry(title:String):IEntry;
        
        /**
         * Destroys the feed.
         */        
        function destroy():void;
    }
}