{ pkgs, config, inputs, ... }:

{
  home.packages = [
    inputs.zen-browser.packages."x86_64-linux".specific
  ];
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
      "x-scheme-handler/about" = "zen.desktop";
      "x-scheme-handler/unknown" = "zen.desktop";
      "application/x-extension-htm" = "zen.desktop";
      "application/x-extension-html" = "zen.desktop";
      "application/x-extension-shtml" = "zen.desktop";
      "application/x-extension-xhtml" = "zen.desktop";
      "application/x-extension-xht" = "zen.desktop";
      "application/xhtml+xml" = "zen.desktop";

    };
  };
}

/*
[Default Applications]
x-scheme-handler/http=zen.desktop
x-scheme-handler/https=zen.desktop
text/html=zen.desktop
application/xhtml+xml=zen.desktop
x-scheme-handler/chrome=zen.desktop
application/x-extension-htm=zen.desktop
application/x-extension-html=zen.desktop
application/x-extension-shtml=zen.desktop
application/x-extension-xhtml=zen.desktop
application/x-extension-xht=zen.desktop

[Added Associations]
x-scheme-handler/http=zen.desktop;
x-scheme-handler/https=zen.desktop;
text/html=zen.desktop;
application/xhtml+xml=zen.desktop;
x-scheme-handler/chrome=zen.desktop;
application/x-extension-htm=zen.desktop;
application/x-extension-html=zen.desktop;
application/x-extension-shtml=zen.desktop;
application/x-extension-xhtml=zen.desktop;
application/x-extension-xht=zen.desktop;

*/
