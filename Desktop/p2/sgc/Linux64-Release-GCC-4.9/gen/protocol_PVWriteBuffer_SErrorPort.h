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
 * Abstract interface class protocol_PVWriteBuffer_SErrorPort for protocol PVWriteBuffer_SErrorPort.
 */

#ifndef protocol_PVWriteBuffer_SErrorPort_h_
#define protocol_PVWriteBuffer_SErrorPort_h_

// Includes from the 'includes' section of this protocol
#line 41 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVWriteBuffer.lisa"

        #include "pv/PVWriteBufferComponent.h"

        using namespace pv;
    
#line 27 "./Linux64-Release-GCC-4.9/gen/protocol_PVWriteBuffer_SErrorPort.h"


// Abstract interface for protocol PVWriteBuffer_SErrorPort
class protocol_PVWriteBuffer_SErrorPort
{
public:
        virtual ~protocol_PVWriteBuffer_SErrorPort() {}
        // Abstract protocol members
	virtual void notify(const Tx_Result& result, bus_addr_t address, const Payload& payload, const uint8_t* faultp) = 0;

};

#endif /* protocol_PVWriteBuffer_SErrorPort_h_ */

