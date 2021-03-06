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
 * Class definition for protocol Cortex__v8EmbeddedCrossTrigger_controlprotocol.
 */

#ifndef Cortex__v8EmbeddedCrossTrigger_controlprotocol_ClassDef_h_
#define Cortex__v8EmbeddedCrossTrigger_controlprotocol_ClassDef_h_

#include <eslapi/eslapi_stdint.h>

#include <list>
#include "sg/SGPort.h"

#include "protocol_v8EmbeddedCrossTrigger_controlprotocol.h"

namespace Cortex_NMS {

class Cortex__v8EmbeddedCrossTrigger_controlprotocol;

// Abstract interface implementation for port
class protocol_v8EmbeddedCrossTrigger_controlprotocol__Implementation: public protocol_v8EmbeddedCrossTrigger_controlprotocol
{
public:
    protocol_v8EmbeddedCrossTrigger_controlprotocol__Implementation(): thisPort(0) {}

    void SetPort(Cortex__v8EmbeddedCrossTrigger_controlprotocol *port) { thisPort = port; }

    // Protocol members
	inline void init(unsigned number_of_triggers, unsigned intack_mask, unsigned number_of_claim_bits);
	inline uint32_t reg_read(bool is_memory_mapped, uint32_t addr);
	inline void reg_write(bool is_memory_mapped, uint32_t addr, uint32_t data);
	inline void setValue_inputTrigger(unsigned index, sg::Signal::State state);
	inline void setValue_outputTrigger(unsigned index, sg::Signal::State state);
	inline uint8_t getPeripheralIdByte(unsigned pidn);
	inline uint8_t getComponentIdByte(unsigned pidn);


private:
    // Parent port this interface belongs to.
    Cortex__v8EmbeddedCrossTrigger_controlprotocol *thisPort;
};


// Protocol (port) class definition
class Cortex__v8EmbeddedCrossTrigger_controlprotocol: public sg::Port
{
private:
    
public:
    // Resources


    // Connector instances
	sg::SlaveConnector< void (unsigned,unsigned,unsigned) > init;
	sg::SlaveConnector< uint32_t (bool,uint32_t) > reg_read;
	sg::SlaveConnector< void (bool,uint32_t,uint32_t) > reg_write;
	sg::SlaveConnector< void (unsigned,sg::Signal::State) > setValue_inputTrigger;
	sg::MasterConnector< void (unsigned,sg::Signal::State) > setValue_outputTrigger;
	sg::MasterConnector< uint8_t (unsigned) > getPeripheralIdByte;
	sg::MasterConnector< uint8_t (unsigned) > getComponentIdByte;


    Cortex__v8EmbeddedCrossTrigger_controlprotocol()
    {
        abstractInterface__.SetPort(this);
		define_behaviour(init);
		define_behaviour(reg_read);
		define_behaviour(reg_write);
		define_behaviour(setValue_inputTrigger);
		define_behaviour(setValue_outputTrigger);
		define_behaviour(getPeripheralIdByte);
		define_behaviour(getComponentIdByte);


    }

    // Set name (currently ignored here)
    void SetName__(const char *) {}

    // Abstract port interface for non-LISA C++ components
    protocol_v8EmbeddedCrossTrigger_controlprotocol__Implementation abstractInterface__;

