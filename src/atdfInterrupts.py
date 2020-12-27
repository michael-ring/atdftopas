#!/usr/bin/env python3.8
import sys,os,getopt
from lxml import etree

def extractInterrupts(mplabXDir:str,chipName:str):
  root:lxml.etree._ElementTree=etree.parse(os.path.join(mplabXDir, chipName + ".atdf"))
  family=str(root.xpath("devices/device/@family")[0])
  interrupts = root.xpath("devices/device/interrupts/interrupt")
  results={}
  for interrupt in interrupts:
    irqIndex=None
    caption=""
    irqCaption=""
    irqName=""
    moduleInstance=""
    for attrib in interrupt.attrib:
      if attrib == "name":
        name=interrupt.attrib["name"]
      elif attrib == "irq-name":
        irqName = interrupt.attrib["irq-name"]
      elif attrib == "index":
        index=int(interrupt.attrib["index"])
      elif attrib == "irq-index":
        irqIndex = int(interrupt.attrib["irq-index"])
      elif attrib == "caption":
        caption=interrupt.attrib["caption"]
      elif attrib == "irq-caption":
        irqCaption=interrupt.attrib["irq-caption"]
      elif attrib.find('alternate-caption') >= 0:
        unknown = attrib
      elif attrib == "module-instance":
        moduleInstance=interrupt.attrib["module-instance"]
      else:
        print('Unknown Interupt Attribute: '+attrib)
        sys.exit(1)
    if irqIndex == None:
      irqIndex=index
    if not index in results.keys():
      results[index]={irqIndex:{"name": name, "caption": caption, "moduleInstance": moduleInstance,"irq-caption":irqCaption,"irq-name":irqName}}
    else:
      results[index].update({irqIndex:{"name": name, "caption": caption, "moduleInstance": moduleInstance,"irq-caption":irqCaption,"irq-name":irqName}})
  results = dict(sorted(results.items()))
  if chipName.startswith('ATSAMD51'):
    results.pop(-15)
  if chipName.startswith('ATSAMD51'):
      for key,interrupt in results.items():
        if "moduleInstance" in interrupt[key] and interrupt[key]["moduleInstance"] != "":
          if interrupt[key]["moduleInstance"] != interrupt[key]["name"]:
            interrupt[key]["name"] = interrupt[key]["moduleInstance"]
            if not (key-1 in results) or (not results[key-1][key-1]["name"].startswith(interrupt[key]["moduleInstance"])):
              interrupt[key]["name"]=interrupt[key]["name"]+"_0"
            else:
              interrupt[key]["name"]=interrupt[key]["name"]+"_"+str(int(results[key-1][key-1]["name"].replace(interrupt[key]["name"]+"_",""))+1)
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

  interrupts=extractInterrupts(mplabXDir,chip)
  minInterrupt=list(interrupts.keys())[0]
  maxInterrupt=list(interrupts.keys())[-1]
  for interrupt in range(minInterrupt,maxInterrupt):
    if interrupt in interrupts.keys():
      values=interrupts[interrupt][list(interrupts[interrupt].keys())[0]]
      if (values["moduleInstance"] != "") and (values["moduleInstance"] != values['name']):
        name=values['moduleInstance']+"_"+values['name']+"_interrupt"
      else:
        name=values['name']+"_interrupt"
      print(f"{name:30} //IRQ:{interrupt:03} {values['caption']}")
    else:
      print(f"{'':30} //IRQ:{interrupt:03}")

if __name__ == "__main__":
  main(sys.argv[1:])