{ config, lib, pkgs, inputs, ... }:
let
  # 上游 ashell 在收到 `StatusNotifierItemRegistered` 时会拆掉并重建整个 tray 事件流，
  # 重建期间到达的 `StatusNotifierItemUnregistered` 会被丢掉：应用（例如 fcitx5）
  # 重启时新条目先注册、旧 bus name 后消失，正好落在这个窗口里，于是旧图标永久残留。
  # 补丁让每次重建后按 watcher 的权威条目列表对账（Sync），并修正 watcher 里
  # “先发注册信号、后登记条目”的顺序问题，同时避免单个坏条目拖垮整个 tray 服务。
  ashell = inputs.ashell.packages.${pkgs.system}.default.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [ ./tray-unregister-leak.patch ];
  });
in
{
  environment.systemPackages = [
    ashell
  ];
}
