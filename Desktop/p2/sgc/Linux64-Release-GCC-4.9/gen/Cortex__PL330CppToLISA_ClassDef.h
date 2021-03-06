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
 * Class definition for protocol Cortex__PL330CppToLISA.
 */

#ifndef Cortex__PL330CppToLISA_ClassDef_h_
#define Cortex__PL330CppToLISA_ClassDef_h_

#include <eslapi/eslapi_stdint.h>

#include <list>
#include "sg/SGPort.h"

#include "protocol_PL330CppToLISA.h"

namespace Cortex_NMS {

class Cortex__PL330CppToLISA;

// Abstract interface implementation for port
class protocol_PL330CppToLISA__Implementation: public protocol_PL330CppToLISA
{
public:
    protocol_PL330CppToLISA__Implementation(): thisPort(0) {}

    void SetPort(Cortex__PL330CppToLISA *port) { thisPort = port; }

    // Protocol members
	inline void message_printer(uint32_t type_, std::string text_);
	inline void wakeup_in_ticks(unsigned ticks_);
	inline void cancel_wakeup_timer();
	inline void update_abort(bool state_);
	inline void update_irq(unsigned index, bool state_);


private:
    // Parent port this interface belongs to.
    Cortex__PL330CppToLISA *thisPort;
};


// Protocol (port) class definition
class Cortex__PL330CppToLISA: public sg::Port
{
private:
    
public:
    // Resources


    // Connector instances
	sg::PeerConnector< void (uint32_t,std::string) > message_printer;
	sg::PeerConnector< void (unsigned) > wakeup_in_ticks;
	sg::PeerConnector< void (void) > cancel_wakeup_timer;
	sg::PeerConnector< void (bool) > update_abort;
	sg::PeerConnector< void (unsigned,bool) > update_irq;


    Cortex__PL330CppToLISA()
    {
        abstractInterface__.SetPort(this);
		define_behaviour(message_printer);
		define_behaviour(wakeup_in_ticks);
		define_behaviour(cancel_wakeup_timer);
		define_behaviour(update_abort);
		define_behaviour(update_irq);


    }

    // Set name (currently ignored here)
    void SetName__(const char *) {}

    // Abstract port interface for non-LISA C++ components
    protocol_PL330CppToLISA__Implementation abstractInterface__;

    // Get abstract interface for non-LISA C++ components
    protocol_PL330CppToLISA *getAbstractInterface() { return &abstractInterface__; }
};


// Abstract interface implementations
inline void protocol_PL330CppToLISA__Implementation::message_printer(uint32_t type_, std::string text_)
{
	return thisPort->message_printer(type_, text_);
}

inline void protocol_PL330CppToLISA__Implementation::wakeup_in_ticks(unsigned ticks_)
{
	return thisPort->wakeup_in_ticks(ticks_);
}

inline void protocol_PL330CppToLISA__Implementation::cancel_wakeup_timer()
{
	return thisPort->cancel_wakeup_timer();
}

inline void protocol_PL330CppToLISA__Implementation::update_abort(bool state_)
{
	return thisPort->update_abort(state_);
}

inline void protocol_PL330CppToLISA__Implementation::update_irq(unsigned index, bool state_)
{
	return thisPort->update_irq(index, state_);
}




// Mapping object
// (these ports are implemented inside Cortex__PL330CppToLISA__AddressablePort)
class Cortex__PL330CppToLISA__AddressablePort_OutPort: public Cortex__PL330CppToLISA
{
public:
    // constructor
    Cortex__PL330CppToLISA__AddressablePort_OutPort(uint32_t inFirst,
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
class Cortex__PL330CppToLISA__AddressablePort: public Cortex__PL330CppToLISA
{
public:
    declare_slave_behaviour(mapRange, sg::Port*(uint64_t inFirst, uint64_t inLast, uint64_t outFirst, uint64_t outLast));
    declare_slave_behaviour(mapDefault, sg::Port*());
    declare_slave_behaviour(unmapRange, void(sg::Port*));
    declare_slave_behaviour(isMapped, bool(uint64_t));

    Cortex__PL330CppToLISA__AddressablePort():
    defaultOutPort__(0),
    portName__("(unknown name)")
    {
        define_behaviour(mapRange);
        define_behaviour(mapDefault);
        define_behaviour(unmapRange);
        define_behaviour(isMapped);
        bind_method(*this, mapRange, &Cortex__PL330CppToLISA__AddressablePort::mapRange__, this);
        bind_method(*this, mapDefault, &Cortex__PL330CppToLISA__AddressablePort::mapDefault__, this);
        bind_method(*this, unmapRange, &Cortex__PL330CppToLISA__AddressablePort::unmapRange__, this);
        bind_method(*this, isMapped, &Cortex__PL330CppToLISA__AddressablePort::isMapped__, this);

    }

    ~Cortex__PL330CppToLISA__AddressablePort()
    {
        OutPortList__::iterator it;
        for (it = outPortList__.begin(); it != outPortList__.end(); ++it)
            delete *it;
        delete defaultOutPort__;
    }

    void SetName__(const char *name) { portName__ = name; }

    Cortex__PL330CppToLISA__AddressablePort_OutPort *locateOutPort__(uint32_t &addr)
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
        Cortex__PL330CppToLISA__AddressablePort_OutPort *masterPort =
            new Cortex__PL330CppToLISA__AddressablePort_OutPort(inFirst, inLast, outFirst, outLast);
		this->message_printer.connectTo(&masterPort->message_printer);
		this->wakeup_in_ticks.connectTo(&masterPort->wakeup_in_ticks);
		this->cancel_wakeup_timer.connectTo(&masterPort->cancel_wakeup_timer);
		this->update_abort.connectTo(&masterPort->update_abort);
		this->update_irq.connectTo(&masterPort->update_irq);

        // push_front() because the first statement should have the lowest priority and the last statement should have the
        // highest priority, like PVBusDecoder
        outPortList__.push_front(masterPort);
        return masterPort;
    }

    // map default slave
    sg::Port* mapDefault__()
    {
        delete defaultOutPort__;
        defaultOutPort__ = new Cortex__PL330CppToLISA__AddressablePort_OutPort(0, uint32_t(0) - 1, 0, uint32_t(0) - 1);
        return defaultOutPort__;
    }

    void unmapRange__(sg::Port* port)
    {
        outPortList__.remove((Cortex__PL330CppToLISA__AddressablePort_OutPort*)port);
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
    typedef std::list<Cortex__PL330CppToLISA__AddressablePort_OutPort*> OutPortList__;
    OutPortList__ outPortList__;
    Cortex__PL330CppToLISA__AddressablePort_OutPort *defaultOutPort__;
    const char *portName__;
};

} // namespace Cortex_NMS

#endif

