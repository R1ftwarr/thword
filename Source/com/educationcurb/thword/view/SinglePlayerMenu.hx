package com.educationcurb.thword.view;

import com.educationcurb.thword.model.GlobalVO;

import com.educationcurb.thword.filemanagement.HighScores;
import starling.text.TextFormat;
import com.educationcurb.thword.model.EnduranceVO;
import com.educationcurb.thword.model.GameSettingsVO;
import com.educationcurb.thword.model.RampageVO;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;

import msignal.Signal.Signal0;

class SinglePlayerMenu extends Sprite
{
    private var _globalVO:GlobalVO;

    public static inline var BTN_SPACE : Int = 8;
    private var settings : Settings = Settings.getInstance();
    
    //Background and Border Assets
    private var background : Image;
    private var front : Image;
    private var backButton : Button;
    
    private var menuHolder : Sprite;
    private var scroll : Image;
    private var border1 : Image;
    private var border2 : Image;
    private var border3 : Image;
    
    
    private var btn9Letters : Button;
    private var btn12Letters : Button;
    
    private var btnEndurance : Button;
    private var btnRampage : Button;
    
    private var letterCountSelected : Int = 9;
    private var difficultyLevel : Int = 1;
    private var gameSelected : String = Settings.GAME_RAMPAGE;
    
    private var sliderCharacter : MovieClip;
    private var enduranceChar : Image;
    private var txtTopScore : TextField;
    
    private var sliderBar : Image;
    private var sliderBtn : starling.display.Button;
    private var sliderLeftX : Int;
    private var sliderRightX : Int;
    private var sliderLength : Int;
    
    private var hammerBronze : Image;
    private var hammerSilver : Image;
    private var hammerGold : Image;
    
    private var btnOK : Button;

    public var navBack:Signal0;
    public var startGame:Signal0;   

    public function new() 
    {
        super();
        this.addEventListener(Event.REMOVED_FROM_STAGE, destroy);

        navBack = new Signal0();
        startGame = new Signal0();      
    }

    public function init(globalVO:GlobalVO):Void
    {
        _globalVO = globalVO;

        createBackgroundAssets();
        createMenu();
        setScore();
    }

    private function createBackgroundAssets() : Void
    {
        background = new Image(_globalVO.assets.getTexture("twhord_menu_bg_back"));
        background.width = background.width * settings.scaleAdjustmentMinor;
        background.height = background.height * settings.scaleAdjustmentMinor;
        background.x = settings.stageWidth / 2 - background.width / 2;
        background.y = settings.stageHeight - background.height;
        this.addChild(background);
        
        front = new Image(_globalVO.assets.getTexture("twhord_menu_bg_front"));
        front.width = front.width * settings.scaleAdjustment;
        front.height = front.height * settings.scaleAdjustment;
        front.x = settings.stageWidth / 2 - front.width / 2;
        front.y = 0;
        this.addChild(front);
        
        //Back Button
        backButton = new Button(_globalVO.assets.getTexture("btn_back"));
        backButton.width = backButton.width * settings.scaleAdjustment;
        backButton.height = backButton.height * settings.scaleAdjustment;
        backButton.name = "ExercisesBack";
        backButton.x = BTN_SPACE;
        backButton.y = BTN_SPACE;
        backButton.addEventListener(Event.TRIGGERED, onBackTriggered);
        addChild(backButton);
    }

