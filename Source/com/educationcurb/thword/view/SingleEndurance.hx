package com.educationcurb.thword.view;

import as3hx.Compat;

import com.educationcurb.thword.model.GlobalVO;
import com.educationcurb.thword.model.FoundWordVO;
import com.educationcurb.thword.model.EnduranceVO;
import com.educationcurb.thword.model.BandaidVO;

import com.educationcurb.thword.utils.SoundManager;
import com.educationcurb.thword.utils.DictionaryChecker;

import com.educationcurb.thword.view.gamestuff.EnduranceEndPopup;


import js.Browser;
import openfl.media.Sound;
import openfl.utils.Assets;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

import msignal.Signal.Signal0;

import starling.core.Starling;
import starling.display.Button;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;
import starling.extensions.PDParticleSystem;
import starling.extensions.ParticleSystem;
import starling.filters.BlurFilter;
import starling.text.TextField;
import starling.textures.Texture;
import starling.text.TextFormat;
import starling.display.Quad;

class SingleEndurance extends Sprite
{
    private var _globalVO:GlobalVO;
    private var _soundManager:SoundManager; 
    private var settings : Settings = Settings.getInstance();
    public static var BTN_SPACE : Int = 6;

    public static inline var TIME_TRIAL_GAME_SHOW_END : String = "timeTrialGameShowEnd";
    public static inline var TIME_TRIAL_GAME_NAV_BACK : String = "timeTrialGameNavBack";
    public static inline var TIME_TRIAL_GAME_REMOVED : String = "timeTrialGameRemoved";
    
    private static inline var CLEAR : String = "clear";
    private static inline var BACKSPACE : String = "backspace";
    private static inline var CHECK : String = "check";
    
    private var dictionaryChecker : DictionaryChecker;
    
    private var gameData : EnduranceVO;
    
    private var buttonVec : Array<Button>;
    private var sprGrid : Sprite;
    
    private var letters : Array<Dynamic>;
    
    private var currentWord : String;
    public var wordsFoundArr : Array<Dynamic>;
    
    private var gridEndYPos : Float;
    
    private var gameTimer : Timer;
    private var gameTimerAmount : Int;
    private var gameLength : Int = 30;
    
    public var points : Int = 0;
    
    private var btnBack : Button;
    private var btnMusic : Button;
    private var sndSetting : Int = 1;
    
    private var scorePanel : Image;
    private var timePanel : Image;
    private var wordPanel : Image;
    private var scroll : Image;
    private var btnCheck : Button;
    private var btnDelete : Button;
    
    private var txtScore : TextField;
    private var txtWord : TextField;
    
    
    //Background and Border Assets
    private var background : Image;
    private var backButton : Button;
    
    private var endPopup : EnduranceEndPopup;

        //Right / Wrong Answers
    private var rightGoat : MovieClip;
    private var wrongGoat : MovieClip;
    private var rightBubble : Image;
    private var wrongBubble : Image;
    private var txtRight : TextField;
    private var txtWrong : TextField;
    private var answerInterval : Int;
    private var txtPoints : TextField;
    private var pointsInterval : Int;
    
    private var compliments : Array<Dynamic> = ["THORRIFIC!", "GREAT STUFF!", "GOOD WORK!", "AWESOME!"];
    private var insults : Array<Dynamic> = ["YOU SUCK!", "DUMB ASS!", "GET A BRAIN!", "EMBARRASSING!"];
    
    //NEW
    private var bonus4Ltr : Int = 0;
    private var bonus5Ltr : Int = 0;
    private var bonus6Ltr : Int = 0;
    private var bonus7Ltr : Int = 0;
    private var bonus8Ltr : Int = 0;
    private var bonus9Ltr : Int = 0;
    private var bonus10Ltr : Int = 0;
    private var currentBonus : Int = 0;
    
    //Progress
    private var barFullWidth : Float;
    private var centerPoint : Float;
    
    private var sprProgress : Sprite;
    private var progressBarBase : Image;
    private var progressBar : Image;
    //private var progressBarMask:Image;
    
    private var lvlNum : Int = 1;
    private var shieldCover : Quad;
    private var shieldNumber : MovieClip;
    private var shieldAnim : MovieClip;
    private var shield : MovieClip;
    private var thorLvlUp : MovieClip;
    private var shieldInterval : Int;
    
    private var sprBonus : Sprite;
    private var imgBonus : Image;
    private var txtBonus : TextField;
    private var bonusInterval : Int;
    
    private var levelInterval : Int;
    
    private var bandaid : BandaidVO;

    public var navBack:Signal0;

    public function new() 
    {
        super();
        this.addEventListener(Event.REMOVED_FROM_STAGE, destroy);
        navBack = new Signal0();    
    }

    public function init(vo:GlobalVO) 
    {
        _globalVO = vo;

        gameData = EnduranceVO.getInstance();
        //sndSetting = GameSettings.getInstance().getSoundSetting();
        sndSetting = 1;
        
        dictionaryChecker = DictionaryChecker.getInstance();
        
        wordsFoundArr = new Array<Dynamic>();
        currentWord = "";
        
        //Create assets
        createBackgroundAssets();
        configBackParticleSystem();
        createBackButtons();
        addItems();
        configParticleSystem();
        
        /*if(gameData.letterCount == 9)
			{
				createNineLetters();					
			}
			else
			{
				createTwelveLetters();					
			}*/
        
        addRightWrong();
        loadSounds();
        setupLevel();
    }

    private function loadSounds() 
    {
        _soundManager = new SoundManager(_globalVO.soundsArr);   
        _soundManager.playMusic("music", 0.5);
    }

    private function setupLevel() : Void
    {
        gameData.selectedLevel = 1;
        
        trace("gameData.selectedLevel-" + gameData.selectedLevel);
        
        stopProgressParticle();
        progressBar.width = progressBar.width / 2;
        showLevel(1);
    }
    
    private function nextLevel() : Void
    {
        txtWord.text = "";
        
        if (gameData.selectedLevel != 10)
        {
            if (gameTimer != null)
            {
                gameTimer.stop();
                gameTimer.removeEventListener(TimerEvent.TIMER, onGameTimerTick);
                gameTimer = null;
            }
            removeLetters();
            
            var lvlCompletePoints : Int = as3hx.Compat.parseInt(gameData.selectedLevel * 1000);
            points += lvlCompletePoints;
            showPoints(lvlCompletePoints);
            
            levelInterval = as3hx.Compat.setInterval(newLevelPauseStart, 1000);
        }
        else
        {
            //endGame();
            showEnd();
        }
    }
    
    private function newLevelPauseStart() : Void
    {
        as3hx.Compat.clearInterval(levelInterval);
        
        stopProgressParticle();
        
        
        createThorLevelEnd();
        
        
        levelInterval = as3hx.Compat.setInterval(triggerNewLevel, 1000);
    }
    
    private function triggerNewLevel() : Void
    {
        as3hx.Compat.clearInterval(levelInterval);
        
        gameData.selectedLevel = gameData.selectedLevel + 1;
        
        progressBar.width = barFullWidth / 2;
        showLevel(gameData.selectedLevel, false);
    }
    
