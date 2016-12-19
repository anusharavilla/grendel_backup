/*
 * 
 *
 * Copyright 2009 ARM Limited.
 * Copyright 2011 ARM Limited.
 *
 * All rights reserved.
 */
/** \file
 * Constructors for CADI wrapper classes. Put in a separate compilation unit
 * so we can compile it without optimisation which is very slow with some
 * versions of some compilers.
 */



#include "GlobalDefs.h"
#include "Components.h"
// includes for components in this file
#include "Component__Cortex_ClassDef.h"
#include "Component__PVBus2AMBAPV_ClassDef.h"


#include "sg/FastDelegate.h"

using namespace fastdelegate;
using namespace Cortex_NMS;

// ------------------------------------------------------------------------------
// CADI Interface for component Component__Cortex
// ------------------------------------------------------------------------------

namespace Cortex_NMS {

class Component__Cortex_CADI : public sg::CADIBase
{
public:
        Component__Cortex_CADI(Component__Cortex* parentComponent, sg::ComponentBase* simulationEngine);

    eslapi::CADIReturn_t CADIXfaceBypass(uint32_t commandLength, const char *command, uint32_t maxResponseLength, char *response);

private:
    Component__Cortex *component;
};

} // Cortex_NMS
// ------------------------------------------------------------------------------
// CADI Interface for component Component__PVBus2AMBAPV
// ------------------------------------------------------------------------------

namespace Cortex_NMS {

class Component__PVBus2AMBAPV_CADI : public sg::CADIBase
{
public:
        Component__PVBus2AMBAPV_CADI(Component__PVBus2AMBAPV* parentComponent, sg::ComponentBase* simulationEngine);

    eslapi::CADIReturn_t CADIXfaceBypass(uint32_t commandLength, const char *command, uint32_t maxResponseLength, char *response);

private:
    Component__PVBus2AMBAPV *component;
};

} // Cortex_NMS


// ------------------------------------------------------------------------------
// CADI Interface for component Component__Cortex
// ------------------------------------------------------------------------------

#include "Component__Cortex_ClassDef.h"

namespace Cortex_NMS {

// constructor
Component__Cortex_CADI::Component__Cortex_CADI(Component__Cortex* parentComponent, sg::ComponentBase* simulationEngine) :
    sg::CADIBase(parentComponent ? parentComponent->getName() : "", simulationEngine),
    component(parentComponent)
{



        // memory blocks
        uint32_t emptySupportedMultiplesOfMAU[32];
        memset(emptySupportedMultiplesOfMAU, 0, sizeof(emptySupportedMultiplesOfMAU));



        // additional data which is referenced in the data structures




    strcpy( features.targetName, "Cortex" );
    strcpy( features.targetVersion, "" );
    features.fProfilingAvailable = false;
    features.nExtendedTargetFeaturesRegNumValid = true;
    features.nExtendedTargetFeaturesRegNum = 0;
    features.nPCRegNum = eslapi::CADI_INVALID_REGISTER_ID;
}


eslapi::CADIReturn_t
Component__Cortex_CADI::CADIXfaceBypass(uint32_t commandLength, const char *command, uint32_t maxResponseLength, char *response)
{
    if (!command || (commandLength == 0))
        return eslapi::CADI_STATUS_IllegalArgument;

    const char *param = 0;

    if (IsBypassCommand(commandLength, command, "GetFeatures", &param))
    {
        if ((maxResponseLength > 0) && (response != 0))
        {
            // Feel free to add more features here using the syntax :feature:otherfeature:morefeatures:...:
            strncpy(response,
                    "::MAXVIEWGEN:",
                    maxResponseLength);
            response[maxResponseLength - 1] = 0;
            return eslapi::CADI_STATUS_OK;
        }
        else
            return eslapi::CADI_STATUS_IllegalArgument;
    }
    else
        return CADIBase::CADIXfaceBypass(commandLength, command, maxResponseLength, response);
}

} // Cortex_NMS
// ------------------------------------------------------------------------------
// CADI Interface for component Component__PVBus2AMBAPV
// ------------------------------------------------------------------------------

#include "Component__PVBus2AMBAPV_ClassDef.h"

namespace Cortex_NMS {

// constructor
Component__PVBus2AMBAPV_CADI::Component__PVBus2AMBAPV_CADI(Component__PVBus2AMBAPV* parentComponent, sg::ComponentBase* simulationEngine) :
    sg::CADIBase(parentComponent ? parentComponent->getName() : "", simulationEngine),
    component(parentComponent)
{



        // memory blocks
        uint32_t emptySupportedMultiplesOfMAU[32];
        memset(emptySupportedMultiplesOfMAU, 0, sizeof(emptySupportedMultiplesOfMAU));



        // additional data which is referenced in the data structures




    strcpy( features.targetName, "PVBus2AMBAPV" );
    strcpy( features.targetVersion, "1.0" );
    features.fProfilingAvailable = false;
    features.nExtendedTargetFeaturesRegNumValid = true;
    features.nExtendedTargetFeaturesRegNum = 0;
    features.nPCRegNum = eslapi::CADI_INVALID_REGISTER_ID;
}


eslapi::CADIReturn_t
Component__PVBus2AMBAPV_CADI::CADIXfaceBypass(uint32_t commandLength, const char *command, uint32_t maxResponseLength, char *response)
{
    if (!command || (commandLength == 0))
        return eslapi::CADI_STATUS_IllegalArgument;

    const char *param = 0;

    if (IsBypassCommand(commandLength, command, "GetFeatures", &param))
    {
        if ((maxResponseLength > 0) && (response != 0))
        {
            // Feel free to add more features here using the syntax :feature:otherfeature:morefeatures:...:
            strncpy(response,
                    "::MAXVIEWGEN:",
                    maxResponseLength);
            response[maxResponseLength - 1] = 0;
            return eslapi::CADI_STATUS_OK;
        }
        else
            return eslapi::CADI_STATUS_IllegalArgument;
    }
    else
        return CADIBase::CADIXfaceBypass(commandLength, command, maxResponseLength, response);
}

} // Cortex_NMS

