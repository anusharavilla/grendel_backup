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
 * Abstract interface class protocol_CCIInterconnectControl for protocol CCIInterconnectControl.
 */

#ifndef protocol_CCIInterconnectControl_h_
#define protocol_CCIInterconnectControl_h_

// Includes from the 'includes' section of this protocol
#line 197 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVCache.lisa"

        namespace CCIInterconnect { class control_if; }
    
#line 25 "./Linux64-Release-GCC-4.9/gen/protocol_CCIInterconnectControl.h"


// Abstract interface for protocol CCIInterconnectControl
class protocol_CCIInterconnectControl
{
public:
        virtual ~protocol_CCIInterconnectControl() {}
        // Abstract protocol members
	virtual CCIInterconnect::control_if* getControlIf() = 0;

};

#endif /* protocol_CCIInterconnectControl_h_ */