    //SHIELD
    private function showLevel(num : Int, createCover : Bool = true) : Void
    {
        createShield(createCover);
        
        shield.currentFrame = num - 1;
        //shield.stop();
        
        shieldNumber.currentFrame = num - 1;
        //shieldNumber.stop();
        
        shieldAnim.alpha = 1;
        shieldAnim.currentFrame = 0;
        shieldAnim.visible = true;
        shieldAnim.play();
        
        if (sndSetting != 3)
        {
            _soundManager.play("whoosh");
            //sndShield.play();
        }
    }
    
    private function createThorLevelEnd() : Void
    {
        var coverBottomColor : Int = 0x000000;
        var coverTopColor : Int = 0x000000;
        shieldCover = new Quad(settings.stageWidth, settings.stageHeight);
        shieldCover.setVertexColor(0, coverTopColor);
        shieldCover.setVertexColor(1, coverTopColor);
        shieldCover.setVertexColor(2, coverBottomColor);
        shieldCover.setVertexColor(3, coverBottomColor);
        shieldCover.alpha = 0.7;
        this.addChild(shieldCover);
        shieldCover.visible = true;
        
        thorLvlUp = new MovieClip(_globalVO.assets.getTextures("thor_levelup_bell"));
        thorLvlUp.width = thorLvlUp.width * settings.scaleAdjustment;
        thorLvlUp.height = thorLvlUp.height * settings.scaleAdjustment;
        thorLvlUp.loop = false;
        Starling.current.juggler.add(thorLvlUp);
        thorLvlUp.x = settings.stageWidth - thorLvlUp.width;
        thorLvlUp.y = settings.stageHeight - thorLvlUp.height;
        this.addChild(thorLvlUp);
        thorLvlUp.play();
        
        if (sndSetting != 3)
        {
            _soundManager.play("bell");
            //sndBell.play();
        }
    }
    
    private function createShield(createCover : Bool) : Void
    {
        if (createCover)
        {
            var coverBottomColor : Int = 0x000000;
            var coverTopColor : Int = 0x000000;
            shieldCover = new Quad(settings.stageWidth, settings.stageHeight);
            shieldCover.setVertexColor(0, coverTopColor);
            shieldCover.setVertexColor(1, coverTopColor);
            shieldCover.setVertexColor(2, coverBottomColor);
            shieldCover.setVertexColor(3, coverBottomColor);
            shieldCover.alpha = 0.7;
            this.addChild(shieldCover);
            shieldCover.visible = true;
        }
        
        //Shield Stuff
        shieldAnim = new MovieClip(_globalVO.assets.getTextures("levelup_shield_large"));
        shieldAnim.width = shieldAnim.width * settings.scaleAdjustment;
        shieldAnim.height = shieldAnim.height * settings.scaleAdjustment;
        shieldAnim.loop = false;
        Starling.current.juggler.add(shieldAnim);
        shieldAnim.x = settings.stageWidth / 2 - shieldAnim.width / 2;
        shieldAnim.y = settings.stageHeight / 2 - shieldAnim.height / 2;
        this.addChild(shieldAnim);
        shieldAnim.stop();
        shieldAnim.visible = false;
        shieldAnim.addEventListener(Event.COMPLETE, showShieldNumber);
        
        shieldNumber = new MovieClip(_globalVO.assets.getTextures("level_numbers_"));
        shieldNumber.width = shieldNumber.width * settings.scaleAdjustment;
        shieldNumber.height = shieldNumber.height * settings.scaleAdjustment;
        shieldNumber.loop = false;
        Starling.current.juggler.add(shieldNumber);
        shieldNumber.x = settings.stageWidth / 2 - shieldNumber.width / 2;
        shieldNumber.y = settings.stageHeight / 2 - shieldNumber.height / 1.6;
        this.addChild(shieldNumber);
        shieldNumber.stop();
        shieldNumber.visible = false;
    }
    
    private function removeShield() : Void
    {
        shieldAnim.removeEventListener(Event.COMPLETE, showShieldNumber);
        Starling.current.juggler.remove(shieldAnim);
        this.removeChild(shieldAnim);
        shieldAnim = null;
        this.removeChild(shieldNumber);
        shieldNumber = null;
        
        this.removeChild(thorLvlUp);
        Starling.current.juggler.remove(thorLvlUp);
        thorLvlUp = null;
        
        this.removeChild(shieldCover);
        shieldCover = null;
    }
    
    
    
    private function showShieldNumber(e : Event) : Void
    {
        //shieldNumber.alpha = 0;
        shieldNumber.visible = true;
        /*TweenMax.to(shieldNumber, 0.3, {
                    alpha : 1
                });*/
        
        playShieldParticle();
        
        if (sndSetting != 3)
        {
            _soundManager.play("explosion");
            //sndExplosion.play();
        }
        
        shieldInterval = as3hx.Compat.setInterval(fadeShield, 1000);
    }
    
    private function fadeShield() : Void
    {
        as3hx.Compat.clearInterval(shieldInterval);
        /*TweenMax.to(shieldNumber, 0.3, {
                    alpha : 0
                });
        TweenMax.to(shieldAnim, 0.3, {
                    alpha : 0
                });*/
        shieldInterval = as3hx.Compat.setInterval(onShowLevelComplete, 300);
    }
    
    private function onShowLevelComplete() : Void
    {
        as3hx.Compat.clearInterval(shieldInterval);
        startTimer();
    }
    
    //GAME LOGIC
    private function startTimer() : Void
    {
        removeShield();
        if (gameData.letterCount == 9)
        {
            createNineLetters();
        }
        else
        {
            createTwelveLetters();
        }
        
        gameTimerAmount = 0;
        
        gameTimer = new Timer(1000);
        gameTimer.addEventListener(TimerEvent.TIMER, onGameTimerTick);
        gameTimer.start();
        
        playProgressParticle();
    }
    
    private function onGameTimerTick(e : TimerEvent) : Void
    {
        gameTimerAmount++;
        setProgressBar(gameTimerAmount, gameLength);
    }
    
