#!/usr/bin/env python3
import sys,os,getopt,glob
from pathlib import Path
from xml.dom import minidom
from atdfPeripherals import extractPeripherals
from atdfInterrupts import extractInterrupts
from atdfModules import extractModules
from atdfExtras import extractExtras
from atdfOptimizeAVR import normalizeOffsets,unifyModules,unifyInterrupts

def main(argv):
  atdfDir= ""
  family=""
  try:
    opts, args = getopt.getopt(argv,"ha:f:",["family=","atdfdir="])
  except getopt.GetoptError:
    print('atdfToMBF.py -f <Family> -a <atdfdirectory>')
    sys.exit(2)
  for opt, arg in opts:
    if opt == '-h':
      print('atdfToMBF.py -f <Family> -a <atdfdirectory>')
      sys.exit()
    elif opt in ("-f", "--family"):
      family = arg
    elif opt in ("-a", "--atdfdir"):
      atdfDir = Path(arg)
  if family == "" or atdfDir == "":
    print('atdfToMBF.py -f <Family> -a <atdfdirectory>')
    sys.exit()

  chips=atdfDir.glob(family+"*.atdf")
  for chipPath in sorted(chips):
    chip=chipPath.stem
    peripherals=extractPeripherals(atdfDir, chip)
    modules=extractModules(atdfDir, chip)
    extras=extractExtras(atdfDir, chip)
    if extras["architecture"].startswith("AVR"):
      normalizeOffsets(peripherals, modules)
      unifyModules(peripherals, modules)

    print(f"{{$if defined({chip.lower().replace('atsam','sam')}) }}")
    print(f"  {{$define {family.replace('ATSAM','SAM')}}}")
    port=modules['PORT']['Default'][0]['count']
    print("  ",end='')
    for gpio in range(modules['PORT']['Default'][0]['count']):
      print("{$define has_gpio"+chr(ord('a')+gpio)+" }  ",end='')
    print()

    print("  ",end='')
    for peripheral in peripherals:
      if peripheral.startswith('SERCOM'):
        print(f"{{$define {peripheral.replace('SERCOM','has_usart')} }} ",end='')
    print()
    print("  ",end='')
    for peripheral in peripherals:
      if peripheral.startswith('SERCOM'):
        print(f"{{$define {peripheral.replace('SERCOM','has_spi') } }}   ",end='')
    print()
    print("  ",end='')
    for peripheral in peripherals:
      if peripheral.startswith('SERCOM'):
        print(f"{{$define {peripheral.replace('SERCOM','has_i2c')} }}   ",end='')
    print()

    print("  ",end='')
    for peripheral in peripherals:
      if peripheral.startswith('ADC'):
        print(f"{{$define {peripheral.replace('ADC','has_adc')} }}   ",end='')
    print()
    print("  ",end='')
    for peripheral in peripherals:
      if peripheral.startswith('DAC'):
        print(f"{{$define {peripheral.replace('DAC','has_dac')} }}   ",end='')
    print()
    print("  ",end='')
    for peripheral in peripherals:
      if peripheral.startswith('RTC'):
        print(f"{{$define {peripheral.replace('RTC','has_rtc')} }}   ",end='')
    print()
    print("{$endif}")

if __name__ == "__main__":
   main(sys.argv[1:])