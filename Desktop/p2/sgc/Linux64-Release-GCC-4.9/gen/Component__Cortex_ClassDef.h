/*
 * 
 *
 * This is an automatically generated file. Do not edit.
 *
 * Copyright 2006 ARM Limited.
 * Copyright 2011 ARM LImited.
 *
 * All rights reserved.
 */

/** \file
 * Class definition for Component Cortex.
 */

#ifndef Component_Component__Cortex_ClassDef_h_
#define Component_Component__Cortex_ClassDef_h_

#include <eslapi/eslapi_stdint.h>

#include <limits.h>
#include <map>
#include <fstream>
#include "SystemGenComponent.h"
#include "CADIBase.h"
#include "ComponentRegister.h"
#include "ResourceAccessFuncTypes.h"
#include "CADIParameterProxy.h"
#include "ParameterFilter.h"
#include "sg/SGTargetInfo.h"
#include "Cortex_DSO.h"

using namespace std;

#include "Cortex__AMBAPV_ClassDef.h"
#include "Cortex__Builtin__ControlProtocol_ClassDef.h"



class SimulationEngine;
class ObjectLoader;

using namespace sg::accessfunc;

namespace eslapi
{
    class CADI;
}

namespace Cortex_NMS {

class ParameterFilter_Clock100MHz_of_ClockDivider_to_Cortex : public ParameterFilter
{
public:
	ParameterFilter_Clock100MHz_of_ClockDivider_to_Cortex()
	{
		ovrd_params["mul"] = eslapi::CADIParameterInfo_t(0x10000000 | PARAMETERFILTER_FIXED, "mul",eslapi::CADI_PARAM_INT, "Clock Rate Multiplier. This parameter is not exposed via CADI and can only be set in LISA",0,INT64_C(0x8000000000000000),INT64_C(0x7fffffffffffffff),INT64_C(0x1), "1" );
	}
};

class ParameterFilter_AMBAPVBus_of_PVBus2AMBAPV_to_Cortex : public ParameterFilter
{
public:
	ParameterFilter_AMBAPVBus_of_PVBus2AMBAPV_to_Cortex()
	{
		ovrd_params["size"] = eslapi::CADIParameterInfo_t(0x10000001 | PARAMETERFILTER_FIXED, "size",eslapi::CADI_PARAM_INT, "Maximum size of memory region",0,INT64_C(0x8000000000000000),INT64_C(0x7fffffffffffffff),INT64_C(0x1000000000000), "0x1000000000000" );
	}
};



class
#ifndef _WINDOWS
SG_Cortex_DSO
#endif
Component__Cortex: public SystemGenComponent
{
public:
    // pointers to subcomponents
	sg::ComponentBase *Core;
	sg::ComponentBase *Clock100MHz;
	Component__PVBus2AMBAPV *AMBAPVBus;
	sg::ComponentBase *Clock1Hz;
	sg::ComponentBase *BusDecoder;


    // control ports of subcomponents
	Cortex__Builtin__ControlProtocol controlPort_Core__;
	Cortex__Builtin__ControlProtocol controlPort_Clock100MHz__;
	Cortex__Builtin__ControlProtocol controlPort_AMBAPVBus__;
	Cortex__Builtin__ControlProtocol controlPort_Clock1Hz__;
	Cortex__Builtin__ControlProtocol controlPort_BusDecoder__;


    // abstract ports
	Cortex__AMBAPV amba_pv_m;


    // resources
    std::string application_pathname;



    // find parameter name for a specific CADIFactory parameter ID
    std::map<uint32_t,std::string> parameterId2parameterName__;

    // list of all CADI parameters
    std::vector<eslapi::CADIParameterInfo_t> parameterInfos__;


    // ================================================================================
    // methods
    // ================================================================================

    // constructor and destructor
    Component__Cortex(const char *argv, sg::SimulationContext* simulationContext, const sg::Params & params);
    ~Component__Cortex();

    // interface functions
    sg::SimulationContext* getSimulationContext() const { return simulationContext__; }

    // control port implementation
    void control_port__configure(const sg::Params& params);
    void control_port__loadApplicationFile(const std::string& filename);
    void control_port__serializeState(const char *name, cp::SerializationInterface* stream);
    std::string control_port__getProperty(const std::string& propname);
    std::string control_port__bypass(const std::string&);
    void control_port__run();
    void control_port__stop();
    void control_port__idle();
    void control_port__quit();
    void control_port__getMxDI(std::map<std::string,eslapi::CADI*>*);
    void control_port__setSimulationEngine(SimulationEngine*);
    void control_port__populateCADIMap(std::map< std::string, eslapi::CAInterface* > &, std::string const &);
    void control_port__message(const std::string &msg, sg::message::MessageType msgType);
    std::string control_port__callSimEngine(const std::string&);
    void control_port__reset(int level);
    void control_port__terminate();

    // CADI Port implementations
    eslapi::CADIReturn_t cadiPort__GetParameters(uint32_t startIndex, uint32_t desiredNumOfParams, uint32_t *actualNumOfParams, eslapi::CADIParameterInfo_t *params);
    eslapi::CADIReturn_t cadiPort__GetParameterInfo(const std::string &parameterName, eslapi::CADIParameterInfo_t* param);
    eslapi::CADIReturn_t cadiPort__GetParameterValues (uint32_t parameterCount, uint32_t *actualNumOfParamsRead, eslapi::CADIParameterValue_t *paramValuesOut);
    eslapi::CADIReturn_t cadiPort__SetParameters(uint32_t count, eslapi::CADIParameterValue_t *params, eslapi::CADIFactoryErrorMessage_t *error);
    eslapi::CADIReturn_t cadiPort__GetProperty(const std::string& propertyName, std::string &value);
    void cadiPort__LoadApplicationFile(const std::string& filename);
    void cadiPort__GetApplicationsAndCommandLineParams(std::map<std::string, std::string>&applications2params_);

    // helper functions
    void insertCADIMap__(std::string prefix, std::map< std::string, eslapi::CAInterface*>&componentName2CADI);

    sg::accessfunc::AccessFuncResult parameter_read_func(uint32_t id, int64_t *data);
    sg::accessfunc::AccessFuncResult parameter_read_string_func(uint32_t id, std::string &data);
    sg::accessfunc::AccessFuncResult parameter_write_func(uint32_t id, const int64_t *data);
    sg::accessfunc::AccessFuncResult parameter_write_string_func(uint32_t id, const std::string &data);

    sg::accessfunc::AccessFuncResult GetExtendedTargetFeatures__(uint32_t /*id*/, std::string &data, bool /*se*/);

    // dummy functions, mostly required by IsimMain (formerly InterpreterMain), will go away soon

    // May be required by TraceGen however that itself is obsolete
    uint64_t getInstructionCount() const { return 0; }
    // May be required by SystemGen however that itself is obsolete
    uint64_t getCycleCount() const { return 0; }

	void interconnect();
	void disconnect();
	void loadApplicationFile(const std::string& filename);
	void init();
	void terminate();
	void reset(int level);
	void reset(int level, int /*argc*/, char** /*argv*/);
	void step();

    void simHalt();
    void simRun();
    bool simIsRunning();
    void simShutdown();
    void simReset(uint32_t level);


private:
    // methods
    eslapi::CADI* obtainCADI__(const std::string &subcomp, const std::map< std::string, eslapi::CAInterface* > &componentName2CADI) const;
    static bool ForwardParameterValueToSubcomponent(CADIParameterProxy *proxy,
                                                    const char *param_name,
                                                    int64_t intVal,
                                                    const char *strVal);
    uint32_t paramNameToParamAccessFuncID(const std::string &name);
    void buildDebugInfoWithMetaData__();

    void reset_resources__();
    void freeCADIResources__();
    void connect_controlports__();
    void add_abstractports__();
    void wire_connectionmap__();

    	void add_abstractports__0__();

    	Cortex__Builtin__AddressablePortProtocol tmp__; // temporary addressable port control port
		void wire_connectionmap__0__();



	ParameterFilter_Clock100MHz_of_ClockDivider_to_Cortex parameterFilter_Clock100MHz_of_ClockDivider_to_Cortex__;
	ParameterFilter_AMBAPVBus_of_PVBus2AMBAPV_to_Cortex parameterFilter_AMBAPVBus_of_PVBus2AMBAPV_to_Cortex__;


	CADIParameterProxy *cadiParameterProxy_Clock100MHz_of_ClockDivider_to_Cortex__;
	CADIParameterProxy *cadiParameterProxy_AMBAPVBus_of_PVBus2AMBAPV_to_Cortex__;


    // definition of parameter IDs as constants for use in parameter access functions




};

} // namespace Cortex_NMS

#endif

