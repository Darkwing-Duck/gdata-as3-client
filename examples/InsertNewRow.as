package
{
    import com.gdata.services.spreadsheet.SpreadsheetService;
    import com.gdata.services.spreadsheet.entries.IEntry;
    import com.gdata.services.spreadsheet.entries.row.RowCustomElements;
    import com.gdata.services.spreadsheet.entries.spreadsheet.SpreadsheetEntry;
    import com.gdata.services.spreadsheet.entries.worksheet.WorksheetEntry;
    import com.gdata.services.spreadsheet.events.ServiceErrorEvent;
    import com.gdata.services.spreadsheet.events.entry.SuccessEntryEvent;
    import com.gdata.services.spreadsheet.events.login.SuccessLoginEvent;
    import com.gdata.services.spreadsheet.feeds.IFeed;
    import com.gdata.services.spreadsheet.feeds.spreadsheet.SpreadsheetFeed;
    import com.gdata.services.spreadsheet.feeds.worksheet.WorksheetFeed;
    
    import flash.display.Sprite;
    import flash.events.Event;
    
    /**
     * Example #8.
     * Insert new row in certain worksheet.<br>
     * 
     * @history create Mar 26, 2012 10:47:21 PM<br>
     * @author Smirnov Sergey
     */	
    public class InsertNewRow extends Sprite
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
        
        public function InsertNewRow()
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
            
            // insert new row
            
            // init params for create the row
            var params:RowCustomElements = new RowCustomElements();
            params.setValue("id", "inserted");
            params.setValue("name", "insertedNAME");
            params.setValue("type", "insertedType");
            params.setValue("posX", "500");
            params.setValue("posY", "500");
            //
            
            WorksheetEntry(worksheet).addEventListener(SuccessEntryEvent.ON_SUCCESSFUL_INSERT, onSuccessInsertRow);
            WorksheetEntry(worksheet).addEventListener(ServiceErrorEvent.ON_ERROR_ENTRY, onErrorInsertRow);
            
            WorksheetEntry(worksheet).insert(params);
            //
        }
        
        /**
         * On successfully row inserted.
         * @param event SuccessEntryEvent
         */        
        protected function onSuccessInsertRow(event:SuccessEntryEvent):void
        {
            // retrieve inserted row entry
            var insertedRowEntry:IEntry = event.entry;
        }
        
        /**
         * Error insert row.
         * @param event ServiceErrorEvent
         */        
        protected function onErrorInsertRow(event:ServiceErrorEvent):void
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