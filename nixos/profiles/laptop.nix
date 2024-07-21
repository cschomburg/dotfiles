{ config, lib, pkgs, ... }:

{
  boot = {
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };

  hardware.firmware = [ pkgs.firmwareLinuxNonfree ];
  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings.General = {
    FastConnectable = true;
  };
  hardware.cpu.intel.updateMicrocode = true;

  hardware.bluetooth.package = lib.mkDefault (
    pkgs.bluez5-experimental.overrideAttrs rec {
      version = "5.76";
      src = pkgs.fetchurl {
        url = "mirror://kernel/linux/bluetooth/bluez-${version}.tar.xz";
        hash = "sha256-VeLGRZCa2C2DPELOhewgQ04O8AcJQbHqtz+s3SQLvWM=";
      };
    }
  );

  hardware.pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];

  hardware.opengl.extraPackages = with pkgs; [
    intel-vaapi-driver
    # vaapiVdpau
    # libvdpau-va-gl
    intel-media-driver
  ];
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
  environment.sessionVariables.VDPAU_DRIVER = "va_gl";

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
    };
  };

  services.throttled = {
    enable = true;
    extraConfig = ''
      [GENERAL]
      # Enable or disable the script execution
      Enabled: True
      # SYSFS path for checking if the system is running on AC power
      Sysfs_Power_Path: /sys/class/power_supply/AC*/online
      # Auto reload config on changes
      Autoreload: True
      
      ## Settings to apply while connected to Battery power
      [BATTERY]
      # Update the registers every this many seconds
      Update_Rate_s: 30
      # Max package power for time window #1
      PL1_Tdp_W: 29
      # Time window #1 duration
      PL1_Duration_s: 28
      # Max package power for time window #2
      PL2_Tdp_W: 44
      # Time window #2 duration
      PL2_Duration_S: 0.002
      # Max allowed temperature before throttling
      Trip_Temp_C: 85
      # Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
      cTDP: 0
      # Disable BDPROCHOT (EXPERIMENTAL)
      Disable_BDPROCHOT: False
      
      ## Settings to apply while connected to AC power
      [AC]
      # Update the registers every this many seconds
      Update_Rate_s: 5
      # Max package power for time window #1
      PL1_Tdp_W: 44
      # Time window #1 duration
      PL1_Duration_s: 28
      # Max package power for time window #2
      PL2_Tdp_W: 44
      # Time window #2 duration
      PL2_Duration_S: 0.002
      # Max allowed temperature before throttling
      Trip_Temp_C: 90
      # Set HWP energy performance hints to 'performance' on high load (EXPERIMENTAL)
      # Uncomment only if you really want to use it
      # HWP_Mode: False
      # Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
      cTDP: 0
      # Disable BDPROCHOT (EXPERIMENTAL)
      Disable_BDPROCHOT: False
      
      # All voltage values are expressed in mV and *MUST* be negative (i.e. undervolt)! 
      [UNDERVOLT.BATTERY]
      # CPU core voltage offset (mV)
      CORE: 0
      # Integrated GPU voltage offset (mV)
      GPU: 0
      # CPU cache voltage offset (mV)
      CACHE: 0
      # System Agent voltage offset (mV)
      UNCORE: 0
      # Analog I/O voltage offset (mV)
      ANALOGIO: 0
      
      # All voltage values are expressed in mV and *MUST* be negative (i.e. undervolt)!
      [UNDERVOLT.AC]
      # CPU core voltage offset (mV)
      CORE: 0
      # Integrated GPU voltage offset (mV)
      GPU: 0
      # CPU cache voltage offset (mV)
      CACHE: 0
      # System Agent voltage offset (mV)
      UNCORE: 0
      # Analog I/O voltage offset (mV)
      ANALOGIO: 0
      
      # [ICCMAX.AC]
      # # CPU core max current (A)
      # CORE: 
      # # Integrated GPU max current (A)
      # GPU: 
      # # CPU cache max current (A)
      # CACHE: 
      
      # [ICCMAX.BATTERY]
      # # CPU core max current (A)
      # CORE: 
      # # Integrated GPU max current (A)
      # GPU: 
      # # CPU cache max current (A)
      # CACHE: 
    '';
  };

  services.fwupd.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";
}
