{ config, lib, pkgs, inputs, ... }:
let
  # 上游 ashell 在收到 `StatusNotifierItemRegistered` 时会拆掉并重建整个 tray 事件流，
  # 重建期间到达的 `StatusNotifierItemUnregistered` 会被丢掉：应用（例如 fcitx5）
  # 重启时新条目先注册、旧 bus name 后消失，正好落在这个窗口里，于是旧图标永久残留。
  # 补丁让每次重建后按 watcher 的权威条目列表对账（Sync），并修正 watcher 里
  # “先发注册信号、后登记条目”的顺序问题，同时避免单个坏条目拖垮整个 tray 服务。
  # 另外 watcher 处理 `NameOwnerChanged` 时只按 unique name 匹配就删条目，而总线在
  # unique name **获得**时也会发这个信号（`new_owner` 非空）；客户端连上后立刻注册，
  # 那条“获名”事件晚于注册被处理时，会把刚登记的条目删掉（fcitx5 重启后图标消失），
  # 补丁要求 `new_owner` 为空才删除。
  ashell = inputs.ashell.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [ ./tray-unregister-leak.patch ];
  });
in
{
  environment.systemPackages = [
    ashell
  ];
}
