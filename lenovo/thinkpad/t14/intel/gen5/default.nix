{
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../../.
    ../../../../../common/cpu/intel/meteor-lake
  ];

  boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "6.8") pkgs.linuxPackages_latest;

  # TODO: Looking for feedback - modern Intel CPUs don't typically need throttled service
  # which can interfere with newer power management on Meteor Lake
  services.throttled.enable = lib.mkDefault false;
}