    //BONUSES ////////////////////////////////////////////////////
    private function checkBonus(wordLen : Int) : Int
    {
        var bonusPoints : Int = 0;
        
        switch (wordLen)
        {
            case 4:
                if (wordLen == currentBonus)
                {
                    bonus4Ltr++;
                }
                else
                {
                    clearBonuses();
                    bonus4Ltr++;
                }
                
                if (bonus4Ltr == 2)
                {
                    //sndFactory.playSoundEffect(new bonus());
                    
                    clearBonuses();
                    //gameHeader.showBonus("DOUBLE 4 LETTER BONUS");
                    txtBonus.text = "DOUBLE 4 LETTER BONUS";
                    sprBonus.visible = true;
                    gameTimerAmount -= 10;
                    bonusPoints += 10;
                    bonusInterval = as3hx.Compat.setInterval(hideBonusDisplay, 1500);
                }
            case 5:
                if (wordLen == currentBonus)
                {
                    bonus5Ltr++;
                }
                else
                {
                    clearBonuses();
                    bonus5Ltr++;
                }
                
                if (bonus5Ltr == 2)
                {
                    //sndFactory.playSoundEffect(new bonus());
                    clearBonuses();
                    //gameHeader.showBonus("DOUBLE 5 LETTER BONUS");
                    txtBonus.text = "DOUBLE 5 LETTER BONUS";
                    sprBonus.visible = true;
                    gameTimerAmount -= 12;
                    bonusPoints += 12;
                    bonusInterval = as3hx.Compat.setInterval(hideBonusDisplay, 1500);
                }
            case 6:
                if (wordLen == currentBonus)
                {
                    bonus6Ltr++;
                }
                else
                {
                    clearBonuses();
                    bonus6Ltr++;
                }
                
                if (bonus6Ltr == 2)
                {
                    //sndFactory.playSoundEffect(new bonus());
                    clearBonuses();
                    //gameHeader.showBonus("DOUBLE 6 LETTER BONUS");
                    txtBonus.text = "DOUBLE 6 LETTER BONUS";
                    sprBonus.visible = true;
                    gameTimerAmount -= 15;
                    bonusPoints += 15;
                    bonusInterval = as3hx.Compat.setInterval(hideBonusDisplay, 1500);
                }
            case 7:
                if (wordLen == currentBonus)
                {
                    bonus7Ltr++;
                }
                else
                {
                    clearBonuses();
                    bonus7Ltr++;
                }
                
                if (bonus7Ltr == 2)
                {
                    //sndFactory.playSoundEffect(new bonus());
                    clearBonuses();
                    //gameHeader.showBonus("DOUBLE 7 LETTER BONUS");
                    txtBonus.text = "DOUBLE 7 LETTER BONUS";
                    sprBonus.visible = true;
                    gameTimerAmount -= 20;
                    bonusPoints += 20;
                    bonusInterval = as3hx.Compat.setInterval(hideBonusDisplay, 1500);
                }
            case 8:
                if (wordLen == currentBonus)
                {
                    bonus8Ltr++;
                }
                else
                {
                    clearBonuses();
                    bonus8Ltr++;
                }
                
                if (bonus8Ltr == 2)
                {
                    //sndFactory.playSoundEffect(new bonus());
                    clearBonuses();
                    //gameHeader.showBonus("DOUBLE 8 LETTER BONUS");
                    txtBonus.text = "DOUBLE 8 LETTER BONUS";
                    sprBonus.visible = true;
                    gameTimerAmount -= 20;
                    bonusPoints += 20;
                    bonusInterval = as3hx.Compat.setInterval(hideBonusDisplay, 1500);
                }
            case 9:
                if (wordLen == currentBonus)
                {
                    bonus9Ltr++;
                }
                else
                {
                    clearBonuses();
                    bonus9Ltr++;
                }
                
                if (bonus9Ltr == 2)
                {
                    //sndFactory.playSoundEffect(new bonus());
                    clearBonuses();
                    //gameHeader.showBonus("DOUBLE 9 LETTER BONUS");
                    txtBonus.text = "DOUBLE 9 LETTER BONUS";
                    sprBonus.visible = true;
                    gameTimerAmount -= 25;
                    bonusPoints += 25;
                    bonusInterval = as3hx.Compat.setInterval(hideBonusDisplay, 1500);
                }
            case 10:
                if (wordLen == currentBonus)
                {
                    bonus10Ltr++;
                }
                else
                {
                    clearBonuses();
                    bonus10Ltr++;
                }
                
                if (bonus10Ltr == 2)
                {
                    //sndFactory.playSoundEffect(new bonus());
                    clearBonuses();
                    //gameHeader.showBonus("DOUBLE 10 LETTER BONUS");
                    txtBonus.text = "DOUBLE 10 LETTER BONUS";
                    sprBonus.visible = true;
                    gameTimerAmount -= 25;
                    bonusPoints += 25;
                    bonusInterval = as3hx.Compat.setInterval(hideBonusDisplay, 1500);
                }
        }
        currentBonus = wordLen;
        
        return bonusPoints;
    }
    
    private function hideBonusDisplay() : Void
    {
        as3hx.Compat.clearInterval(bonusInterval);
        txtBonus.text = "";
        sprBonus.visible = false;
    }
    
    private function clearBonuses() : Void
    {
        bonus4Ltr = 0;
        bonus5Ltr = 0;
        bonus6Ltr = 0;
        bonus7Ltr = 0;
        bonus8Ltr = 0;
        bonus9Ltr = 0;
        bonus10Ltr = 0;
    }
    
    
    //ASSETS /////////////////////////////////////////////////////
    private function createBackgroundAssets() : Void
    {
        background = new Image(_globalVO.assets.getTexture("thword_game-screen_bg"));
        //background.width = background.width * settings.scaleAdjustmentMinor;
        //background.height = background.height * settings.scaleAdjustmentMinor;
        background.x = settings.stageWidth / 2 - background.width / 2;
        background.y = settings.stageHeight - background.height;
        this.addChild(background);
    }
    
    private function createBackButtons() : Void
    {
        //Back Button
        backButton = new Button(_globalVO.assets.getTexture("btn_back"));
        this.addChild(backButton);
        //backButton.width = backButton.width * settings.scaleAdjustment;
        //backButton.height = backButton.height * settings.scaleAdjustment;
        backButton.x = BTN_SPACE;
        backButton.y = BTN_SPACE;
        backButton.addEventListener(Event.TRIGGERED, onBackTriggered);



        if (sndSetting == 1)
        {
            btnMusic = new Button(_globalVO.assets.getTexture("btn_sound"));
        }
        else if (sndSetting == 2)
        {
            btnMusic = new Button(_globalVO.assets.getTexture("btn_sound_mutemusic"));
        }
        else if (sndSetting == 3)
        {
            btnMusic = new Button(_globalVO.assets.getTexture("btn_sound_mute"));
        }
        this.addChild(btnMusic);
        //btnMusic.width = btnMusic.width * settings.scaleAdjustment;
        //btnMusic.height = btnMusic.height * settings.scaleAdjustment;
        btnMusic.x = backButton.x + backButton.width + BTN_SPACE;
        btnMusic.y = BTN_SPACE;
        btnMusic.addEventListener(Event.TRIGGERED, onMusicTriggered);

    }
    
    private function onMusicTriggered(e : Event) : Void
    {

        if (sndSetting == 1)
        {
            sndSetting++;
            btnMusic.upState = _globalVO.assets.getTexture("btn_sound_mutemusic");
            _soundManager.stopMusic("music");
        }
        else if (sndSetting == 2)
        {
            sndSetting++;
            btnMusic.upState = _globalVO.assets.getTexture("btn_sound_mute");
            _soundManager.stopMusic("music");
        }
        else if (sndSetting == 3)
        {
            sndSetting = 1;
            btnMusic.upState = _globalVO.assets.getTexture("btn_sound");
            _soundManager.playMusic("music", 0.5);
        }
    }
    
