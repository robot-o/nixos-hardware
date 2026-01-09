{
  lib,
  pkgs,
  config,
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

  services.powertop.enable = lib.mkDefault true;
  services.system76-scheduler.enable = lib.mkDefault true;
  services.system76-scheduler.settings.cfsProfiles.enable = lib.mkDefault true;
  services.thermald.enable = lib.mkDefault true;
  hardware.system76.power-daemon.enable = lib.mkDefault true;
  services.power-profiles-daemon.enable = lib.mkDefault true;
  # Alternate solution using tlp: (disable ppd and thermald if using this)
  # services.tlp = {
  #   enable = lib.mkDefault true;
  #   settings = lib.mkDefault {
  #     CPU_BOOST_ON_AC = 1;
  #     CPU_BOOST_ON_BAT = 1;
  #     CPU_HWP_DYN_BOOST_ON_AC = 1;
  #     CPU_HWP_DYN_BOOST_ON_BAT = 1;
  #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  #     CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
  #     CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
  #     PLATFORM_PROFILE_ON_AC = "performance";
  #     PLATFORM_PROFILE_ON_BAT = "balanced";
  #     START_CHARGE_TRESH_BAT0 = 65;
  #     STOP_CHARGE_TRESH_BAT0 = 71;
  #   };
  # };
}
