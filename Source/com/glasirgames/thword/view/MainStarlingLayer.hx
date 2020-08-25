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

import robotlegs.bender.extensions.display.stage3D.starling.impl.StarlingLayer;
import starling.display.Quad;
import starling.display.Sprite;
import starling.utils.Color;

import com.glasirgames.thword.utils.SoundManager;
import com.glasirgames.thword.model.GlobalVO;
import com.glasirgames.thword.model.GameSettingsVO;

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