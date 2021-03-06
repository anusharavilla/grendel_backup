/*
 * 
 *
 * This is an automatically generated file. Do not edit.
 *
 * Copyright 2005 ARM Limited.
 * Copyright 2011 ARM Limited.
 *
 * All rights reserved.
 */

/** \file
 * Class definition for protocol Cortex__PVBusCacheControl.
 */

#ifndef Cortex__PVBusCacheControl_ClassDef_h_
#define Cortex__PVBusCacheControl_ClassDef_h_

#include <eslapi/eslapi_stdint.h>

#include <list>
#include "sg/SGPort.h"

#include "protocol_PVBusCacheControl.h"

namespace Cortex_NMS {

class Cortex__PVBusCacheControl;

// Abstract interface implementation for port
class protocol_PVBusCacheControl__Implementation: public protocol_PVBusCacheControl
{
public:
    protocol_PVBusCacheControl__Implementation(): thisPort(0) {}

    void SetPort(Cortex__PVBusCacheControl *port) { thisPort = port; }

    // Protocol members
	inline pv::TransactionGenerator* createTransactionGenerator(unsigned output_port);
	inline void revokeRoutingDecisions();
	inline pv::Tx_Result passThroughRead(unsigned output_port, pv::ReadTransaction tx);
	inline pv::Tx_Result passThroughWrite(unsigned output_port, pv::WriteTransaction tx);
	inline pv::Tx_Result readFromLine(pv::ReadTransaction tx, unsigned hit_line_index);
	inline pv::Tx_Result writeToLine(pv::WriteTransaction tx, unsigned hit_line_index);
	inline pv::Tx_Result writeToLineAndPassThrough(pv::WriteTransaction tx, unsigned hit_line_index, unsigned output_port);
	inline void invalidateLineHit(unsigned hit_line_index, pv::CacheRevocation revoke_type);
	inline char* getLineContentsForWrite(unsigned line_index);
	inline const char* getLineContentsForRead(unsigned line_index);


private:
    // Parent port this interface belongs to.
    Cortex__PVBusCacheControl *thisPort;
};


// Protocol (port) class definition
class Cortex__PVBusCacheControl: public sg::Port
{
private:
    
public:
    // Resources


    // Connector instances
	sg::SlaveConnector< pv::TransactionGenerator* (unsigned) > createTransactionGenerator;
	sg::SlaveConnector< void (void) > revokeRoutingDecisions;
	sg::SlaveConnector< pv::Tx_Result (unsigned,pv::ReadTransaction) > passThroughRead;
	sg::SlaveConnector< pv::Tx_Result (unsigned,pv::WriteTransaction) > passThroughWrite;
	sg::SlaveConnector< pv::Tx_Result (pv::ReadTransaction,unsigned) > readFromLine;
	sg::SlaveConnector< pv::Tx_Result (pv::WriteTransaction,unsigned) > writeToLine;
	sg::SlaveConnector< pv::Tx_Result (pv::WriteTransaction,unsigned,unsigned) > writeToLineAndPassThrough;
	sg::SlaveConnector< void (unsigned,pv::CacheRevocation) > invalidateLineHit;
	sg::SlaveConnector< char* (unsigned) > getLineContentsForWrite;
	sg::SlaveConnector< const char* (unsigned) > getLineContentsForRead;


    Cortex__PVBusCacheControl()
    {
        abstractInterface__.SetPort(this);
		define_behaviour(createTransactionGenerator);
		define_behaviour(revokeRoutingDecisions);
		define_behaviour(passThroughRead);
		define_behaviour(passThroughWrite);
		define_behaviour(readFromLine);
		define_behaviour(writeToLine);
		define_behaviour(writeToLineAndPassThrough);
		define_behaviour(invalidateLineHit);
		define_behaviour(getLineContentsForWrite);
		define_behaviour(getLineContentsForRead);


    }

    // Set name (currently ignored here)
    void SetName__(const char *) {}

