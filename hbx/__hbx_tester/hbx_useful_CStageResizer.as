import flash.display.MovieClip;
import flash.events.Event;
import flash.net.URLRequest;
import hbx.utils.MURLLoaderUtil;
import hbx.tools.MDebugTool;
import hbx.useful.CStageResizer;



var _thm:MovieClip = this;


//CStageResizer.defaulter(_thm.stage);
CStageResizer.recter(_thm.stage);
CStageResizer.create(_thm, mcRect.width, mcRect.height);
