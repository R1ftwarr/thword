package com.educationcurb.thword.view;

import starling.text.TextField;
import starling.events.Touch;
import starling.events.TouchPhase;
import starling.events.TouchEvent;

import com.educationcurb.thword.model.GlobalVO;
import com.educationcurb.thword.utils.SoundManager;

import starling.display.Image;
import msignal.Signal.Signal0;
import starling.display.Button;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.utils.Color;

//import openfl.Assets;
import openfl.utils.Assets;
import openfl.display.BitmapData;
import starling.textures.Texture;

import starling.extensions.ParticleSystem;
import starling.extensions.PDParticleSystem;

import starling.core.Starling;

class MainMenuView extends Sprite
{
    private var _globalVO:GlobalVO;

    public static inline var BTN_SPACE : Int = 10;
    private var settings : Settings = Settings.getInstance();
    
    //Background and Border Assets
    private var background : Image;
    private var front : Image;
    private var character : Image;
    private var title : Image;
    
    private var btnSinglePlayer : Button;
    private var btnMultiPlayer : Button;
    private var btnAbout : Button;
    private var btnSettings : Button;
    private var btnInstructions : Button;
    
    //Background Particle
    private var _particleSystems:Array<ParticleSystem>;
    private var _particleSystem:ParticleSystem;  

    //Sound
    private var _soundManager:SoundManager; 

    public var showSinglePlayerMenu:Signal0;
    public var aboutMenu:Signal0;
    public var showIntructions:Signal0;

    public function new()
    {
        super();

        this.addEventListener(Event.REMOVED_FROM_STAGE, destroy);

        showSinglePlayerMenu = new Signal0();
        aboutMenu = new Signal0();
        showIntructions = new Signal0();

        var quad:Quad = new Quad(settings.stageWidth, settings.stageHeight, Color.RED);
        quad.alpha = 0;
        this.addChild(quad);
    }

    public function init(globalVO:GlobalVO):Void
    {
        _globalVO = globalVO;

        createBackground();  
        configBackParticleSystem();
        createMenu();

        //loadSounds();
    }

    private function loadSounds():Void
    {
        _soundManager = new SoundManager(_globalVO.soundsArr);
        _soundManager.playMusic("menumusic", 0.5);
    }

    private function configBackParticleSystem() {
        var backConfig = Assets.getText("particle/menu.pex");
        var backTexture = Texture.fromBitmapData(Assets.getBitmapData("particle/menu.png"));
        _particleSystems = [new PDParticleSystem(backConfig, backTexture)];

        startNextParticleSystem();
    }

    private function startNextParticleSystem():Void
    {
        if (_particleSystem != null)
        {
            _particleSystem.stop();
            _particleSystem.removeFromParent();
            Starling.current.juggler.remove(_particleSystem);
        }

        _particleSystem = _particleSystems.shift();
        _particleSystems.push(_particleSystem);

        _particleSystem.emitterX = settings.stageWidth / 2 - _particleSystem.width / 2;
        _particleSystem.emitterY = settings.stageHeight * 0.2;
        _particleSystem.start();

        addChild(_particleSystem);
        Starling.current.juggler.add(_particleSystem);
    }

    private function createBackground():Void
    {
        background = new Image(_globalVO.assets.getTexture("twhord_menu_bg_back"));
        background.width = background.width * settings.scaleAdjustmentMinor;
        background.height = background.height * settings.scaleAdjustmentMinor;
        background.x = settings.stageWidth / 2 - background.width / 2;
        background.y = settings.stageHeight - background.height;
        this.addChild(background);

        var adj : Float = settings.scaleAdjustment * 0.8;
        character = new Image(_globalVO.assets.getTexture("twhord_menu_bg_mid_thor"));
        character.width = character.width * adj;
        character.height = character.height * adj;
        character.x = settings.stageWidth - character.width;
        character.y = settings.stageHeight - character.height;
        this.addChild(character);
        
        front = new Image(_globalVO.assets.getTexture("twhord_menu_bg_front"));
        front.width = front.width * settings.scaleAdjustment;
        front.height = front.height * settings.scaleAdjustment;
        front.x = settings.stageWidth / 2 - front.width / 2;
        front.y = 0;
        this.addChild(front);
    }

    private function createMenu():Void
    {
        btnSinglePlayer = new Button(_globalVO.assets.getTexture("btn_play"));
        btnSinglePlayer.width = btnSinglePlayer.width * settings.scaleAdjustment;
        btnSinglePlayer.height = btnSinglePlayer.height * settings.scaleAdjustment;
        btnSinglePlayer.name = "single";
        btnSinglePlayer.x = settings.stageWidth / 2 - btnSinglePlayer.width / 2;
        btnSinglePlayer.y = front.height * 0.5;
        btnSinglePlayer.addEventListener(Event.TRIGGERED, onButtonTriggered);
        addChild(btnSinglePlayer);
        
        
        btnAbout = new Button(_globalVO.assets.getTexture("btn_about"));
        btnAbout.width = btnAbout.width * settings.scaleAdjustment;
        btnAbout.height = btnAbout.height * settings.scaleAdjustment;
        btnAbout.name = "About";
        btnAbout.x = 0 + BTN_SPACE;
        btnAbout.y = 0 + BTN_SPACE / 2;
        btnAbout.addEventListener(Event.TRIGGERED, onAbout);
        addChild(btnAbout);
        
        btnInstructions = new Button(_globalVO.assets.getTexture("btn_instructions"));
        btnInstructions.width = btnInstructions.width * settings.scaleAdjustment;
        btnInstructions.height = btnInstructions.height * settings.scaleAdjustment;
        btnInstructions.x = btnAbout.x + btnAbout.width + BTN_SPACE;
        btnInstructions.y = 0 + BTN_SPACE / 2;
        btnInstructions.addEventListener(Event.TRIGGERED, onInstructions);
        addChild(btnInstructions);
    }

    private function onInstructions(e : Event) : Void
    {
        showIntructions.dispatch();
    }
    
    private function onAbout(e : Event) : Void
    {
        aboutMenu.dispatch();
    }
    
    private function onButtonTriggered(e : Event) : Void
    {
        var _sw2_ = ((try cast(e.target, Button) catch(e:Dynamic) null).name);        

        switch (_sw2_)
        {
            case "single":
                showSinglePlayerMenu.dispatch();
                
        }
    }

    private function destroy():Void
    {
        this.removeEventListener(Event.REMOVED_FROM_STAGE, destroy);

        showSinglePlayerMenu.removeAll();
        showSinglePlayerMenu = null;
    }
}