    // Abstract port interface for non-LISA C++ components
    protocol_PVBusCacheControl__Implementation abstractInterface__;

    // Get abstract interface for non-LISA C++ components
    protocol_PVBusCacheControl *getAbstractInterface() { return &abstractInterface__; }
};


// Abstract interface implementations
inline pv::TransactionGenerator* protocol_PVBusCacheControl__Implementation::createTransactionGenerator(unsigned output_port)
{
	return thisPort->createTransactionGenerator(output_port);
}

inline void protocol_PVBusCacheControl__Implementation::revokeRoutingDecisions()
{
	return thisPort->revokeRoutingDecisions();
}

inline pv::Tx_Result protocol_PVBusCacheControl__Implementation::passThroughRead(unsigned output_port, pv::ReadTransaction tx)
{
	return thisPort->passThroughRead(output_port, tx);
}

inline pv::Tx_Result protocol_PVBusCacheControl__Implementation::passThroughWrite(unsigned output_port, pv::WriteTransaction tx)
{
	return thisPort->passThroughWrite(output_port, tx);
}

inline pv::Tx_Result protocol_PVBusCacheControl__Implementation::readFromLine(pv::ReadTransaction tx, unsigned hit_line_index)
{
	return thisPort->readFromLine(tx, hit_line_index);
}

inline pv::Tx_Result protocol_PVBusCacheControl__Implementation::writeToLine(pv::WriteTransaction tx, unsigned hit_line_index)
{
	return thisPort->writeToLine(tx, hit_line_index);
}

inline pv::Tx_Result protocol_PVBusCacheControl__Implementation::writeToLineAndPassThrough(pv::WriteTransaction tx, unsigned hit_line_index, unsigned output_port)
{
	return thisPort->writeToLineAndPassThrough(tx, hit_line_index, output_port);
}

inline void protocol_PVBusCacheControl__Implementation::invalidateLineHit(unsigned hit_line_index, pv::CacheRevocation revoke_type)
{
	return thisPort->invalidateLineHit(hit_line_index, revoke_type);
}

inline char* protocol_PVBusCacheControl__Implementation::getLineContentsForWrite(unsigned line_index)
{
	return thisPort->getLineContentsForWrite(line_index);
}

inline const char* protocol_PVBusCacheControl__Implementation::getLineContentsForRead(unsigned line_index)
{
	return thisPort->getLineContentsForRead(line_index);
}




// Mapping object
// (these ports are implemented inside Cortex__PVBusCacheControl__AddressablePort)
class Cortex__PVBusCacheControl__AddressablePort_OutPort: public Cortex__PVBusCacheControl
{
public:
    // constructor
    Cortex__PVBusCacheControl__AddressablePort_OutPort(uint32_t inFirst,
                                                 uint32_t inLast,
                                                 uint32_t outFirst,
                                                 uint32_t outLast):
    inFirst__(inFirst),
    inLast__(inLast),
    outFirst__(outFirst),
    outSize__(outLast - outFirst + 1)
    {
    }

    bool isCovered__(uint32_t address) const
    {
        return (address >= inFirst__) && (address <= inLast__);
    }

    void remapAddress__(uint32_t &address) const
    {
        if(outSize__)
            address = ((address - inFirst__) % outSize__) + outFirst__;
    }

private:
    uint32_t inFirst__;
    uint32_t inLast__;
    uint32_t outFirst__;
    uint32_t outSize__;
};


// Addressable protocol class definition
class Cortex__PVBusCacheControl__AddressablePort: public Cortex__PVBusCacheControl
{
public:
    declare_slave_behaviour(mapRange, sg::Port*(uint64_t inFirst, uint64_t inLast, uint64_t outFirst, uint64_t outLast));
    declare_slave_behaviour(mapDefault, sg::Port*());
    declare_slave_behaviour(unmapRange, void(sg::Port*));
    declare_slave_behaviour(isMapped, bool(uint64_t));

