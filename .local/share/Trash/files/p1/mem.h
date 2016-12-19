/*************************************************

SystemC Transaction Level Modeling Tutorial
(c) 2/3/2013 W. Rhett Davis (rhett_davis@ncsu.edu)

**************************************************/


#ifndef __MEM_H__ 
#define __MEM_H__

#include "tlm.h"
#include "tlm_utils/simple_target_socket.h"

class mem: public sc_core::sc_module
{
  public:  

  mem( sc_core::sc_module_name module_name,
       sc_dt::uint64  memory_size  // memory size (bytes)
      );

  tlm_utils::simple_target_socket<mem>  slave;
  bool accMem; // added // to check if mem location is read already  
 
  private:
	    
  sc_dt::uint64 m_memory_size;
  sc_dt::uint64 prev_row_addr, prev_bank_addr; // previous row address to check if same row

  void custom_b_transport
  ( tlm::tlm_generic_payload &gp, sc_core::sc_time &delay );

};


#endif /* __MEM_H__ */
