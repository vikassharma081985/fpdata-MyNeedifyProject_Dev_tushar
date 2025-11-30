using System.Web.Optimization;

namespace Bundle
{
    public class BundleConfig
    {
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/WebFormsJs").Include(
                  "~/Scripts/jquery-3.1.1.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/MsAjaxJs").Include(
                  "~/Scripts/jquery.extensions.js",
                  "~/Scripts/jquery.tablednd.js", "~/Scripts/jquery.blockUI.js"));

             bundles.Add(new ScriptBundle("~/bundles/handsontable").Include(
                  "~/Scripts/handsontable/handsontable.full.min.js"));

             bundles.Add(new ScriptBundle("~/bundles/JQueryUIJs").Include(
                "~/Scripts/jquery-ui.js"));

 bundles.Add(new ScriptBundle("~/bundles/Chosen").Include(
               "~/Scripts/chosen.jquery.js"));
            // Use the Development version of Modernizr to develop with and learn from. Then, when you’re
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/ResultEntry").Include(
               "~/Scripts/Jcrop-Master/js/jquery.Jcrop.min.js", "~/Scripts/uploadify/jquery.uploadify.js", "~/Scripts/fancybox/jquery.fancybox.pack.js", "~/Scripts/ResultEntryJS.js"));


        }
    }
}