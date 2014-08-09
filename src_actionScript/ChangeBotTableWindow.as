//--*-coding:utf-8-*--

package {
    import mx.controls.Alert;
    
    public class ChangeBotTableWindow extends AddBotTableWindow {
        
        
        private var originalCommand:String;
        private var originalGameType:String;
        
        
        override protected function setup():void {
            super.setup();
            
            title = Language.s.changeBotTableWindowTitle;
            executeButton.label = Language.s.botTableChangeButton;
            
            setVisiblePrintSampleButton( false );
        }
        
        override public function initAfter():void {
            originalCommand = commandText.text;
            originalGameType = diceBotGameType.selectedItem.gameType;
        }
        
        /**
         * 表変更処理
         */
        override public function execute():void {
            var gameType:String = diceBotGameType.selectedItem.gameType;
            
            window.changeBotTable(commandText.text, diceText.text, titleText.text,
                                  getTableTextFromTextArea(),
                                  gameType, originalCommand, originalGameType,
                                  checkResult);
        }
        
    }
}