    private function createMenu() : Void
    {
        menuHolder = new Sprite();
        
        scroll = new Image(_globalVO.assets.getTexture("panel_gameoptions"));
        scroll.width = scroll.width * settings.scaleAdjustment;
        scroll.height = scroll.height * settings.scaleAdjustment;
        menuHolder.addChild(scroll);
        
        border1 = new Image(_globalVO.assets.getTexture("gameoption_box_choosegame"));
        border1.width = border1.width * settings.scaleAdjustment;
        border1.height = border1.height * settings.scaleAdjustment;
        border1.x = scroll.width * 0.07;
        border1.y = scroll.height * 0.08;
        menuHolder.addChild(border1);
        
        border2 = new Image(_globalVO.assets.getTexture("gameoption_box_difficulty"));
        border2.width = border2.width * settings.scaleAdjustment;
        border2.height = border2.height * settings.scaleAdjustment;
        border2.x = border1.x + border1.width + BTN_SPACE;
        border2.y = scroll.height * 0.08;
        menuHolder.addChild(border2);
        
        border3 = new Image(_globalVO.assets.getTexture("gameoption_box_letters"));
        border3.width = border3.width * settings.scaleAdjustment;
        border3.height = border3.height * settings.scaleAdjustment;
        border3.x = scroll.width * 0.07;
        border3.y = border1.y + border1.height * 1.15 + BTN_SPACE / 1.3;
        menuHolder.addChild(border3);
        
        //Game Type
        btnRampage = new Button(_globalVO.assets.getTexture("btn_rampage_selected"));
        btnRampage.width = btnRampage.width * settings.scaleAdjustment;
        btnRampage.height = btnRampage.height * settings.scaleAdjustment;
        btnRampage.name = Settings.GAME_RAMPAGE;
        btnRampage.x = border1.x + 6;
        btnRampage.y = border1.y + border1.height * 0.35;
        btnRampage.addEventListener(Event.TRIGGERED, onGameTriggered);
        menuHolder.addChild(btnRampage);
        
        btnEndurance = new Button(_globalVO.assets.getTexture("btn_endurance"));
        btnEndurance.width = btnEndurance.width * settings.scaleAdjustment;
        btnEndurance.height = btnEndurance.height * settings.scaleAdjustment;
        btnEndurance.name = Settings.GAME_ENDURANCE;
        btnEndurance.x = btnRampage.x + btnRampage.width + 6;
        btnEndurance.y = btnRampage.y;
        btnEndurance.addEventListener(Event.TRIGGERED, onGameTriggered);
        menuHolder.addChild(btnEndurance);
        //btnEndurance.alpha = 0.8;
        
        //Amount of Letters
        btn9Letters = new Button(_globalVO.assets.getTexture("btn_letters_9_selected"));
        btn9Letters.width = btn9Letters.width * settings.scaleAdjustment;
        btn9Letters.height = btn9Letters.height * settings.scaleAdjustment;
        btn9Letters.name = "9";
        btn9Letters.x = border3.x + border3.width / 2 - btn9Letters.width - BTN_SPACE;
        btn9Letters.y = border3.y + border3.height * 0.33;
        btn9Letters.addEventListener(Event.TRIGGERED, onButtonTriggered);
        menuHolder.addChild(btn9Letters);
        
        btn12Letters = new Button(_globalVO.assets.getTexture("btn_letters_12"));
        btn12Letters.width = btn12Letters.width * settings.scaleAdjustment;
        btn12Letters.height = btn12Letters.height * settings.scaleAdjustment;
        btn12Letters.name = "12";
        btn12Letters.x = border3.x + border3.width / 2 + BTN_SPACE;
        btn12Letters.y = btn9Letters.y;
        btn12Letters.addEventListener(Event.TRIGGERED, onButtonTriggered);
        btn12Letters.alpha = 0.8;
        menuHolder.addChild(btn12Letters);
        
        sliderCharacter = new MovieClip(_globalVO.assets.getTextures("difficulty_goat"));
        sliderCharacter.width = sliderCharacter.width * settings.scaleAdjustment;
        sliderCharacter.height = sliderCharacter.height * settings.scaleAdjustment;
        sliderCharacter.loop = false;
        Starling.current.juggler.add(sliderCharacter);
        sliderCharacter.x = border2.x + (border2.width / 2 - sliderCharacter.width / 2);
        sliderCharacter.y = border2.height * 0.28;
        menuHolder.addChild(sliderCharacter);
        sliderCharacter.stop();
        
        
        txtTopScore = new starling.text.TextField(Std.int(border2.width * 0.8), Std.int(border2.height * 0.09), "");
        txtTopScore.format  = new TextFormat("Arial", settings.fontLarge, 0x663300,"center");
        txtTopScore.autoScale = true;
        txtTopScore.text = "Level 1 Best: " + HighScores.getInstance().getRampageScore(9, 1);
        txtTopScore.x = border2.x + (border2.width / 2 - txtTopScore.width / 2);
        txtTopScore.y = border2.height * 0.22;
        menuHolder.addChild(txtTopScore);
        
        //Difficulty
        sliderBar = new Image(_globalVO.assets.getTexture("gameoption_difficulty"));
        sliderBar.width = sliderBar.width * settings.scaleAdjustment;
        sliderBar.height = sliderBar.height * settings.scaleAdjustment;
        sliderBar.x = border2.x + (border2.width / 2 - sliderBar.width / 2);
        sliderBar.y = border2.height * 0.92;
        menuHolder.addChild(sliderBar);
        
        sliderBtn = new starling.display.Button(_globalVO.assets.getTexture("gameoption_difficulty_slider"));
        sliderBtn.pivotX = sliderBtn.width / 2;
        sliderBtn.width = sliderBtn.width * settings.scaleAdjustment;
        sliderBtn.height = sliderBtn.height * settings.scaleAdjustment;
        sliderBtn.name = "move";
        sliderBtn.x = sliderBar.x + sliderBar.width * 0.05;
        sliderBtn.y = sliderBar.y - sliderBtn.height * 0.4;
        sliderBtn.addEventListener(TouchEvent.TOUCH, onFireTouch);
        menuHolder.addChild(sliderBtn);
        
        sliderLeftX = Std.int(sliderBar.x + sliderBar.width * 0.06);
        sliderRightX = Std.int(sliderBar.x + sliderBar.width - sliderBtn.width / 22);
        sliderLength = Std.int(sliderRightX - sliderLeftX);
        //-----------------
        
        enduranceChar = new Image(_globalVO.assets.getTexture("goat_endurance"));
        enduranceChar.width = enduranceChar.width * settings.scaleAdjustment;
        enduranceChar.height = enduranceChar.height * settings.scaleAdjustment;
        enduranceChar.x = border2.x + (border2.width / 2 - enduranceChar.width / 2);
        enduranceChar.y = border2.height * 0.3;
        menuHolder.addChild(enduranceChar);
        enduranceChar.visible = false;
        
        menuHolder.x = settings.stageWidth / 2 - menuHolder.width / 2;
        menuHolder.y = settings.stageHeight * 0.45 - menuHolder.height / 2;
        this.addChild(menuHolder);
        
        btnOK = new Button(_globalVO.assets.getTexture("btn_start"));
        btnOK.width = btnOK.width * settings.scaleAdjustment;
        btnOK.height = btnOK.height * settings.scaleAdjustment;
        btnOK.x = menuHolder.x + menuHolder.width - btnOK.width * 1.05;
        btnOK.y = menuHolder.y + menuHolder.height + BTN_SPACE * 2;
        btnOK.addEventListener(Event.TRIGGERED, onStartTriggered);
        this.addChild(btnOK);
         
        //Add Hammers
        hammerBronze = new Image(_globalVO.assets.getTexture("difficulty_hammer_bronze"));
        hammerBronze.width = hammerBronze.width * settings.scaleAdjustment;
        hammerBronze.height = hammerBronze.height * settings.scaleAdjustment;
        hammerBronze.x = border2.x + border2.width - hammerBronze.width - BTN_SPACE * 1.7;
        hammerBronze.y = border2.height * 0.61;
        menuHolder.addChild(hammerBronze);
        hammerBronze.visible = false;
        
        hammerSilver = new Image(_globalVO.assets.getTexture("difficulty_hammer_silver"));
        hammerSilver.width = hammerSilver.width * settings.scaleAdjustment;
        hammerSilver.height = hammerSilver.height * settings.scaleAdjustment;
        hammerSilver.x = border2.x + border2.width - hammerSilver.width - BTN_SPACE * 1.7;
        hammerSilver.y = border2.height * 0.61;
        menuHolder.addChild(hammerSilver);
        hammerSilver.visible = false;
        
        hammerGold = new Image(_globalVO.assets.getTexture("difficulty_hammer_gold"));
        hammerGold.width = hammerGold.width * settings.scaleAdjustment;
        hammerGold.height = hammerGold.height * settings.scaleAdjustment;
        hammerGold.x = border2.x + border2.width - hammerGold.width - BTN_SPACE * 1.7;
        hammerGold.y = border2.height * 0.61;
        menuHolder.addChild(hammerGold);
        hammerGold.visible = false;
    }

