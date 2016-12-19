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
 * Abstract interface class protocol_SystemCoherencyInterface for protocol SystemCoherencyInterface.
 */

#ifndef protocol_SystemCoherencyInterface_h_
#define protocol_SystemCoherencyInterface_h_

// Includes from the 'includes' section of this protocol
#line 24 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/SystemCoherencyInterface.lisa"

        namespace SystemCoherency {
            class DownstreamAction;
            class UpstreamAction;
        }
    
#line 28 "./Linux64-Release-GCC-4.9/gen/protocol_SystemCoherencyInterface.h"


// Abstract interface for protocol SystemCoherencyInterface
class protocol_SystemCoherencyInterface
{
public:
        virtual ~protocol_SystemCoherencyInterface() {}
        // Abstract protocol members
	virtual bool doDownstreamAction(const SystemCoherency::DownstreamAction& ) = 0;
	virtual bool doUpstreamAction(const SystemCoherency::UpstreamAction& ) = 0;

};

#endif /* protocol_SystemCoherencyInterface_h_ */

