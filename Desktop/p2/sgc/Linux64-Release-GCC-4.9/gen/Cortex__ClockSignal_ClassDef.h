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
 * Class definition for protocol Cortex__ClockSignal.
 */

#ifndef Cortex__ClockSignal_ClassDef_h_
#define Cortex__ClockSignal_ClassDef_h_

#include <eslapi/eslapi_stdint.h>

#include <list>
#include "sg/SGPort.h"

#include "protocol_ClockSignal.h"

namespace Cortex_NMS {

class Cortex__ClockSignal;

// Abstract interface implementation for port
class protocol_ClockSignal__Implementation: public protocol_ClockSignal
{
public:
    protocol_ClockSignal__Implementation(): thisPort(0) {}

    void SetPort(Cortex__ClockSignal *port) { thisPort = port; }

    // Protocol members
	inline void setClock(sg::FrequencySource* );
	inline sg::FrequencySource* getClock();
	inline double rateInHz();
	inline uint64_t currentTicks();


private:
    // Parent port this interface belongs to.
    Cortex__ClockSignal *thisPort;
};


// Protocol (port) class definition
class Cortex__ClockSignal: public sg::Port
{
private:
    
public:
    // Resources


    // Connector instances
	sg::PeerConnector< void (sg::FrequencySource*) > setClock;
	sg::PeerConnector< sg::FrequencySource* (void) > getClock;
	sg::PeerConnector< double (void) > rateInHz;
	sg::PeerConnector< uint64_t (void) > currentTicks;


    Cortex__ClockSignal()
    {
        abstractInterface__.SetPort(this);
		define_behaviour(setClock);
		define_behaviour(getClock);
		define_behaviour(rateInHz);
		define_behaviour(currentTicks);


    }

    // Set name (currently ignored here)
    void SetName__(const char *) {}

    // Abstract port interface for non-LISA C++ components
    protocol_ClockSignal__Implementation abstractInterface__;

    // Get abstract interface for non-LISA C++ components
    protocol_ClockSignal *getAbstractInterface() { return &abstractInterface__; }
};


// Abstract interface implementations
inline void protocol_ClockSignal__Implementation::setClock(sg::FrequencySource* param0__)
{
	return thisPort->setClock(param0__);
}

inline sg::FrequencySource* protocol_ClockSignal__Implementation::getClock()
{
	return thisPort->getClock();
}

inline double protocol_ClockSignal__Implementation::rateInHz()
{
	return thisPort->rateInHz();
}

inline uint64_t protocol_ClockSignal__Implementation::currentTicks()
{
	return thisPort->currentTicks();
}




// Mapping object
// (these ports are implemented inside Cortex__ClockSignal__AddressablePort)
class Cortex__ClockSignal__AddressablePort_OutPort: public Cortex__ClockSignal
{
public:
    // constructor
    Cortex__ClockSignal__AddressablePort_OutPort(uint32_t inFirst,
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
class Cortex__ClockSignal__AddressablePort: public Cortex__ClockSignal
{
public:
    declare_slave_behaviour(mapRange, sg::Port*(uint64_t inFirst, uint64_t inLast, uint64_t outFirst, uint64_t outLast));
    declare_slave_behaviour(mapDefault, sg::Port*());
    declare_slave_behaviour(unmapRange, void(sg::Port*));
    declare_slave_behaviour(isMapped, bool(uint64_t));

    Cortex__ClockSignal__AddressablePort():
    defaultOutPort__(0),
    portName__("(unknown name)")
    {
        define_behaviour(mapRange);
        define_behaviour(mapDefault);
        define_behaviour(unmapRange);
        define_behaviour(isMapped);
        bind_method(*this, mapRange, &Cortex__ClockSignal__AddressablePort::mapRange__, this);
        bind_method(*this, mapDefault, &Cortex__ClockSignal__AddressablePort::mapDefault__, this);
        bind_method(*this, unmapRange, &Cortex__ClockSignal__AddressablePort::unmapRange__, this);
        bind_method(*this, isMapped, &Cortex__ClockSignal__AddressablePort::isMapped__, this);

    }

    ~Cortex__ClockSignal__AddressablePort()
    {
        OutPortList__::iterator it;
        for (it = outPortList__.begin(); it != outPortList__.end(); ++it)
            delete *it;
        delete defaultOutPort__;
    }

    void SetName__(const char *name) { portName__ = name; }

    Cortex__ClockSignal__AddressablePort_OutPort *locateOutPort__(uint32_t &addr)
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
        Cortex__ClockSignal__AddressablePort_OutPort *masterPort =
            new Cortex__ClockSignal__AddressablePort_OutPort(inFirst, inLast, outFirst, outLast);
		this->setClock.connectTo(&masterPort->setClock);
		this->getClock.connectTo(&masterPort->getClock);
		this->rateInHz.connectTo(&masterPort->rateInHz);
		this->currentTicks.connectTo(&masterPort->currentTicks);

        // push_front() because the first statement should have the lowest priority and the last statement should have the
        // highest priority, like PVBusDecoder
        outPortList__.push_front(masterPort);
        return masterPort;
    }

    // map default slave
    sg::Port* mapDefault__()
    {
        delete defaultOutPort__;
        defaultOutPort__ = new Cortex__ClockSignal__AddressablePort_OutPort(0, uint32_t(0) - 1, 0, uint32_t(0) - 1);
        return defaultOutPort__;
    }

    void unmapRange__(sg::Port* port)
    {
        outPortList__.remove((Cortex__ClockSignal__AddressablePort_OutPort*)port);
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
    typedef std::list<Cortex__ClockSignal__AddressablePort_OutPort*> OutPortList__;
    OutPortList__ outPortList__;
    Cortex__ClockSignal__AddressablePort_OutPort *defaultOutPort__;
    const char *portName__;
};

} // namespace Cortex_NMS

#endif

