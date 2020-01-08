package com.educationcurb.thword.view.gamestuff;

import com.educationcurb.thword.model.GlobalVO;
import com.educationcurb.thword.view.components.ScrollList;
import js.html.HTMLDocument;
import js.html.TextAreaElement;
import openfl.text.TextField;
import openfl.text.TextFormat;
import msignal.Signal.Signal0;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;

class WordListPopup extends Sprite
{
    private var settings : Settings = Settings.getInstance();
    
    private var cover : Quad;
    private var wordListBg : Image;
    private var txtWords : flash.text.TextField;
    private var header : Image;
    private var words : Array<Dynamic>;
    private var wordsTxt : String = "";
    private var btnClose : Button;

    private var listTextArray:Array<String> = new Array<String>();
    
    public var close : Signal0;

    private var _globalVO:GlobalVO;
    
    public function new(words : Array<Dynamic>, vo:GlobalVO)
    {
        super();
        this.words = words;
        this._globalVO = vo;
        close = new Signal0();
        createWords();
        createPopup();
    }
    
    private function createWords() : Void
    {
        for (i in 0...words.length)
        {
            wordsTxt = Std.string(words[i].points) + getSpacing(words[i].points) + " - " + words[i].word;
            listTextArray.push(wordsTxt);
        }
    }
    
    private function getSpacing(length : Float) : String
    {
        var spaces : String = "";
        
        if (length < 0 && length > -100)
        {
            spaces = "    ";
        }
        else if (length < -99 && length > -1000)
        {
            spaces = "   ";
        }
        else if (length > -1 && length < 10)
        {
            spaces = "      ";
        }
        else if (length > 9 && length < 100)
        {
            spaces = "     ";
        }
        else if (length > 99 && length < 1000)
        {
            spaces = "    ";
        }
        else if (length > 999)
        {
            spaces = "   ";
        }
        
        return spaces;
    }
    
    private function createPopup() : Void
    //Cover
    {
        
        var coverBottomColor : Int = 0x000000;
        var coverTopColor : Int = 0x000000;
        cover = new Quad(settings.stageWidth, settings.stageHeight);
        cover.setVertexColor(0, coverTopColor);
        cover.setVertexColor(1, coverTopColor);
        cover.setVertexColor(2, coverBottomColor);
        cover.setVertexColor(3, coverBottomColor);
        cover.alpha = 0.7;
        this.addChild(cover);
        
        
        wordListBg = new Image(_globalVO.assets.getTexture("end_game_scroll_wordlist"));
        wordListBg.width = wordListBg.width * settings.scaleAdjustment;
        wordListBg.height = wordListBg.height * settings.scaleAdjustment;
        wordListBg.x = settings.stageWidth / 2 - wordListBg.width / 2;
        wordListBg.y = settings.stageHeight / 2 - wordListBg.height / 2;
        this.addChild(wordListBg);
        
        
        header = new Image(_globalVO.assets.getTexture("wordlist_title"));
        header.width = header.width * settings.scaleAdjustment;
        header.height = header.height * settings.scaleAdjustment;
        header.x = wordListBg.x + (wordListBg.width / 2 - header.width / 2);
        header.y = wordListBg.y + (wordListBg.height * 0.12);
        this.addChild(header);


        var scrollList:ScrollList = new ScrollList(Std.int(wordListBg.width * 0.5), Std.int(wordListBg.height * 0.6), listTextArray);
        scrollList.x = settings.stageWidth/2 - scrollList.width/2;
        scrollList.y = header.y + header.height + 30;
        this.addChild(scrollList);

        
        /*
        var myFormat : TextFormat = new TextFormat();
        myFormat.size = Std.int(settings.fontLarge);
        myFormat.color = 0x663300;
        myFormat.font = "Book Antiqua";
        
        txtWords = new openfl.text.TextField();
        txtWords.defaultTextFormat = myFormat;
        //txtWords.type = openfl.text.TextFieldType.INPUT;
        txtWords.multiline=true;
        txtWords.wordWrap=true;
        txtWords.mouseWheelEnabled = true;
        txtWords.width = wordListBg.width * 0.7;
        txtWords.height = wordListBg.height * 0.7;
        txtWords.wordWrap = true;
        //txtWords.x = settings.stageWidth/2 - txtWords.width/2;
        //txtWords.y =  settings.stageHeight/2 - wordListBg.height/3;
        txtWords.text = wordsTxt;
        txtWords.x = wordListBg.x + wordListBg.width * 0.2;
        txtWords.y = header.y + header.height + 8;
        Starling.current.nativeOverlay.addChild(txtWords);
        */


        
        var adj : Float = settings.scaleAdjustment * 0.7;
        btnClose = new Button(_globalVO.assets.getTexture("btn_cancel"));
        btnClose.width = btnClose.width * adj;
        btnClose.height = btnClose.height * adj;
        btnClose.x = wordListBg.x + (wordListBg.width - btnClose.width * 0.8);
        btnClose.y = wordListBg.y + wordListBg.height * 0.1;
        btnClose.addEventListener(Event.TRIGGERED, onClose);
        this.addChild(btnClose);
    }
    
    private function onClose(e : Event) : Void
    {
        Starling.current.nativeOverlay.removeChild(txtWords);
        txtWords = null;
        btnClose.removeEventListener(Event.TRIGGERED, onClose);
        close.dispatch();
    }
}
