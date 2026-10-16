# Rambox 3.x 还没有进 nixpkgs（那边仍停在 2.6.3，而上游 2.x 已停止支持）。
#
# 这个文件就是 nixpkgs `pkgs/by-name/ra/rambox/package.nix` 的配方，唯一区别是
# 版本/hash 换成了官方 release 仓库（https://github.com/ramboxapp/download）
# 里当前的 3.x AppImage —— 3.x 的 AppImage 内部布局和 2.6.3 相同
# （二进制 `rambox`、图标 `usr/share/icons/hicolor/*/apps/rambox.png`）。
#
# 由 `../default.nix` 里的 overlay 通过 `prev.callPackage ./rambox { }` 引入。
#
# 升级方式：改下面的 `version`，把 hash 留成 `lib.fakeHash` 之后构建一次，
# 报错信息里会给出新的正确 hash。
{
  appimageTools,
  lib,
  fetchurl,
  makeDesktopItem,
  procps,
}:

appimageTools.wrapType2 rec {
  pname = "rambox";
  version = "3.1.1";

  src = fetchurl {
    url = "https://github.com/ramboxapp/download/releases/download/v${version}/Rambox-${version}-linux-x64.AppImage";
    hash = "sha256-u/g1WDA/Tgfprykh2dcHYB2cvABp6UBJVJKS19rAyF8=";
  };

  desktopItem = makeDesktopItem {
    desktopName = "Rambox";
    name = "rambox";
    # `%U` 用于接收 Rambox 自己的 deep link（浏览器登录完成后回调 rambox://...）
    exec = "rambox %U";
    icon = "rambox";
    categories = [ "Network" ];
    # 必须声明这个 scheme handler，否则浏览器登录完无法把 rambox:// 回调交给客户端
    # （AppImage 自带 desktop 项里就是 `MimeType=x-scheme-handler/rambox;`）
    mimeTypes = [ "x-scheme-handler/rambox" ];
    # AppImage 自带 desktop 项里的 StartupWMClass=rambox，用于窗口/图标关联
    startupWMClass = "rambox";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };

  extraInstallCommands = ''
    mkdir -p $out/share/applications $out/share/icons/hicolor/256x256/apps
    install -Dm644 ${appimageContents}/usr/share/icons/hicolor/256x256/apps/rambox*.png $out/share/icons/hicolor/256x256/apps/rambox.png
    install -Dm644 ${desktopItem}/share/applications/* $out/share/applications
  '';

  extraPkgs = _: [ procps ];

  meta = {
    description = "Workspace Simplifier - a cross-platform application organizing web services into Workspaces similar to browser profiles";
    homepage = "https://rambox.app";
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ nazarewk ];
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}
