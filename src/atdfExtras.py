#!/usr/bin/env python3.8
import sys,os,getopt
from lxml import etree

def extractExtras(mplabXDir:str,chipName:str):
  root:lxml.etree._ElementTree=etree.parse(os.path.join(mplabXDir, chipName + ".atdf"))
  family=str(root.xpath("devices/device/@family")[0])
  architecture=str(root.xpath("devices/device/@architecture")[0])
  addressSpaces = root.xpath("devices/device/address-spaces/address-space")
  results={}
  results.update({"family":family})
  results.update({"architecture":architecture})
  for addressSpace in addressSpaces:
    name=addressSpace.attrib["name"]
    results[name]={}
    start=addressSpace.attrib["start"]
    if start.startswith("0x"):
      start=int(start,base=16)
    else:
      start=int(start)
    memorySegments=addressSpace.xpath("memory-segment")
    for memorySegment in memorySegments:
      segmentName=memorySegment.attrib["name"]
      segmentStart=memorySegment.attrib["start"]
      if segmentStart.startswith("0x"):
          segmentStart = int(segmentStart, base=16)
      else:
          segmentStart = int(segmentStart)
      segmentSize=memorySegment.attrib["size"]
      if segmentSize.startswith("0x"):
          segmentSize = int(segmentSize, base=16)
      else:
          segmentSize = int(segmentSize)
      segmentType=memorySegment.attrib["type"]
      results[name].update({name:{"start":segmentStart,"size":segmentSize,"type":segmentType}})
      if family == "PIC32MX":
        if segmentName.lower() == "kseg1_data_mem":
          results.update({"ramStart": segmentStart})
          results.update({"ramSize": segmentSize})
        if segmentName.lower() == "code":
          results.update({"flashStart": segmentStart})
          results.update({"flashSize": segmentSize})
        if segmentName.lower() == "bootconfig":
          results.update({"bootFlashStart": segmentStart})
          results.update({"bootFlashSize": segmentSize})
      else:
        if segmentType.lower()=="ram":
          results.update({"ramStart":segmentStart})
          results.update({"ramSize":segmentSize})
        if (chipName == "ATtiny11") or (chipName == "ATtiny12") or (chipName == "ATtiny15"):
          results.update({"ramStart": 0})
          results.update({"ramSize": 0})

        if (segmentType.lower()=="flash") and ((segmentName.lower()=="flash") or (segmentName.lower()=="progmem")):
          results.update({"flashStart":segmentStart})
          results.update({"flashSize":segmentSize})

  results = dict(sorted(results.items()))
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

  extras=extractExtras(mplabXDir,chip)
  print(f"{chip:15} ",end="")
  print(f"{extras['architecture']:15} {extras['family']:10} 0x{extras['flashStart']:08x}  0x{extras['flashSize']:06x} 0x{extras['ramStart']:08x} 0x{extras['ramSize']:05x}")

if __name__ == "__main__":
  main(sys.argv[1:])