    private function addItems() : Void
    {
        
        scorePanel = new Image(_globalVO.assets.getTexture("game_panel_score"));
        scorePanel.width = scorePanel.width * settings.scaleAdjustment;
        scorePanel.height = scorePanel.height * settings.scaleAdjustment;
        scorePanel.x = settings.stageWidth - scorePanel.width - BTN_SPACE;
        scorePanel.y = BTN_SPACE;
        this.addChild(scorePanel);

        var format:TextFormat = new TextFormat("Arial", settings.fontExLarge, 0xFFFFFF,"center");
        txtScore = new starling.text.TextField(Std.int(scorePanel.width * 0.8), Std.int(scorePanel.height * 0.8), "");
        txtScore.format = format;
        txtScore.autoScale = true;
        txtScore.text = "0";
        txtScore.x = scorePanel.x + scorePanel.width * 0.2 + (scorePanel.width / 2 - txtScore.width / 2);
        txtScore.y = scorePanel.y + scorePanel.height / 2 - txtScore.height / 2;
        this.addChild(txtScore);
        
        //Add ProgressBar
        addProgressBar();
        
        
        //Bonus
        sprBonus = new Sprite();
        imgBonus = new Image(_globalVO.assets.getTexture("bonus_bg"));
        sprBonus.addChild(imgBonus);

        var bonusFormat:TextFormat = new TextFormat("Arial", settings.fontExLarge, 0xFFFFFF,"center");
        txtBonus = new starling.text.TextField(Std.int(imgBonus.width * 0.75), Std.int(imgBonus.height * 0.6), "");
        txtBonus.format = bonusFormat;
        txtBonus.autoScale = true;
        txtBonus.text = "";
        txtBonus.x = imgBonus.width / 2 - txtBonus.width / 2;
        txtBonus.y = imgBonus.height / 2 - txtBonus.height / 2;
        sprBonus.addChild(txtBonus);
        
        sprBonus.width = sprBonus.width * settings.scaleAdjustment;
        sprBonus.height = sprBonus.height * settings.scaleAdjustment;
        sprBonus.x = sprProgress.x + (sprProgress.width / 2 - sprBonus.width / 2);
        sprBonus.y = sprProgress.y + sprBonus.height * 0.5;
        this.addChild(sprBonus);
        sprBonus.visible = false;
        
        //Word creation panel
        wordPanel = new Image(_globalVO.assets.getTexture("game_panel_word"));
        wordPanel.width = wordPanel.width * settings.scaleAdjustment;
        wordPanel.height = wordPanel.height * settings.scaleAdjustment;
        wordPanel.x = settings.stageWidth / 2 - wordPanel.width * 0.66;
        wordPanel.y = sprProgress.y + sprProgress.height + BTN_SPACE * 4;
        this.addChild(wordPanel);

        var wordFormat:TextFormat = new TextFormat("Arial", settings.fontExLarge, 0xFFFFFF,"center");
        txtWord = new starling.text.TextField(Std.int(wordPanel.width * 0.95), Std.int(wordPanel.height * 0.5), "");
        txtWord.format = wordFormat;
        txtWord.autoScale = true;
        txtWord.text = "";
        txtWord.x = wordPanel.x + (wordPanel.width / 2 - txtWord.width / 2);
        txtWord.y = wordPanel.y + (wordPanel.height / 2 - txtWord.height / 2);
        this.addChild(txtWord);
        
        //Letters
        scroll = new Image(_globalVO.assets.getTexture("game_panel_wordsbg"));
        scroll.width = scroll.width * settings.scaleAdjustment;
        scroll.height = scroll.height * settings.scaleAdjustment;
        scroll.x = wordPanel.x;
        scroll.y = wordPanel.y + wordPanel.height + BTN_SPACE * 2;
        this.addChild(scroll);
        
        //Buttons
        btnDelete = new Button(_globalVO.assets.getTexture("btn_backspace"));
        btnDelete.width = btnDelete.width * settings.scaleAdjustment;
        btnDelete.height = btnDelete.height * settings.scaleAdjustment;
        btnDelete.x = wordPanel.x + wordPanel.width + BTN_SPACE;
        btnDelete.y = wordPanel.y;
        btnDelete.addEventListener(Event.TRIGGERED, onClearLetter);
        this.addChild(btnDelete);
        //btnDelete.filter = BlurFilter.createDropShadow(1.0, 1.8, 0x000000, 0.5, 1.5);
        
        btnCheck = new Button(_globalVO.assets.getTexture("btn_check"));
        btnCheck.width = btnCheck.width * settings.scaleAdjustment;
        btnCheck.height = btnCheck.height * settings.scaleAdjustment;
        btnCheck.x = wordPanel.x + wordPanel.width + BTN_SPACE;
        btnCheck.y = wordPanel.y + wordPanel.height;
        btnCheck.addEventListener(Event.TRIGGERED, onCheckWord);
        this.addChild(btnCheck);
        //btnCheck.filter = BlurFilter.createDropShadow(1.0, 1.8, 0x000000, 0.5, 1.5);

        txtPoints = new starling.text.TextField(Std.int(scorePanel.width * 0.8), Std.int(scorePanel.height * 0.6), "");
        txtPoints.format = new TextFormat("Arial", settings.fontLarge, 0xFFFFFF,"center");
        txtPoints.autoScale = true;
        txtPoints.text = "";
        txtPoints.x = scorePanel.x + scorePanel.width * 0.2 + (scorePanel.width / 2 - txtPoints.width / 2);
        txtPoints.y = scorePanel.y + scorePanel.height + BTN_SPACE;
        this.addChild(txtPoints);
        
        
        
        
        shield = new MovieClip(_globalVO.assets.getTextures("levelup_shield_small"));
        shield.width = shield.width * settings.scaleAdjustment * 0.8;
        shield.height = shield.height * settings.scaleAdjustment * 0.8;
        shield.loop = false;
        Starling.current.juggler.add(shield);
        shield.x = backButton.x;
        shield.y = scorePanel.y + scorePanel.height;
        this.addChild(shield);
        shield.stop();
    }
    
    //PROGRESS BAR *******************************************************
    private function addProgressBar() : Void
    {
        sprProgress = new Sprite();
        progressBarBase = new Image(_globalVO.assets.getTexture("endurance_panel"));
        sprProgress.addChild(progressBarBase);
        
        //progressBar = new Image (Root.assets.getTexture("endurance_progressbar"));
        progressBar = new Image(_globalVO.assets.getTexture("endurance_loadingbar"));
        progressBar.x = progressBarBase.width * 0.132;
        progressBar.y = progressBarBase.height / 2 - progressBar.height / 2.2;
        sprProgress.addChild(progressBar);
        
        sprProgress.width = sprProgress.width * settings.scaleAdjustment;
        sprProgress.height = sprProgress.height * settings.scaleAdjustment;
        sprProgress.x = settings.stageWidth / 2 - sprProgress.width * 0.6;
        sprProgress.y = scorePanel.y;
        this.addChild(sprProgress);
        
        
        
        
        //Set Progressbar
        barFullWidth = progressBar.width;
        centerPoint = progressBar.width / 2;
    }
    
    private function setProgressBar(timerAmount : Int, gameLength : Int) : Void
    {
        var diff : Int = 0;
        if (timerAmount < 0)
        {
            diff = as3hx.Compat.parseInt(timerAmount * -1);
        }
        else
        {
            diff = timerAmount;
        }
        
        var perc : Float = diff / gameLength * 100;
        var xAmount : Float = (centerPoint) * perc / 100;
        
        if (timerAmount < 0)
        {
            if (perc >= 100)
            {
                progressBar.width = barFullWidth;
                progressSys.emitterX = progressBar.x + progressBar.width;
                //sendEvent(HEADER_NEXT_LEVEL);
                nextLevel();
                trace("NEXT LEVEL");
            }
            else
            {
                progressBar.width = centerPoint + xAmount;
                progressSys.emitterX = progressBar.x + progressBar.width;
            }
        }
        else
        {
            if (perc >= 100)
            {
                progressBar.width = 0;
                //sendEvent(HEADER_END_GAME);

                trace("END GAME!");
                //endGame();
                showEnd();
            }
            else
            {
                progressBar.width = centerPoint - xAmount;
                progressSys.emitterX = progressBar.x + progressBar.width;
            }
        }
    }
    
