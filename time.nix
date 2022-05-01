{ config, pkgs, ... }:

{
  time.timeZone = "Asia/Shanghai";
  time.hardwareClockInLocalTime = true;
}