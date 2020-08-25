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

package com.glasirgames.thword.view.gamestuff;

import openfl.media.Sound;
import openfl.Assets;
import starling.text.TextFormat;
import com.glasirgames.thword.model.RampageVO;
import com.glasirgames.thword.filemanagement.HighScores;
import msignal.Signal.Signal0;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.extensions.PDParticleSystem;
import starling.extensions.ParticleSystem;
import starling.text.TextField;
import starling.textures.Texture;

import com.glasirgames.thword.model.GlobalVO;
import com.glasirgames.thword.utils.SoundManager;

class RampageEndPopup extends Sprite
{
    public static inline var BTN_SPACE : Int = 5;
    private var settings : Settings = Settings.getInstance();
    
    private var cover : Quad;
    private var background : Image;
    private var board : Sprite;
    private var txtCongrats : TextField;
    private var txtScoreTitle : TextField;
    private var scoreHolder : Image;
    private var txtScore : TextField;
    private var btnHome : Button;
    private var btnReplay : Button;
    private var btnWordList : Button;
    
    private var characterRock : Image;
    private var character : MovieClip;
    private var hammer : Image;
    
    
    private var score : Int;
    private var wordsFoundArr : Array<Dynamic>;
    
    private var wordListPopup : WordListPopup;
    private var wordListBg : Image;
    private var showHighScore : Bool = false;
    
    public var replayGame : Signal0;
    public var navHome : Signal0;
    
    private var goatCover : Quad;
    private var light : Image;
    private var highScoreBanner : Image;
    private var dancingGoat : MovieClip;
    private var goatInterval : Int;
    
    //Best Score Particle
    private static var BestScoreParticle : Class<Dynamic>;
    private var bestScoreSystemVec : Array<ParticleSystem>;
    private var bestScoreSys : ParticleSystem;
    private var particleIntervalBest : Int;
    private var sndBestScore:Sound;

    private var _globalVO:GlobalVO;
    private var _soundManager:SoundManager; 
    
    public function new(score : Int, wordsFoundArr : Array<Dynamic>, sndMgr:SoundManager, vo:GlobalVO)
    {
        super();
        this.score = score;
        this.wordsFoundArr = wordsFoundArr;
        this._globalVO = vo;
        this._soundManager = sndMgr;
        
        var timeTrialVO : RampageVO = RampageVO.getInstance();
        
        if (HighScores.getInstance().saveRampageScore(timeTrialVO.letterCount, timeTrialVO.selectedLevel, score))
        {
            showHighScore = true;
        }

        this.addEventListener(Event.REMOVED_FROM_STAGE, cleanup);
        
        replayGame = new Signal0();
        navHome = new Signal0();
        
        loadSounds();
        
        createPopup();
    }
    
    private function loadSounds() : Void
    {

    }

    //Configure end game particle system
    private function createHighScoreParticle() : Void
    {
        var bestConfig = Assets.getText("particle/highscore.pex");
        var bestTexture = Texture.fromBitmapData(Assets.getBitmapData("particle/highscore.png"));


        bestScoreSystemVec = [new PDParticleSystem(bestConfig, bestTexture)];
        
        bestScoreSys = bestScoreSystemVec.shift();
        bestScoreSystemVec.push(bestScoreSys);
        bestScoreSys.emitterX = settings.stageWidth / 2 - bestScoreSys.width / 2;
        bestScoreSys.emitterY = 0;
        bestScoreSys.start();
        this.addChild(bestScoreSys);
        Starling.current.juggler.add(bestScoreSys);
        
        particleIntervalBest = as3hx.Compat.setInterval(removeHighScoreParticle, 500);
    }
    
    private function removeHighScoreParticle() : Void
    {
        as3hx.Compat.clearInterval(particleIntervalBest);
        bestScoreSys.stop();
    }

