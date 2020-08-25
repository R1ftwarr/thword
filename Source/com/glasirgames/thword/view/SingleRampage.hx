/**
THWORD - A fast paced, challenging word game
Copyright (C) 2020  Glasir Games Pty Ltd

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
**/

package com.glasirgames.thword.view;

import as3hx.Compat;

import com.glasirgames.thword.model.GlobalVO;
import com.glasirgames.thword.model.FoundWordVO;
import com.glasirgames.thword.model.RampageVO;
import com.glasirgames.thword.model.BandaidVO;

import com.glasirgames.thword.utils.SoundManager;
import com.glasirgames.thword.utils.DictionaryChecker;

import com.glasirgames.thword.view.gamestuff.RampageEndPopup;

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

class SingleRampage extends Sprite
{
    private var _globalVO:GlobalVO;
    private var _soundManager:SoundManager; 
    private var settings : Settings = Settings.getInstance();
    public static var BTN_SPACE : Int = 6;

    public var navBack:Signal0;
    
    public static inline var TIME_TRIAL_GAME_SHOW_END : String = "timeTrialGameShowEnd";
    public static inline var TIME_TRIAL_GAME_NAV_BACK : String = "timeTrialGameNavBack";
    public static inline var TIME_TRIAL_GAME_REMOVED : String = "timeTrialGameRemoved";
    
    private static inline var CLEAR : String = "clear";
    private static inline var BACKSPACE : String = "backspace";
    private static inline var CHECK : String = "check";
    
    private var dictionaryChecker : DictionaryChecker;

    private var rampageVO : RampageVO;
    
    private var buttonVec : Array<Button>;
    private var sprGrid : Sprite;
    
    private var letters : Array<Dynamic>;

    private var currentWord : String;
    public var wordsFoundArr : Array<Dynamic>;
    
    private var gridEndYPos : Float;
    
    private var gameTimer : Timer;
    private var gameTimerAmount : Int;
    private var gameLength : Int = 180;
    
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
    private var txtTime : TextField;
    private var txtWord : TextField;
    
    public var challengeMode : Bool = false;
    
    //Background and Border Assets
    private var background : Image;
    private var backButton : Button;
    
    private var endPopup : RampageEndPopup;
    
    //private var grdNine : GridNine;
    //private var grdTwelve : GridTwelve;

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
    
    private var bandaid : BandaidVO;
    private var bandaidActivated : Image;
    private var bandaidInterval : Int;
    
    private var compliments : Array<Dynamic> = ["THORRIFIC!", "GREAT STUFF!", "GOOD WORK!", "AWESOME!"];
    private var insults : Array<Dynamic> = ["BAD LUCK!", "TRY AGAIN!", "SORRY!", "MAYBE NEXT TIME!"];

    public function new(){
        super();
        this.addEventListener(Event.REMOVED_FROM_STAGE, destroy);
        navBack = new Signal0();
    }

    public function init(vo:GlobalVO) {
        _globalVO = vo;

        rampageVO = RampageVO.getInstance();
        bandaid = BandaidVO.getInstance();

        //bandaid.enabled = true;
        loadSounds();
        
        dictionaryChecker = DictionaryChecker.getInstance();

        wordsFoundArr = new Array<Dynamic>();
        currentWord = "";

        //Create assets
        createBackgroundAssets();
        configBackParticleSystem();
        createBackButtons();
        addItems();
        configParticleSystem();

        
        if (rampageVO.letterCount == 9)
        {
            createNineLetters();
        }
        else
        {
            createTwelveLetters();
        }

        addRightWrong();
        startTimer();
    }

    private function startTimer() : Void
    {
        gameTimerAmount = 0;

        gameTimer = new Timer(1000);
        gameTimer.addEventListener(TimerEvent.TIMER, onGameTimerTick);
        gameTimer.start();
    }

    private function onGameTimerTick(e : TimerEvent) : Void
    {
        gameTimerAmount++;

        var disAmount : Int = as3hx.Compat.parseInt(gameLength - gameTimerAmount);
        var formattedTime : String =
        (Math.floor(disAmount / 60)) + ":" +  // minutes
        ((disAmount % 60 >= 10) ? "" : "0") +  // padding for seconds if needed
        (disAmount % 60);
        txtTime.text = formattedTime;

        if (gameTimerAmount == gameLength)
        {
            
            showEnd();
        }
    }