    private function showEndurance() : Void
    {
        sliderCharacter.visible = false;
        sliderBar.visible = false;
        sliderBtn.visible = false;
        enduranceChar.visible = true;
    }
    
    private function showRampage() : Void
    {
        enduranceChar.visible = false;
        sliderCharacter.visible = true;
        sliderBar.visible = true;
        sliderBtn.visible = true;
    }

    private function onGameTriggered(e : Event) : Void
    {
        var _sw4_ = ((try cast(e.target, Button) catch(e:Dynamic) null).name);        

        switch (_sw4_)
        {
            case Settings.GAME_ENDURANCE:
                btnEndurance.upState = _globalVO.assets.getTexture("btn_endurance_selected");
                btnRampage.upState = _globalVO.assets.getTexture("btn_rampage");
                gameSelected = Settings.GAME_ENDURANCE;
                showEndurance();
            case Settings.GAME_RAMPAGE:
                btnEndurance.upState = _globalVO.assets.getTexture("btn_endurance");
                btnRampage.upState = _globalVO.assets.getTexture("btn_rampage_selected");
                gameSelected = Settings.GAME_RAMPAGE;
                showRampage();
        }
        setScore();
    }

    private function onButtonTriggered(e : Event) : Void
    {
        var _sw5_ = ((try cast(e.target, Button) catch(e:Dynamic) null).name);        

        switch (_sw5_)
        {
            case "9":
                btn9Letters.upState = _globalVO.assets.getTexture("btn_letters_9_selected");
                btn12Letters.upState = _globalVO.assets.getTexture("btn_letters_12");
                letterCountSelected = 9;
            case "12":
                btn9Letters.upState = _globalVO.assets.getTexture("btn_letters_9");
                btn12Letters.upState = _globalVO.assets.getTexture("btn_letters_12_selected");
                letterCountSelected = 12;
            case "16":
                letterCountSelected = 16;
        }
        setScore();
    }