    //PROGRESS BAR *******************************************************
    
    
    
    private function addRightWrong() : Void
    {
        var adj : Float = settings.scaleAdjustment * 0.7;
        
        //Answer Animations
        rightGoat = new MovieClip(_globalVO.assets.getTextures("goat_combo"));
        rightGoat.width = rightGoat.width * adj * 1.3;
        rightGoat.height = rightGoat.height * adj * 1.3;
        rightGoat.loop = false;
        Starling.current.juggler.add(rightGoat);
        rightGoat.x = settings.stageWidth - rightGoat.width - BTN_SPACE;
        rightGoat.y = settings.stageHeight - rightGoat.height;
        this.addChild(rightGoat);
        rightGoat.stop();
        rightGoat.visible = false;
        
        wrongGoat = new MovieClip(_globalVO.assets.getTextures("goat_repeatword"));
        wrongGoat.width = wrongGoat.width * adj * 1.3;
        wrongGoat.height = wrongGoat.height * adj * 1.3;
        wrongGoat.loop = false;
        Starling.current.juggler.add(wrongGoat);
        wrongGoat.x = settings.stageWidth - wrongGoat.width - BTN_SPACE;
        wrongGoat.y = settings.stageHeight - wrongGoat.height;
        this.addChild(wrongGoat);
        wrongGoat.stop();
        wrongGoat.visible = false;
        
        //Answer Bubbles
        rightBubble = new Image(_globalVO.assets.getTexture("speechbubble_combo"));
        rightBubble.width = rightBubble.width * adj;
        rightBubble.height = rightBubble.height * adj;
        rightBubble.x = rightGoat.x - rightBubble.width * 0.7;
        rightBubble.y = rightGoat.y + rightBubble.height * 0.05;
        this.addChild(rightBubble);
        rightBubble.visible = false;
        
        wrongBubble = new Image(_globalVO.assets.getTexture("speechbubble_repeatword"));
        wrongBubble.width = wrongBubble.width * adj;
        wrongBubble.height = wrongBubble.height * adj;
        wrongBubble.x = wrongGoat.x - wrongBubble.width / 2;
        wrongBubble.y = wrongGoat.y + wrongBubble.height * 0.2;
        this.addChild(wrongBubble);
        wrongBubble.visible = false;
        
        //Answer Text
        txtRight = new starling.text.TextField(Std.int(rightBubble.width * 0.8), Std.int(rightBubble.height * 0.5), "");
        txtRight.format = new TextFormat("Arial", settings.fontMedium, 0x000000,"center");
        txtRight.autoScale = true;
        txtRight.text = "";
        txtRight.x = rightBubble.x + (rightBubble.width / 2 - txtRight.width / 2);
        txtRight.y = rightBubble.y + (rightBubble.height / 2 - txtRight.height / 2);
        this.addChild(txtRight);
        //txtRight.visible = false;
        
        txtWrong = new starling.text.TextField(Std.int(wrongBubble.width * 0.95), Std.int(wrongBubble.height * 0.8), "");
        txtWrong.format = new TextFormat("Arial", settings.fontMedium, 0x000000,"center");
        txtWrong.autoScale = true;
        txtWrong.text = "";
        txtWrong.x = wrongBubble.x + (wrongBubble.width / 2 - txtWrong.width / 2);
        txtWrong.y = wrongBubble.y + (wrongBubble.height / 2 - txtWrong.height / 2);
        this.addChild(txtWrong);
    }
    
    private function createNineLetters() : Void
    {
        letters = gameData.getLetters();
        //trace("9-" + Std.string(letters));
        
        buttonVec = new Array<Button>();
        sprGrid = new Sprite();
        
        var xpos : Float = 0;
        var ypos : Float = 0;
        
        var btn : Button;
        var i : Int = 1;
        while (i <= letters.length)
        {
            btn = new Button(_globalVO.assets.getTexture("game_tile_word"), Std.string(letters[i - 1]));
            btn.textFormat = new TextFormat("Arial", settings.fontSuperLarge, 0xFFFFFF,"center");
            btn.width = btn.width * settings.scaleAdjustment;
            btn.height = btn.height * settings.scaleAdjustment;
            btn.name = Std.string(letters[i - 1]);
            btn.x = xpos;
            btn.y = ypos;
            btn.addEventListener(Event.TRIGGERED, onLetterClick);
            sprGrid.addChild(btn);
            buttonVec.push(btn);
            
            // x/y pos
            if (i % 3 == 0)
            {
                if (i == 0)
                {
                    xpos += btn.width + 5;
                }
                else
                {
                    xpos = 0;
                    ypos += btn.height + 5;
                }
            }
            else
            {
                xpos += btn.width + 5;
            }
            i++;
        }
        
        
        sprGrid.x = scroll.x + (scroll.width / 2 - sprGrid.width / 2);
        sprGrid.y = scroll.y + (scroll.height / 2 - sprGrid.height / 2);
        this.addChild(sprGrid);
    }
    
    private function createTwelveLetters() : Void
    {
        letters = gameData.getLetters();
        //trace("12-" + Std.string(letters));
        
        buttonVec = new Array<Button>();
        sprGrid = new Sprite();
        
        var xpos : Float = 0;
        var ypos : Float = 0;
        
        var btn : Button;
        var i : Int = 1;
        while (i <= letters.length)
        {
            btn = new Button(_globalVO.assets.getTexture("game_tile_word"), Std.string(letters[i - 1]));
            btn.textFormat = new TextFormat("Arial", settings.fontSuperLarge, 0xFFFFFF,"center");
            btn.width = btn.width * settings.scaleAdjustment;
            btn.height = btn.height * settings.scaleAdjustment;
            btn.name = Std.string(letters[i - 1]);
            btn.x = xpos;
            btn.y = ypos;
            btn.addEventListener(Event.TRIGGERED, onLetterClick);
            sprGrid.addChild(btn);
            buttonVec.push(btn);
            
            // x/y pos
            if (i % 4 == 0)
            {
                if (i == 0)
                {
                    xpos += btn.width + 5;
                }
                else
                {
                    xpos = 0;
                    ypos += btn.height + 5;
                }
            }
            else
            {
                xpos += btn.width + 5;
            }
            i++;
        }
        
        sprGrid.x = scroll.x + (scroll.width / 2 - sprGrid.width / 2);
        sprGrid.y = scroll.y + (scroll.height / 2 - sprGrid.height / 2);
        this.addChild(sprGrid);
    }
    
    private function removeLetters() : Void
    {
        if (buttonVec != null)
        {
            var i : Int = as3hx.Compat.parseInt(buttonVec.length - 1);
            while (i >= 0)
            {
                buttonVec[i].removeEventListener(Event.TRIGGERED, onLetterClick);
                sprGrid.removeChild(buttonVec[i]);
                buttonVec[i] = null;
                buttonVec.splice(i, 1);
                i--;
            }
            buttonVec = null;
        }
    }
    
