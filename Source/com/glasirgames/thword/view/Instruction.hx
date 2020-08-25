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

import starling.filters.BlurFilter;
import starling.text.TextFormat;
import starling.core.Starling;
import starling.animation.Transitions;
import starling.animation.Tween;
import starling.display.Button;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;

import msignal.Signal.Signal0;

class Instruction extends Sprite
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
    
    private var box : Image;
    private var imgCheck : Image;
    private var imgDelete : Image;
    private var imgBandaid : Image;
    
    private var txtRampageHeader : TextField;
    private var txtEnduranceHeader : TextField;
    private var txtRampageDesc : TextField;
    private var txtEnduranceDesc : TextField;
    private var txtCheckDesc : TextField;
    private var txtDeleteDesc : TextField;
    private var txtBandaidHeader : TextField;
    private var txtBandaidDesc : TextField;

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
        menuToolBar = new Image(_globalVO.assets.getTexture("title_instructions"));
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
        scroll = new Image(_globalVO.assets.getTexture("panel_instructions"));
        scroll.width = scroll.width * settings.scaleAdjustment;
        scroll.height = scroll.height * settings.scaleAdjustment;
        scroll.x = settings.stageWidth / 2 - scroll.width / 2;
        scroll.y = settings.stageHeight / 2 - scroll.height / 2.3;
        this.addChild(scroll);
        
        box = new Image(_globalVO.assets.getTexture("inst_box"));
        box.width = box.width * settings.scaleAdjustment;
        box.height = box.height * settings.scaleAdjustment;
        box.x = settings.stageWidth / 2 - box.width / 2;
        box.y = scroll.y + (scroll.height * 0.9) - box.height * 0.93;
        this.addChild(box);

        var format:TextFormat = new TextFormat("Arkhip", settings.fontLarge, 0x663300,"left");
        txtRampageHeader = new starling.text.TextField(Std.int(scroll.width * 0.3), Std.int(scroll.height * 0.08));
        txtRampageHeader.format = format;
        txtRampageHeader.autoScale = true;
        txtRampageHeader.text = "Rampage Mode";
        txtRampageHeader.x = scroll.x + scroll.width * 0.08;
        txtRampageHeader.y = scroll.y + scroll.height * 0.07;
        this.addChild(txtRampageHeader);

        txtRampageDesc = new starling.text.TextField(Std.int(scroll.width * 0.5), Std.int(scroll.height * 0.2));
        txtRampageDesc.format = new TextFormat("Book Antiqua", settings.fontMedium, 0x663300,"left");
        //txtRampageDesc = new starling.text.TextField(scroll.width * 0.5, scroll.height * 0.2, "", "Book Antiqua", settings.fontMedium, 0x663300);
        txtRampageDesc.autoScale = true;
        txtRampageDesc.text = "Score as many points as possible in 3 minutes. The longer the word the more points you earn. Incorrect spelling earns minus points.";
        txtRampageDesc.x = scroll.x + scroll.width * 0.42;
        txtRampageDesc.y = txtRampageHeader.y - txtRampageHeader.height*0.6; //+ txtRampageHeader.height - txtRampageDesc.height * 0.5;
        this.addChild(txtRampageDesc);


        txtEnduranceHeader = new starling.text.TextField(Std.int(scroll.width * 0.3), Std.int(scroll.height * 0.08));
        txtEnduranceHeader.format = new TextFormat("Arkhip", settings.fontLarge, 0x663300,"left");
        //txtEnduranceHeader = new starling.text.TextField(scroll.width * 0.3, scroll.height * 0.08, "", "Arkhip", settings.fontLarge, 0x663300);
        txtEnduranceHeader.autoScale = true;
        txtEnduranceHeader.text = "Endurance Mode";
        txtEnduranceHeader.x = scroll.x + scroll.width * 0.08;
        txtEnduranceHeader.y = scroll.y + scroll.height * 0.26;
        this.addChild(txtEnduranceHeader);

        txtEnduranceDesc = new starling.text.TextField(Std.int(scroll.width * 0.5), Std.int(scroll.height * 0.2));
        txtEnduranceDesc.format = new TextFormat("Book Antiqua", settings.fontMedium, 0x663300,"left");
        //txtEnduranceDesc = new starling.text.TextField(scroll.width * 0.5, scroll.height * 0.2, "", "Book Antiqua", settings.fontMedium, 0x663300);
        txtEnduranceDesc.autoScale = true;
        txtEnduranceDesc.text = "Stay in the battle for as long as possible. Gain more time with bigger words and combos. Level up when time hits the maximum limit.";
        txtEnduranceDesc.x = scroll.x + scroll.width * 0.42;
        txtEnduranceDesc.y = txtEnduranceHeader.y- txtEnduranceHeader.height*0.6; //+ txtEnduranceHeader.height - txtEnduranceDesc.height * 0.5;
        this.addChild(txtEnduranceDesc);
        
        imgCheck = new Image(_globalVO.assets.getTexture("inst_check"));
        imgCheck.width = imgCheck.width * settings.scaleAdjustment;
        imgCheck.height = imgCheck.height * settings.scaleAdjustment;
        imgCheck.x = box.x + box.width * 0.05;
        imgCheck.y = box.y + box.height * 0.1;
        this.addChild(imgCheck);

        txtCheckDesc = new starling.text.TextField(Std.int(box.width * 0.6), Std.int(box.height * 0.3));
        txtCheckDesc.format = new TextFormat("Book Antiqua", settings.fontMedium, 0x663300,"left");
        //txtCheckDesc = new starling.text.TextField(box.width * 0.6, box.height * 0.3, "", "Book Antiqua", settings.fontMedium, 0x663300);
        txtCheckDesc.autoScale = true;
        txtCheckDesc.text = "Check your word when you have finished.\nThe longer the word the more points you get.";
        txtCheckDesc.x = box.x + box.width * 0.27;
        txtCheckDesc.y = imgCheck.y + imgCheck.height - txtCheckDesc.height * 0.85;
        this.addChild(txtCheckDesc);
        
        imgDelete = new Image(_globalVO.assets.getTexture("inst_backspace"));
        imgDelete.width = imgDelete.width * settings.scaleAdjustment;
        imgDelete.height = imgDelete.height * settings.scaleAdjustment;
        imgDelete.x = imgCheck.x + imgCheck.width - imgDelete.width;
        imgDelete.y = box.y + box.height * 0.4;
        this.addChild(imgDelete);

        txtDeleteDesc = new starling.text.TextField(Std.int(box.width * 0.65), Std.int(box.height * 0.3));
        txtDeleteDesc.format = new TextFormat("Book Antiqua", settings.fontMedium, 0x663300,"left");
        //txtDeleteDesc = new starling.text.TextField(box.width * 0.65, box.height * 0.3, "", "Book Antiqua", settings.fontMedium, 0x663300);
        txtDeleteDesc.autoScale = true;
        txtDeleteDesc.text = "Delete one letter.\nUsing this button will deduct -10 from your score.";
        txtDeleteDesc.x = box.x + box.width * 0.27;
        txtDeleteDesc.y = imgDelete.y + imgDelete.height - txtDeleteDesc.height * 0.85;
        this.addChild(txtDeleteDesc);
        
        /*imgBandaid = new Image(Game.assets.getTexture("inst_bandaid"));
        imgBandaid.width = imgBandaid.width * settings.scaleAdjustment;
        imgBandaid.height = imgBandaid.height * settings.scaleAdjustment;
        imgBandaid.x = imgCheck.x + imgCheck.width - imgBandaid.width;
        imgBandaid.y = box.y + box.height * 0.7;
        this.addChild(imgBandaid);
        //imgBandaid.filter = BlurFilter.createDropShadow(0.2, 1.8, 0x000000, 0.7, 0.5);

        txtBandaidHeader = new starling.text.TextField(Std.int(box.width * 0.6), Std.int(box.height * 0.15));
        txtBandaidHeader.format = new TextFormat("Arkhip", settings.fontLarge, 0x663300,"left");
        //txtBandaidHeader = new starling.text.TextField(box.width * 0.6, box.height * 0.15, "", "Arkhip", settings.fontLarge, 0x663300);
        txtBandaidHeader.autoScale = true;
        txtBandaidHeader.text = "Super Healing";
        txtBandaidHeader.x = box.x + box.width * 0.27;
        txtBandaidHeader.y = imgBandaid.y;
        this.addChild(txtBandaidHeader);

        txtBandaidDesc = new starling.text.TextField(Std.int(box.width * 0.6), Std.int(box.height * 0.132));
        txtBandaidDesc.format = new TextFormat("Book Antiqua", settings.fontMedium, 0x663300,"left");
        //txtBandaidDesc = new starling.text.TextField(box.width * 0.6, box.height * 0.132, "", "Book Antiqua", settings.fontMedium, 0x663300);
        txtBandaidDesc.autoScale = true;
        txtBandaidDesc.text = "Remove minus points.";
        txtBandaidDesc.x = box.x + box.width * 0.27;
        txtBandaidDesc.y = txtBandaidHeader.y + txtBandaidHeader.height * 0.85;
        this.addChild(txtBandaidDesc);
        */

        txtBandaidHeader = new starling.text.TextField(Std.int(box.width * 0.6), Std.int(box.height * 0.15));
        txtBandaidHeader.format = new TextFormat("Book Antiqua", settings.fontMedium, 0x663300,"left");
        //txtBandaidHeader = new starling.text.TextField(box.width * 0.6, box.height * 0.15, "", "Arkhip", settings.fontLarge, 0x663300);
        txtBandaidHeader.autoScale = true;
        txtBandaidHeader.text = "High Scores";
        txtBandaidHeader.x = box.x + box.width * 0.27;
        txtBandaidHeader.y = box.y + box.height*0.7;
        this.addChild(txtBandaidHeader);

        txtBandaidDesc = new starling.text.TextField(Std.int(box.width * 0.6), Std.int(box.height * 0.132));
        txtBandaidDesc.format = new TextFormat("Book Antiqua", settings.fontMedium, 0x663300,"left");
        //txtBandaidDesc = new starling.text.TextField(box.width * 0.6, box.height * 0.132, "", "Book Antiqua", settings.fontMedium, 0x663300);
        txtBandaidDesc.autoScale = true;
        txtBandaidDesc.text = "Clearing your browser cache WILL clear your high scores.";
        txtBandaidDesc.x = box.x + box.width * 0.27;
        txtBandaidDesc.y = txtBandaidHeader.y + txtBandaidHeader.height * 0.65;
        this.addChild(txtBandaidDesc);
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