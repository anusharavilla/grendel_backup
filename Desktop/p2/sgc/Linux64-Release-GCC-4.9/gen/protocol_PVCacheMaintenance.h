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
 * Abstract interface class protocol_PVCacheMaintenance for protocol PVCacheMaintenance.
 */

#ifndef protocol_PVCacheMaintenance_h_
#define protocol_PVCacheMaintenance_h_

// Includes from the 'includes' section of this protocol
#line 10 "/afs/eos/dist/ds-5_v5.24.1/FastModelsPortfolio_10.0/LISA/PVCacheMaintenance.lisa"

#include "pv/PVBusAddr.h"
#include "pv/PVTransaction.h"
    
#line 26 "./Linux64-Release-GCC-4.9/gen/protocol_PVCacheMaintenance.h"


// Abstract interface for protocol PVCacheMaintenance
class protocol_PVCacheMaintenance
{
public:
        virtual ~protocol_PVCacheMaintenance() {}
        // Abstract protocol members
	virtual void clean_all() = 0;
	virtual void clean_by_addr(pv::bus_addr_t addr, bool is_non_secure) = 0;
	virtual void clean_by_set_way(uint32_t set, uint32_t way, bool is_non_secure) = 0;
	virtual void invalidate_all() = 0;
	virtual void invalidate_by_addr(pv::bus_addr_t addr, bool is_non_secure) = 0;
	virtual void invalidate_by_set_way(uint32_t set, uint32_t way, bool is_non_secure) = 0;
	virtual pv::Tx_Result preload(const pv::MemoryAttributes& memory_attributes_, pv::bus_addr_t address_, bool make_unique_, sg::ticks_t& local_time_) = 0;
	virtual bool find_in_cache(const pv::MemoryAttributes& memory_attributes_, pv::bus_addr_t address_) = 0;
	virtual void setLockDown(uint32_t lock) = 0;
	virtual uint32_t getLockDown() = 0;
	virtual void setIsInner(bool is_inner) = 0;
	virtual bool getEnabled(bool is_non_secure) = 0;
	virtual void setEnabled(bool enabled, bool is_non_secure) = 0;
	virtual void setCacheStateModelled(bool modelled) = 0;
	virtual bool getCacheStateModelled() = 0;
	virtual void enableUpstreamAcceptsSnoopRequests(unsigned upstream_port_, bool on_) = 0;
	virtual void enableUpstreamAcceptsDVM(unsigned upstream_port_, bool on_) = 0;
	virtual void enableLocalDVMMessageProcessing(bool on_) = 0;
	virtual void cacheSizeOverride(unsigned cache_line_size_in_bytes_, unsigned number_of_sets_, unsigned number_of_ways_) = 0;

};

#endif /* protocol_PVCacheMaintenance_h_ */

