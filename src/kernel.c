#include "../include/kb.h"
#include "../include/isr.h"
#include "../include/idt.h"
#include "../include/util.h"
#include "../include/shell.h"
#include "../include/multiboot.h"

int main(unsigned int ebx){
	multiboot_info_t *mbinfo = (multiboot_info_t *) ebx;
	unsigned int address_of_module = mbinfo->mods_addr;	
}