    private function onFireTouch(e : TouchEvent) : Void
    {      
        var touchtest : Touch = e.getTouch(menuHolder);
        if (e.getTouches(sliderBtn, TouchPhase.MOVED).length > 0)
        {
            var xpos : Float = touchtest.getLocation(menuHolder).x;

            if (sliderLeftX <= xpos && sliderRightX >= xpos)
            {
                sliderBtn.x = xpos;
                var val : Float = sliderLength - (sliderRightX - sliderBtn.x);
                var sliderVal : Int = Std.int(val * 100 / sliderLength);
                var perc : Float;

                if (sliderVal > 0 && sliderVal <= 10)
                {
                    difficultyLevel = 1;
                    sliderCharacter.currentFrame = 0;
                }
                else if (sliderVal > 10 && sliderVal <= 20)
                {
                    difficultyLevel = 2;
                    sliderCharacter.currentFrame = 1;
                }
                else if (sliderVal > 20 && sliderVal <= 30)
                {
                    difficultyLevel = 3;
                    sliderCharacter.currentFrame = 2;
                }
                else if (sliderVal > 30 && sliderVal <= 40)
                {
                    difficultyLevel = 4;
                    sliderCharacter.currentFrame = 3;
                }
                else if (sliderVal > 40 && sliderVal <= 50)
                {
                    difficultyLevel = 5;
                    sliderCharacter.currentFrame = 4;
                }
                else if (sliderVal > 50 && sliderVal <= 60)
                {
                    difficultyLevel = 6;
                    sliderCharacter.currentFrame = 5;
                }
                else if (sliderVal > 60 && sliderVal <= 70)
                {
                    difficultyLevel = 7;
                    sliderCharacter.currentFrame = 6;
                }
                else if (sliderVal > 70 && sliderVal <= 80)
                {
                    difficultyLevel = 8;
                    sliderCharacter.currentFrame = 7;
                }
                else if (sliderVal > 80 && sliderVal <= 90)
                {
                    difficultyLevel = 9;
                    sliderCharacter.currentFrame = 8;
                }
                else if (sliderVal > 90 && sliderVal <= 100)
                {
                    difficultyLevel = 10;
                    sliderCharacter.currentFrame = 9;
                }
            }
            
            touchtest = null;
            
            txtTopScore.text = "Level " + difficultyLevel + " Best: " + HighScores.getInstance().getRampageScore(letterCountSelected, difficultyLevel);
            setScore();
        }
    }

