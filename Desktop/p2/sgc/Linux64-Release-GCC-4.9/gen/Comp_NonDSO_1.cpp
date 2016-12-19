/*
 * 
 *
 * This is an automatically generated file. Do not edit.
 *
 * Copyright 2009 ARM Limited.
 * Copyright 2011 ARM Limited.
 *
 * All rights reserved.
 */
/** \file
 * System components.
 */

#include "GlobalDefs.h"
#include "Components.h"

#include "Component__PVBus2AMBAPV_ClassDef.h"
#include "Component__Cortex_ClassDef.h"


#include "eslapi/CADITypes.h"

#include "cp/SerializationInterface.h"


#include "sg/SGBasicComponentFactory.h"
#include "sg/FastDelegate.h"

#include "TerminateScheduler.h"
#include "ParameterFilter.h"

#include <sg/MSCFixes.h>

// make the MSG_<...> symbols available in the global namespace
using namespace sg::message;
using namespace fastdelegate;

// component CADI interfaces
// ------------------------------------------------------------------------------
// CADI Interface for component Component__Cortex
// ------------------------------------------------------------------------------

namespace Cortex_NMS {

class Component__Cortex_CADI : public sg::CADIBase
{
public:
        Component__Cortex_CADI(Component__Cortex* parentComponent, sg::ComponentBase* simulationEngine);

    eslapi::CADIReturn_t CADIXfaceBypass(uint32_t commandLength, const char *command, uint32_t maxResponseLength, char *response);

private:
    Component__Cortex *component;
};

} // Cortex_NMS


// non inline behaviors
#line 1 "/afs/unity.ncsu.edu/users/a/aravill/ece720/gitrepo/hw05/p2/sgc/Cortex-M0.lisa"
namespace Cortex_NMS { void 
Component__Cortex::interconnect()
{{if(!controlPort_Core__.interconnect.empty()) controlPort_Core__.interconnect();if(!controlPort_Clock100MHz__.interconnect.empty()) controlPort_Clock100MHz__.interconnect();if(!controlPort_AMBAPVBus__.interconnect.empty()) controlPort_AMBAPVBus__.interconnect();if(!controlPort_Clock1Hz__.interconnect.empty()) controlPort_Clock1Hz__.interconnect();if(!controlPort_BusDecoder__.interconnect.empty()) controlPort_BusDecoder__.interconnect();};
}
}

#line 1 "/afs/unity.ncsu.edu/users/a/aravill/ece720/gitrepo/hw05/p2/sgc/Cortex-M0.lisa"
namespace Cortex_NMS { void 
Component__Cortex::disconnect()
{{if(!controlPort_Core__.disconnect.empty()) controlPort_Core__.disconnect();if(!controlPort_Clock100MHz__.disconnect.empty()) controlPort_Clock100MHz__.disconnect();if(!controlPort_AMBAPVBus__.disconnect.empty()) controlPort_AMBAPVBus__.disconnect();if(!controlPort_Clock1Hz__.disconnect.empty()) controlPort_Clock1Hz__.disconnect();if(!controlPort_BusDecoder__.disconnect.empty()) controlPort_BusDecoder__.disconnect();};
}
}

#line 1 "/afs/unity.ncsu.edu/users/a/aravill/ece720/gitrepo/hw05/p2/sgc/Cortex-M0.lisa"
namespace Cortex_NMS { void 
Component__Cortex::loadApplicationFile(const std::string& filename)
{{if(!controlPort_Core__.loadApplicationFile.empty()) controlPort_Core__.loadApplicationFile(filename);if(!controlPort_Clock100MHz__.loadApplicationFile.empty()) controlPort_Clock100MHz__.loadApplicationFile(filename);if(!controlPort_AMBAPVBus__.loadApplicationFile.empty()) controlPort_AMBAPVBus__.loadApplicationFile(filename);if(!controlPort_Clock1Hz__.loadApplicationFile.empty()) controlPort_Clock1Hz__.loadApplicationFile(filename);if(!controlPort_BusDecoder__.loadApplicationFile.empty()) controlPort_BusDecoder__.loadApplicationFile(filename);};
}
}

#line 1 "/afs/unity.ncsu.edu/users/a/aravill/ece720/gitrepo/hw05/p2/sgc/Cortex-M0.lisa"
namespace Cortex_NMS { void 
Component__Cortex::init()
{{if(!controlPort_Core__.init.empty()) controlPort_Core__.init();if(!controlPort_Clock100MHz__.init.empty()) controlPort_Clock100MHz__.init();if(!controlPort_AMBAPVBus__.init.empty()) controlPort_AMBAPVBus__.init();if(!controlPort_Clock1Hz__.init.empty()) controlPort_Clock1Hz__.init();if(!controlPort_BusDecoder__.init.empty()) controlPort_BusDecoder__.init();};
}
}

#line 1 "/afs/unity.ncsu.edu/users/a/aravill/ece720/gitrepo/hw05/p2/sgc/Cortex-M0.lisa"
namespace Cortex_NMS { void 
Component__Cortex::terminate()
{{if(!controlPort_Core__.terminate.empty()) controlPort_Core__.terminate();if(!controlPort_Clock100MHz__.terminate.empty()) controlPort_Clock100MHz__.terminate();if(!controlPort_AMBAPVBus__.terminate.empty()) controlPort_AMBAPVBus__.terminate();if(!controlPort_Clock1Hz__.terminate.empty()) controlPort_Clock1Hz__.terminate();if(!controlPort_BusDecoder__.terminate.empty()) controlPort_BusDecoder__.terminate();};
}
}

