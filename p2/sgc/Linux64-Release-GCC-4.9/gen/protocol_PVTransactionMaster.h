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
 * Abstract interface class protocol_PVTransactionMaster for protocol PVTransactionMaster.
 */

#ifndef protocol_PVTransactionMaster_h_
#define protocol_PVTransactionMaster_h_

// Includes from the 'includes' section of this protocol
#line 31 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVTransactionMasterProtocol.lisa"

#include "pv/PVBus.h"
#include "pv/PVBusMaster.h"

        namespace pv
        {
            class RandomContextTransactionGenerator;
        }
    
#line 31 "./Linux64-Release-GCC-4.9/gen/protocol_PVTransactionMaster.h"


// Abstract interface for protocol PVTransactionMaster
class protocol_PVTransactionMaster
{
public:
        virtual ~protocol_PVTransactionMaster() {}
        // Abstract protocol members
	virtual pv::TransactionGenerator* createTransactionGenerator() = 0;
	virtual pv::RandomContextTransactionGenerator* createRandomContextTransactionGenerator() = 0;
	virtual void reset() = 0;

};

#endif /* protocol_PVTransactionMaster_h_ */

