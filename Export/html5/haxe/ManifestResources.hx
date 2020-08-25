package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__fonts_arkhip_font_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__fonts_caviardreams_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__fonts_bkant_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy34:assets%2Ftextures%2Fbackground.pngy4:sizei463219y4:typey5:IMAGEy2:idR1goR0y32:assets%2Ftextures%2FTHWORD-1.xmlR2i2947R3y4:TEXTR5R6goR0y32:assets%2Ftextures%2FTHWORD-1.pngR2i3467052R3R4R5R8goR0y32:assets%2Ftextures%2FTHWORD-0.pngR2i3514688R3R4R5R9goR0y32:assets%2Ftextures%2FTHWORD-0.xmlR2i2657R3R7R5R10goR0y32:assets%2Ftextures%2FTHWORD-2.xmlR2i4266R3R7R5R11goR0y32:assets%2Ftextures%2FTHWORD-2.pngR2i3182322R3R4R5R12goR0y32:assets%2Ftextures%2FTHWORD-3.pngR2i3626584R3R4R5R13goR0y32:assets%2Ftextures%2FTHWORD-3.xmlR2i7919R3R7R5R14goR0y32:assets%2Ftextures%2FTHWORD-4.xmlR2i7676R3R7R5R15goR0y32:assets%2Ftextures%2FTHWORD-4.pngR2i2944324R3R4R5R16goR0y44:assets%2Ftextures%2Fparticle%2Fhighscore.pexR2i2345R3R7R5R17goR0y40:assets%2Ftextures%2Fparticle%2Fbonus.pexR2i2326R3R7R5R18goR0y45:assets%2Ftextures%2Fparticle%2Fendgame-V2.pngR2i130380R3R4R5R19goR0y46:assets%2Ftextures%2Fparticle%2Fscore_check.pngR2i2320R3R4R5R20goR0y50:assets%2Ftextures%2Fparticle%2Fscore_backspace.pexR2i2344R3R7R5R21goR0y47:assets%2Ftextures%2Fparticle%2Fendurancebar.pexR2i2334R3R7R5R22goR0y47:assets%2Ftextures%2Fparticle%2Fendurancebar.pngR2i9063R3R4R5R23goR0y50:assets%2Ftextures%2Fparticle%2Fscore_backspace.pngR2i98291R3R4R5R24goR0y46:assets%2Ftextures%2Fparticle%2Fscore_check.pexR2i2334R3R7R5R25goR0y45:assets%2Ftextures%2Fparticle%2Fendgame-V2.pexR2i2353R3R7R5R26goR0y40:assets%2Ftextures%2Fparticle%2Fbonus.pngR2i14810R3R4R5R27goR0y44:assets%2Ftextures%2Fparticle%2Fhighscore.pngR2i27983R3R4R5R28goR0y50:assets%2Ftextures%2Fparticle%2Fshield_particle.pngR2i5193R3R4R5R29goR0y42:assets%2Ftextures%2Fparticle%2Fbandaid.pexR2i2331R3R7R5R30goR0y47:assets%2Ftextures%2Fparticle%2Fletter_light.pngR2i75928R3R4R5R31goR0y39:assets%2Ftextures%2Fparticle%2Fmenu.pngR2i30846R3R4R5R32goR0y48:assets%2Ftextures%2Fparticle%2Fgamescreen_bg.pexR2i2339R3R7R5R33goR0y45:assets%2Ftextures%2Fparticle%2Ffire_wrong.pexR2i2339R3R7R5R34goR0y45:assets%2Ftextures%2Fparticle%2Ffire_wrong.pngR2i35067R3R4R5R35goR0y48:assets%2Ftextures%2Fparticle%2Fgamescreen_bg.pngR2i4566R3R4R5R36goR0y39:assets%2Ftextures%2Fparticle%2Fmenu.pexR2i2343R3R7R5R37goR0y47:assets%2Ftextures%2Fparticle%2Fletter_light.pexR2i2333R3R7R5R38goR0y42:assets%2Ftextures%2Fparticle%2Fbandaid.pngR2i3434R3R4R5R39goR0y50:assets%2Ftextures%2Fparticle%2Fshield_particle.pexR2i2336R3R7R5R40goR2i78232R3y4:FONTy9:classNamey30:__ASSET__fonts_arkhip_font_ttfR5y23:fonts%2FArkhip_font.ttfy7:preloadtgoR2i58864R3R41R42y31:__ASSET__fonts_caviardreams_ttfR5y24:fonts%2FCaviarDreams.ttfR45tgoR2i155528R3R41R42y24:__ASSET__fonts_bkant_ttfR5y17:fonts%2FBKANT.TTFR45tgoR0y30:assets%2Fdata%2Fdictionary.txtR2i2707019R3R7R5R50goR0y31:assets%2Fdata%2Fasset-data.jsonR2i2242R3R7R5R51goR2i132052R3y5:MUSICR5y37:assets%2Faudio%2Fshield_explosion.mp3y9:pathGroupaR53hgoR2i42219R3R52R5y34:assets%2Faudio%2Fshield_whoosh.mp3R54aR55hgoR2i11744R3R52R5y26:assets%2Faudio%2Fspin5.mp3R54aR56hgoR2i95515R3R52R5y30:assets%2Faudio%2Fend_flame.mp3R54aR57hgoR2i154896R3R52R5y30:assets%2Faudio%2Fend_sword.mp3R54aR58hgoR2i79468R3R52R5y29:assets%2Faudio%2Fcorrect1.mp3R54aR59hgoR2i150599R3R52R5y31:assets%2Faudio%2Fbest_score.mp3R54aR60hgoR2i16966R3R52R5y27:assets%2Faudio%2Fclick3.mp3R54aR61hgoR2i138810R3R52R5y30:assets%2Faudio%2Fspin_done.mp3R54aR62hgoR2i22839R3R52R5y26:assets%2Faudio%2Fspark.mp3R54aR63hgoR2i12787R3R52R5y27:assets%2Faudio%2Fclick2.mp3R54aR64hgoR2i7321240R3R52R5y31:assets%2Faudio%2Fmenu_music.mp3R54aR65hgoR2i16962R3R52R5y27:assets%2Faudio%2Fclick1.mp3R54aR66hgoR2i124194R3R52R5y31:assets%2Faudio%2Flevel_bell.mp3R54aR67hgoR2i93918R3R52R5y27:assets%2Faudio%2Frepeat.mp3R54aR68hgoR2i35668R3R52R5y26:assets%2Faudio%2Fwrong.mp3R54aR69hgoR2i8223837R3R52R5y35:assets%2Faudio%2Frampage_music2.mp3R54aR70hgoR0y24:particle%2Fhighscore.pexR2i2345R3R7R5R71R45tgoR0y20:particle%2Fbonus.pexR2i2326R3R7R5R72R45tgoR0y25:particle%2Fendgame-V2.pngR2i130380R3R4R5R73R45tgoR0y26:particle%2Fscore_check.pngR2i2320R3R4R5R74R45tgoR0y30:particle%2Fscore_backspace.pexR2i2344R3R7R5R75R45tgoR0y27:particle%2Fendurancebar.pexR2i2334R3R7R5R76R45tgoR0y27:particle%2Fendurancebar.pngR2i9063R3R4R5R77R45tgoR0y30:particle%2Fscore_backspace.pngR2i98291R3R4R5R78R45tgoR0y26:particle%2Fscore_check.pexR2i2334R3R7R5R79R45tgoR0y25:particle%2Fendgame-V2.pexR2i2353R3R7R5R80R45tgoR0y20:particle%2Fbonus.pngR2i14810R3R4R5R81R45tgoR0y24:particle%2Fhighscore.pngR2i27983R3R4R5R82R45tgoR0y30:particle%2Fshield_particle.pngR2i5193R3R4R5R83R45tgoR0y22:particle%2Fbandaid.pexR2i2331R3R7R5R84R45tgoR0y27:particle%2Fletter_light.pngR2i75928R3R4R5R85R45tgoR0y19:particle%2Fmenu.pngR2i30846R3R4R5R86R45tgoR0y28:particle%2Fgamescreen_bg.pexR2i2339R3R7R5R87R45tgoR0y25:particle%2Ffire_wrong.pexR2i2339R3R7R5R88R45tgoR0y25:particle%2Ffire_wrong.pngR2i35067R3R4R5R89R45tgoR0y28:particle%2Fgamescreen_bg.pngR2i4566R3R4R5R90R45tgoR0y19:particle%2Fmenu.pexR2i2343R3R7R5R91R45tgoR0y27:particle%2Fletter_light.pexR2i2333R3R7R5R92R45tgoR0y22:particle%2Fbandaid.pngR2i3434R3R4R5R93R45tgoR0y30:particle%2Fshield_particle.pexR2i2336R3R7R5R94R45tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_background_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_thword_1_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_thword_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_thword_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_thword_0_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_thword_2_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_thword_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_thword_3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_thword_3_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_thword_4_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_thword_4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_highscore_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_bonus_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_endgame_v2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_score_check_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_score_backspace_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_endurancebar_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_endurancebar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_score_backspace_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_score_check_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_endgame_v2_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_bonus_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_highscore_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_shield_particle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_bandaid_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_letter_light_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_menu_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_gamescreen_bg_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_fire_wrong_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_fire_wrong_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_gamescreen_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_menu_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_letter_light_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_bandaid_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_textures_particle_shield_particle_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__fonts_arkhip_font_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__fonts_caviardreams_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__fonts_bkant_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_dictionary_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_asset_data_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_audio_shield_explosion_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_audio_shield_whoosh_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_audio_spin5_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_audio_end_flame_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_audio_end_sword_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_audio_correct1_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_audio_best_score_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_audio_click3_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_audio_spin_done_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_audio_spark_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_audio_click2_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_audio_menu_music_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_audio_click1_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_audio_level_bell_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_audio_repeat_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_audio_wrong_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_audio_rampage_music2_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_highscore_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_bonus_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_endgame_v2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_score_check_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_score_backspace_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_endurancebar_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_endurancebar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_score_backspace_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_score_check_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_endgame_v2_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_bonus_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_highscore_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_shield_particle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_bandaid_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_letter_light_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_menu_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_gamescreen_bg_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_fire_wrong_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_fire_wrong_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_gamescreen_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_menu_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_letter_light_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_bandaid_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__particle_shield_particle_pex extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/textures/particle/highscore.pex") @:noCompletion #if display private #end class __ASSET__particle_highscore_pex extends haxe.io.Bytes {}
@:keep @:file("assets/textures/particle/bonus.pex") @:noCompletion #if display private #end class __ASSET__particle_bonus_pex extends haxe.io.Bytes {}
@:keep @:image("assets/textures/particle/endgame-V2.png") @:noCompletion #if display private #end class __ASSET__particle_endgame_v2_png extends lime.graphics.Image {}
@:keep @:image("assets/textures/particle/score_check.png") @:noCompletion #if display private #end class __ASSET__particle_score_check_png extends lime.graphics.Image {}
@:keep @:file("assets/textures/particle/score_backspace.pex") @:noCompletion #if display private #end class __ASSET__particle_score_backspace_pex extends haxe.io.Bytes {}
@:keep @:file("assets/textures/particle/endurancebar.pex") @:noCompletion #if display private #end class __ASSET__particle_endurancebar_pex extends haxe.io.Bytes {}
@:keep @:image("assets/textures/particle/endurancebar.png") @:noCompletion #if display private #end class __ASSET__particle_endurancebar_png extends lime.graphics.Image {}
@:keep @:image("assets/textures/particle/score_backspace.png") @:noCompletion #if display private #end class __ASSET__particle_score_backspace_png extends lime.graphics.Image {}
@:keep @:file("assets/textures/particle/score_check.pex") @:noCompletion #if display private #end class __ASSET__particle_score_check_pex extends haxe.io.Bytes {}
@:keep @:file("assets/textures/particle/endgame-V2.pex") @:noCompletion #if display private #end class __ASSET__particle_endgame_v2_pex extends haxe.io.Bytes {}
@:keep @:image("assets/textures/particle/bonus.png") @:noCompletion #if display private #end class __ASSET__particle_bonus_png extends lime.graphics.Image {}
@:keep @:image("assets/textures/particle/highscore.png") @:noCompletion #if display private #end class __ASSET__particle_highscore_png extends lime.graphics.Image {}
@:keep @:image("assets/textures/particle/shield_particle.png") @:noCompletion #if display private #end class __ASSET__particle_shield_particle_png extends lime.graphics.Image {}
@:keep @:file("assets/textures/particle/bandaid.pex") @:noCompletion #if display private #end class __ASSET__particle_bandaid_pex extends haxe.io.Bytes {}
@:keep @:image("assets/textures/particle/letter_light.png") @:noCompletion #if display private #end class __ASSET__particle_letter_light_png extends lime.graphics.Image {}
@:keep @:image("assets/textures/particle/menu.png") @:noCompletion #if display private #end class __ASSET__particle_menu_png extends lime.graphics.Image {}
@:keep @:file("assets/textures/particle/gamescreen_bg.pex") @:noCompletion #if display private #end class __ASSET__particle_gamescreen_bg_pex extends haxe.io.Bytes {}
@:keep @:file("assets/textures/particle/fire_wrong.pex") @:noCompletion #if display private #end class __ASSET__particle_fire_wrong_pex extends haxe.io.Bytes {}
@:keep @:image("assets/textures/particle/fire_wrong.png") @:noCompletion #if display private #end class __ASSET__particle_fire_wrong_png extends lime.graphics.Image {}
@:keep @:image("assets/textures/particle/gamescreen_bg.png") @:noCompletion #if display private #end class __ASSET__particle_gamescreen_bg_png extends lime.graphics.Image {}
@:keep @:file("assets/textures/particle/menu.pex") @:noCompletion #if display private #end class __ASSET__particle_menu_pex extends haxe.io.Bytes {}
@:keep @:file("assets/textures/particle/letter_light.pex") @:noCompletion #if display private #end class __ASSET__particle_letter_light_pex extends haxe.io.Bytes {}
@:keep @:image("assets/textures/particle/bandaid.png") @:noCompletion #if display private #end class __ASSET__particle_bandaid_png extends lime.graphics.Image {}
@:keep @:file("assets/textures/particle/shield_particle.pex") @:noCompletion #if display private #end class __ASSET__particle_shield_particle_pex extends haxe.io.Bytes {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}

