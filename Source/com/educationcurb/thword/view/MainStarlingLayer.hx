package com.educationcurb.thword.view;

import robotlegs.bender.extensions.display.stage3D.starling.impl.StarlingLayer;
import starling.display.Quad;
import starling.display.Sprite;
import starling.utils.Color;

import com.educationcurb.thword.utils.SoundManager;
import com.educationcurb.thword.model.GlobalVO;
import com.educationcurb.thword.model.GameSettingsVO;

@:rtti
@:keepSub
class MainStarlingLayer extends StarlingLayer
{
    @:meta(Embed(source="assets/fonts/BKANT.ttf",embedAsCFF="false",fontFamily="Book Antiqua"))
    private static var BookAntiqua : Class<Dynamic>;

    @:meta(Embed(source="assets/fonts/Arkhip_font.ttf",embedAsCFF="false",fontFamily="Arkhip"))
    private static var Arkhip : Class<Dynamic>;

    @:meta(Embed(source="assets/fonts/CaviarDreams.ttf",embedAsCFF="false",fontFamily="Caviar Dreams"))
    private static var CaviarDreams : Class<Dynamic>;
    
    private var settings:Settings = Settings.getInstance();

    private var _activeScene : Sprite;

    //Sound
    private var _soundManager:SoundManager; 
    private var menuMusicPlaying:Bool = false;

    private var _globalVO:GlobalVO;

    public function new()
    {
        super();
    }

    public function init():Void
    {
        var quad:Quad = new Quad(settings.stageWidth, settings.stageHeight, Color.RED);
        quad.alpha = 0;
        this.addChild(quad);

        

        showScene(LoaderGlobalView);
    }

    public function showMainMenu(vo:GlobalVO):Void
    {
        if(_globalVO == null)
            _globalVO = vo;

        if(menuMusicPlaying == false){
            if(_soundManager == null)
                _soundManager = new SoundManager(_globalVO.soundsArr);   
            _soundManager.playMusic("menumusic", 0.5);
            menuMusicPlaying = true;
        }

        showScene(MainMenuView);
    }

    public function showSinglePlayerMenu():Void 
    {
        showScene(SinglePlayerMenu);
    }

    public function showGame():Void 
    {
        //Stop menu music
        menuMusicPlaying = false;
        _soundManager.stopMusic("menumusic");

        if(GameSettingsVO.getInstance().gameType == Settings.GAME_RAMPAGE){
            showScene(SingleRampage);
        }
        else
        {
            showScene(SingleEndurance);
        }
    }

    public function showAbout() {
        showScene(AboutMenu);
    }

    public function showInstructions() {
        showScene(Instruction);
    }

    private function showScene(screen : Class<Dynamic>) : Void
    {
        if (_activeScene != null)
        {
            _activeScene.removeFromParent(true);
        }
        _activeScene = Type.createInstance(screen, []);
        addChild(_activeScene);
    }
}