    private function onStartTriggered(e : Event) : Void
    {
        GameSettingsVO.getInstance().letterCount = letterCountSelected;
        GameSettingsVO.getInstance().difficultyLevel = difficultyLevel;
        GameSettingsVO.getInstance().gameType = gameSelected;
        
        if (gameSelected == Settings.GAME_ENDURANCE)
        {
            EnduranceVO.getInstance().letterCount = letterCountSelected;
            EnduranceVO.getInstance().selectedLevel = difficultyLevel;
        }
        else
        {
            RampageVO.getInstance().letterCount = letterCountSelected;
            RampageVO.getInstance().selectedLevel = difficultyLevel;
        }

        startGame.dispatch();
    }

    private function onBackTriggered(e : Event) : Void
    {
        navBack.dispatch();
    }

    private function setScore() : Void
    {
        if (gameSelected == Settings.GAME_ENDURANCE)
        {
            txtTopScore.text = " Best: " + HighScores.getInstance().getEnduranceScore(letterCountSelected);
        }
        else
        {
            txtTopScore.text = "Level " + difficultyLevel + " Best: " + HighScores.getInstance().getRampageScore(letterCountSelected, difficultyLevel);
        }
        setHammer();
    }

    private function setHammer() : Void
    {
        hammerBronze.visible = false;
        hammerSilver.visible = false;
        hammerGold.visible = false;
        
        var bestScore : Int = 0;
        if (gameSelected == Settings.GAME_ENDURANCE)
        {
            bestScore = HighScores.getInstance().getEnduranceScore(letterCountSelected);
            
            if (bestScore > 4999 && bestScore <= 9999)
            {
                hammerBronze.visible = true;
            }
            else if (bestScore > 9999 && bestScore <= 19999)
            {
                hammerSilver.visible = true;
            }
            else if (bestScore > 19999)
            {
                hammerGold.visible = true;
            }
        }
        else
        {
            bestScore = HighScores.getInstance().getRampageScore(letterCountSelected, difficultyLevel);
            
            if (bestScore > 999 && bestScore <= 1499)
            {
                hammerBronze.visible = true;
            }
            else if (bestScore > 1499 && bestScore <= 1999)
            {
                hammerSilver.visible = true;
            }
            else if (bestScore > 1999)
            {
                hammerGold.visible = true;
            }
        }
    }

    private function destroy():Void
    {
        this.removeEventListener(Event.REMOVED_FROM_STAGE, destroy);

        backButton.removeEventListener(Event.TRIGGERED, onBackTriggered);

        navBack.removeAll();
        navBack = null;

        startGame.removeAll();
        startGame = null;

    }
}