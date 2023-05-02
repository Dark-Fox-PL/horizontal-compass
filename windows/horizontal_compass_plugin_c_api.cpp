#include "include/horizontal_compass/horizontal_compass_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "horizontal_compass_plugin.h"

void HorizontalCompassPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  horizontal_compass::HorizontalCompassPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
