package com.educationcurb.thword.view.components;

import starling.events.TouchPhase;
import starling.events.Touch;
import starling.textures.RenderTexture;
import starling.events.TouchEvent;
import starling.display.Button;
import starling.text.TextFormat;
import starling.text.TextField;
import starling.utils.Color;
import starling.display.Canvas;
import starling.display.Quad;
import starling.display.Sprite;

class ScrollList extends Sprite
{
    private var settings : Settings = Settings.getInstance();

    private var _baseContainer : Sprite;
    private var _sprList:Sprite;

    private var _width:Int;
    private var _height:Int;

    private var _scrollBarWidth:Float;

    public function new(w:Int, h:Int, list:Array<String>)
    {
        super();

        _width = w;
        _height = h;

        var back:Quad = new Quad(w, h);
        this.addChild(back);
        back.alpha = 0;

        buildBase();
        buildList(list);

        if(_sprList.height > h)
            buildVerticalScrollbar();
    }

    private function buildBase() : Void
    {
        _baseContainer = new Sprite();
        _baseContainer.width = _width;
        _baseContainer.height = _height;

        //Mask
        var maskCanvas:Canvas = new Canvas();
        maskCanvas.beginFill(Color.BLACK);
        maskCanvas.drawRectangle(0,0,_width, _height);
        maskCanvas.endFill();
        
        _baseContainer.mask = maskCanvas;
        this.addChild(_baseContainer);

        
    }

    private function buildList(list:Array<String>):Void
    {
        _sprList = new Sprite();

        var txt:TextField;
        var txtFormat:TextFormat = new TextFormat("Arial", settings.fontMedium, 0x663300,"left");
        var ypos:Float = 0;

        for (i in 0...list.length)
        {
            txt = new TextField(Std.int(_width * 0.9), 30);
            txt.format = txtFormat;
            txt.autoScale = true;
            txt.text = list[i];
            txt.x = 2;
            txt.y = ypos;
            _sprList.addChild(txt);
            ypos += txt.height;
        }
        _baseContainer.addChild(_sprList);
    }

    private var sliderBar : Quad;
    private var sliderBtn : Button;
    private var minY:Float;
    private var maxY:Float;
    private var prevY:Float = 0;
    private var moveAmount : Float = 0;
    private var slideStart:Float = 0;
    private var slidePercentage:Float = 0;

    private function buildVerticalScrollbar():Void
    {
        var barWidth:Float = 20;
        if(_width*0.1 < 20)
            barWidth = _width*0.1;

        sliderBar = new Quad(barWidth, _height, 0x663300);
        sliderBar.x = _width - sliderBar.width;
        sliderBar.y = 0;
        this.addChild(sliderBar);

        var btnHeight:Int = 10;
        var difference:Int = 0;

        if(_sprList.height > _height)
        {
            btnHeight = Std.int(_height * (_height/_sprList.height));
        }
        else
        {
            btnHeight = 10;
        }

        var rt:RenderTexture = new RenderTexture(Std.int(barWidth), btnHeight);
        rt.draw(new Quad(barWidth - 3, btnHeight, 0xffffff));
        sliderBtn = new Button(rt);
        addChild(sliderBtn);
        sliderBtn.x = sliderBar.x + 2;
        sliderBtn.y = sliderBar.y + 1;
        sliderBtn.scaleWhenDown = 1;
        sliderBtn.addEventListener(TouchEvent.TOUCH, onSliderTouch);

        minY = sliderBtn.y;
        maxY = _height;

        slideStart = sliderBtn.y + btnHeight;
    }

    private function onSliderTouch(e:TouchEvent):Void
    {
        var touch:Touch = e.getTouch(this);

        if (e.getTouches(sliderBtn, TouchPhase.MOVED).length > 0)
        {
            var touchPos:Float = touch.getLocation(this).y;

            if(prevY != 0)
            {
                if(touchPos > prevY)
                {
                    moveAmount = touchPos - prevY;
                    if (maxY >= (sliderBtn.y + sliderBtn.height + moveAmount))
                    {
                        sliderBtn.y += moveAmount;
                        //percent = 100 * (value - min) / (max - min)
                        slidePercentage = 100 * ((sliderBtn.y + sliderBtn.height) - slideStart) / (maxY - slideStart);
                        _sprList.y = 0 - ((_sprList.height - _height) * slidePercentage / 100);
                    }
                }
                else
                {
                    moveAmount = prevY - touchPos;
                    if (minY <= sliderBtn.y - moveAmount)
                    {
                        sliderBtn.y -= moveAmount;
                        slidePercentage = 100 * ((sliderBtn.y + sliderBtn.height) - slideStart) / (maxY - slideStart);
                        _sprList.y = 0 - ((_sprList.height - _height) * slidePercentage / 100);
                    }
                }
            }
            prevY = touchPos;
        }

        if (touch != null && touch.phase == TouchPhase.ENDED)
        {
            prevY = 0;
        }
        touch = null;
    }
}