    // Get abstract interface for non-LISA C++ components
    protocol_v8EmbeddedCrossTrigger_controlprotocol *getAbstractInterface() { return &abstractInterface__; }
};


// Abstract interface implementations
inline void protocol_v8EmbeddedCrossTrigger_controlprotocol__Implementation::init(unsigned number_of_triggers, unsigned intack_mask, unsigned number_of_claim_bits)
{
	return thisPort->init(number_of_triggers, intack_mask, number_of_claim_bits);
}

inline uint32_t protocol_v8EmbeddedCrossTrigger_controlprotocol__Implementation::reg_read(bool is_memory_mapped, uint32_t addr)
{
	return thisPort->reg_read(is_memory_mapped, addr);
}

inline void protocol_v8EmbeddedCrossTrigger_controlprotocol__Implementation::reg_write(bool is_memory_mapped, uint32_t addr, uint32_t data)
{
	return thisPort->reg_write(is_memory_mapped, addr, data);
}

inline void protocol_v8EmbeddedCrossTrigger_controlprotocol__Implementation::setValue_inputTrigger(unsigned index, sg::Signal::State state)
{
	return thisPort->setValue_inputTrigger(index, state);
}

inline void protocol_v8EmbeddedCrossTrigger_controlprotocol__Implementation::setValue_outputTrigger(unsigned index, sg::Signal::State state)
{
	return thisPort->setValue_outputTrigger(index, state);
}

inline uint8_t protocol_v8EmbeddedCrossTrigger_controlprotocol__Implementation::getPeripheralIdByte(unsigned pidn)
{
	return thisPort->getPeripheralIdByte(pidn);
}

inline uint8_t protocol_v8EmbeddedCrossTrigger_controlprotocol__Implementation::getComponentIdByte(unsigned pidn)
{
	return thisPort->getComponentIdByte(pidn);
}




// Mapping object
// (these ports are implemented inside Cortex__v8EmbeddedCrossTrigger_controlprotocol__AddressablePort)
class Cortex__v8EmbeddedCrossTrigger_controlprotocol__AddressablePort_OutPort: public Cortex__v8EmbeddedCrossTrigger_controlprotocol
{
public:
    // constructor
    Cortex__v8EmbeddedCrossTrigger_controlprotocol__AddressablePort_OutPort(uint32_t inFirst,
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
class Cortex__v8EmbeddedCrossTrigger_controlprotocol__AddressablePort: public Cortex__v8EmbeddedCrossTrigger_controlprotocol
{
public:
    declare_slave_behaviour(mapRange, sg::Port*(uint64_t inFirst, uint64_t inLast, uint64_t outFirst, uint64_t outLast));
    declare_slave_behaviour(mapDefault, sg::Port*());
    declare_slave_behaviour(unmapRange, void(sg::Port*));
    declare_slave_behaviour(isMapped, bool(uint64_t));

    Cortex__v8EmbeddedCrossTrigger_controlprotocol__AddressablePort():
    defaultOutPort__(0),
    portName__("(unknown name)")
    {
        define_behaviour(mapRange);
        define_behaviour(mapDefault);
        define_behaviour(unmapRange);
        define_behaviour(isMapped);
        bind_method(*this, mapRange, &Cortex__v8EmbeddedCrossTrigger_controlprotocol__AddressablePort::mapRange__, this);
        bind_method(*this, mapDefault, &Cortex__v8EmbeddedCrossTrigger_controlprotocol__AddressablePort::mapDefault__, this);
        bind_method(*this, unmapRange, &Cortex__v8EmbeddedCrossTrigger_controlprotocol__AddressablePort::unmapRange__, this);
        bind_method(*this, isMapped, &Cortex__v8EmbeddedCrossTrigger_controlprotocol__AddressablePort::isMapped__, this);

    }

    ~Cortex__v8EmbeddedCrossTrigger_controlprotocol__AddressablePort()
    {
        OutPortList__::iterator it;
        for (it = outPortList__.begin(); it != outPortList__.end(); ++it)
            delete *it;
        delete defaultOutPort__;
    }

    void SetName__(const char *name) { portName__ = name; }

    Cortex__v8EmbeddedCrossTrigger_controlprotocol__AddressablePort_OutPort *locateOutPort__(uint32_t &addr)
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
        Cortex__v8EmbeddedCrossTrigger_controlprotocol__AddressablePort_OutPort *masterPort =
            new Cortex__v8EmbeddedCrossTrigger_controlprotocol__AddressablePort_OutPort(inFirst, inLast, outFirst, outLast);
		this->init.connectTo(&masterPort->init);
		this->reg_read.connectTo(&masterPort->reg_read);
		this->reg_write.connectTo(&masterPort->reg_write);
		this->setValue_inputTrigger.connectTo(&masterPort->setValue_inputTrigger);
		this->setValue_outputTrigger.connectTo(&masterPort->setValue_outputTrigger);
		this->getPeripheralIdByte.connectTo(&masterPort->getPeripheralIdByte);
		this->getComponentIdByte.connectTo(&masterPort->getComponentIdByte);

        // push_front() because the first statement should have the lowest priority and the last statement should have the
        // highest priority, like PVBusDecoder
        outPortList__.push_front(masterPort);
        return masterPort;
    }

    // map default slave
    sg::Port* mapDefault__()
    {
        delete defaultOutPort__;
        defaultOutPort__ = new Cortex__v8EmbeddedCrossTrigger_controlprotocol__AddressablePort_OutPort(0, uint32_t(0) - 1, 0, uint32_t(0) - 1);
        return defaultOutPort__;
    }

    void unmapRange__(sg::Port* port)
    {
        outPortList__.remove((Cortex__v8EmbeddedCrossTrigger_controlprotocol__AddressablePort_OutPort*)port);
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
    typedef std::list<Cortex__v8EmbeddedCrossTrigger_controlprotocol__AddressablePort_OutPort*> OutPortList__;
    OutPortList__ outPortList__;
    Cortex__v8EmbeddedCrossTrigger_controlprotocol__AddressablePort_OutPort *defaultOutPort__;
    const char *portName__;
};

} // namespace Cortex_NMS

#endif