    //Cover
    private function createPopup() : Void
    {       
        var coverBottomColor : Int = 0x000000;
        var coverTopColor : Int = 0x000000;
        cover = new Quad(settings.stageWidth, settings.stageHeight);
        cover.setVertexColor(0, coverTopColor);
        cover.setVertexColor(1, coverTopColor);
        cover.setVertexColor(2, coverBottomColor);
        cover.setVertexColor(3, coverBottomColor);
        cover.alpha = 0.8;
        this.addChild(cover);
        cover.visible = true;
        
        board = new Sprite();
        background = new Image(_globalVO.assets.getTexture("end_panel"));
        board.addChild(background);

        var format:TextFormat = new TextFormat("Arial", settings.fontExLarge, 0x192229,"center");
        txtCongrats = new TextField(Std.int(background.width * 0.8), Std.int(background.height * 0.4), "");
        txtCongrats.format = format;
        txtCongrats.autoScale = true;
        
        if (showHighScore)
        {
            txtCongrats.text = "CONGRATULATIONS,\nYOU BEAT YOUR\nHIGH SCORE!";
        }
        else if (score >= 1000)
        {
            if (score <= 1499)
            {
                txtCongrats.text = "CONGRATULATIONS,\nBRONZE MJOLNIR\nPERFORMANCE!";
            }
            else if (score > 1499 && score <= 1999)
            {
                txtCongrats.text = "CONGRATULATIONS,\nSILVER MJOLNIR\nPERFORMANCE!";
            }
            else if (score > 1999)
            {
                txtCongrats.text = "CONGRATULATIONS,\nGOLD MJOLNIR\nPERFORMANCE!";
            }
        }
        else if (score < 100)
        {
            txtCongrats.text = "YOU\nSUCK!";
        }
        else if (score > 99 && score < 200)
        {
            txtCongrats.text = "TERRIBLE!";
        }
        else if (score > 199 && score < 300)
        {
            txtCongrats.text = "BLOODY\nAWEFUL!";
        }
        else if (score > 299 && score < 400)
        {
            txtCongrats.text = "POOR\nPERFORMANCE!";
        }
        else if (score > 399 && score < 500)
        {
            txtCongrats.text = "VERY\nAVERAGE!";
        }
        else if (score > 499 && score < 700)
        {
            txtCongrats.text = "GETTING\nBETTER!";
        }
        else if (score > 699 && score < 800)
        {
            txtCongrats.text = "ALMOST\nTHERE!";
        }
        else if (score > 799 && score < 900)
        {
            txtCongrats.text = "CLOSER!";
        }
        else if (score > 899 && score < 1000)
        {
            txtCongrats.text = "ALMOST\nEARNED A MJOLNIR!";
        }
        
        txtCongrats.x = background.width / 2 - txtCongrats.width / 2;
        txtCongrats.y = background.height * 0.13;
        board.addChild(txtCongrats);

        var formatScoreTitle:TextFormat = new TextFormat("Arial", settings.fontExLarge, 0xFFFFFF,"center");
        txtScoreTitle = new TextField(Std.int(background.width * 0.4), Std.int(background.height * 0.08), "");
        txtScoreTitle.format = formatScoreTitle;
        txtScoreTitle.autoScale = true;
        txtScoreTitle.text = "YOUR SCORE:";
        txtScoreTitle.x = background.width / 2 - txtScoreTitle.width / 2;
        txtScoreTitle.y = background.height * 0.48;
        board.addChild(txtScoreTitle);
        
        scoreHolder = new Image(_globalVO.assets.getTexture("end_score_textbg"));
        scoreHolder.x = txtScoreTitle.x;
        scoreHolder.y = txtScoreTitle.y + txtScoreTitle.height;
        board.addChild(scoreHolder);

        var formatScore:TextFormat = new TextFormat("Arial", settings.fontExLarge, 0xFFFFFF,"center");
        txtScore = new TextField(Std.int(scoreHolder.width), Std.int(scoreHolder.height * 0.8), "");
        txtScore.format = formatScore;
        txtScore.autoScale = true;
        txtScore.text = Std.string(score);
        txtScore.x = scoreHolder.x;
        txtScore.y = scoreHolder.y + (scoreHolder.height / 2 - txtScore.height / 2);
        board.addChild(txtScore);
        
        
        btnHome = new Button(_globalVO.assets.getTexture("btn_home"));
        btnHome.x = background.width * 0.1;
        btnHome.y = background.height * 0.9 - btnHome.height;
        btnHome.addEventListener(Event.TRIGGERED, onNavHome);
        board.addChild(btnHome);
        
        btnReplay = new Button(_globalVO.assets.getTexture("btn_refresh"));
        btnReplay.x = btnHome.x + btnHome.width + BTN_SPACE * 3;
        btnReplay.y = background.height * 0.9 - btnReplay.height;
        btnReplay.addEventListener(Event.TRIGGERED, onReplay);
        board.addChild(btnReplay);
        
        btnWordList = new Button(_globalVO.assets.getTexture("btn_wordlist"));
        btnWordList.x = btnReplay.x + btnReplay.width + BTN_SPACE * 3;
        btnWordList.y = background.height * 0.9 - btnWordList.height;
        btnWordList.addEventListener(Event.TRIGGERED, onShowWordList);
        board.addChild(btnWordList);
        
        board.width = board.width * settings.scaleAdjustment;
        board.height = board.height * settings.scaleAdjustment;
        board.x = cover.width / 2 - board.width / 2;
        board.y = cover.height / 2 - board.height / 2;
        this.addChild(board);
        
        characterRock = new Image(_globalVO.assets.getTexture("thor_endscreen_rock"));
        characterRock.width = characterRock.width * settings.scaleAdjustment;
        characterRock.height = characterRock.height * settings.scaleAdjustment;
        characterRock.x = settings.stageWidth - characterRock.width;
        characterRock.y = settings.stageHeight - characterRock.height;
        this.addChild(characterRock);
        
        character = new MovieClip(_globalVO.assets.getTextures("thor_endscreen_thor"));
        character.width = character.width * settings.scaleAdjustment;
        character.height = character.height * settings.scaleAdjustment;
        character.loop = false;
        Starling.current.juggler.add(character);
        character.x = settings.stageWidth - character.width * 0.8;
        character.y = settings.stageHeight - character.height;
        this.addChild(character);
        
        
        
        if (score >= 1000)
        {
            if (score <= 1499)
            {
                hammer = new Image(_globalVO.assets.getTexture("end_hammer0003"));
            }
            else if (score > 1499 && score < 2000)
            {
                hammer = new Image(_globalVO.assets.getTexture("end_hammer0002"));
            }
            else if (score > 1999)
            {
                hammer = new Image(_globalVO.assets.getTexture("end_hammer0001"));
            }
            hammer.width = hammer.width * settings.scaleAdjustment;
            hammer.height = hammer.height * settings.scaleAdjustment;
            hammer.x = board.x - hammer.width * 0.22;
            hammer.y = board.y + board.height * 0.8 - hammer.height;
            this.addChild(hammer);
        }
        
        if (showHighScore)
        {
            goatInterval = as3hx.Compat.setInterval(createGoat, 1000);
        }
    }
    
