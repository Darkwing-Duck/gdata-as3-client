package
{
    import com.gdata.services.spreadsheet.SpreadsheetService;
    import com.gdata.services.spreadsheet.entries.IEntry;
    import com.gdata.services.spreadsheet.entries.row.RowEntry;
    import com.gdata.services.spreadsheet.entries.spreadsheet.SpreadsheetEntry;
    import com.gdata.services.spreadsheet.entries.worksheet.WorksheetEntry;
    import com.gdata.services.spreadsheet.events.ServiceErrorEvent;
    import com.gdata.services.spreadsheet.events.entry.SuccessEntryEvent;
    import com.gdata.services.spreadsheet.events.login.SuccessLoginEvent;
    import com.gdata.services.spreadsheet.feeds.IFeed;
    import com.gdata.services.spreadsheet.feeds.row.RowFeed;
    import com.gdata.services.spreadsheet.feeds.spreadsheet.SpreadsheetFeed;
    import com.gdata.services.spreadsheet.feeds.worksheet.WorksheetFeed;
    
    import flash.display.Sprite;
    import flash.events.Event;
    
    /**
     * Example #9.
     * Update the existing row from a certain worksheet.<br>
     * 
     * @history create Mar 26, 2012 10:47:21 PM<br>
     * @author Smirnov Sergey
     */	
    public class UpdateExistingRow extends Sprite
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
         * Spreadsheets service instance. 
         */        
        private var _service:SpreadsheetService;
        
        //----------------------------------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------------------------------
        
        public function UpdateExistingRow()
        {
            // init the service
            _service = new SpreadsheetService();
            
            // init login event listeners
            _service.addEventListener(SuccessLoginEvent.ON_SUCCESSFUL_LOGIN, onSuccessLogin);
            //
            
            // login
            _service.login("yourEmail", "yourPassword");
        }
        
        //----------------------------------------------------------------------------------------------
        //
        //  Event handlers
        //
        //----------------------------------------------------------------------------------------------
        
        /**
         * Successful login handler.
         * @param event SuccessLoginEvent
         */        
        protected function onSuccessLogin(event:SuccessLoginEvent):void
        {
            // get new instance of spreadsheets feed
            var spreadsheetFeed:IFeed = _service.getFeed();
            
            // retrive the url of spreadsheets feed
            var spreadsheetFeedUrl:String = _service.getSpreadsheetFeedUrl();
            
            // load spreadsheets feed
            SpreadsheetFeed(spreadsheetFeed).addEventListener(Event.COMPLETE, onSpreadsheetFeedLoaded);
            spreadsheetFeed.load(spreadsheetFeedUrl);
            //
        }
        
        /**
         * Successful loaded list of spreadsheets.
         * @param event Event
         */        
        protected function onSpreadsheetFeedLoaded(event:Event):void
        {
            // retrieve spreadsheets feed
            var spreadsheetFeed:IFeed = event.currentTarget as IFeed;
            
            // get specific spreadsheet by title 'Sheet1'
            var spreadsheet:IEntry = spreadsheetFeed.getEntry("Sheet1");
            
            // get url to load worksheets feed of specific spreadsheet
            var worksheetsFeedUrl:String = SpreadsheetEntry(spreadsheet).getWorksheetFeedUrl();
            
            // load worksheets feed
            var worksheetFeed:IFeed = SpreadsheetEntry(spreadsheet).getFeed();
            WorksheetFeed(worksheetFeed).addEventListener(Event.COMPLETE, onWorksheetFeedLoaded);
            worksheetFeed.load(worksheetsFeedUrl);
            //
        }
        
        /**
         * Successful loaded list of worksheets.
         * @param event Event
         */
        protected function onWorksheetFeedLoaded(event:Event):void
        {
            // retrieve the worksheets feed
            var worksheetFeed:IFeed = event.currentTarget as IFeed;
            
            // get specific worksheet by title 'Worksheet1'
            var worksheet:IEntry = worksheetFeed.getEntry("Worksheet1");
            
            // load rows feed
            var rowFeed:IFeed = WorksheetEntry(worksheet).getRowFeed();
            var rowFeedUrl:String = WorksheetEntry(worksheet).getRowFeedUrl();
            RowFeed(rowFeed).addEventListener(Event.COMPLETE, onRowFeedLoaded);
            rowFeed.load(rowFeedUrl);
            //
        }
        
        /**
         * On rows feed successfully laoded.
         * @param event Event
         */        
        protected function onRowFeedLoaded(event:Event):void
        {
            // retrieve loded rows feed
            var rowFeed:IFeed = event.currentTarget as IFeed;
            
            // get row by title (Undertakes from column 'A')
            var row:IEntry = rowFeed.getEntry("1");
            
            // update the row
            RowEntry(row).addEventListener(SuccessEntryEvent.ON_SUCCESSFUL_UPDATE, onRowSuccessfulUpdated);
            RowEntry(row).addEventListener(ServiceErrorEvent.ON_ERROR_ENTRY, onRowErrorUpdate);
            
            // change the value of existing custom elements 
            RowEntry(row).getCustomElements().setValue("id", "999999");
            RowEntry(row).getCustomElements().setValue("name", "Crazy");
            RowEntry(row).getCustomElements().setValue("type", "CrazyType");
            RowEntry(row).getCustomElements().setValue("posX", "150");
            RowEntry(row).getCustomElements().setValue("posY", "150");
            RowEntry(row).getCustomElements().setValue("testField", "test_test");
            RowEntry(row).update();
            //
        }
        
        /**
         * Successful update row.
         * @param event SuccessEntryEvent
         */
        protected function onRowSuccessfulUpdated(event:SuccessEntryEvent):void
        {
            // retrieve updated row entry
            // event.currentTarget or event.entry
            var updatedRowEntry:IEntry = event.entry;
        }
        
        /**
         * Error update row.
         * @param event ServiceErrorEvent
         */        
        protected function onRowErrorUpdate(event:ServiceErrorEvent):void
        {
            // get error message
            trace(event.text);
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