/*************************************************

SystemC Transaction Level Modeling Tutorial
(c) 2/3/2013 W. Rhett Davis (rhett_davis@ncsu.edu)

**************************************************/

#include "mem.h"

using namespace  std;

SC_HAS_PROCESS(mem);
mem::mem( sc_core::sc_module_name module_name, sc_dt::uint64 memory_size )
  : sc_module (module_name)
  , m_memory_size (memory_size)
{
  
  slave.register_b_transport(this, &mem::custom_b_transport);
  accMem = false; // initial setting << memory not accessed.  
}

void                                        
mem::custom_b_transport
 ( tlm::tlm_generic_payload &gp, sc_core::sc_time &delay )
{ 
  sc_dt::uint64    address   = gp.get_address();
  tlm::tlm_command command   = gp.get_command();
  sc_core::sc_time mem_delay(10,sc_core::SC_NS);
 
 if (address < m_memory_size) { 
    switch (command) {
      case tlm::TLM_WRITE_COMMAND:
      { wait(delay+mem_delay);
        //sc_core::sc_time mem_delay(10,sc_core::SC_NS);
       cout << sc_core::sc_time_stamp() << " " << sc_object::name();        
        cout << " WRITE 0x" << hex << address << endl; 
        gp.set_response_status( tlm::TLM_OK_RESPONSE );
        break;
      }
      case tlm::TLM_READ_COMMAND: // have to modify the read
      { 
      
        /* Latency calc. */
       if(accMem == false) // not accessed
       { accMem = true; 
          mem_delay = sc_core::sc_time(80,sc_core::SC_NS);
       std::cout<<"Delay for initial access:    "<<mem_delay<<"\n";   }
             
       else if(((address & 0x0FFF8000) == prev_row_addr) && ((address & 0x00006000)== prev_bank_addr)) // same row same bank access
        {
	mem_delay = sc_core::sc_time(50,sc_core::SC_NS); 
        std::cout<<"Delay for accessing same row of same bank:    "<<mem_delay<<"\n"; }

       else if(((address & 0x0FFF8000) != prev_row_addr) && ((address & 0x00006000)== prev_bank_addr)) // different row
       {
       mem_delay =  sc_core::sc_time(100,sc_core::SC_NS);
       std::cout<<"Delay for accessing different row of same bank :   "<<mem_delay<<"\n";}
      
       else if((address & 0x00006000)!= prev_bank_addr)
       {mem_delay = sc_core::sc_time(80,sc_core::SC_NS);
       std::cout<<"Delay for accessing different bank:    "<<mem_delay<<"\n";
       }

       else
       cout<<"ERRONEOUS ADDRESS";

       /* LAtency control */
        wait(mem_delay);
         cout << sc_core::sc_time_stamp() << " " << sc_object::name();
            cout << " READ 0x" << hex << address << endl; 
      prev_row_addr = (address & 0x0FFF8000); //32'b00001111111111111000000000000000);
      prev_bank_addr = (address & 0x00006000); // 32'b00000000000000000110000000000000);
       address = address + 0x40; 
  
      } // end of reads set status as OK 
       gp.set_response_status( tlm::TLM_OK_RESPONSE );
        break;
      
      default:
      {
        cout << " ERROR Command " << command << " not recognized" << endl;
        gp.set_response_status( tlm::TLM_COMMAND_ERROR_RESPONSE );
      } 
    }
 } 
  else {
    cout << " ERROR Address 0x" << hex << address << " out of range" << endl;
    gp.set_response_status( tlm::TLM_ADDRESS_ERROR_RESPONSE );
  }  

  return;     
}