    private function loadSounds() 
    {
        _soundManager = new SoundManager(_globalVO.soundsArr);   
        _soundManager.playMusic("rampagemusic", 0.5);
    }

    private function createBackgroundAssets() : Void
    {
        background = new Image(_globalVO.assets.getTexture("thword_game-screen_bg"));
        background.width = background.width * settings.scaleAdjustmentMinor;
        background.height = background.height * settings.scaleAdjustmentMinor;
        background.x = settings.stageWidth / 2 - background.width / 2;
        background.y = settings.stageHeight - background.height;
        this.addChild(background);
    }

    private function createBackButtons() : Void
    {
        //Back Button
        backButton = new Button(_globalVO.assets.getTexture("btn_back"));
        addChild(backButton);
        backButton.width = backButton.width * settings.scaleAdjustment;
        backButton.height = backButton.height * settings.scaleAdjustment;

        backButton.name = "ExercisesBack";
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
        btnMusic.width = btnMusic.width * settings.scaleAdjustment;
        btnMusic.height = btnMusic.height * settings.scaleAdjustment;
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
            _soundManager.stopMusic("rampagemusic");
        }
        else if (sndSetting == 2)
        {
            sndSetting++;
            btnMusic.upState = _globalVO.assets.getTexture("btn_sound_mute");
            _soundManager.stopMusic("rampagemusic");
        }
        else if (sndSetting == 3)
        {
            sndSetting = 1;
            btnMusic.upState = _globalVO.assets.getTexture("btn_sound");
            _soundManager.playMusic("rampagemusic", 0.5);
        }
    }

    private function addItems() : Void
    {
        //Score
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

        //Time
        timePanel = new Image(_globalVO.assets.getTexture("game_panel_time"));
        timePanel.width = timePanel.width * settings.scaleAdjustment;
        timePanel.height = timePanel.height * settings.scaleAdjustment;
        timePanel.x = scorePanel.x - scorePanel.width * 1.25;
        timePanel.y = BTN_SPACE;
        this.addChild(timePanel);

        var timeFormat:TextFormat = new TextFormat("Arial", settings.fontExLarge, 0xFFFFFF,"left");
        txtTime = new starling.text.TextField(Std.int(timePanel.width * 0.5), Std.int(timePanel.height * 0.8), "");
        txtTime.format = timeFormat;
        txtTime.autoScale = false;
        txtTime.text = "3:00";
        txtTime.x = timePanel.x + timePanel.width * 0.35 + (timePanel.width / 2 - txtTime.width / 2);
        txtTime.y = timePanel.y + timePanel.height / 2 - txtTime.height / 2;
        this.addChild(txtTime);

        //Word creation panel
        wordPanel = new Image(_globalVO.assets.getTexture("game_panel_word"));
        wordPanel.width = wordPanel.width * settings.scaleAdjustment;
        wordPanel.height = wordPanel.height * settings.scaleAdjustment;
        wordPanel.x = settings.stageWidth / 2 - wordPanel.width * 0.66;
        wordPanel.y = timePanel.y + timePanel.height + BTN_SPACE * 3;
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
        btnCheck = new Button(_globalVO.assets.getTexture("btn_check"));
        btnCheck.width = btnCheck.width * settings.scaleAdjustment;
        btnCheck.height = btnCheck.height * settings.scaleAdjustment;
        btnCheck.x = wordPanel.x + wordPanel.width + BTN_SPACE;
        btnCheck.y = wordPanel.y + wordPanel.height;
        btnCheck.addEventListener(Event.TRIGGERED, onCheckWord);
        this.addChild(btnCheck);

        btnDelete = new Button(_globalVO.assets.getTexture("btn_backspace"));
        btnDelete.width = btnDelete.width * settings.scaleAdjustment;
        btnDelete.height = btnDelete.height * settings.scaleAdjustment;
        btnDelete.x = wordPanel.x + wordPanel.width + BTN_SPACE;
        btnDelete.y = wordPanel.y;
        btnDelete.addEventListener(Event.TRIGGERED, onClearLetter);
        this.addChild(btnDelete);

        var pointsFormat:TextFormat = new TextFormat("Arial", settings.fontExLarge, 0xFFFFFF,"center");
        txtPoints = new starling.text.TextField(Std.int(scorePanel.width * 0.8), Std.int(scorePanel.height * 0.6), "");
        txtPoints.format = pointsFormat;
        txtPoints.autoScale = true;
        txtPoints.text = "";
        txtPoints.x = scorePanel.x + scorePanel.width * 0.2 + (scorePanel.width / 2 - txtPoints.width / 2);
        txtPoints.y = scorePanel.y + scorePanel.height + BTN_SPACE;
        this.addChild(txtPoints);

        bandaidActivated = new Image(_globalVO.assets.getTexture("gpc_bandaid"));
        bandaidActivated.width = bandaidActivated.width * settings.scaleAdjustment;
        bandaidActivated.height = bandaidActivated.height * settings.scaleAdjustment;
        bandaidActivated.x = scorePanel.x + (scorePanel.width * 0.85 - bandaidActivated.width);
        bandaidActivated.y = scorePanel.y + scorePanel.height + BTN_SPACE;
        this.addChild(bandaidActivated);
        bandaidActivated.visible = false;
        //bandaidActivated.filter = BlurFilter.createDropShadow(0.2, 1.8, 0x000000, 0.7, 0.5);
    }



    private function addRightWrong() : Void
    {
        var adj : Float = settings.scaleAdjustment;

        //Answer Animations
        rightGoat = new MovieClip(_globalVO.assets.getTextures("goat_combo"));
        rightGoat.width = rightGoat.width * adj;
        rightGoat.height = rightGoat.height * adj;
        rightGoat.loop = false;
        Starling.current.juggler.add(rightGoat);
        rightGoat.x = settings.stageWidth - rightGoat.width - BTN_SPACE;
        rightGoat.y = settings.stageHeight - rightGoat.height;
        this.addChild(rightGoat);
        rightGoat.stop();
        rightGoat.visible = false;

        wrongGoat = new MovieClip(_globalVO.assets.getTextures("goat_repeatword"));
        wrongGoat.width = wrongGoat.width * adj;
        wrongGoat.height = wrongGoat.height * adj;
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
        var rightFormat:TextFormat = new TextFormat("Arkhip", settings.fontExLarge, 0x000000,"center");
        txtRight = new starling.text.TextField(Std.int(rightBubble.width * 0.8), Std.int(rightBubble.height * 0.5), "");
        txtRight.format = rightFormat;
        txtRight.autoScale = true;
        txtRight.text = "";
        txtRight.x = rightBubble.x + (rightBubble.width / 2 - txtRight.width / 2);
        txtRight.y = rightBubble.y + (rightBubble.height / 2 - txtRight.height / 2);
        this.addChild(txtRight);
        //txtRight.visible = false;

        var wrongFormat:TextFormat = new TextFormat("Arkhip", settings.fontExLarge, 0x000000,"center");
        txtWrong = new starling.text.TextField(Std.int(wrongBubble.width * 0.95), Std.int(wrongBubble.height * 0.8), "");
        txtWrong.format = wrongFormat;
        txtWrong.autoScale = true;
        txtWrong.text = "";
        txtWrong.x = wrongBubble.x + (wrongBubble.width / 2 - txtWrong.width / 2);
        txtWrong.y = wrongBubble.y + (wrongBubble.height / 2 - txtWrong.height / 2);
        this.addChild(txtWrong);
    }

    private function createNineLetters() : Void
    {
        letters = rampageVO.getLetters();
        trace("9-" + Std.string(letters));

        buttonVec = new Array<Button>();
        sprGrid = new Sprite();

        var xpos : Float = 0;
        var ypos : Float = 0;

        var btn : Button;
        var btnFormat:TextFormat = new TextFormat("Arkhip", settings.fontSuperLarge, 0xFFFFFF,"center");
        var i : Int = 1;
        while (i <= letters.length)
        {
            btn = new Button(_globalVO.assets.getTexture("game_tile_word"), Std.string(letters[i - 1]));
            btn.textFormat = btnFormat;
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
        letters = rampageVO.getLetters();
        trace("12-" + Std.string(letters));

        buttonVec = new Array<Button>();
        sprGrid = new Sprite();

        var xpos : Float = 0;
        var ypos : Float = 0;

        var btn : Button;
        var btnFormat:TextFormat = new TextFormat("Arkhip", settings.fontSuperLarge, 0xFFFFFF,"center");
        var i : Int = 1;
        while (i <= letters.length)
        {
            btn = new Button(_globalVO.assets.getTexture("game_tile_word"), Std.string(letters[i - 1]));
            btn.textFormat = btnFormat;
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

    private function activateGrid() : Void
    {
        for (btn in buttonVec)
        {
            if (!btn.hasEventListener(Event.TRIGGERED))
            {
                btn.addEventListener(Event.TRIGGERED, onLetterClick);
            }
        }
    }

    private function clearGrid() : Void
    {
        for (btn in buttonVec)
        {
            if (btn.hasEventListener(Event.TRIGGERED))
            {
                btn.removeEventListener(Event.TRIGGERED, onLetterClick);
            }
        }
    }

    private function onLetterClick(e : Event) : Void
    {
        if (sndSetting != 3)
        {
            _soundManager.play("click");
        }

        var btn : Button = try cast(e.target, Button) catch(e:Dynamic) null;
        playLetterLight(btn.x + btn.width / 2, btn.y + btn.height / 2);
        var let : String = btn.name;

        var xpos : Float = btn.x;
        var ypos : Float = btn.y;

        currentWord += let;
        txtWord.text = currentWord;

        var newLetter : String = rampageVO.getNewLetter(let);
        btn.name = newLetter;
        btn.text = newLetter;
    }




    private function onClearLetter(e : Event) : Void
    {
        
        var showMinusPoints : Bool = false;

        var currentWordLength : Int = currentWord.length;

        if (currentWord != "")
        {
            currentWord = currentWord.substring(0, currentWord.length - 1);


            //if not bandaid calculate minus scores
            if (!bandaid.enabled)
            {
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
            }



            txtScore.text = Std.string(points);
            txtWord.text = currentWord;

            if (sndSetting != 3)
            {
                _soundManager.play("backspace");
            }
        }

        if (showMinusPoints)
        {
            showPoints(-10);
        }
        else if (bandaid.enabled)
        {
            showBandaid();
        }
    }

    private function onCheckWord(e : Event) : Void
    {
        
        var foundWord : FoundWordVO = new FoundWordVO();

        var showThePoints : Bool = false;
        var pointsEarned : Float = 0;

        if (currentWord != "")
        {
            var correct : Bool = dictionaryChecker.checkWord(currentWord);
            var pointsVal : Int = 0;

            if (correct)
            {
                if (checkDuplicate())
                {
                    if (sndSetting != 3)
                    {
                        _soundManager.play("repeat");
                        
                    }
                    showWrong(true);
                    foundWord.duplicate = true;
                }
                else
                {
                    pointsVal = dictionaryChecker.checkPoints(currentWord.length);
                    points += pointsVal;

                    pointsEarned = pointsVal;
                    showThePoints = true;

                    foundWord.duplicate = false;
                    showRight();
                }

                foundWord.correct = true;
                foundWord.points = pointsVal;
                foundWord.word = currentWord;
                wordsFoundArr.push(foundWord);
            }
            else
            {
                showWrong();


                //if not bandaid calculate minus scores
                if (!bandaid.enabled)
                {
                    pointsVal = as3hx.Compat.parseInt(0 - dictionaryChecker.checkPoints(currentWord.length));

                    if (points > 0)
                    {
                        pointsEarned = pointsVal;
                        showThePoints = true;
                    }

                    var testZero : Int = as3hx.Compat.parseInt(points + pointsVal);
                    if (testZero < 0)
                    {
                        points = 0;
                    }
                    else
                    {
                        points += pointsVal;
                    }
                }





                foundWord.correct = false;
                foundWord.duplicate = true;
                foundWord.points = pointsVal;
                foundWord.word = currentWord;
                wordsFoundArr.push(foundWord);
            }

            if (showThePoints)
            {
                showPoints(pointsEarned);
            }
            else if (bandaid.enabled)
            {
                //showBandaid();
            }

            currentWord = "";
            txtWord.text = "";
            
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

        //RIGHT / WRONG
    private function showRight() : Void
    {
        
        if (sndSetting != 3)
        {
            _soundManager.play("right");
        }

        playScoreCheckRight();

        var ran : Int = as3hx.Compat.parseInt(Math.random() * compliments.length);

        rightGoat.visible = true;
        rightGoat.currentFrame = 0;
        rightGoat.play();
        rightBubble.visible = true;
        txtRight.text = compliments[ran];

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


    private function showBandaid() : Void
    {
        if (bandaidInterval != 0)
        {
            as3hx.Compat.clearInterval(bandaidInterval);
        }

        bandaidActivated.visible = true;
        bandaidInterval = as3hx.Compat.setInterval(hideBandaid, 1500);
    }

    private function hideBandaid() : Void
    {
        as3hx.Compat.clearInterval(bandaidInterval);
        bandaidActivated.visible = false;
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

    private function onBackTriggered(e : Event) : Void
    {
        navBack.dispatch();
    }

    private function destroy():Void
    {
        _soundManager.stopMusic("rampagemusic");

        this.removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
        navBack.removeAll();
        navBack = null;

        Starling.current.juggler.remove(rightGoat);
        Starling.current.juggler.remove(wrongGoat);

        clearGrid();

        if (gameTimer != null)
        {
            gameTimer.stop();
            gameTimer.removeEventListener(TimerEvent.TIMER, onGameTimerTick);
            gameTimer = null;
        }

        btnCheck.removeEventListener(Event.TRIGGERED, onCheckWord);
        btnDelete.removeEventListener(Event.TRIGGERED, onClearLetter);
        btnMusic.removeEventListener(Event.TRIGGERED, onMusicTriggered);

        backButton.removeEventListener(Event.TRIGGERED, onBackTriggered);
        this.removeChild(backButton);
        backButton = null;

        if (endPopup != null)
        {
            this.removeChild(endPopup);
        }
    }



/**
END SCREEN
**/
    private function showEnd() : Void
    {
        bandaid.enabled = false;

        endGame();
        playEndParticle();
    }

    //BONUS SPIN!!!!!!!!!!!
    private function startBonusSpin() : Void
    {
        if (sndSetting != 3)
        {
            _soundManager.play("flame");
            _soundManager.play("sword");
        }

        gameTimer.stop();
        gameTimer.removeEventListener(TimerEvent.TIMER, onGameTimerTick);
        gameTimer = null;

        clearGrid();

        /*bonusSpin = new BonusSpin(points);
        this.addChild(bonusSpin);
        bonusSpin.alpha = 0;
        TweenMax.to(bonusSpin, 1.2, {
                    alpha : 1
                });

        bonusSpin.exitSpinner.add(exitSpinner);
        */
    }

    /*private function exitSpinner(newScore : Int) : Void
    {
        points = newScore;
        this.removeChild(bonusSpin);
        endGame(true);
    }*/

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

        if (gameTimer != null)
        {
            gameTimer.stop();
            gameTimer.removeEventListener(TimerEvent.TIMER, onGameTimerTick);
            gameTimer = null;
        }

        clearGrid();

        endPopup = new RampageEndPopup(points, wordsFoundArr, _soundManager ,_globalVO);
        this.addChild(endPopup);

        endPopup.replayGame.add(onEndReplay);
        endPopup.navHome.add(onEndNavHome);
    }

    private function onEndNavHome() : Void
    {
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
        txtTime.text = "3:00";
        txtWord.text = "";
        txtScore.text = Std.string(points);
        activateGrid();

        _soundManager.stopMusic("rampagemusic");
        loadSounds();


        gameTimer = new Timer(1000);
        gameTimer.addEventListener(TimerEvent.TIMER, onGameTimerTick);
        gameTimer.start();
    }







/******************************
PARTICLES
*******************************/
    //Background Particle
    private var backSystemVec : Array<ParticleSystem>;
    private var backSys : ParticleSystem;

    //Letter Particle
    private var letterLightSystem : Array<ParticleSystem>;
    private var letterLight : ParticleSystem;
    private var particleInterval : Int;
    private var particleIntervalEnd : Int;

    private var scoreCheckRightSystemVec : Array<ParticleSystem>;
    private var scoreCheckRightSys : ParticleSystem;
    private var scoreCheckInterval : Int;

    private var scoreCheckWrongSystemVec : Array<ParticleSystem>;
    private var scoreCheckWrongSys : ParticleSystem;

    private var endGameSystemVec : Array<ParticleSystem>;
    private var endGameSys : ParticleSystem;

    private function configBackParticleSystem() {
        var backConfig = Assets.getText("particle/gamescreen_bg.pex");
        var backTexture = Texture.fromBitmapData(Assets.getBitmapData("particle/gamescreen_bg.png"));
        backSystemVec = [new PDParticleSystem(backConfig, backTexture)];
        startBackParticleSystem();
    }

    private function startBackParticleSystem():Void
    {
        backSys = backSystemVec.shift();
        backSystemVec.push(backSys);
        backSys.emitterX = settings.stageWidth / 2 - backSys.width / 2;
        backSys.emitterY = settings.stageHeight * 0.2;
        backSys.start();
        this.addChild(backSys);
        Starling.current.juggler.add(backSys);
    }

    private function configParticleSystem() : Void
    {
        //Configure letter particle system
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
}//END