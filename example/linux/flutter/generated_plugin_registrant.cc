//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <horizontal_compass/horizontal_compass_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) horizontal_compass_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "HorizontalCompassPlugin");
  horizontal_compass_plugin_register_with_registrar(horizontal_compass_registrar);
}
