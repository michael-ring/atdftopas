#!/usr/bin/env python3.8
import sys,os,getopt
from lxml import etree

def extractPeripherals(mplabXDir:str,chipName:str):
  root:lxml.etree._ElementTree=etree.parse(os.path.join(mplabXDir, chipName + ".atdf"))
  family=str(root.xpath("devices/device/@family")[0])
  instances = root.xpath("devices/device/peripherals/module/instance")
  results={}
  for instance in instances:
    name=""
    caption=""
    for attrib in instance.attrib:
      if attrib == "name":
        name=instance.attrib["name"]
      elif attrib == "caption":
          caption = instance.attrib["caption"]
      else:
        print('Unknown Instance Attribute: '+attrib)
        sys.exit(1)
    registerGroups=instance.xpath("register-group")
    for registerGroup in registerGroups:
      for attrib in registerGroup.attrib:
        if attrib == "name":
          name = registerGroup.attrib["name"]
        elif attrib == "name-in-module":
          nameInModule = registerGroup.attrib["name-in-module"]
        elif attrib == "offset":
          offset = registerGroup.attrib["offset"]
          if offset.startswith("0x"):
            offset = int(offset,base=16)
          else:
            offset=int(offset)
        elif attrib == "address-space":
          addressSpace = registerGroup.attrib["address-space"]
        elif attrib == "caption":
          caption = registerGroup.attrib["caption"]
        else:
          print('Unknown Instance Attribute: ' + attrib)
          sys.exit(1)
      results.update({name:{"name-in-module":nameInModule,"offset":offset,"address-space":addressSpace}})

  results = dict(sorted(results.items()))
  results.pop('NVIC')
  results.pop('SysTick')
  results.pop('ITM')
  results.pop('DWT')
  if 'TPI' in results:
    results.pop('TPI')
  results.pop('FPU')
  results.pop('CoreDebug')
  return(results)

def main(argv):
  mplabXDir = "/Applications/Microchip"
  mplabXDir="atdf/"
  chip=""
  try:
    opts, args = getopt.getopt(argv,"hc:",["chip="])
  except getopt.GetoptError:
    print('atdfPeripherals.py -c <Chip>')
    sys.exit(2)
  for opt, arg in opts:
    if opt == '-h':
      print('atdfPeripherals.py -c <Chip>')
      sys.exit()
    elif opt in ("-c", "--chip"):
      chip = arg
  if chip == "":
    print('atdfPeripherals.py -c <Chip>')
    sys.exit()

  peripherals=extractPeripherals(mplabXDir,chip)
  for peripheral in peripherals:
    print(f"  {peripheral:14} : T{peripherals[peripheral]['name-in-module']+'_Registers':24} absolute {peripherals[peripheral]['offset']}")

if __name__ == "__main__":
  main(sys.argv[1:])