    Cortex__PVBusCacheControl__AddressablePort():
    defaultOutPort__(0),
    portName__("(unknown name)")
    {
        define_behaviour(mapRange);
        define_behaviour(mapDefault);
        define_behaviour(unmapRange);
        define_behaviour(isMapped);
        bind_method(*this, mapRange, &Cortex__PVBusCacheControl__AddressablePort::mapRange__, this);
        bind_method(*this, mapDefault, &Cortex__PVBusCacheControl__AddressablePort::mapDefault__, this);
        bind_method(*this, unmapRange, &Cortex__PVBusCacheControl__AddressablePort::unmapRange__, this);
        bind_method(*this, isMapped, &Cortex__PVBusCacheControl__AddressablePort::isMapped__, this);

    }

    ~Cortex__PVBusCacheControl__AddressablePort()
    {
        OutPortList__::iterator it;
        for (it = outPortList__.begin(); it != outPortList__.end(); ++it)
            delete *it;
        delete defaultOutPort__;
    }

    void SetName__(const char *name) { portName__ = name; }

    Cortex__PVBusCacheControl__AddressablePort_OutPort *locateOutPort__(uint32_t &addr)
    {
        OutPortList__::iterator it;
        for (it = outPortList__.begin(); it != outPortList__.end(); ++it)
        {
            if ((*it)->isCovered__(addr)) {
                (*it)->remapAddress__(addr);
                return *it;
            }
        }
        return defaultOutPort__;
    }

    sg::Port* mapRange__(uint64_t inFirst, uint64_t inLast, uint64_t outFirst, uint64_t outLast)
    {
        Cortex__PVBusCacheControl__AddressablePort_OutPort *masterPort =
            new Cortex__PVBusCacheControl__AddressablePort_OutPort(inFirst, inLast, outFirst, outLast);
		this->createTransactionGenerator.connectTo(&masterPort->createTransactionGenerator);
		this->revokeRoutingDecisions.connectTo(&masterPort->revokeRoutingDecisions);
		this->passThroughRead.connectTo(&masterPort->passThroughRead);
		this->passThroughWrite.connectTo(&masterPort->passThroughWrite);
		this->readFromLine.connectTo(&masterPort->readFromLine);
		this->writeToLine.connectTo(&masterPort->writeToLine);
		this->writeToLineAndPassThrough.connectTo(&masterPort->writeToLineAndPassThrough);
		this->invalidateLineHit.connectTo(&masterPort->invalidateLineHit);
		this->getLineContentsForWrite.connectTo(&masterPort->getLineContentsForWrite);
		this->getLineContentsForRead.connectTo(&masterPort->getLineContentsForRead);

        // push_front() because the first statement should have the lowest priority and the last statement should have the
        // highest priority, like PVBusDecoder
        outPortList__.push_front(masterPort);
        return masterPort;
    }

    // map default slave
    sg::Port* mapDefault__()
    {
        delete defaultOutPort__;
        defaultOutPort__ = new Cortex__PVBusCacheControl__AddressablePort_OutPort(0, uint32_t(0) - 1, 0, uint32_t(0) - 1);
        return defaultOutPort__;
    }

    void unmapRange__(sg::Port* port)
    {
        outPortList__.remove((Cortex__PVBusCacheControl__AddressablePort_OutPort*)port);
        if(defaultOutPort__ == port)
        {
            delete defaultOutPort__;
            defaultOutPort__ = 0;
        }
    }

    bool isMapped__(uint64_t addr)
    {
        OutPortList__::iterator it;
        for (it = outPortList__.begin(); it != outPortList__.end(); ++it)
        {
            if ((*it)->isCovered__(static_cast<uint32_t>(addr)))
                return true;
        }
        return false;
    }

    // Wrapper functions for protocol behaviors


private:
    typedef std::list<Cortex__PVBusCacheControl__AddressablePort_OutPort*> OutPortList__;
    OutPortList__ outPortList__;
    Cortex__PVBusCacheControl__AddressablePort_OutPort *defaultOutPort__;
    const char *portName__;
};

} // namespace Cortex_NMS

#endif