#line 1 "/afs/unity.ncsu.edu/users/a/aravill/ece720/gitrepo/hw05/p2/sgc/Cortex-M0.lisa"
namespace Cortex_NMS { void 
Component__Cortex::reset(int level)
{{if(!controlPort_Core__.reset.empty()) controlPort_Core__.reset(level);if(!controlPort_Clock100MHz__.reset.empty()) controlPort_Clock100MHz__.reset(level);if(!controlPort_AMBAPVBus__.reset.empty()) controlPort_AMBAPVBus__.reset(level);if(!controlPort_Clock1Hz__.reset.empty()) controlPort_Clock1Hz__.reset(level);if(!controlPort_BusDecoder__.reset.empty()) controlPort_BusDecoder__.reset(level);};
}
}

#line 1 "/afs/unity.ncsu.edu/users/a/aravill/ece720/gitrepo/hw05/p2/sgc/Cortex-M0.lisa"
namespace Cortex_NMS { void 
Component__Cortex::reset(int level, int /*argc*/, char** /*argv*/)
{
	reset(level);

}
}

#line 1 "/afs/unity.ncsu.edu/users/a/aravill/ece720/gitrepo/hw05/p2/sgc/Cortex-M0.lisa"
namespace Cortex_NMS { void 
Component__Cortex::step()
{{if(!controlPort_Core__.step.empty()) controlPort_Core__.step();if(!controlPort_Clock100MHz__.step.empty()) controlPort_Clock100MHz__.step();if(!controlPort_AMBAPVBus__.step.empty()) controlPort_AMBAPVBus__.step();if(!controlPort_Clock1Hz__.step.empty()) controlPort_Clock1Hz__.step();if(!controlPort_BusDecoder__.step.empty()) controlPort_BusDecoder__.step();};
}
}

#line 120 "./Linux64-Release-GCC-4.9/gen/Comp_NonDSO_1.cpp"

// ------------------------------------------------------------------------------
// implementation of class Component__Cortex
// ------------------------------------------------------------------------------

namespace Cortex_NMS {

Component__Cortex::Component__Cortex(const char * instName, sg::SimulationContext* simulationContext, const sg::Params & params):
    SystemGenComponent(instName, simulationContext, params)



