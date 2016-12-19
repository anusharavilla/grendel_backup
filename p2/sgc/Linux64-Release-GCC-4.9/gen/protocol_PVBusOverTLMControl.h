/*
 * 
 *
 * This is an automatically generated file. Do not edit.
 *
 * Copyright 2007 ARM Limited.
 * Copyright 2011 ARM Limited.
 *
 * All rights reserved.
 */

/** \file
 * Abstract interface class protocol_PVBusOverTLMControl for protocol PVBusOverTLMControl.
 */

#ifndef protocol_PVBusOverTLMControl_h_
#define protocol_PVBusOverTLMControl_h_

// Includes from the 'includes' section of this protocol
#line 24 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVBus2AMBAPVACE.lisa"

        enum BUS_RouteOption
        {
            ROUTE_TO_TLM = 0,
            ROUTE_TO_PVBUS = 1
        };
    
#line 29 "./Linux64-Release-GCC-4.9/gen/protocol_PVBusOverTLMControl.h"


// Abstract interface for protocol PVBusOverTLMControl
class protocol_PVBusOverTLMControl
{
public:
        virtual ~protocol_PVBusOverTLMControl() {}
        // Abstract protocol members
	virtual bool routeAccesses(BUS_RouteOption destination) = 0;

};

#endif /* protocol_PVBusOverTLMControl_h_ */

