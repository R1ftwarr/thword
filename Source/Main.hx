package;


import openfl.display.Sprite;

import com.educationcurb.thword.config.ModelConfig;
import com.educationcurb.thword.config.CommandConfig;
import com.educationcurb.thword.config.ServiceConfig;
import com.educationcurb.thword.config.ViewConfig;

import robotlegs.bender.bundles.mvcs.MVCSBundle;
import robotlegs.bender.bundles.stage3D.Stage3DBundle;
import robotlegs.bender.bundles.stage3D.StarlingBundle;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.impl.Context;

import com.educationcurb.thword.Settings;

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