    private function onLetterClick(e : Event) : Void
    {
        if (sndSetting != 3)
        {
            _soundManager.play("click");
            //sndClick.play();
        }
        
        var btn : Button = try cast(e.target, Button) catch(e:Dynamic) null;
        
        playLetterLight(btn.x + btn.width / 2, btn.y + btn.height / 2);
        
        var let : String = btn.name;
        
        var xpos : Float = btn.x;
        var ypos : Float = btn.y;
        
        currentWord += let;
        txtWord.text = currentWord;
        
        /*TweenMax.to(btn, 0.2, {
                    alpha : 0
                });
        TweenMax.to(btn, 0.2, {
                    alpha : 0
                });*/
        
        var newLetter : String = gameData.getNewLetter(let);
        btn.name = newLetter;
        btn.text = newLetter;
        
        /*TweenMax.to(btn, 1, {
                    alpha : 1
                });
        TweenMax.to(btn, 1, {
                    alpha : 1
                });*/
    }
    
    //GAME LOGIC ------------------------------------------
    private function onClearLetter(e : Event) : Void
    {
        var showMinusPoints : Bool = false;
        
        var currentWordLength : Int = currentWord.length;
        
        if (currentWord != "")
        {
            currentWord = currentWord.substring(0, currentWord.length - 1);
            
            if (points > 0)
            {
                showMinusPoints = true;
            }
            
            var testZero : Int = as3hx.Compat.parseInt(points - 10);
            if (testZero < 0)
            {
                points = 0;
            }
            else
            {
                points -= 10;
            }
            
            txtScore.text = Std.string(points);
            txtWord.text = currentWord;

            if (sndSetting != 3)
            {
                _soundManager.play("backspace");
                //sndBackspace.play();
            }
        }
        
        /*if (points != 0 && currentWordLength != 0)
        {

            
            playScoreCheckWrong();
        }*/
        
        if (showMinusPoints)
        {
            gameTimerAmount += 1;
            showPoints(-10);
        }
    }

    private function showPoints(p : Float) : Void
    {
        txtPoints.y = scorePanel.y + scorePanel.height + BTN_SPACE;
        
        if (pointsInterval != 0)
        {
            as3hx.Compat.clearInterval(pointsInterval);
        }
        
        if (p > 0)
        {
            txtPoints.text = "+" + Std.string(p);
            pointsInterval = as3hx.Compat.setInterval(movePoints, 1000);
        }
        else
        {
            txtPoints.text = Std.string(p);
            if (p == -10)
            {
                pointsInterval = as3hx.Compat.setInterval(movePoints, 500);
            }
            else
            {
                pointsInterval = as3hx.Compat.setInterval(movePoints, 1000);
            }
        }
    }
    
    private function movePoints() : Void
    {
        as3hx.Compat.clearInterval(pointsInterval);
        
        pointsInterval = as3hx.Compat.setInterval(hidePoints, 100);
    }
    
    private function hidePoints() : Void
    {
        as3hx.Compat.clearInterval(pointsInterval);
        txtPoints.text = "";
        txtScore.text = Std.string(points);
    }
    
    private function onCheckWord(e : Event) : Void
    {
        txtWord.text = "";
        
        var foundWord : FoundWordVO = new FoundWordVO();
        
        var showThePoints : Bool = false;
        var pointsEarned : Float = 0;
        
        _soundManager.play("click");
        
        if (currentWord != "")
        {
            var correct : Bool = dictionaryChecker.checkWord(currentWord);
            var pointsVal : Int = 0;
            
            if (correct)
            {
                if (checkDuplicate())
                {
                    clearBonuses();
                    if (sndSetting != 3)
                    {
                        _soundManager.play("repeat");
                        //sndRepeat.play();
                    }
                    showWrong(true);
                    foundWord.duplicate = true;
                }
                else
                {
                    showRight();
                    pointsVal = dictionaryChecker.checkPoints(currentWord.length);
                    points += pointsVal;
                    gameTimerAmount -= as3hx.Compat.parseInt(pointsVal / 10);
                    foundWord.duplicate = false;
                    
                    var bon : Int = checkBonus(currentWord.length);
                    points += bon;
                    
                    pointsEarned = pointsVal + bon;
                    showThePoints = true;
                }
                
                foundWord.correct = true;
                foundWord.points = pointsVal;
                foundWord.word = currentWord;
                wordsFoundArr.push(foundWord);
            }
            else
            {
                clearBonuses();
                
                showWrong();
                
                pointsVal = as3hx.Compat.parseInt(0 - dictionaryChecker.checkPoints(currentWord.length));
                
                if (points > 0)
                {
                    pointsEarned = pointsVal;
                    showThePoints = true;
                }
                
                gameTimerAmount += (dictionaryChecker.checkTimePoints(currentWord.length));
                
                var testZero : Int = as3hx.Compat.parseInt(points + pointsVal);
                if (testZero < 0)
                {
                    points = 0;
                }
                else
                {
                    points += pointsVal;
                }
                
                foundWord.correct = false;
                foundWord.duplicate = true;
                foundWord.points = pointsVal;
                foundWord.word = currentWord;
                wordsFoundArr.push(foundWord);
            }
            //gameHeader.setPoints(points, pointsVal);
            //txtScore.text = points.toString();
            
            if (showThePoints)
            {
                showPoints(pointsEarned);
            }
            
            
            
            currentWord = "";
        }
    }
    
    private function checkDuplicate() : Bool
    {
        var found : Bool = false;
        
        for (vo in wordsFoundArr)
        {
            if (vo.word == currentWord)
            {
                found = true;
                break;
            }
        }
        
        return found;
    }
    
    //RIGHT / WRONG
    private function showRight() : Void
    {
        if (sndSetting != 3)
        {
            _soundManager.play("right");
            //sndRight.play();
        }
        playScoreCheckRight();
        
        var ran : Int = as3hx.Compat.parseInt(Math.random() * compliments.length);
        
        rightGoat.visible = true;
        rightGoat.currentFrame = 0;
        rightGoat.play();
        rightBubble.visible = true;
        txtRight.text = compliments[ran];
        
        
        //txtRight.visible = true;
        answerInterval = as3hx.Compat.setInterval(hideRight, 1500);
    }
    
    private function hideRight() : Void
    {
        as3hx.Compat.clearInterval(answerInterval);
        rightGoat.visible = false;
        rightBubble.visible = false;
        txtRight.text = "";
    }
    
    private function showWrong(repeat : Bool = false) : Void
    {
        if (!repeat)
        {
            if (sndSetting != 3)
            {
                _soundManager.play("wrong");
                //sndWrong.play();
            }
            playScoreCheckWrong();
        }
        
        var ran : Int = as3hx.Compat.parseInt(Math.random() * insults.length);
        wrongGoat.visible = true;
        wrongGoat.currentFrame = 0;
        wrongGoat.play();
        wrongBubble.visible = true;
        
        if (!repeat)
        {
            txtWrong.text = insults[ran];
        }
        else
        {
            txtWrong.text = "REPEAT!";
        }
        
        answerInterval = as3hx.Compat.setInterval(hideWrong, 1500);
    }
    