@:keep @:noCompletion #if display private #end class __ASSET__fonts_arkhip_font_ttf extends lime.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "fonts/Arkhip_font"; name = "Arkhip"; super (); }}
@:keep @:noCompletion #if display private #end class __ASSET__fonts_caviardreams_ttf extends lime.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "fonts/CaviarDreams"; name = "Caviar Dreams"; super (); }}
@:keep @:noCompletion #if display private #end class __ASSET__fonts_bkant_ttf extends lime.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "fonts/BKANT"; name = "Book Antiqua"; super (); }}


#else

@:keep @:expose('__ASSET__fonts_arkhip_font_ttf') @:noCompletion #if display private #end class __ASSET__fonts_arkhip_font_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "fonts/Arkhip_font"; #else ascender = 851; descender = -349; height = 1200; numGlyphs = 223; underlinePosition = -99; underlineThickness = 50; unitsPerEM = 1000; #end name = "Arkhip"; super (); }}
@:keep @:expose('__ASSET__fonts_caviardreams_ttf') @:noCompletion #if display private #end class __ASSET__fonts_caviardreams_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "fonts/CaviarDreams"; #else ascender = 2005; descender = -375; height = 2380; numGlyphs = 578; underlinePosition = -292; underlineThickness = 150; unitsPerEM = 2048; #end name = "Caviar Dreams"; super (); }}
@:keep @:expose('__ASSET__fonts_bkant_ttf') @:noCompletion #if display private #end class __ASSET__fonts_bkant_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "fonts/BKANT"; #else ascender = 1891; descender = -578; height = 2469; numGlyphs = 669; underlinePosition = -327; underlineThickness = 119; unitsPerEM = 2048; #end name = "Book Antiqua"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__fonts_arkhip_font_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__fonts_arkhip_font_ttf extends openfl.text.Font { public function new () { name = "Arkhip"; super (); }}
@:keep @:expose('__ASSET__OPENFL__fonts_caviardreams_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__fonts_caviardreams_ttf extends openfl.text.Font { public function new () { name = "Caviar Dreams"; super (); }}
@:keep @:expose('__ASSET__OPENFL__fonts_bkant_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__fonts_bkant_ttf extends openfl.text.Font { public function new () { name = "Book Antiqua"; super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__fonts_arkhip_font_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__fonts_arkhip_font_ttf extends openfl.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "fonts/Arkhip_font"; name = "Arkhip"; super (); }}
@:keep @:expose('__ASSET__OPENFL__fonts_caviardreams_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__fonts_caviardreams_ttf extends openfl.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "fonts/CaviarDreams"; name = "Caviar Dreams"; super (); }}
@:keep @:expose('__ASSET__OPENFL__fonts_bkant_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__fonts_bkant_ttf extends openfl.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "fonts/BKANT"; name = "Book Antiqua"; super (); }}

#end

#end
#end

#end
