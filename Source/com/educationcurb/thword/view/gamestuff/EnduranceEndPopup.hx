package com.educationcurb.thword.view.gamestuff;

import com.educationcurb.thword.model.GlobalVO;
import com.educationcurb.thword.model.EnduranceVO;
import com.educationcurb.thword.utils.SoundManager;

import openfl.Assets;
import openfl.media.Sound;
import starling.text.TextFormat;
import msignal.Signal.Signal0;

import com.educationcurb.thword.model.EnduranceVO;
import com.educationcurb.thword.filemanagement.HighScores;

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


class EnduranceEndPopup extends Sprite
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
    
    public var replayGame : Signal0;
    public var navHome : Signal0;
    
    private var showHighScore : Bool = false;
    
    private var goatCover : Quad;
    private var light : Image;
    private var highScoreBanner : Image;
    private var dancingGoat : MovieClip;
    private var goatInterval : Int;
    
    //Best Score Particle
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
        
        var gameDataVO : EnduranceVO = EnduranceVO.getInstance();
        
        if (HighScores.getInstance().saveEnduranceScore(gameDataVO.letterCount, score))
        {
            showHighScore = true;
        }
        
        this.addEventListener(Event.REMOVED_FROM_STAGE, cleanup);
        
        replayGame = new Signal0();
        navHome = new Signal0();
        
        //loadSounds();
        createPopup();
    }
    
    private function loadSounds() : Void
    {
        //SoundManager.addSound("bestscore", "/audio/best_score.mp3", 0.3);
        //sndBestScore = cast(Game.assets.getSound("best_score"), Sound);
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
        
        txtCongrats = new TextField(Std.int(background.width * 0.8), Std.int(background.height * 0.4), "");
        txtCongrats.format = new TextFormat("Arial", settings.fontExLarge, 0x192229,"center");
        txtCongrats.autoScale = true;
        
        if (showHighScore)
        {
            txtCongrats.text = "CONGRATULATIONS,\nYOU BEAT YOUR\nHIGH SCORE!";
        }
        else if (score >= 5000)
        {
            if (score <= 9999)
            {
                txtCongrats.text = "CONGRATULATIONS,\nBRONZE MJOLNIR\nPERFORMANCE!";
            }
            else if (score > 9999 && score <= 19999)
            {
                txtCongrats.text = "CONGRATULATIONS,\nSILVER MJOLNIR\nPERFORMANCE!";
            }
            else if (score > 19999)
            {
                txtCongrats.text = "CONGRATULATIONS,\nGOLD MJOLNIR\nPERFORMANCE!";
            }
        }
        else if (score < 1000)
        {
            txtCongrats.text = "YOU\nSUCK!";
        }
        else if (score > 999 && score < 2000)
        {
            txtCongrats.text = "POOR\nPERFORMANCE!";
        }
        else if (score > 1999 && score < 3000)
        {
            txtCongrats.text = "VERY\nAVERAGE!";
        }
        else if (score > 2999 && score < 4000)
        {
            txtCongrats.text = "GETTING\nTHERE!";
        }
        else if (score > 3999 && score < 5000)
        {
            txtCongrats.text = "ALMOST\nEARNED A MJOLNIR!";
        }
        
        txtCongrats.x = background.width / 2 - txtCongrats.width / 2;
        txtCongrats.y = background.height * 0.13;
        board.addChild(txtCongrats);
        
        txtScoreTitle = new TextField(Std.int(background.width * 0.4), Std.int(background.height * 0.08), "");
        txtScoreTitle.format = new TextFormat("Arial", settings.fontExLarge, 0xFFFFFF,"center");
        txtScoreTitle.autoScale = true;
        txtScoreTitle.text = "YOUR SCORE:";
        txtScoreTitle.x = background.width / 2 - txtScoreTitle.width / 2;
        txtScoreTitle.y = background.height * 0.48;
        board.addChild(txtScoreTitle);
        
        scoreHolder = new Image(_globalVO.assets.getTexture("end_score_textbg"));
        scoreHolder.x = txtScoreTitle.x;
        scoreHolder.y = txtScoreTitle.y + txtScoreTitle.height;
        board.addChild(scoreHolder);
        
        
        txtScore = new TextField(Std.int(scoreHolder.width), Std.int(scoreHolder.height * 0.8), "");
        txtScore.format = new TextFormat("Arial", settings.fontSuperLarge, 0xFFFFFF,"center");
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

        if (score >= 5000)
        {
            if (score <= 9999)
            {
                hammer = new Image(_globalVO.assets.getTexture("end_hammer0003"));
            }
            else if (score > 9999 && score <= 14999)
            {
                hammer = new Image(_globalVO.assets.getTexture("end_hammer0002"));
            }
            else if (score > 14999)
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
        //dancingGoat.x = settings.stageWidth;
        //dancingGoat.y = settings.stageHeight - dancingGoat.height;
        dancingGoat.x = settings.stageWidth / 2 - dancingGoat.width / 2.5;
        dancingGoat.y = settings.stageHeight / 2 - dancingGoat.height / 2;
        this.addChild(dancingGoat);
        dancingGoat.play();
        goatInterval = as3hx.Compat.setInterval(fadeGoat, 3000);
    }
    
    private function fadeGoat() : Void
    {
        as3hx.Compat.clearInterval(goatInterval);
        /*TweenMax.to(dancingGoat, 1, {
                    alpha : 0
                });
        TweenMax.to(goatCover, 1, {
                    alpha : 0
                });
        TweenMax.to(light, 1, {
                    alpha : 0
                });
        TweenMax.to(highScoreBanner, 1, {
                    alpha : 0
                });*/
        
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


