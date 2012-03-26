package com.gdata.services.spreadsheet.feeds.spreadsheet
{
    import com.gdata.services.spreadsheet.SpreadsheetNamespaces;
    import com.gdata.services.spreadsheet.requests.GDataRequest;
    import com.gdata.services.spreadsheet.requests.GetFeed;
    import com.gdata.services.spreadsheet.requests.IGDataRequest;
    import com.gdata.services.spreadsheet.entries.IEntry;
    import com.gdata.services.spreadsheet.entries.spreadsheet.SpreadsheetEntry;
    import com.gdata.services.spreadsheet.feeds.Feed;
    import com.gdata.services.spreadsheet.feeds.IFeed;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import flash.events.IOErrorEvent;
    
    /**
     * ...<br>
     * 
     * @history create Mar 23, 2012 2:03:04 AM<br>
     * @author Smirnov Sergey
     */	
    public class SpreadsheetFeed extends Feed
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
        
        public function SpreadsheetFeed()
        {
            super();
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
        override protected function init(rawFeed:XML):void
        {
            default xml namespace = SpreadsheetNamespaces.ans;
            
            var entriesInfo:XMLList = rawFeed.entry;
            
            for each (var entryInfo:XML in entriesInfo)
            {
                var entry:SpreadsheetEntry = new SpreadsheetEntry(entryInfo);
                _entries.push(entry);
            }
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