    private function hideWrong() : Void
    {
        as3hx.Compat.clearInterval(answerInterval);
        wrongGoat.visible = false;
        wrongBubble.visible = false;
        txtWrong.text = "";
    }
    
    private function showEnd() : Void
    {
        if (points >= 5000)
        {
            //startBonusSpin();
            playEndParticle();
        }
        else
        {
            endGame();
            //startBonusSpin();
            playEndParticle();
        }
    }
    
    //BONUS SPIN!!!!!!!!!!!
    /*private function startBonusSpin() : Void
    {
        if (sndSetting != 3)
        {
            //SoundManager.play("flame");
            //SoundManager.play("sword");
            sndFlame.play();
            sndSword.play();
        }
        
        //gameHeader.setTimer(gameTimerAmount, gameLength);
        gameTimer.stop();
        gameTimer.removeEventListener(TimerEvent.TIMER, onGameTimerTick);
        gameTimer = null;
        
        clearGrid();
        
        //bonusSpin = new BonusSpin(points);
        //this.addChild(bonusSpin);
        //bonusSpin.alpha = 0;

        
        //bonusSpin.exitSpinner.add(exitSpinner);
    }
    
    
    private function exitSpinner(newScore : Int) : Void
    {
        trace(newScore);
        points = newScore;
        //this.removeChild(bonusSpin);
        endGame(true);
    }
    */
    
    private function endGame(secondDibs : Bool = false) : Void
    {
        if (!secondDibs)
        {
            if (sndSetting != 3)
            {
                _soundManager.play("flame");
                _soundManager.play("sword");
            }
        }
        
        //gameHeader.setTimer(gameTimerAmount, gameLength);
        if (gameTimer != null)
        {
            gameTimer.stop();
            gameTimer.removeEventListener(TimerEvent.TIMER, onGameTimerTick);
            gameTimer = null;
        }
        
        removeLetters();
        
        
        stopProgressParticle();



        endPopup = new EnduranceEndPopup(points, wordsFoundArr, _soundManager, _globalVO);
        this.addChild(endPopup);
        
        if (!secondDibs)
        {
            //endPopup.alpha = 0;
            /*TweenMax.to(endPopup, 1.2, {
                        alpha : 1
                    });*/
        }
        
        endPopup.replayGame.add(onEndReplay);
        endPopup.navHome.add(onEndNavHome);
    }
    
    private function onEndNavHome() : Void
    {
        //dispatchEventWith(Nav.NAVIGATE_MAIN_MENU, true);
        navBack.dispatch();
    }
    
    private function onEndReplay() : Void
    {
        this.removeChild(endPopup);
        endPopup = null;
        
        currentWord = "";
        points = 0;
        wordsFoundArr = [];
        gameTimerAmount = 0;
        //txtTime.text = "3:00";
        txtWord.text = "";
        txtScore.text = Std.string(points);
        
        progressBar.width = barFullWidth;
        //activateGrid();

        _soundManager.stopMusic("music");
        loadSounds();
        
        setupLevel();
    }
    
    //EVENTS------------------------------------------------
    private function onBackTriggered(e : Event) : Void
    {
        navBack.dispatch();
    }
    
    private function activateGrid() : Void
    {
        if(buttonVec != null)
        {
            for (btn in buttonVec)
            {
                if (!btn.hasEventListener(Event.TRIGGERED))
                {
                    btn.addEventListener(Event.TRIGGERED, onLetterClick);
                }
            }
        }
    }
    
    private function clearGrid() : Void
    {
        if(buttonVec != null)
        {
            for (btn in buttonVec)
            {
                if (btn.hasEventListener(Event.TRIGGERED))
                {
                    btn.removeEventListener(Event.TRIGGERED, onLetterClick);
                }
            }
        }
    }

    private function destroy():Void
    {
        _soundManager.stopMusic("music");

        this.removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
        navBack.removeAll();
        navBack = null;

        if (shieldAnim != null)
        {
            shieldAnim.removeEventListener(Event.COMPLETE, showShieldNumber);
        }
        
        clearGrid();
        
        if (gameTimer != null)
        {
            gameTimer.stop();
            gameTimer.removeEventListener(TimerEvent.TIMER, onGameTimerTick);
            gameTimer = null;
        }
        
        btnCheck.removeEventListener(Event.TRIGGERED, onCheckWord);
        btnDelete.removeEventListener(Event.TRIGGERED, onClearLetter);
        
        backButton.removeEventListener(Event.TRIGGERED, onBackTriggered);
        this.removeChild(backButton);
        backButton = null;
        
        btnMusic.removeEventListener(Event.TRIGGERED, onMusicTriggered);
        
        if (endPopup != null)
        {
            this.removeChild(endPopup);
        }
    }










//PARTICLES


    //Background Particle
    private var backSystemVec : Array<ParticleSystem>;
    private var backSys : ParticleSystem;
    
    //Letter Particle
    private var letterLightSystem : Array<ParticleSystem>;
    private var letterLight : ParticleSystem;
    private var particleInterval : Int;
    private var particleIntervalEnd : Int;
    
    //Score Check Right
    private var scoreCheckRightSystemVec : Array<ParticleSystem>;
    private var scoreCheckRightSys : ParticleSystem;
    private var scoreCheckInterval : Int;
    
    //Score Check Wrong
    private var scoreCheckWrongSystemVec : Array<ParticleSystem>;
    private var scoreCheckWrongSys : ParticleSystem;
    
    //Progress Particle
    private var progressSystemVec : Array<ParticleSystem>;
    private var progressSys : ParticleSystem;
    
    //Shield Particle
    private var shieldExSystemVec : Array<ParticleSystem>;
    private var shieldExSys : ParticleSystem;
    
    //End Particle
    private var endGameSystemVec : Array<ParticleSystem>;
    private var endGameSys : ParticleSystem;

    
    
    
    //Configure score check wrong particle system
    private function configBackParticleSystem() : Void
    {
        var backConfig = Assets.getText("particle/gamescreen_bg.pex");
        var backTexture = Texture.fromBitmapData(Assets.getBitmapData("particle/gamescreen_bg.png"));

        backSystemVec = [new PDParticleSystem(backConfig, backTexture)];

        backSys = backSystemVec.shift();
        backSystemVec.push(backSys);
        backSys.emitterX = settings.stageWidth / 2 - backSys.width / 2;
        backSys.emitterY = settings.stageHeight * 0.2;
        backSys.start();
        this.addChild(backSys);
        Starling.current.juggler.add(backSys);
    }