	,cadiParameterProxy_Clock100MHz_of_ClockDivider_to_Cortex__(0)
	,cadiParameterProxy_AMBAPVBus_of_PVBus2AMBAPV_to_Cortex__(0)

{
    // initialize properties__
	properties__["component_name"] = "";
	properties__["component_type"] = "System";
	properties__["debugger_name"] = "";
	properties__["debugger_start_command"] = "";
	properties__["default_view"] = "auto";
	properties__["description"] = "";
	properties__["documentation_file"] = "";
	properties__["dso_safe"] = "0";
	properties__["executes_software"] = "0";
	properties__["expose_extern_sub_component_cadi"] = "1";
	properties__["factory_namespace"] = "";
	properties__["has_cadi"] = "1";
	properties__["has_implicit_clk_in"] = "1";
	properties__["hidden"] = "0";
	properties__["hwversion"] = "";
	properties__["icon_file"] = "";
	properties__["ip_provider"] = "";
	properties__["is_single_stepped"] = "0";
	properties__["license_feature"] = "";
	properties__["loadfile_extension"] = "";
	properties__["small_icon_file"] = "";
	properties__["variant"] = "";
	properties__["version"] = "1.0";

    // initialize parameter info
    {
        sg::ComponentFactory *factory = Cortex_GetFactory();

        sg::TargetInfo *targetInfo = factory->getTargetInfo(""); // empty string means 'this' component

        if(targetInfo) // if we have no target info we also have no parameters towards CADI interfaces
        {
            // get parameter infos
            for(unsigned int i = 0; i < targetInfo->parameter_count; i++)
            {
                parameterId2parameterName__[targetInfo->parameter_info[i].id] = targetInfo->parameter_info[i].name;
                parameterInfos__.push_back((targetInfo->parameter_info)[i]);
            }
        }

        factory->dereference();
    }

    // create subcomponents
	{
		sg::ComponentFactory *ClockDivider_factory = ClockDivider_GetFactory();
		sg::ComponentFactory *MasterClock_factory = MasterClock_GetFactory();
		sg::ComponentFactory *ARMCortexM0CT_factory = ARMCortexM0CT_GetFactory();
		sg::ComponentFactory *PVBusDecoder_factory = PVBusDecoder_GetFactory();
		sg::ComponentFactory *PVBus2AMBAPV_factory = PVBus2AMBAPV_GetFactory();
		{
			sg::Params params_Core__ = params.getParamsFor("Core");
			Core = ARMCortexM0CT_factory->instantiate(subcompHierName("Core"), simulationContext, params_Core__);
			Core->setParent(this);
			add(Core);
		}
		{
			sg::Params params_Clock100MHz__ = params.getParamsFor("Clock100MHz");
			params_Clock100MHz__["mul"] = UINT64_C(0x0000000005F5E100);
			Clock100MHz = ClockDivider_factory->instantiate(subcompHierName("Clock100MHz"), simulationContext, params_Clock100MHz__);
			Clock100MHz->setParent(this);
			add(Clock100MHz);
		}
		{
			sg::Params params_AMBAPVBus__ = params.getParamsFor("AMBAPVBus");
			params_AMBAPVBus__["size"] = UINT64_C(0x00000000F0000000);
			AMBAPVBus = dynamic_cast<Component__PVBus2AMBAPV*>(PVBus2AMBAPV_factory->instantiate(subcompHierName("AMBAPVBus"), simulationContext, params_AMBAPVBus__));
			assert(AMBAPVBus);
			add(AMBAPVBus);
		}
		{
			sg::Params params_Clock1Hz__ = params.getParamsFor("Clock1Hz");
			Clock1Hz = MasterClock_factory->instantiate(subcompHierName("Clock1Hz"), simulationContext, params_Clock1Hz__);
			Clock1Hz->setParent(this);
			add(Clock1Hz);
		}
		{
			sg::Params params_BusDecoder__ = params.getParamsFor("BusDecoder");
			BusDecoder = PVBusDecoder_factory->instantiate(subcompHierName("BusDecoder"), simulationContext, params_BusDecoder__);
			BusDecoder->setParent(this);
			add(BusDecoder);
		}
		ClockDivider_factory->dereference();
		MasterClock_factory->dereference();
		ARMCortexM0CT_factory->dereference();
		PVBusDecoder_factory->dereference();
		PVBus2AMBAPV_factory->dereference();
	}


    // bind local behaviors to this->control_port
    bind_method(control_port, configure, &Component__Cortex::control_port__configure, this);
    bind_method(control_port, init, &Component__Cortex::init, this);
    bind_method(control_port, interconnect, &Component__Cortex::interconnect, this);
    bind_method(control_port, reset, &Component__Cortex::control_port__reset, this);
    bind_method(control_port, loadApplicationFile, &Component__Cortex::loadApplicationFile, this);
    bind_method(control_port, serializeState, &Component__Cortex::control_port__serializeState, this);
    bind_method(control_port, disconnect, &Component__Cortex::disconnect, this);
    bind_method(control_port, terminate, &Component__Cortex::control_port__terminate, this);
    bind_method(control_port, populateCADIMap, &Component__Cortex::control_port__populateCADIMap, this);
    bind_method(control_port, step, &Component__Cortex::step, this);
    bind_method(control_port, getProperty, &Component__Cortex::control_port__getProperty, this);
    bind_method(control_port, bypass, &Component__Cortex::control_port__bypass, this);
    bind_method(control_port, run, &Component__Cortex::control_port__run, this);
    bind_method(control_port, stop, &Component__Cortex::control_port__stop, this);
    bind_method(control_port, idle, &Component__Cortex::control_port__idle, this);
    bind_method(control_port, quit, &Component__Cortex::control_port__quit, this);
    bind_method(control_port, setSimulationEngine, &Component__Cortex::control_port__setSimulationEngine, this);
    bind_method(control_port, message, &Component__Cortex::control_port__message, this);
    bind_method(control_port, callSimEngine, &Component__Cortex::control_port__callSimEngine, this);

    // Avoid the propagation of calls to subcomponents through the framework:
    // if setLocalOnly(true) is not called, any call to an element (connector)
    // of the control port, causes the corresponding behaviours of all
    // subcomponents to be automatically called, too. Whenever we want the
    // LISA programmer to control the propagation of special-purpose behaviours,
    // we need to prevent this to happen.
    control_port.configure.setLocalOnly(true);
    control_port.init.setLocalOnly(true);
    control_port.interconnect.setLocalOnly(true);
    control_port.reset.setLocalOnly(true);
    control_port.loadApplicationFile.setLocalOnly(true);
    control_port.serializeState.setLocalOnly(true);
    control_port.disconnect.setLocalOnly(true);
    control_port.terminate.setLocalOnly(true);
    control_port.populateCADIMap.setLocalOnly(true);
    control_port.step.setLocalOnly(true);
    control_port.getProperty.setLocalOnly(true);
//  control_port.bypass.setLocalOnly(true);
//  control_port.run.setLocalOnly(true);
//  control_port.stop.setLocalOnly(true);
//  control_port.idle.setLocalOnly(true); // broadcast ports don't have setLocalOnly
//  control_port.quit.setLocalOnly(true);
//  control_port.setSimulationEngine.setLocalOnly(true);

    // bind cadiPort behaviors
    bind_method(cadiPort__, GetParameters, &Component__Cortex::cadiPort__GetParameters, this);
    bind_method(cadiPort__, GetParameterInfo, &Component__Cortex::cadiPort__GetParameterInfo, this);
    bind_method(cadiPort__, GetProperty, &Component__Cortex::cadiPort__GetProperty, this);
    bind_method(cadiPort__, LoadApplicationFile, &Component__Cortex::cadiPort__LoadApplicationFile, this);
    bind_method(cadiPort__, GetApplicationsAndCommandLineParams, &Component__Cortex::cadiPort__GetApplicationsAndCommandLineParams, this);

    // connect control ports for subcomponents to subcomponents
    connect_controlports__();


    // resource initialization code
    reset_resources__();

    // bind behaviors to abstract ports


    // add abstract ports
    add_abstractports__();

    // wire up static connection map
    wire_connectionmap__();

    // init profiling

    // init resources


    // run the parameter write access functions for all of the component's parameters
    for (size_t i = 0; i < parameterInfos__.size(); ++i)
    {
        std::string paramName = parameterInfos__[i].name;

        switch (parameterInfos__[i].dataType)
        {
        case eslapi::CADI_PARAM_STRING:
            {
                std::string data = GetParameterValue(params, paramName, parameterInfos__[i].defaultString);
                parameter_write_string_func(paramNameToParamAccessFuncID(paramName), data);
            }
            break;
        case eslapi::CADI_PARAM_BOOL:
        case eslapi::CADI_PARAM_INT:
            {
                int64_t data = GetParameterValue(params, paramName, parameterInfos__[i].defaultValue, parameterInfos__[i].minValue, parameterInfos__[i].maxValue);
                parameter_write_func(paramNameToParamAccessFuncID(paramName), &data);
            }
            break;
        default:
            break;
        }
    }
}


Component__Cortex::~Component__Cortex()
{
}

void Component__Cortex::control_port__serializeState(const char *name, cp::SerializationInterface* stream)
{
    serializeState(name, stream);
}

void Component__Cortex::control_port__configure(const sg::Params& params)
{

	if(controlPort_Core__.configure.implemented()) controlPort_Core__.configure(params.getParamsFor("Core"));
	if(controlPort_Clock100MHz__.configure.implemented()) controlPort_Clock100MHz__.configure(params.getParamsFor("Clock100MHz"));
	if(controlPort_AMBAPVBus__.configure.implemented()) controlPort_AMBAPVBus__.configure(params.getParamsFor("AMBAPVBus"));
	if(controlPort_Clock1Hz__.configure.implemented()) controlPort_Clock1Hz__.configure(params.getParamsFor("Clock1Hz"));
	if(controlPort_BusDecoder__.configure.implemented()) controlPort_BusDecoder__.configure(params.getParamsFor("BusDecoder"));


    assert(simulationContext__->getSimulationEngine());
    cadi__ = new Component__Cortex_CADI(this, simulationContext__->getSimulationEngine());
    buildDebugInfoWithMetaData__();

    // forward certain calls from CADI interface to this component
    cadi__->GetCADIPort().connectTo(cadiPort__);

    

    std::map< std::string, eslapi::CAInterface* > tempMap;
    control_port__populateCADIMap(tempMap, ""); // precompute mxdi map

	cadi__->EnableSubComponentCADIImport();


}

void Component__Cortex::control_port__populateCADIMap(std::map< std::string, eslapi::CAInterface* >&output_map, std::string const & base_prefix)
{
    if (componentName2CADI__.empty())
    {
        componentName2CADI__[getName()] = static_cast<eslapi::CADI*>(cadi__);
        std::string prefix = getName() + ".";

		{
			std::map< std::string, eslapi::CAInterface* > compMap;
			if (controlPort_Core__.populateCADIMap.implemented())
			{
				controlPort_Core__.populateCADIMap(compMap, "");
			}
			insertCADIMap__(prefix, compMap);
		}
		{
			std::map< std::string, eslapi::CAInterface* > compMap;
			if (controlPort_Clock100MHz__.populateCADIMap.implemented())
			{
				controlPort_Clock100MHz__.populateCADIMap(compMap, "");
			}
			insertCADIMap__(prefix, compMap);
			eslapi::CADI *cadi = obtainCADI__("Clock100MHz", compMap);
			if (cadi != NULL)
			{
				cadiParameterProxy_Clock100MHz_of_ClockDivider_to_Cortex__ = new CADIParameterProxy(cadi, &parameterFilter_Clock100MHz_of_ClockDivider_to_Cortex__);
			}
		}
		{
			std::map< std::string, eslapi::CAInterface* > compMap;
			if (controlPort_AMBAPVBus__.populateCADIMap.implemented())
			{
				controlPort_AMBAPVBus__.populateCADIMap(compMap, "");
			}
			insertCADIMap__(prefix, compMap);
			eslapi::CADI *cadi = obtainCADI__("AMBAPVBus", compMap);
			if (cadi != NULL)
			{
				cadiParameterProxy_AMBAPVBus_of_PVBus2AMBAPV_to_Cortex__ = new CADIParameterProxy(cadi, &parameterFilter_AMBAPVBus_of_PVBus2AMBAPV_to_Cortex__);
			}
		}
		{
			std::map< std::string, eslapi::CAInterface* > compMap;
			if (controlPort_Clock1Hz__.populateCADIMap.implemented())
			{
				controlPort_Clock1Hz__.populateCADIMap(compMap, "");
			}
			insertCADIMap__(prefix, compMap);
		}
		{
			std::map< std::string, eslapi::CAInterface* > compMap;
			if (controlPort_BusDecoder__.populateCADIMap.implemented())
			{
				controlPort_BusDecoder__.populateCADIMap(compMap, "");
			}
			insertCADIMap__(prefix, compMap);
		}

    }
    // Copy the local map into the given map with the requested prefix.
    for (std::map<std::string,eslapi::CAInterface*>::iterator it = componentName2CADI__.begin(); it != componentName2CADI__.end(); ++it)
    {
        output_map.insert(std::make_pair(base_prefix + it->first, it->second));
    }
}

void Component__Cortex::buildDebugInfoWithMetaData__()
{
    sg::CADIBase::RegInfo regData[] =
    {

        {"ETFR", "ExtendedTargetFeatureRegisterGroup", 0, 0, eslapi::CADI_REGTYPE_STRING, "Extended Target Features", eslapi::CADI_REG_READ_ONLY, 0, 0, 0, true, 0, false, 0, 0, 0, true/*pseudo*/, true, 0xFFFFFFFF, 0, 0, 0, 0, 0xffffffff, 0, 0, false, false, false},
        {0, "", 0, 0, eslapi::CADI_REGTYPE_HEX, 0, eslapi::CADI_REG_READ_WRITE, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    };

    // the instance specific data has to be non-static, this is currently only access_data
    // this array is compressed: only registers which have hasInstanceSpecificPointers=true in regData are present here
    sg::CADIBase::RegInfoInstanceSpecific regDataInstanceSpecific[] = {

        {0, 0, 0, 0, MakeDelegate(this, &Component__Cortex::GetExtendedTargetFeatures__), 0, 0},
        {0, 0, 0, 0, 0, 0, 0}
    };

    sg::CADIBase::ParamInfo paramData[] =
    {

        { 0, 0, 0, 0, 0 }
    };

    buildDebugInfo__(regData, (sizeof(regData) / sizeof( regData[0])) - 1,
                     regDataInstanceSpecific, sizeof(regDataInstanceSpecific) / sizeof( regDataInstanceSpecific[0]),
                     paramData, sizeof(paramData) / sizeof(paramData[0]));
}

sg::accessfunc::AccessFuncResult
Component__Cortex::GetExtendedTargetFeatures__(uint32_t /*id*/, std::string &data, bool /*se*/)
{
    data = getExtendedTargetFeatures();
    return sg::accessfunc::ACCESS_FUNC_OK;
}

eslapi::CADI* Component__Cortex::obtainCADI__(const std::string &subcomp, const std::map< std::string, eslapi::CAInterface* > &componentName2CADI) const
{
    std::map< std::string, eslapi::CAInterface* >::const_iterator it = componentName2CADI.find(subcomp);
    if (it != componentName2CADI.end())
    {
        eslapi::CAInterface *cai = it->second;
        if (cai != NULL)
        {
            cai = cai->ObtainInterface(eslapi::CADI::IFNAME(), 0, 0);
            if (cai != NULL)
            {
                return static_cast<eslapi::CADI*>(cai);
            }
        }
    }
    return NULL;
}

void Component__Cortex::insertCADIMap__(std::string prefix, std::map< std::string, eslapi::CAInterface* > &componentName2CADI)
{
    for (std::map<std::string, eslapi::CAInterface*>::iterator it = componentName2CADI.begin(); it != componentName2CADI.end(); it++)
    {
        // put prefix in front of all entries
        componentName2CADI__[prefix + it->first] = it->second;
    }
}


std::string Component__Cortex::control_port__getProperty(const std::string& propname)
{
    if(properties__.find(propname) != properties__.end())
    {
        return properties__[propname];
    }
    else
        return ""; // unknown property
}

std::string Component__Cortex::control_port__bypass(const std::string&)
{
    return "";
}

void Component__Cortex::control_port__run()
{
}


void Component__Cortex::control_port__stop()
{
}


void Component__Cortex::control_port__idle()
{
}


void Component__Cortex::control_port__quit()
{
}


void Component__Cortex::control_port__setSimulationEngine(SimulationEngine*)
{
}


void Component__Cortex::control_port__message(const std::string &msg, sg::message::MessageType msgType)
{
}


std::string Component__Cortex::control_port__callSimEngine(const std::string &)
{
    return "";
}


void Component__Cortex::control_port__reset(int level)
{
    // restore the resources' reset values before executing 'reset'
    reset_resources__();
    reset(level);
}


void Component__Cortex::control_port__terminate()
{
    // the CADI was created before 'init', therefore we free it after 'terminate'
    terminate();
    freeCADIResources__();
}


void Component__Cortex::freeCADIResources__()
{
    // free CADI parameter proxies
	delete cadiParameterProxy_Clock100MHz_of_ClockDivider_to_Cortex__;
	cadiParameterProxy_Clock100MHz_of_ClockDivider_to_Cortex__ = 0;
	delete cadiParameterProxy_AMBAPVBus_of_PVBus2AMBAPV_to_Cortex__;
	cadiParameterProxy_AMBAPVBus_of_PVBus2AMBAPV_to_Cortex__ = 0;


    // free CADI interface
    delete cadi__;
    cadi__ = 0;
}


// CADI Port implementations
eslapi::CADIReturn_t Component__Cortex::cadiPort__GetParameters(uint32_t startIndex, uint32_t desiredNumOfParams, uint32_t *actualNumOfParams, eslapi::CADIParameterInfo_t *params)
{
    // check arguments
    if(actualNumOfParams == 0)
        return eslapi::CADI_STATUS_IllegalArgument;
    *actualNumOfParams = 0;
    if(params == 0)
        return eslapi::CADI_STATUS_IllegalArgument;

    // collect parameters
    uint32_t i = 0;
    for (; (i < desiredNumOfParams) && ((startIndex + i) < parameterInfos__.size()); ++i)
    {
        params[i] = parameterInfos__[startIndex + i];
    }
    *actualNumOfParams = i;

    return eslapi::CADI_STATUS_OK;
}

eslapi::CADIReturn_t Component__Cortex::cadiPort__GetParameterInfo(const std::string &parameterName, eslapi::CADIParameterInfo_t* param)
{
    if(param == 0)
        return eslapi::CADI_STATUS_IllegalArgument;

    for (size_t i = 0; i < parameterInfos__.size(); ++i)
    {
        if (!strcmp(parameterInfos__[i].name, parameterName.c_str()))
        {
            *param = parameterInfos__[i];

            return eslapi::CADI_STATUS_OK;
        }
    }

    return eslapi::CADI_STATUS_GeneralError;
}


bool Component__Cortex::ForwardParameterValueToSubcomponent(CADIParameterProxy *proxy, const char *param_name, int64_t intVal, const char *strVal)
{
    if (!proxy)
        return false;

    // we need the parameter's CADI id in order to create an eslapi::CADIParameterValue_t structure
    // therefore, we first retrieve its eslapi::CADIParameterInfo_t meta-data
    eslapi::CADIParameterInfo_t paramInfo;
    if (proxy->CADIGetParameterInfo(param_name, &paramInfo) != eslapi::CADI_STATUS_OK)
        return false;

    eslapi::CADIParameterValue_t paramVal(paramInfo.id, paramInfo.dataType, intVal, strVal);
    eslapi::CADIFactoryErrorMessage_t error;
    if (proxy->CADISetParameters(1, &paramVal, &error) != eslapi::CADI_STATUS_OK)
        return false;

    return true;
}


sg::accessfunc::AccessFuncResult Component__Cortex::parameter_read_func(uint32_t id, int64_t *data)
{
    if (data == 0)
        return eslapi::CADI_STATUS_IllegalArgument;

    switch (id)
    {

        default:
            printf("error: Component__Cortex::parameter_read_func: undefined parameter id '0x%08x'\n", id);
            return sg::accessfunc::ACCESS_FUNC_GeneralError;
    }

    return sg::accessfunc::ACCESS_FUNC_OK;
}

sg::accessfunc::AccessFuncResult Component__Cortex::parameter_read_string_func(uint32_t id, std::string &data)
{
    switch (id)
    {

        default:
            printf("error: Component__Cortex::parameter_read_string_func: undefined parameter id '0x%08x'\n", id);
            return sg::accessfunc::ACCESS_FUNC_GeneralError;
    }

    return sg::accessfunc::ACCESS_FUNC_OK;
}

sg::accessfunc::AccessFuncResult Component__Cortex::parameter_write_func(uint32_t id, const int64_t *data)
{
    if (data == 0)
        return eslapi::CADI_STATUS_IllegalArgument;

    switch (id)
    {

        default:
            printf("error: Component__Cortex::parameter_write_func: undefined parameter id '0x%08x'\n", id);
            return sg::accessfunc::ACCESS_FUNC_GeneralError;
    }

    return sg::accessfunc::ACCESS_FUNC_OK;
}

sg::accessfunc::AccessFuncResult Component__Cortex::parameter_write_string_func(uint32_t id, const std::string &data)
{
    switch (id)
    {

        default:
            printf("error: Component__Cortex::parameter_write_string_func: undefined parameter id '0x%08x'\n", id);
            return sg::accessfunc::ACCESS_FUNC_GeneralError;
    }

    return sg::accessfunc::ACCESS_FUNC_OK;
}

void Component__Cortex::cadiPort__LoadApplicationFile(const std::string& filename)
{
    loadApplicationFile(filename);
    applications2params[filename] = "";
}

void Component__Cortex::cadiPort__GetApplicationsAndCommandLineParams(std::map<std::string, std::string>&applications2params_)
{
    applications2params_ = applications2params;
}

eslapi::CADIReturn_t Component__Cortex::cadiPort__GetProperty(const std::string& propertyName, std::string &value)
{
    if(properties__.find(propertyName) != properties__.end())
    {
        value = properties__[propertyName];
        return eslapi::CADI_STATUS_OK;
    }
    else
    {
        value = "";
        return eslapi::CADI_STATUS_GeneralError;
    }
}

// functions to stop and lock the simulator
// we only expose the simHalt() function in the documentation for the moment

void Component__Cortex::simHalt()
{
    cadi__->StopSimulation();
}


// start simulation from the inside
// (useful from visualisation components which can execute code while the
// simulation is stopped, like key events)
void Component__Cortex::simRun()
{
    cadi__->CADIExecContinue();
}


// return true if simulation is running
// (useful from visualisation components which can execute code while the
// simulation is stopped, like key events)
bool Component__Cortex::simIsRunning()
{
    uint32_t mode = eslapi::CADI_EXECMODE_Stop;
    cadi__->CADIExecGetMode(&mode);
    return mode != eslapi::CADI_EXECMODE_Stop;
}


void Component__Cortex::simShutdown()
{
    cadiPort__.simShutdown();
}

void Component__Cortex::simReset(uint32_t level)
{
    cadi__->CADIExecReset(level);
}

uint32_t Component__Cortex::paramNameToParamAccessFuncID(const std::string &name)
{
    uint32_t id = 0;
    if (name == "") id = 0xffffffff;

    return id;
}

void Component__Cortex::reset_resources__()
{
    // resource initialization code

}

void Component__Cortex::connect_controlports__()
{
    typedef struct {
        sg::Port * local_cport_name;
        sg::ComponentBase * local_instance_name;
        const char * cport_name;
    } connection_map_t;


    connection_map_t cmap[] = {
    {&controlPort_Core__,Core,"$control"},
    {&controlPort_Clock100MHz__,Clock100MHz,"$control"},
    {&controlPort_AMBAPVBus__,AMBAPVBus,"$control"},
    {&controlPort_Clock1Hz__,Clock1Hz,"$control"},
    {&controlPort_BusDecoder__,BusDecoder,"$control"},
    { 0, 0, 0 },
    };


    for(unsigned int i=0; cmap[i].local_cport_name != 0; i++) {
        connection_map_t c = cmap[i];
        c.local_cport_name->connectTo(c.local_instance_name->findPort(c.cport_name));
    }


    // #CONNECT_CONTROLPORTS_TO_SUBCOMPONENTS#
}

void Component__Cortex::add_abstractports__0__()
{
	publishMasterPort("amba_pv_m", amba_pv_m);
	amba_pv_m.SetName__("amba_pv_m");
}



void Component__Cortex::add_abstractports__()
{
	add_abstractports__0__();

}

void Component__Cortex::wire_connectionmap__0__()
{
	AMBAPVBus->findPort("amba_pv_m").connectTo(amba_pv_m);
	Clock1Hz->findPort("clk_out").connectTo(Clock100MHz->findPort("clk_in"));
	tmp__.setName("tmp_addressmap_control");
	tmp__.setParent(this);	tmp__.connectTo(BusDecoder->findPort("pvbus_m_range"));
#line 18 "/afs/unity.ncsu.edu/users/a/aravill/ece720/gitrepo/hw05/p2/sgc/Cortex-M0.lisa"
	tmp__.mapRange(UINT64_C(0x00000000), UINT64_C(0x5FFFFFFF), UINT64_C(0x00000000), UINT64_C(0x5FFFFFFF))->connectTo(AMBAPVBus->findPort("pvbus_s"));
#line 821 "./Linux64-Release-GCC-4.9/gen/Comp_NonDSO_1.cpp"
	tmp__.disconnectFrom(BusDecoder->findPort("pvbus_m_range"));
	Clock100MHz->findPort("clk_out").connectTo(Core->findPort("clk_in"));
	Core->findPort("pvbus_m").connectTo(BusDecoder->findPort("pvbus_s"));
}



void Component__Cortex::wire_connectionmap__()
{
	wire_connectionmap__0__();

}


} // Cortex_NMS

#line 838 "./Linux64-Release-GCC-4.9/gen/Comp_NonDSO_1.cpp"

// This is an anonymous namespace, it effectively declares everything inside it as 'static', e.g. only visible within the .o file it is compiled into
//     without this we get link errors when linking together LISA generated components
namespace
{

class ComponentFactoryBase :
    public sg::BasicComponentFactory
{
protected:
    void publishSubComponent(sg::ComponentFactory *factory,
                             const std::string &prefix,
                             bool publish_all,
                             const ParameterFilter &param_filter);
};

void
ComponentFactoryBase::publishSubComponent(sg::ComponentFactory *factory,
                                          const std::string &prefix,
                                          bool publish_all,
                                          const ParameterFilter &param_filter)
{
    using namespace sg;

    if (param_filter.isEmpty())
    {
        BasicComponentFactory::publishComponent(factory, prefix, publish_all);
    }
    else
    {
        for (unsigned int t = 0; t < factory->getTargetCount(); ++t)
        {
            TargetInfo *info = factory->getTargetInfo(t);

            std::vector<eslapi::CADIParameterInfo_t> my_param_infos;

            param_filter.filter(info->parameter_info, info->parameter_count, info->instance_path, my_param_infos);

            TargetInfo *my_target_info = new TargetInfo;

                        eslapi::CADITargetInfo_t *my_cadi_target_info = new eslapi::CADITargetInfo_t;
                        *my_cadi_target_info = *(info->cadi_target_info); // copy CADI target info
            my_cadi_target_info->numberOfParameters = (uint32_t)my_param_infos.size();
            my_target_info->cadi_target_info = my_cadi_target_info;

            my_target_info->parameter_count = (unsigned)my_param_infos.size();

            // only copy parameters, if there are ones
                        if (my_target_info->parameter_count)
                        {
                                my_target_info->parameter_info = new eslapi::CADIParameterInfo_t[my_target_info->parameter_count];
                                memcpy(const_cast<eslapi::CADIParameterInfo_t *>(my_target_info->parameter_info),
                                           &my_param_infos.front(),
                                           sizeof(eslapi::CADIParameterInfo_t) * my_target_info->parameter_count);
                        }

            my_target_info->instance_path = info->instance_path;

            // Skip any targets that have an instance_path of "".
            if (my_target_info->instance_path.length() > 0)
            {
                // Add the prefix at the start of the instance path.
                std::string new_path = prefix + "." + my_target_info->instance_path;
                publishTarget(*my_target_info, new_path);
            }
            else if (publish_all)
            {
                std::string new_path = prefix;
                publishTarget(*my_target_info, new_path);
            }
            delete my_target_info;
        }
    }
}

}

using namespace Cortex_NMS;

// component factory implementation
// ------------------------------------------------------------------------------
// component factory of class Cortex
// ------------------------------------------------------------------------------
//


namespace
{

// component factory class
// (this concrete class is never exposed to the outside world)
class Cortex_ComponentFactoryClass: public ComponentFactoryBase
{
    bool componentsPublished;
    void lazyPublish(void)
    {
        static eslapi::CADITargetInfo_t info
        (
            0, /* uint32_t id; (overridden in CADIFactory) */                                                              // used for identification
            "Cortex", /* char  targetName[CADI_NAME_SIZE];     */      // name of the target, i.e. the "type", not the instance name
            "", /* char instanceName[CADI_NAME_SIZE]; (overridden in CADIFactory) */    // name of the CADI target instance
            "1.0", /* char        version[CADI_DESCRIPTION]; */           // version string
            "", /* char    description[CADI_DESCRIPTION]; */       // target description
            "System", /* char componentType[CADI_NAME_SIZE]; */       // classification of the target into a user-defined group
            0, /* uint32_t numberOfParameters; (overridden below) */                               // number of parameters supported
            0, /* bool        executesSoftware; */                            // false = does not execute programs, true = executes software
            false, /* uint32_t     isHardwareModel; */                             // 0 = is software model, 1 = is hardware model
            "", /* char systemName[CADI_NAME_SIZE];  (overridden in CADIFactory) */             // name of the system the target belongs to.
            // Is empty for single-core standalone models.
            0, /* uint32_t systemID; (overridden in CADIFactory) */                                                // system id
            "" /* char  systemDescription[CADI_DESCRIPTION]; (overridden in CADIFactory) */ // description of the system
        );

        static eslapi::CADIParameterInfo_t parameters[] =
        {

            eslapi::CADIParameterInfo_t( 0, "", eslapi::CADI_PARAM_BOOL, "", 1, INT64_C(0), INT64_C(-1), 0, "0" )
        };
        info.numberOfParameters = (sizeof(parameters) / sizeof(parameters[0])) - 1;

        // build TargetInfo
        sg::TargetInfo targetInfo;
        targetInfo.cadi_target_info = &info;
        targetInfo.parameter_count = targetInfo.cadi_target_info->numberOfParameters;
        targetInfo.parameter_info = parameters;

        // publish this component's TargetInfo
        publishTarget(targetInfo, "");

        // publish subcomponent TargetInfos
        {
            sg::ComponentFactory *componentFactory = ARMCortexM0CT_GetFactory();
            ComponentFactoryBase::publishComponent(componentFactory, "Core", true);
            componentFactory->dereference();
        }
        {
            sg::ComponentFactory *componentFactory = ClockDivider_GetFactory();
            ComponentFactoryBase::publishSubComponent(componentFactory, "Clock100MHz", true, ParameterFilter_Clock100MHz_of_ClockDivider_to_Cortex());
            componentFactory->dereference();
        }
        {
            sg::ComponentFactory *componentFactory = PVBus2AMBAPV_GetFactory();
            ComponentFactoryBase::publishSubComponent(componentFactory, "AMBAPVBus", true, ParameterFilter_AMBAPVBus_of_PVBus2AMBAPV_to_Cortex());
            componentFactory->dereference();
        }
        {
            sg::ComponentFactory *componentFactory = MasterClock_GetFactory();
            ComponentFactoryBase::publishComponent(componentFactory, "Clock1Hz", true);
            componentFactory->dereference();
        }
        {
            sg::ComponentFactory *componentFactory = PVBusDecoder_GetFactory();
            ComponentFactoryBase::publishComponent(componentFactory, "BusDecoder", true);
            componentFactory->dereference();
        }

        componentsPublished = true;
    }
    ~Cortex_ComponentFactoryClass()
    {
    }

public:
    Cortex_ComponentFactoryClass() {
        componentsPublished = false;
    }

