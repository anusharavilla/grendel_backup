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
 * Abstract interface class protocol_StateSignal for protocol StateSignal.
 */

#ifndef protocol_StateSignal_h_
#define protocol_StateSignal_h_

// Includes from the 'includes' section of this protocol
#line 34 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/SignalProtocol.lisa"

        #include "sg/SGSignal.h"
    
#line 25 "./Linux64-Release-GCC-4.9/gen/protocol_StateSignal.h"


// Abstract interface for protocol StateSignal
class protocol_StateSignal
{
public:
        virtual ~protocol_StateSignal() {}
        // Abstract protocol members
	virtual void setValue(sg::Signal::State ) = 0;
	virtual sg::Signal::State getValue() = 0;

};

#endif /* protocol_StateSignal_h_ */