    //Configure letter particle system
    private function configParticleSystem() : Void
    {

        var letterLightConfig = Assets.getText("particle/letter_light.pex");
        var letterLightTexture = Texture.fromBitmapData(Assets.getBitmapData("particle/letter_light.png"));
        letterLightSystem = [new PDParticleSystem(letterLightConfig, letterLightTexture)];
        
        //Configure end game particle system
        var endGameConfig = Assets.getText("particle/fire_wrong.pex");
        var endGameTexture = Texture.fromBitmapData(Assets.getBitmapData("particle/fire_wrong.png"));
        endGameSystemVec = [new PDParticleSystem(endGameConfig, endGameTexture)];
        
        //Configure score check right particle system
        var scoreCheckRightConfig = Assets.getText("particle/score_check.pex");
        var scoreCheckRightTexture = Texture.fromBitmapData(Assets.getBitmapData("particle/score_check.png"));
        scoreCheckRightSystemVec = [new PDParticleSystem(scoreCheckRightConfig, scoreCheckRightTexture)];
        
        //Configure score check wrong particle system
        var scoreCheckWrongConfig = Assets.getText("particle/score_backspace.pex");
        var scoreCheckWrongTexture = Texture.fromBitmapData(Assets.getBitmapData("particle/score_backspace.png"));
        scoreCheckWrongSystemVec = [new PDParticleSystem(scoreCheckWrongConfig, scoreCheckWrongTexture)];
        
        //Configure shield explosion particle system
        var shieldExConfig = Assets.getText("particle/shield_particle.pex");
        var shieldExTexture = Texture.fromBitmapData(Assets.getBitmapData("particle/shield_particle.png"));
        shieldExSystemVec = [new PDParticleSystem(shieldExConfig, shieldExTexture)];
    }
    
    private function playScoreCheckRight() : Void
    {
        if (scoreCheckRightSys != null)
        {
            scoreCheckRightSys.stop();
            scoreCheckRightSys.removeFromParent();
            Starling.current.juggler.remove(scoreCheckRightSys);
        }
        
        scoreCheckRightSys = scoreCheckRightSystemVec.shift();
        scoreCheckRightSystemVec.push(scoreCheckRightSys);
        scoreCheckRightSys.emitterX = scorePanel.x + (scorePanel.width / 1.4 - scoreCheckRightSys.width / 2);
        scoreCheckRightSys.emitterY = scorePanel.y + (scorePanel.height / 2 - scoreCheckRightSys.height / 2);
        scoreCheckRightSys.start();
        this.addChild(scoreCheckRightSys);
        Starling.current.juggler.add(scoreCheckRightSys);
        
        scoreCheckInterval = as3hx.Compat.setInterval(stopScoreCheckRightParticle, 10);
    }
    
    private function stopScoreCheckRightParticle() : Void
    {
        as3hx.Compat.clearInterval(scoreCheckInterval);
        scoreCheckRightSys.stop();
    }
    
    private function playScoreCheckWrong() : Void
    {
        if (scoreCheckWrongSys != null)
        {
            scoreCheckWrongSys.stop();
            scoreCheckWrongSys.removeFromParent();
            Starling.current.juggler.remove(scoreCheckWrongSys);
        }
        
        scoreCheckWrongSys = scoreCheckWrongSystemVec.shift();
        scoreCheckWrongSystemVec.push(scoreCheckWrongSys);
        scoreCheckWrongSys.emitterX = scorePanel.x + (scorePanel.width / 1.4 - scoreCheckWrongSys.width / 2);
        scoreCheckWrongSys.emitterY = scorePanel.y + (scorePanel.height / 2.3 - scoreCheckWrongSys.height / 2);
        scoreCheckWrongSys.start();
        this.addChild(scoreCheckWrongSys);
        Starling.current.juggler.add(scoreCheckWrongSys);
        
        scoreCheckInterval = as3hx.Compat.setInterval(stopScoreCheckWrongParticle, 50);
    }
    
    private function stopScoreCheckWrongParticle() : Void
    {
        as3hx.Compat.clearInterval(scoreCheckInterval);
        scoreCheckWrongSys.stop();
    }
    
    private function playLetterLight(xpos : Float, ypos : Float) : Void
    {
        if (letterLight != null)
        {
            letterLight.stop();
            letterLight.removeFromParent();
            Starling.current.juggler.remove(letterLight);
        }
        
        letterLight = letterLightSystem.shift();
        letterLightSystem.push(letterLight);
        //letterLight.width = letterLight.width * (settings.scaleAdjustment*0.5);
        //letterLight.height = letterLight.height * (settings.scaleAdjustment*0.5);
        letterLight.emitterX = sprGrid.x + xpos;
        letterLight.emitterY = sprGrid.y + ypos;
        letterLight.start();
        this.addChild(letterLight);
        Starling.current.juggler.add(letterLight);
        
        particleInterval = as3hx.Compat.setInterval(stopLetterLight, 100);
    }
    
    private function stopLetterLight() : Void
    {
        as3hx.Compat.clearInterval(particleInterval);
        letterLight.stop();
    }
    
    private function playEndParticle() : Void
    {
        if (endGameSys != null)
        {
            endGameSys.stop();
            endGameSys.removeFromParent();
            Starling.current.juggler.remove(endGameSys);
        }
        
        endGameSys = endGameSystemVec.shift();
        endGameSystemVec.push(endGameSys);
        endGameSys.emitterX = settings.stageWidth / 2 - endGameSys.width / 2;
        endGameSys.emitterY = settings.stageHeight / 2 - endGameSys.height / 2;
        endGameSys.start();
        this.addChild(endGameSys);
        Starling.current.juggler.add(endGameSys);
        
        particleIntervalEnd = as3hx.Compat.setInterval(stopEndParticle, 100);
    }
    
    private function stopEndParticle() : Void
    {
        as3hx.Compat.clearInterval(particleIntervalEnd);
        endGameSys.stop();
    }

    //Configure progress particle system
    private function playProgressParticle() : Void
    {
        
        if (progressSystemVec == null)
        {
            //var progressConfig : FastXML = FastXML.parse(Type.createInstance(ProgressConfig, []));
            //var progressTexture : Texture = Texture.fromBitmap(Type.createInstance(ProgressParticle, []));

            var progressConfig = Assets.getText("particle/endurancebar.pex");
            var progressTexture = Texture.fromBitmapData(Assets.getBitmapData("particle/endurancebar.png"));
            progressSystemVec = [new PDParticleSystem(progressConfig, progressTexture)];
        }
        
        if (progressSys != null)
        {
            progressSys.stop();
            progressSys.removeFromParent();
            Starling.current.juggler.remove(progressSys);
        }
        
        progressSys = progressSystemVec.shift();
        progressSystemVec.push(progressSys);
        progressSys.emitterX = progressBar.x + progressBar.width;
        progressSys.emitterY = progressBar.y + (progressBar.height / 2 - progressSys.height / 2);
        progressSys.start();
        sprProgress.addChild(progressSys);
        Starling.current.juggler.add(progressSys);
    }
    
    private function stopProgressParticle() : Void
    {
        //clearInterval(scoreCheckInterval);
        
        if (progressSys != null)
        {
            progressSys.stop();
        }
    }
    
    private function playShieldParticle() : Void
    {
        if (shieldExSys != null)
        {
            shieldExSys.stop();
            shieldExSys.removeFromParent();
            Starling.current.juggler.remove(shieldExSys);
        }
        
        shieldExSys = shieldExSystemVec.shift();
        shieldExSystemVec.push(shieldExSys);
        shieldExSys.emitterX = settings.stageWidth / 2 - shieldExSys.width / 2;
        shieldExSys.emitterY = settings.stageHeight / 2 - shieldExSys.height / 2;
        shieldExSys.start();
        this.addChild(shieldExSys);
        Starling.current.juggler.add(shieldExSys);
        
        particleIntervalEnd = as3hx.Compat.setInterval(stopShieldParticle, 50);
    }
    
    private function stopShieldParticle() : Void
    {
        as3hx.Compat.clearInterval(particleIntervalEnd);
        shieldExSys.stop();
    }



}