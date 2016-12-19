/*
 * 
 *
 * This is an automatically generated file. Do not edit.
 *
 * Copyright 2009 ARM Limited.
 * Copyright 2011 ARM Limited.
 *
 * All rights reserved.
 */
/** \file
 * System components.
 */

#ifndef _NO_CORE_Components_h_
#define _NO_CORE_Components_h_

#include <eslapi/eslapi_stdint.h>

#include <string>
#include <vector>
#include "MaxCoreVersion.h"

// clean way to get the name of the generated class for a component (e.g. for behavior return types for types defined in the resources section)
#define COMPONENT_CLASS_NAME(compName) Component__##compName

// collected defines start
#define MAXCORE_VERSION  "10 + 3.0.37"
#define SYSTEM_GENERATOR_VERSION  "10.0.37"
#define GEN_SBOX  1
#define GEN_SYSTEM_PLATFORM  1
#define linux  1
#define SIMGEN_RELEASE  1
#define NDEBUG  1

// collected defines end

#include "CADIProtocol.h"

#include "MCPagedMemory.h"
#include "MCNonPagedMemory.h"
#include "sg/SGSimulationContext.h"
#include "sg/SGComponentFactory.h"
class ObjectLoader;

#include "SGComponentWithPorts.h"

#include "Cortex_DSO.h"

// include protocols
#include "Cortex__Builtin__AddressablePortProtocol_ClassDef.h"
#include "Cortex__Builtin__ControlProtocol_ClassDef.h"

// legacy: collected includes from components


// collected includes from components


sg::ComponentFactory *PVBusBridge_GetFactory();
sg::ComponentFactory *PVBusDecoder_GetFactory();
sg::ComponentFactory *ClockDivider_GetFactory();
sg::ComponentFactory *MasterClock_GetFactory();
sg::ComponentFactory *ARMCortexM0CT_GetFactory();


namespace Cortex_NMS {

// declare all components (forward decls)
class Component__Cortex;
class Component__PVBus2AMBAPV;


// legacy: component class declarations


// legacy: component class definitions


// component factory prototypes
sg::ComponentFactory *Cortex_GetFactory();
sg::ComponentFactory *PVBus2AMBAPV_GetFactory();


} // namespace Cortex_NMS

#endif

