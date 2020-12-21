#!/usr/bin/env python3
import sys,os,getopt
from xml.dom import minidom
from atdfPeripherals import extractPeripherals
from atdfInterrupts import extractInterrupts
from atdfModules import extractModules
from atdfExtras import extractExtras
from atdfOptimizeAVR import normalizeOffsets,unifyModules,unifyInterrupts

def extractRegistersSimple(registers):
  try:
    lastOffset = sorted(registers.keys())[0]
  except:
    lastOffset = 0
  lastReserved = 0
  for registerKey in sorted(registers.keys()):
    if lastOffset != registerKey:
      if registerKey - lastOffset == 1:
        print(f"    RESERVED{lastReserved:<4} : byte;                 //{lastOffset:04X}")
      if registerKey - lastOffset == 2:
        print(f"    RESERVED{lastReserved:<4} : word;                 //{lastOffset:04X}")
      if registerKey - lastOffset == 3:
        print(f"    RESERVED{lastReserved:<4} : array[1..3] of byte;  //{lastOffset:04X}")
      if registerKey - lastOffset == 4:
        print(f"    RESERVED{lastReserved:<4} : longWord;             //{lastOffset:04X}")
      if registerKey - lastOffset > 4:
        print(f"    RESERVED{lastReserved:<4} : array[1..{registerKey - lastOffset}] of byte; //{lastOffset:04X}")
      lastReserved += 1
    register = registers[registerKey]
    if register["size"] == 1:
      print(f"    {register['name']:12} : byte;                 //{registerKey:04X} {register['caption']}")
    if register["size"] == 2:
      print(f"    {register['name']:12} : word;                 //{registerKey:04X} {register['caption']}")
    if register["size"] == 4:
      print(f"    {register['name']:12} : longWord;             //{registerKey:04X} {register['caption']}")
    if register["size"] > 4:
      print(f"    {register['name']:12} : {register['size']:04X};     //{registerKey:04X} {register['caption']}")
    lastOffset = registerKey + register["size"]

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

  print(f"unit {chip.lower()};")
  print("interface")
  print("{$PACKRECORDS C}")
  print("{$GOTO ON}")
  print("{$SCOPEDENUMS ON}")
  print()
  print("type")
  print("  TIRQ_Enum = (")
  lastIrq = list(interrupts.keys())[-1]
  for interrupt in interrupts:
    subIrqs=interrupts[interrupt]
    lastSubIrq=list(subIrqs.keys())[-1]
    for subIrq in subIrqs:
      print(f"    {subIrqs[subIrq]['name']+'_IRQ':25} = {subIrq}", end='')
      if (lastIrq == interrupt) and (lastSubIrq == subIrq):
        print("")
      else:
        print(",")
  print("  );")
  print()

  for module in sorted(modules.keys()):
    print(f"// ")
    print(f"  T{module}_Registers = record")
    for registerMode in modules[module]:
      if registerMode == "Default":
        extractRegistersSimple(modules[module][registerMode])
      else:
        print()
    print("  end;")
    print()
  print("const")
  for peripheral in sorted(peripherals.keys()):
    print(f"  {peripheral+'_BASE':20}= ${peripherals[peripheral]['offset']:08x};")

  print()
  print("var")
  for peripheral in sorted(peripherals.keys()):
    print(f"  {peripheral:20}: T{peripherals[peripheral]['name-in-module']+'_Registers':20}absolute {peripheral}_BASE;")

  print()
  print("implementation")
  print()
  if extras["architecture"].startswith("AVR"):
    print("{$i avrcommon.inc}")
    print("")

  for interrupt in interrupts:
    subIrqs=interrupts[interrupt]
    tmp=""
    for subIrq in subIrqs:
      tmp+=subIrqs[subIrq]['name']+'_'
    print(f"procedure {tmp+'ISR;':25} external name '{tmp}ISR';")
  print()
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
    print(f"  jmp {tmp+'ISR;'}")
  print()
  print("  {$i start.inc}")
  print()
  for interrupt in interrupts:
    subIrqs=interrupts[interrupt]
    tmp=""
    for subIrq in subIrqs:
      tmp+=subIrqs[subIrq]['name']+'_'
    print(f"  .weak {tmp+'ISR;'}")
  print()
  for interrupt in interrupts:
    subIrqs=interrupts[interrupt]
    tmp=""
    for subIrq in subIrqs:
      tmp+=subIrqs[subIrq]['name']+'_'
    print(f"  .set {tmp+'ISR,':25}Default_Irq_Handler")
  print("end;")
  print("end.")

if __name__ == "__main__":
   main(sys.argv[1:])