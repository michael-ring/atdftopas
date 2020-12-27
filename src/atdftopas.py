#!/usr/bin/env python3
import sys,os,getopt
from xml.dom import minidom
from atdfPeripherals import extractPeripherals
from atdfInterrupts import extractInterrupts
from atdfModules import extractModules
from atdfExtras import extractExtras
from atdfOptimizeAVR import normalizeOffsets,unifyModules,unifyInterrupts

def extractRegistersSimple(registers,module):
  try:
    lastOffset = sorted(registers.keys())[0]
  except:
    lastOffset = 0
  lastReserved = 0

  for registerKey in sorted(registers.keys()):
    if lastOffset != registerKey:
      if registerKey - lastOffset == 1:
        print(f"    RESERVED{lastReserved:<4} : byte;")
      if registerKey - lastOffset == 2:
        print(f"    RESERVED{lastReserved:<4} : word;")
      if registerKey - lastOffset == 3:
        print(f"    RESERVED{lastReserved:<4} : array[1..3] of byte;")
      if registerKey - lastOffset == 4:
        print(f"    RESERVED{lastReserved:<4} : longWord;")
      if registerKey - lastOffset > 4:
        print(f"    RESERVED{lastReserved:<4} : array[1..{registerKey - lastOffset}] of byte;")
      lastReserved += 1
    register = registers[registerKey]
    if register["count"] == 1 and module != "PORT":
      try:
        if register["groupname"] != "":
          print(f"    {register['name']:12} : T{register['groupname']}_Registers;  //{registerKey:04X} {register['caption']}")
          lastOffset = registerKey + register["size"]
          continue
      except:
        pass
      if register["size"] == 1:
        print(f"    {register['name']:12} : byte;                 //{registerKey:04X} {register['caption']}")
      if register["size"] == 2:
        print(f"    {register['name']:12} : word;                 //{registerKey:04X} {register['caption']}")
      if register["size"] == 4:
        print(f"    {register['name']:12} : longWord;             //{registerKey:04X} {register['caption']}")
      if register["size"] > 4:
        print(f"    {register['name']:12} : {register['size']:04X};     //{registerKey:04X} {register['caption']}")
      lastOffset = registerKey + register["size"]
    else:
      try:
        if register["groupname"] != "":
          print(f"    {register['groupname']:12} : array[0..{register['count'] - 1}] of T{register['name']}_Registers;  //{registerKey:04X} {register['caption']}")
          lastOffset = registerKey + register["size"] * register["count"]
          continue
      except:
        pass
      if register["size"] == 1:
        print(f"    {register['name']:12} : array[0..{register['count']-1}] of byte;  //{registerKey:04X} {register['caption']}")
      if register["size"] == 2:
        print(f"    {register['name']:12} : array[0..{register['count']-1}] of word;  //{registerKey:04X} {register['caption']}")
      if register["size"] == 4:
        print(f"    {register['name']:12} : array[0..{register['count']-1}] of longWord; //{registerKey:04X} {register['caption']}")
      if register["size"] > 4:
        print(f"    {register['name']:12} : array[0..{register['count']-1}] of {register['size']:04X}; //{registerKey:04X} {register['caption']}")
      lastOffset = registerKey + register["size"]*register["count"]

