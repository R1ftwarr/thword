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

import com.glasirgames.thword.model.GlobalVO;

import starling.core.Starling;
import starling.animation.Transitions;
import starling.animation.Tween;
import starling.display.Button;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.text.TextFormat;

import msignal.Signal.Signal0;

class AboutMenu extends Sprite
{
    private var _globalVO:GlobalVO;

    public static inline var NAVIGATE_SETTINGS_BACK : String = "navigateSettingsBack";
    public static inline var BTN_SPACE : Int = 4;
    
    private var menuToolBar : Image;
    
    //Background and Border Assets
    private var background : Image;
    private var front : Image;
    
    //Content
    private var scroll : Image;
    private var logo : Image;
    private var urlText : TextField;

    private var navSiteBtn : Button;
    private var adImg : Image;
    private var privacy : Button;
    
    private var settings : Settings = Settings.getInstance();
    
    private var backButton : Button;

    public var navBack:Signal0;
    
    public function new()
    {
        super();
        
        this.addEventListener(Event.REMOVED_FROM_STAGE, destroy);
        navBack = new Signal0();    
    }
    
    public function init(vo:GlobalVO) : Void
    {
        _globalVO = vo;

        createBackgroundAssets();
        createToolbar();
        createContent();
        
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
    }
    
    private function createToolbar() : Void
    {
        menuToolBar = new Image(_globalVO.assets.getTexture("title_about"));
        menuToolBar.width = menuToolBar.width * settings.scaleAdjustment;
        menuToolBar.height = menuToolBar.height * settings.scaleAdjustment;
        menuToolBar.x = settings.stageWidth / 2 - menuToolBar.width / 2;
        menuToolBar.y = 0 - menuToolBar.height;
        this.addChild(menuToolBar);
        
        var tween:Tween = new Tween(menuToolBar, 1.0, Transitions.EASE_IN_OUT);
        tween.animate("y", 0);
        Starling.current.juggler.add(tween);
    }
    
    private function createContent() : Void
    {
        scroll = new Image(_globalVO.assets.getTexture("panel_gameoptions"));
        scroll.width = scroll.width * settings.scaleAdjustment;
        scroll.height = scroll.height * settings.scaleAdjustment;
        scroll.x = settings.stageWidth / 2 - scroll.width / 2;
        scroll.y = settings.stageHeight / 2 - scroll.height / 2;
        this.addChild(scroll);

        logo = new Image(_globalVO.assets.getTexture("glasir_logo_col"));
        logo.width = logo.width * settings.scaleAdjustment;
        logo.height = logo.height * settings.scaleAdjustment;
        logo.x = settings.stageWidth / 2 - logo.width / 2;
        logo.y = scroll.y + (scroll.height / 2 - logo.height / 1.7);
        this.addChild(logo);
        
        var txtInfo:TextField = new starling.text.TextField(Std.int(scroll.width * 0.7), Std.int(scroll.height * 0.08));
        txtInfo.format = new TextFormat("Arkhip", settings.fontExLarge, 0x663300,"center");
        txtInfo.autoScale = true;
        txtInfo.text = "THWORD - The ultimate word game.";
        txtInfo.x = scroll.x + (scroll.width / 2 - txtInfo.width/2);
        txtInfo.y = scroll.y + scroll.height - 100;
        this.addChild(txtInfo);
    }
    
    private function onBackTriggered(e : Event) : Void
    {
        navBack.dispatch();
    }
    
    private function destroy(e : Event) : Void
    {
        this.removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
        navBack.removeAll();
        
        backButton.removeEventListener(Event.TRIGGERED, onBackTriggered);
    }
}