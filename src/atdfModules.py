#!/usr/bin/env python3.8
import sys,os,getopt
from lxml import etree

def extractRegisters(registerGroup,registerMode:str):
  result={}
  regSize=4
  regOffset=0
  for register in registerGroup:
    if register.tag == "register":
      regName=""
      regOffset=-1
      regCount=1
      regSize=0
      regCaption=""
      for attrib in register.attrib:
        if attrib == "name":
          regName = register.attrib["name"]
        elif attrib == "offset":
          regOffset = int(register.attrib["offset"],base=16)
        elif attrib == "rw":
          regRW = register.attrib["rw"]
        elif attrib == "access":
          regAccess = register.attrib["access"]
        elif attrib == "count":
          regCount= int(register.attrib["count"])
        elif attrib == "size":
          regSize = int(register.attrib["size"])
        elif attrib == "caption":
          regCaption = register.attrib["caption"]
        else:
          if (attrib != "initval") and (attrib != "atomic-op") and (attrib != "access-size") and (attrib != "modes") and (attrib != "mask"  and (attrib != "ocd-rw")):
            print("Unknown Attribute for Register found: "+attrib)
            sys.exit(1)
      if (registerMode != "Default") and ('modes' in register.attrib.keys()):
        if register.attrib["modes"] != registerMode:
          continue
      if regOffset == -1:
        # PIC32 atdf files do not have proper Offset and Size Attributes
        regOffset=len(result)*4
        regSize=4
      if regCount > 1:
        print()
      result[regOffset] = {"name": regName, "size": regSize,"caption": regCaption,"count": regCount}
    elif register.tag == "register-group":
      regGroupUnionTagValue=""
      regGroupSize=0
      regGroupCount=0
      regGroupOffset=0
      regGroupCaption=""
      for attrib in register.attrib:
        if attrib == "name":
          regGroupName = register.attrib["name"]
          if attrib == "caption":
            regGroupName = register.attrib["caption"]
        elif attrib == "name-in-module":
          regGroupNameInModule = register.attrib["name-in-module"]
        elif attrib == "offset":
          regGroupOffset = int(register.attrib["offset"],base=16)
        elif attrib == "size":
          regGroupSize = int(register.attrib["size"],base=16)
        elif attrib == "count":
          regGroupCount = int(register.attrib["count"])
        elif attrib == "union-tag-value":
          regGroupUnionTagValue = int(register.attrib["union-tag-value"])
        else:
          if (attrib != "modes"):
            print("Unknown Attribute for Register-Group found: "+attrib)
            sys.exit(1)
      result[regOffset] = {"name": regGroupName, "size": regGroupSize, "caption": regGroupCaption, "count": regGroupCount, "offset": regGroupOffset, "groupname": regGroupNameInModule,"uniontag": regGroupUnionTagValue}
    elif register.tag == "mode":
      for attrib in register.attrib:
        if attrib == "name":
          regGroupModeName = register.attrib["name"]
        elif attrib == "qualifier":
          regGroupModeQualifier = register.attrib["qualifier"]
        elif attrib == "value":
          regGroupModeOffset = int(register.attrib["value"])
        elif attrib == "mask":
          regGroupModeOffset = int(register.attrib["mask"])
        elif attrib == "caption":
          regGroupModeCaption = register.attrib["caption"]
        else:
          print("Unknown Attribute for Register-Group mode found: " + attrib)
          sys.exit(1)
    else:
      print("Unknown Tag found: " + register.tag)
      sys.exit(1)
    result=dict(sorted(result.items()))
  return(result)

def extractModules(mplabXDir:str,chipName:str):
  root:lxml.etree._ElementTree=etree.parse(os.path.join(mplabXDir, chipName + ".atdf"))
  family=str(root.xpath("devices/device/@family")[0])
  modules = root.xpath("modules/module")
  results={}
  for module in modules:
    caption=module.attrib["caption"]
    name=module.attrib["name"]
    registerGroups=module.xpath("register-group")
    for registerGroup in registerGroups:
      rgName=registerGroup.attrib["name"]
      modes=registerGroup.xpath("mode")
      if modes==[]:
        results[rgName] = {"Default":extractRegisters(registerGroup,"Default")}
      else:
        results[rgName]={}
        for mode in modes:
          results[rgName].update({mode.attrib["name"]: extractRegisters(registerGroup,mode.attrib["name"])})
  results = dict(sorted(results.items()))
  return(results)

def main(argv):
  mplabXDir = "/Applications/Microchip"
  mplabXDir="atdf/"
  chip=""
  try:
    opts, args = getopt.getopt(argv,"hc:",["chip="])
  except getopt.GetoptError:
    print('atdfToPas.py -c <Chip>')
    sys.exit(2)
  for opt, arg in opts:
    if opt == '-h':
      print('atdfToPas.py -c <Chip>')
      sys.exit()
    elif opt in ("-c", "--chip"):
      chip = arg
  if chip == "":
    print('atdfToPas.py -c <Chip>')
    sys.exit()

  modules=extractModules(mplabXDir,chip)
  for moduleKey in sorted(modules.keys()):
    module=modules[moduleKey]
    for subModule in module:
      print(f"{moduleKey:12} {subModule}")
      try:
        lastOffset=sorted(module[subModule].keys())[0]
      except:
        lastOffset=0
      lastReserved=0
      for registerKey in sorted(module[subModule].keys()):
        if lastOffset != registerKey:
          if registerKey-lastOffset == 1:
            print(f"    RESERVED{lastReserved:<4} : byte;                 //{lastOffset:04X}")
          if registerKey-lastOffset == 2:
            print(f"    RESERVED{lastReserved:<4} : word;                 //{lastOffset:04X}")
          if registerKey-lastOffset == 3:
            print(f"    RESERVED{lastReserved:<4} : array[1..3] of byte;  //{lastOffset:04X}")
          if registerKey-lastOffset == 4:
            print(f"    RESERVED{lastReserved:<4} : longWord;             //{lastOffset:04X}")
          if registerKey-lastOffset > 4:
            print(f"    RESERVED{lastReserved:<4} : array[1..{registerKey-lastOffset}] of byte; //{lastOffset:04X}")
          lastReserved+=1
        register=module[subModule][registerKey]
        if register["size"] == 1:
          print(f"    {register['name']:12} : byte;                 //{registerKey:04X}")
        if register["size"] == 2:
          print(f"    {register['name']:12} : word;                 //{registerKey:04X}")
        if register["size"] == 4:
          print(f"    {register['name']:12} : longWord;             //{registerKey:04X}")
        if register["size"] > 4:
          print(f"    {register['name']:12} : {register['size']:04X};     //{registerKey:04X}")
        lastOffset = registerKey+register["size"]

if __name__ == "__main__":
  main(sys.argv[1:])