def main(argv):
  atdfDir= ""
  chip=""
  try:
    opts, args = getopt.getopt(argv,"ha:c:",["chip=","atdfdir="])
  except getopt.GetoptError:
    print('atdfToPas.py -c <Chip> -a <atdfdirectory>')
    sys.exit(2)
  for opt, arg in opts:
    if opt == '-h':
      print('atdfToPas.py -c <Chip> -a <atdfdirectory>')
      sys.exit()
    elif opt in ("-c", "--chip"):
      chip = arg
    elif opt in ("-a", "--atdfdir"):
      atdfDir = arg
  if chip == "" or atdfDir == "":
    print('atdfToPas.py -c <Chip> -a <atdfdirectory>')
    sys.exit()

  peripherals=extractPeripherals(atdfDir, chip)
  modules=extractModules(atdfDir, chip)
  interrupts=extractInterrupts(atdfDir, chip)
  extras=extractExtras(atdfDir, chip)
  if extras["architecture"].startswith("AVR"):
    normalizeOffsets(peripherals, modules)
    unifyModules(peripherals, modules)
    unifyInterrupts(interrupts)

  print(f"unit {chip.lower().replace('atsam','sam')};")
  print("""(*
  Copyright (c) 2020 Microchip Technology Inc.
                   
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the Licence at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*)
""")
  print("interface")
  print("{$PACKRECORDS C}")
  print("{$GOTO ON}")
  print("{$SCOPEDENUMS ON}")
  print("{$DEFINE INTERFACE}")
  print("{$UNDEF IMPLEMENTATION}")
  print("{$DEFINE __" + extras['architecture'].replace('-', '') + "}")
  if extras['__NVIC_PRIO_BITS'] == '2':
    print("{$DEFINE __NVIC_PRIO_BITS2 }")
  if extras['__NVIC_PRIO_BITS'] == '3':
    print("{$DEFINE __NVIC_PRIO_BITS3 }")
  if extras['__NVIC_PRIO_BITS'] == '4':
    print("{$DEFINE __NVIC_PRIO_BITS4 }")
  print()
  if "CORTEX" in extras["architecture"]:
    print("const")
    if '__FPU_PRESENT' in extras:
      print(f"  __FPU_PRESENT={extras['__FPU_PRESENT']};")
    print(f"  __MPU_PRESENT={extras['__MPU_PRESENT']};")
    print(f"  __NVIC_PRIO_BITS={extras['__NVIC_PRIO_BITS']};")
    print()

  print("type")
  print("  TIRQn_Enum = (")
  lastIrq = list(interrupts.keys())[-1]
  for interrupt in interrupts:
    subIrqs=interrupts[interrupt]
    lastSubIrq=list(subIrqs.keys())[-1]
    for subIrq in subIrqs:
      print(f"    {subIrqs[subIrq]['name']+'_IRQn':25} = {subIrq}", end='')
      if (lastIrq == interrupt) and (lastSubIrq == subIrq):
        print("")
      else:
        print(",")
  print("  );")
  print()

  #for module in sorted(modules.keys()):
  for module in modules:
    for registerMode in modules[module]:
      if registerMode == "Default":
        print(f"  T{module}_Registers = record")
        extractRegistersSimple(modules[module][registerMode],module)
        print("  end;")
        print()
      else:
        if "_"+registerMode in module:
          print(f"  T{module}_Registers = record")
        else:
          print(f"  T{module}{registerMode}_Registers = record")
        extractRegistersSimple(modules[module][registerMode],module)
        print("  end;")
        print()

  for module in modules:
    if len(modules[module]) > 1:
      count = 0
      print(f'  T{module}_Registers = record')
      print(f"  case byte of")
      for index  in modules[module].keys():
        print(f"    {count}: ( {index} : T{module}{index}_Registers );")
        count = count + 1

      print("    end;")
      print()

  print("const")
  for peripheral in sorted(peripherals.keys()):
    print(f"  {peripheral+'_BASE':20}= ${peripherals[peripheral]['offset']:08x};")

  print()
  print("var")
  for peripheral in sorted(peripherals.keys()):
    print(f"  {peripheral:20}: T{peripherals[peripheral]['name-in-module']+'_Registers ':20}absolute {peripheral}_BASE;")

  print()
  print("{$i    cmsis.inc}")
  print()
  print("implementation")
  print()
  print("{$DEFINE IMPLEMENTATION}")
  print("{$UNDEF INTERFACE}")
  print()
  if extras["architecture"].startswith("AVR"):
    print("{$i avrcommon.inc}")
    print("")

  for interrupt in interrupts:
    subIrqs=interrupts[interrupt]
    tmp=""
    for subIrq in subIrqs:
      tmp+=subIrqs[subIrq]['name']+'_'
    print(f"procedure {tmp+'Handler;':25} external name '{tmp}Handler';")
  print()

  if "CORTEX" in extras["architecture"]:
    if "CORTEX-M0" in extras["architecture"]:
      print("{$i    cortexm0_start.inc}")
    if "CORTEX-M3" in extras["architecture"]:
      print("{$i    cortexm3_start.inc}")
    if "CORTEX-M4" in extras["architecture"]:
      print("{$i    cortexm4f_start.inc}")
    print("{$i    cmsis.inc}")
    print()
    print("procedure Vectors; assembler; nostackframe;")
    print("label interrupt_vectors;")
    print("asm")
    print('  .section ".init.interrupt_vectors"')
    print("  interrupt_vectors:")
    print("  .long _stack_top")
    print("  .long Startup")
    lastIrqUsed=-15
    for interrupt in interrupts:
      subIrqs=interrupts[interrupt]
      tmp=""
      for subIrq in subIrqs:
        tmp+=subIrqs[subIrq]['name']+'_'
      if lastIrqUsed < interrupt-1:
        for empty in range(lastIrqUsed,interrupt-1):
          print("  .long 0")
      print(f"  .long {tmp+'Handler;'}")
      lastIrqUsed=interrupt
  else:
    print("procedure _FPC_start; assembler; nostackframe;")
    print("label")
    print("  _start;")
    print("asm")
    print("  .init")
    print("  .globl _start")
    print()
    print("  jmp _start")
    for interrupt in interrupts:
      subIrqs=interrupts[interrupt]
      tmp=""
      for subIrq in subIrqs:
        tmp+=subIrqs[subIrq]['name']+'_'
      print(f"  jmp {tmp+'Handler;'}")
    print()
    print("  {$i start.inc}")

  print()
  for interrupt in interrupts:
    subIrqs=interrupts[interrupt]
    tmp=""
    for subIrq in subIrqs:
      tmp+=subIrqs[subIrq]['name']+'_'
    print(f"  .weak {tmp+'Handler;'}")
  print()
  for interrupt in interrupts:
    subIrqs=interrupts[interrupt]
    tmp=""
    for subIrq in subIrqs:
      tmp+=subIrqs[subIrq]['name']+'_'
    if interrupt < 0:
      print(f"  .set {tmp + 'Handler,':25}_{tmp + 'Handler'}")
    else:
      print(f"  .set {tmp+'Handler,':25}Haltproc")
  print("  .text")
  print("  end;")
  print("end.")

if __name__ == "__main__":
   main(sys.argv[1:])