    private function createGoat() : Void
    {
        as3hx.Compat.clearInterval(goatInterval);
        
        _soundManager.play("bestscore");
        
        //Cover
        var coverBottomColor : Int = 0x000000;
        var coverTopColor : Int = 0x000000;
        goatCover = new Quad(settings.stageWidth, settings.stageHeight);
        goatCover.setVertexColor(0, coverTopColor);
        goatCover.setVertexColor(1, coverTopColor);
        goatCover.setVertexColor(2, coverBottomColor);
        goatCover.setVertexColor(3, coverBottomColor);
        goatCover.alpha = 0.7;
        this.addChild(goatCover);
        cover.visible = true;
        
        light = new Image(_globalVO.assets.getTexture("highscore_glow"));
        light.width = light.width * settings.scaleAdjustment;
        light.height = light.height * settings.scaleAdjustment;
        light.x = settings.stageWidth / 2 - light.width / 2;
        light.y = settings.stageHeight / 2 - light.height / 2;
        this.addChild(light);
        
        createHighScoreParticle();
        
        highScoreBanner = new Image(_globalVO.assets.getTexture("highscore_banner"));
        highScoreBanner.width = highScoreBanner.width * settings.scaleAdjustment;
        highScoreBanner.height = highScoreBanner.height * settings.scaleAdjustment;
        highScoreBanner.x = settings.stageWidth / 2 - highScoreBanner.width / 2;
        highScoreBanner.y = settings.stageHeight * 0.1;
        this.addChild(highScoreBanner);
        
        dancingGoat = new MovieClip(_globalVO.assets.getTextures("goat_highscore_ani"));
        dancingGoat.width = dancingGoat.width * settings.scaleAdjustment;
        dancingGoat.height = dancingGoat.height * settings.scaleAdjustment;
        dancingGoat.loop = false;
        dancingGoat.fps = 8;
        Starling.current.juggler.add(dancingGoat);
        dancingGoat.x = settings.stageWidth / 2 - dancingGoat.width / 2.5;
        dancingGoat.y = settings.stageHeight / 2 - dancingGoat.height / 2;
        this.addChild(dancingGoat);
        dancingGoat.play();
        goatInterval = as3hx.Compat.setInterval(fadeGoat, 3000);
    }
    
    private function fadeGoat() : Void
    {
        as3hx.Compat.clearInterval(goatInterval);
        goatInterval = as3hx.Compat.setInterval(removeGoat, 1000);
    }
    
    private function removeGoat() : Void
    {
        as3hx.Compat.clearInterval(goatInterval);
        Starling.current.juggler.remove(dancingGoat);
        this.removeChild(dancingGoat);
        this.removeChild(goatCover);
        this.removeChild(light);
        this.removeChild(highScoreBanner);
    }
    
    private function onNavHome(e : Event) : Void
    {
        navHome.dispatch();
    }
    
    private function onReplay(e : Event) : Void
    {
        replayGame.dispatch();
    }
    
    private function onShowWordList(e : Event) : Void
    {
        wordListPopup = new WordListPopup(this.wordsFoundArr, _globalVO);
        
        wordListPopup.x = 0;
        wordListPopup.y = 0;
        this.addChild(wordListPopup);
        
        wordListPopup.close.add(closeWordList);
    }
    
    private function closeWordList() : Void
    {
        wordListPopup.close.removeAll();
        this.removeChild(wordListPopup);
        wordListPopup = null;
    }
    
    
    
    private function cleanup(e : Event) : Void
    {
        this.removeEventListener(Event.REMOVED_FROM_STAGE, cleanup);
        
        replayGame.removeAll();
        
        btnHome.removeEventListener(Event.TRIGGERED, onNavHome);
        btnReplay.removeEventListener(Event.TRIGGERED, onReplay);
        btnWordList.removeEventListener(Event.TRIGGERED, onShowWordList);
    }
}