    virtual void dereference() { delete this; }

    virtual sg::ComponentBase *instantiate(std::string const & instance_name,
                                                sg::SimulationContext *simulationContext,
                                                sg::Params const & params)
    {
        return new Cortex_NMS::Component__Cortex(instance_name.c_str(), simulationContext, params);
    }

    virtual unsigned int getTargetCount()
    {
        if (!componentsPublished) lazyPublish();
        return ComponentFactoryBase::getTargetCount();
    }

    virtual sg::TargetInfo * getTargetInfo(unsigned int index)
    {
        if (!componentsPublished) lazyPublish();
        return ComponentFactoryBase::getTargetInfo(index);
    }

    virtual sg::TargetInfo * getTargetInfo(std::string const & instance_path)
    {
        if (!componentsPublished) lazyPublish();
        return ComponentFactoryBase::getTargetInfo(instance_path);
    }

    virtual void publishSubComponent(sg::ComponentFactory *factory, const std::string &prefix,
                          bool publish_all, const ParameterFilter &param_filter)
    {
        if (!componentsPublished) lazyPublish();
        return ComponentFactoryBase::publishSubComponent(factory, prefix, publish_all, param_filter);
    }

    virtual void publishComponent(sg::ComponentFactory *factory, const std::string &prefix,
                          bool publish_all)
    {
        if (!componentsPublished) lazyPublish();
        return ComponentFactoryBase::publishComponent(factory, prefix, publish_all);
    }

};

}

namespace Cortex_NMS {

// factory function
// (this is the function which is exposed to the outside world)
sg::ComponentFactory *Cortex_GetFactory()
{
        return new Cortex_ComponentFactoryClass();
}

} // Cortex_NMS

