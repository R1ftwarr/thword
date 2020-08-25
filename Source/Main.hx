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

package;

import openfl.display.Sprite;

import com.glasirgames.thword.config.ModelConfig;
import com.glasirgames.thword.config.CommandConfig;
import com.glasirgames.thword.config.ServiceConfig;
import com.glasirgames.thword.config.ViewConfig;

import robotlegs.bender.bundles.mvcs.MVCSBundle;
import robotlegs.bender.bundles.stage3D.Stage3DBundle;
import robotlegs.bender.bundles.stage3D.StarlingBundle;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.impl.Context;

import com.glasirgames.thword.Settings;

class Main extends Sprite {
	
    private var _context:IContext;

	public function new()
	{
		super ();

        Settings.getInstance().stageWidth = stage.stageWidth;
        Settings.getInstance().stageHeight = stage.stageHeight;
        Settings.getInstance().scale = 1;

		_context = new Context()
        .install(MVCSBundle, Stage3DBundle, StarlingBundle)
        .configure(ModelConfig, CommandConfig, ServiceConfig, ViewConfig)
        .configure(new ContextView(this));
	}
}