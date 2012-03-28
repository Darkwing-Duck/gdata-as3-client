package
{
    import com.gdata.services.spreadsheet.SpreadsheetService;
    import com.gdata.services.spreadsheet.entries.IEntry;
    import com.gdata.services.spreadsheet.entries.cell.CellEntry;
    import com.gdata.services.spreadsheet.entries.row.RowCustomElements;
    import com.gdata.services.spreadsheet.entries.spreadsheet.SpreadsheetEntry;
    import com.gdata.services.spreadsheet.entries.worksheet.WorksheetEntry;
    import com.gdata.services.spreadsheet.events.ServiceErrorEvent;
    import com.gdata.services.spreadsheet.events.entry.SuccessEntryEvent;
    import com.gdata.services.spreadsheet.events.login.SuccessLoginEvent;
    import com.gdata.services.spreadsheet.feeds.IFeed;
    import com.gdata.services.spreadsheet.feeds.cell.CellFeed;
    import com.gdata.services.spreadsheet.feeds.spreadsheet.SpreadsheetFeed;
    import com.gdata.services.spreadsheet.feeds.worksheet.WorksheetFeed;
    
    import flash.display.Sprite;
    import flash.events.Event;
    
    /**
     * Example #11.
     * Retrieve the cells list of certain worksheet.<br>
     * 
     * @history create Mar 26, 2012 10:47:21 PM<br>
     * @author Smirnov Sergey
     */	
    public class RetrieveCellsList extends Sprite
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
        
        public function RetrieveCellsList()
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
            
            // load cells feed
            var cellFeed:IFeed = WorksheetEntry(worksheet).getCellFeed();
            var cellFeedUrl:String = WorksheetEntry(worksheet).getCellFeedUrl();
            CellFeed(cellFeed).addEventListener(Event.COMPLETE, onCellFeedLoaded);
            CellFeed(cellFeed).addEventListener(ServiceErrorEvent.ON_ERROR_FEED, onCellFeedError);
            cellFeed.load(cellFeedUrl);
            //
        }
        
        /**
         * On successfully load cells feed.
         * @param event Event
         */        
        protected function onCellFeedLoaded(event:Event):void
        {
            // retrieve loaded cell feed
            var cellFeed:IFeed = event.currentTarget as IFeed;
            
            // get cell by title
            var cell:IEntry = cellFeed.getEntry("B1");
            
            // get cell's title
            trace(CellEntry(cell).getTitle());
            
            // get cell's value
            trace(CellEntry(cell).getValue());
            
            // get cell's column index
            trace(CellEntry(cell).getColumnIndex());
            
            // get cell's row index
            trace(CellEntry(cell).getRowIndex());
            
            // get all cells at worksheet
            var cells:Vector.<IEntry> = cellFeed.getEntries();
        }
        
        /**
         * Error load cells feed.
         * @param event ServiceErrorEvent
         */        
        protected function onCellFeedError(event:ServiceErrorEvent):void
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