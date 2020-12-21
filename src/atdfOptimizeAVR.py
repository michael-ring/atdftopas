#!/usr/bin/env python3.8
import sys,os,getopt
from atdfPeripherals import extractPeripherals
from atdfModules import extractModules
from atdfInterrupts import extractInterrupts

def normalizeOffsets(peripherals,modules):
  #Normalize Peripheral and Module offsets for attiny and atmega. Newer Chips like ATMega4808 & friends are already properly configured
  for peripheral in peripherals:
    if peripherals[peripheral]['offset'] == 0:
      moduleName = peripherals[peripheral]['name-in-module']
      if "Default" in modules[moduleName].keys():
        baseAddress=list(modules[moduleName]['Default'].keys())[0]
        peripherals[peripheral]['offset'] = baseAddress
        if baseAddress > 0:
          tmpDict={}
          for offset in modules[moduleName]['Default'].keys():
            tmpDict[offset-baseAddress]=modules[moduleName]['Default'][offset]
          modules[moduleName]['Default']=tmpDict

def fixupPeripheral(peripherals,modules,peripheral):
  if peripheral in peripherals.keys():
    moduleName=peripherals[peripheral]["name-in-module"]
    if moduleName==peripheral:
      cleanModuleName=moduleName[:-1]
      moduleIndex=moduleName[-1]
      peripherals[peripheral]["name-in-module"]=cleanModuleName
      if moduleIndex == "0":
        modules.update({cleanModuleName: modules[moduleName]})
        for offset in modules[cleanModuleName]["Default"]:
          modules[cleanModuleName]["Default"][offset]["name"] = modules[cleanModuleName]["Default"][offset]["name"].replace(moduleIndex,"")
      modules.pop(moduleName)

def unifyModules(peripherals,modules):
  firstPortFound=False
  for peripheral in peripherals:
    if peripheral.startswith("PORT") and (len(peripheral) == 5):
      moduleName=peripherals[peripheral]["name-in-module"]
      if (len(modules[moduleName]["Default"]) == 3) and (firstPortFound == False):
        peripherals[peripheral]["name-in-module"] = "PORT"
        modules.update({"PORT":modules[moduleName]})
        modules["PORT"]["Default"][0]["name"]    = modules["PORT"]["Default"][0]["name"][:-1]
        modules["PORT"]["Default"][0]["caption"] = modules["PORT"]["Default"][0]["caption"].replace(" "+moduleName[-1]+" "," ")
        modules["PORT"]["Default"][1]["name"]    = modules["PORT"]["Default"][1]["name"][:-1]
        modules["PORT"]["Default"][1]["caption"] = modules["PORT"]["Default"][1]["caption"].replace(" "+moduleName[-1]+" "," ")
        modules["PORT"]["Default"][2]["name"]    = modules["PORT"]["Default"][2]["name"][:-1]
        modules["PORT"]["Default"][2]["caption"] = modules["PORT"]["Default"][2]["caption"].replace(" "+moduleName[-1]+" "," ")
        del modules[moduleName]
        firstPortFound=True
      elif (len(modules[moduleName]["Default"]) == 3) and (firstPortFound==True):
        peripherals[peripheral]["name-in-module"] = "PORT"
        del modules[moduleName]

  fixupPeripheral(peripherals,modules,"ADC0")
  fixupPeripheral(peripherals,modules,"ADC1")
  if "ADC" in peripherals.keys():
    peripherals.update({"ADC0":peripherals["ADC"]})
    peripherals.pop("ADC")

  fixupPeripheral(peripherals,modules,"SPI0")
  fixupPeripheral(peripherals,modules,"SPI1")
  if "SPI" in peripherals.keys():
    peripherals.update({"SPI0":peripherals["SPI"]})
    peripherals.pop("SPI")

  fixupPeripheral(peripherals,modules,"TWI0")
  fixupPeripheral(peripherals,modules,"TWI1")
  if "TWI" in peripherals.keys():
    peripherals.update({"TWI0": peripherals["TWI"]})
    peripherals.pop("TWI")

  fixupPeripheral(peripherals,modules,"USART0")
  fixupPeripheral(peripherals,modules,"USART1")
  fixupPeripheral(peripherals,modules,"USART2")
  if "USART" in peripherals.keys():
    peripherals.update({"USART0": peripherals["USART"]})
    peripherals.pop("USART")

def unifyInterrupts(interrupts):
  if 0 in interrupts:
    interrupts.pop(0)
  for interrupt in interrupts:
    if interrupts[interrupt][interrupt]["name"] == "ADC":
      interrupts[interrupt][interrupt]["name"] = "ADC0"
    if interrupts[interrupt][interrupt]["name"] == "SPI":
      interrupts[interrupt][interrupt]["name"] = "SPI0"
    if interrupts[interrupt][interrupt]["name"].startswith("SPI_"):
      interrupts[interrupt][interrupt]["name"] = interrupts[interrupt][interrupt]["name"].replace("SPI_","SPI0_")
    if interrupts[interrupt][interrupt]["name"] == "TWI":
      interrupts[interrupt][interrupt]["name"] = "TWI0"
    if interrupts[interrupt][interrupt]["name"].startswith("TWI_"):
      interrupts[interrupt][interrupt]["name"] = interrupts[interrupt][interrupt]["name"].replace("TWI_","TWI0_")
    if interrupts[interrupt][interrupt]["name"] == "USART":
      interrupts[interrupt][interrupt]["name"] = "USART0"
    if interrupts[interrupt][interrupt]["name"].startswith("USART_"):
      interrupts[interrupt][interrupt]["name"] = interrupts[interrupt][interrupt]["name"].replace("USART_","USART0_")


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
  peripherals=extractPeripherals(mplabXDir,chip)
  modules=extractModules(mplabXDir,chip)
  interrupts=extractInterrupts(mplabXDir,chip)
  normalizeOffsets(peripherals,modules)
  unifyModules(peripherals,modules)
  unifyInterrupts(interrupts)
  print("")

if __name__ == "__main__":
   main(sys.argv[1:])