unit samd51p19a;

interface

{$PACKRECORDS C}
//{$PACKRECORDS 2}
{$GOTO ON}
{$SCOPEDENUMS ON}

type
  TIRQn_Enum = (
    NonMaskableInt_IRQn = -14,         //  Cortex-M4 Non Maskable Interrupt
    HardFault_IRQn = -13,              //  Cortex-M4 Hard Fault Interrupt
    MemoryManagement_IRQn = -12,
    BusFault_IRQn = -11,
    UsageFault_IRQn = -10,
    SVC_IRQn = -5,                  //  Cortex-M4 SV Call Interrupt
    DebugMonitor_IRQn = -4,
    PendSV_IRQn = -2,                  //  Cortex-M4 Pend SV Interrupt
    SysTick_IRQn = -1,                 //  Cortex-M4 System Tick Interrupt
    PM_IRQn = 0,                       //  0 Power Manager */
    MCLK_IRQn,                         //  1 Main Clock */
    OSCCTRL_0_IRQn,                    //  2 OSCCTRL_XOSCFAIL_0, OSCCTRL_XOSCRDY_0 */
    OSCCTRL_1_IRQn,                    //  3 OSCCTRL_XOSCFAIL_1, OSCCTRL_XOSCRDY_1 */
    OSCCTRL_2_IRQn,                    //  4 OSCCTRL_DFLLLOCKC, OSCCTRL_DFLLLOCKF, OSCCTRL_DFLLOOB, OSCCTRL_DFLLRCS, OSCCTRL_DFLLRDY */
    OSCCTRL_3_IRQn,                    //  5 OSCCTRL_DPLLLCKF_0, OSCCTRL_DPLLLCKR_0, OSCCTRL_DPLLLDRTO_0, OSCCTRL_DPLLLTO_0 */
    OSCCTRL_4_IRQn,                    //  6 OSCCTRL_DPLLLCKF_1, OSCCTRL_DPLLLCKR_1, OSCCTRL_DPLLLDRTO_1, OSCCTRL_DPLLLTO_1 */
    OSC32KCTRL_IRQn,                   //  7 32kHz Oscillators Control */
    SUPC_0_IRQn,         //  8 SUPC_B12SRDY, SUPC_B33SRDY, SUPC_BOD12RDY, SUPC_BOD33RDY, SUPC_VCORERDY, SUPC_VREGRDY */
    SUPC_1_IRQn,         //  9 SUPC_BOD12DET, SUPC_BOD33DET */
    WDT_IRQn,            // 10 Watchdog Timer */
    RTC_IRQn,            // 11 Real-Time Counter */
    EIC_0_IRQn,          // 12 EIC_EXTINT_0 */
    EIC_1_IRQn,          // 13 EIC_EXTINT_1 */
    EIC_2_IRQn,          // 14 EIC_EXTINT_2 */
    EIC_3_IRQn,          // 15 EIC_EXTINT_3 */
    EIC_4_IRQn,          // 16 EIC_EXTINT_4 */
    EIC_5_IRQn,          // 17 EIC_EXTINT_5 */
    EIC_6_IRQn,          // 18 EIC_EXTINT_6 */
    EIC_7_IRQn,          // 19 EIC_EXTINT_7 */
    EIC_8_IRQn,          // 20 EIC_EXTINT_8 */
    EIC_9_IRQn,          // 21 EIC_EXTINT_9 */
    EIC_10_IRQn,         // 22 EIC_EXTINT_10 */
    EIC_11_IRQn,         // 23 EIC_EXTINT_11 */
    EIC_12_IRQn,         // 24 EIC_EXTINT_12 */
    EIC_13_IRQn,         // 25 EIC_EXTINT_13 */
    EIC_14_IRQn,         // 26 EIC_EXTINT_14 */
    EIC_15_IRQn,         // 27 EIC_EXTINT_15 */
    FREQM_IRQn,          // 28 Frequency Meter */
    NVMCTRL_0_IRQn,      // 29 NVMCTRL_0, NVMCTRL_1, NVMCTRL_2, NVMCTRL_3, NVMCTRL_4, NVMCTRL_5, NVMCTRL_6, NVMCTRL_7 */
    NVMCTRL_1_IRQn,      // 30 NVMCTRL_10, NVMCTRL_8, NVMCTRL_9 */
    DMAC_0_IRQn,         // 31 DMAC_SUSP_0, DMAC_TCMPL_0, DMAC_TERR_0 */
    DMAC_1_IRQn,         // 32 DMAC_SUSP_1, DMAC_TCMPL_1, DMAC_TERR_1 */
    DMAC_2_IRQn,         // 33 DMAC_SUSP_2, DMAC_TCMPL_2, DMAC_TERR_2 */
    DMAC_3_IRQn,         // 34 DMAC_SUSP_3, DMAC_TCMPL_3, DMAC_TERR_3 */
    DMAC_4_IRQn,         // 35 DMAC_SUSP_10, DMAC_SUSP_11, DMAC_SUSP_12, DMAC_SUSP_13, DMAC_SUSP_14, DMAC_SUSP_15, DMAC_SUSP_16, DMAC_SUSP_17, DMAC_SUSP_18, DMAC_SUSP_19, DMAC_SUSP_20, DMAC_SUSP_21, DMAC_SUSP_22, DMAC_SUSP_23, DMAC_SUSP_24, DMAC_SUSP_25, DMAC_SUSP_26, DMAC_SUSP_27, DMAC_SUSP_28, DMAC_SUSP_29, DMAC_SUSP_30, DMAC_SUSP_31, DMAC_SUSP_4, DMAC_SUSP_5, DMAC_SUSP_6, DMAC_SUSP_7, DMAC_SUSP_8, DMAC_SUSP_9, DMAC_TCMPL_10, DMAC_TCMPL_11, DMAC_TCMPL_12, DMAC_TCMPL_13, DMAC_TCMPL_14, DMAC_TCMPL_15, DMAC_TCMPL_16, DMAC_TCMPL_17, DMAC_TCMPL_18, DMAC_TCMPL_19, DMAC_TCMPL_20, DMAC_TCMPL_21, DMAC_TCMPL_22, DMAC_TCMPL_23, DMAC_TCMPL_24, DMAC_TCMPL_25, DMAC_TCMPL_26, DMAC_TCMPL_27, DMAC_TCMPL_28, DMAC_TCMPL_29, DMAC_TCMPL_30, DMAC_TCMPL_31, DMAC_TCMPL_4, DMAC_TCMPL_5, DMAC_TCMPL_6, DMAC_TCMPL_7, DMAC_TCMPL_8, DMAC_TCMPL_9, DMAC_TERR_10, DMAC_TERR_11, DMAC_TERR_12, DMAC_TERR_13, DMAC_TERR_14, DMAC_TERR_15, DMAC_TERR_16, DMAC_TERR_17, DMAC_TERR_18, DMAC_TERR_19, DMAC_TERR_20, DMAC_TERR_21, DMAC_TERR_22, DMAC_TERR_23, DMAC_TERR_24, DMAC_TERR_25, DMAC_TERR_26, DMAC_TERR_27, DMAC_TERR_28, DMAC_TERR_29, DMAC_TERR_30, DMAC_TERR_31, DMAC_TERR_4, DMAC_TERR_5, DMAC_TERR_6, DMAC_TERR_7, DMAC_TERR_8, DMAC_TERR_9 */
    EVSYS_0_IRQn,        // 36 EVSYS_EVD_0, EVSYS_OVR_0 */
    EVSYS_1_IRQn,        // 37 EVSYS_EVD_1, EVSYS_OVR_1 */
    EVSYS_2_IRQn,        // 38 EVSYS_EVD_2, EVSYS_OVR_2 */
    EVSYS_3_IRQn,        // 39 EVSYS_EVD_3, EVSYS_OVR_3 */
    EVSYS_4_IRQn,        // 40 EVSYS_EVD_10, EVSYS_EVD_11, EVSYS_EVD_4, EVSYS_EVD_5, EVSYS_EVD_6, EVSYS_EVD_7, EVSYS_EVD_8, EVSYS_EVD_9, EVSYS_OVR_10, EVSYS_OVR_11, EVSYS_OVR_4, EVSYS_OVR_5, EVSYS_OVR_6, EVSYS_OVR_7, EVSYS_OVR_8, EVSYS_OVR_9 */
    PAC_IRQn,            // 41 Peripheral Access Controller */
    TAL_0_IRQn,          // 42 TAL_BRK */
    TAL_1_IRQn,          // 43 TAL_IPS_0, TAL_IPS_1 */
    Reserved44,          // 44 Reserved */
    RAMECC_IRQn,         // 45 RAM ECC */
    SERCOM0_0_IRQn,      // 46 SERCOM0_0 */
    SERCOM0_1_IRQn,      // 47 SERCOM0_1 */
    SERCOM0_2_IRQn,      // 48 SERCOM0_2 */
    SERCOM0_3_IRQn,      // 49 SERCOM0_3, SERCOM0_4, SERCOM0_5, SERCOM0_6 */
    SERCOM1_0_IRQn,      // 50 SERCOM1_0 */
    SERCOM1_1_IRQn,      // 51 SERCOM1_1 */
    SERCOM1_2_IRQn,      // 52 SERCOM1_2 */
    SERCOM1_3_IRQn,      // 53 SERCOM1_3, SERCOM1_4, SERCOM1_5, SERCOM1_6 */
    SERCOM2_0_IRQn,      // 54 SERCOM2_0 */
    SERCOM2_1_IRQn,      // 55 SERCOM2_1 */
    SERCOM2_2_IRQn,      // 56 SERCOM2_2 */
    SERCOM2_3_IRQn,      // 57 SERCOM2_3, SERCOM2_4, SERCOM2_5, SERCOM2_6 */
    SERCOM3_0_IRQn,      // 58 SERCOM3_0 */
    SERCOM3_1_IRQn,      // 59 SERCOM3_1 */
    SERCOM3_2_IRQn,      // 60 SERCOM3_2 */
    SERCOM3_3_IRQn,      // 61 SERCOM3_3, SERCOM3_4, SERCOM3_5, SERCOM3_6 */
    SERCOM4_0_IRQn,      // 62 SERCOM4_0 */
    SERCOM4_1_IRQn,      // 63 SERCOM4_1 */
    SERCOM4_2_IRQn,      // 64 SERCOM4_2 */
    SERCOM4_3_IRQn,      // 65 SERCOM4_3, SERCOM4_4, SERCOM4_5, SERCOM4_6 */
    SERCOM5_0_IRQn,      // 66 SERCOM5_0 */
    SERCOM5_1_IRQn,      // 67 SERCOM5_1 */
    SERCOM5_2_IRQn,      // 68 SERCOM5_2 */
    SERCOM5_3_IRQn,      // 69 SERCOM5_3, SERCOM5_4, SERCOM5_5, SERCOM5_6 */
    SERCOM6_0_IRQn,      // 70 SERCOM6_0 */
    SERCOM6_1_IRQn,      // 71 SERCOM6_1 */
    SERCOM6_2_IRQn,      // 72 SERCOM6_2 */
    SERCOM6_3_IRQn,      // 73 SERCOM6_3, SERCOM6_4, SERCOM6_5, SERCOM6_6 */
    SERCOM7_0_IRQn,      // 74 SERCOM7_0 */
    SERCOM7_1_IRQn,      // 75 SERCOM7_1 */
    SERCOM7_2_IRQn,      // 76 SERCOM7_2 */
    SERCOM7_3_IRQn,      // 77 SERCOM7_3, SERCOM7_4, SERCOM7_5, SERCOM7_6 */
    CAN0_IRQn,           // 78 Control Area Network 0 */
    CAN1_IRQn,           // 79 Control Area Network 1 */
    USB_0_IRQn,          // 80 USB_EORSM_DNRSM, USB_EORST_RST, USB_LPMSUSP_DDISC, USB_LPM_DCONN, USB_MSOF, USB_RAMACER, USB_RXSTP_TXSTP_0, USB_RXSTP_TXSTP_1, USB_RXSTP_TXSTP_2, USB_RXSTP_TXSTP_3, USB_RXSTP_TXSTP_4, USB_RXSTP_TXSTP_5, USB_RXSTP_TXSTP_6, USB_RXSTP_TXSTP_7, USB_STALL0_STALL_0, USB_STALL0_STALL_1, USB_STALL0_STALL_2, USB_STALL0_STALL_3, USB_STALL0_STALL_4, USB_STALL0_STALL_5, USB_STALL0_STALL_6, USB_STALL0_STALL_7, USB_STALL1_0, USB_STALL1_1, USB_STALL1_2, USB_STALL1_3, USB_STALL1_4, USB_STALL1_5, USB_STALL1_6, USB_STALL1_7, USB_SUSPEND, USB_TRFAIL0_TRFAIL_0, USB_TRFAIL0_TRFAIL_1, USB_TRFAIL0_TRFAIL_2, USB_TRFAIL0_TRFAIL_3, USB_TRFAIL0_TRFAIL_4, USB_TRFAIL0_TRFAIL_5, USB_TRFAIL0_TRFAIL_6, USB_TRFAIL0_TRFAIL_7, USB_TRFAIL1_PERR_0, USB_TRFAIL1_PERR_1, USB_TRFAIL1_PERR_2, USB_TRFAIL1_PERR_3, USB_TRFAIL1_PERR_4, USB_TRFAIL1_PERR_5, USB_TRFAIL1_PERR_6, USB_TRFAIL1_PERR_7, USB_UPRSM, USB_WAKEUP */
    USB_1_IRQn,          // 81 USB_SOF_HSOF */
    USB_2_IRQn,          // 82 USB_TRCPT0_0, USB_TRCPT0_1, USB_TRCPT0_2, USB_TRCPT0_3, USB_TRCPT0_4, USB_TRCPT0_5, USB_TRCPT0_6, USB_TRCPT0_7 */
    USB_3_IRQn,          // 83 USB_TRCPT1_0, USB_TRCPT1_1, USB_TRCPT1_2, USB_TRCPT1_3, USB_TRCPT1_4, USB_TRCPT1_5, USB_TRCPT1_6, USB_TRCPT1_7 */
    GMAC_IRQn,           // 84 Ethernet MAC */
    TCC0_0_IRQn,         // 85 TCC0_CNT_A, TCC0_DFS_A, TCC0_ERR_A, TCC0_FAULT0_A, TCC0_FAULT1_A, TCC0_FAULTA_A, TCC0_FAULTB_A, TCC0_OVF, TCC0_TRG, TCC0_UFS_A */
    TCC0_1_IRQn,         // 86 TCC0_MC_0 */
    TCC0_2_IRQn,         // 87 TCC0_MC_1 */
    TCC0_3_IRQn,         // 88 TCC0_MC_2 */
    TCC0_4_IRQn,         // 89 TCC0_MC_3 */
    TCC0_5_IRQn,         // 90 TCC0_MC_4 */
    TCC0_6_IRQn,         // 91 TCC0_MC_5 */
    TCC1_0_IRQn,         // 92 TCC1_CNT_A, TCC1_DFS_A, TCC1_ERR_A, TCC1_FAULT0_A, TCC1_FAULT1_A, TCC1_FAULTA_A, TCC1_FAULTB_A, TCC1_OVF, TCC1_TRG, TCC1_UFS_A */
    TCC1_1_IRQn,         // 93 TCC1_MC_0 */
    TCC1_2_IRQn,         // 94 TCC1_MC_1 */
    TCC1_3_IRQn,         // 95 TCC1_MC_2 */
    TCC1_4_IRQn,         // 96 TCC1_MC_3 */
    TCC2_0_IRQn,         // 97 TCC2_CNT_A, TCC2_DFS_A, TCC2_ERR_A, TCC2_FAULT0_A, TCC2_FAULT1_A, TCC2_FAULTA_A, TCC2_FAULTB_A, TCC2_OVF, TCC2_TRG, TCC2_UFS_A */
    TCC2_1_IRQn,         // 98 TCC2_MC_0 */
    TCC2_2_IRQn,         // 99 TCC2_MC_1 */
    TCC2_3_IRQn,         // 100 TCC2_MC_2 */
    TCC3_0_IRQn,         // 101 TCC3_CNT_A, TCC3_DFS_A, TCC3_ERR_A, TCC3_FAULT0_A, TCC3_FAULT1_A, TCC3_FAULTA_A, TCC3_FAULTB_A, TCC3_OVF, TCC3_TRG, TCC3_UFS_A */
    TCC3_1_IRQn,         // 102 TCC3_MC_0 */
    TCC3_2_IRQn,         // 103 TCC3_MC_1 */
    TCC4_0_IRQn,         // 104 TCC4_CNT_A, TCC4_DFS_A, TCC4_ERR_A, TCC4_FAULT0_A, TCC4_FAULT1_A, TCC4_FAULTA_A, TCC4_FAULTB_A, TCC4_OVF, TCC4_TRG, TCC4_UFS_A */
    TCC4_1_IRQn,         // 105 TCC4_MC_0 */
    TCC4_2_IRQn,         // 106 TCC4_MC_1 */
    TC0_IRQn,            // 107 Basic Timer Counter 0 */
    TC1_IRQn,            // 108 Basic Timer Counter 1 */
    TC2_IRQn,            // 109 Basic Timer Counter 2 */
    TC3_IRQn,            // 110 Basic Timer Counter 3 */
    TC4_IRQn,            // 111 Basic Timer Counter 4 */
    TC5_IRQn,            // 112 Basic Timer Counter 5 */
    TC6_IRQn,            // 113 Basic Timer Counter 6 */
    TC7_IRQn,            // 114 Basic Timer Counter 7 */
    PDEC_0_IRQn,         // 115 PDEC_DIR_A, PDEC_ERR_A, PDEC_OVF, PDEC_VLC_A */
    PDEC_1_IRQn,         // 116 PDEC_MC_0 */
    PDEC_2_IRQn,         // 117 PDEC_MC_1 */
    ADC0_0_IRQn,         // 118 ADC0_OVERRUN, ADC0_WINMON */
    ADC0_1_IRQn,         // 119 ADC0_RESRDY */
    ADC1_0_IRQn,         // 120 ADC1_OVERRUN, ADC1_WINMON */
    ADC1_1_IRQn,         // 121 ADC1_RESRDY */
    AC_IRQn,             // 122 Analog Comparators */
    DAC_0_IRQn,          // 123 DAC_OVERRUN_A_0, DAC_OVERRUN_A_1, DAC_UNDERRUN_A_0, DAC_UNDERRUN_A_1 */
    DAC_1_IRQn,          // 124 DAC_EMPTY_0 */
    DAC_2_IRQn,          // 125 DAC_EMPTY_1 */
    DAC_3_IRQn,          // 126 DAC_RESRDY_0 */
    DAC_4_IRQn,          // 127 DAC_RESRDY_1 */
    I2S_IRQn,            // 128 Inter-IC Sound Interface */
    PCC_IRQn,            // 129 Parallel Capture Controller */
    AES_IRQn,            // 130 Advanced Encryption Standard */
    TRNG_IRQn,           // 131 True Random Generator */
    ICM_IRQn,            // 132 Integrity Check Monitor */
    PUKCC_IRQn,          // 133 PUblic-Key Cryptography Controller */
    QSPI_IRQn,           // 134 Quad SPI interface */
    SDHC0_IRQn,          // 135 SD/MMC Host Controller 0 */
    SDHC1_IRQn,          // 136 SD/MMC Host Controller 1 */
    PERIPH_COUNT_IRQn
);

  TAc_Registers = record
    CTRLA       : byte;                // Control A 
    CTRLB       : byte;                // Control B 
    EVCTRL      : word;                // Event Control 
    INTENCLR    : byte;                // Interrupt Enable Clear 
    INTENSET    : byte;                // Interrupt Enable Set 
    INTFLAG     : byte;                // Interrupt Flag Status and Clear 
    Reserved1   : array[0..0] of byte;
    STATUSA     : byte;                // Status A 
    STATUSB     : byte;                // Status B 
    STATUSC     : byte;                // Status C 
    Reserved2   : array[0..0] of byte;
    WINCTRL     : byte;                // Window Control 
    Reserved3   : array[0..2] of byte;
    COMPCTRL    : array[0..1] of longword; // Comparator Control n 
    Reserved4   : array[0..7] of byte;
    SCALER      : array[0..1] of byte; // Scaler n 
  end;

  TAdc_Registers = record
    CTRLA       : byte;                // Control A 
    REFCTRL     : byte;                // Reference Control 
    AVGCTRL     : byte;                // Average Control 
    SAMPCTRL    : byte;                // Sampling Time Control 
    CTRLB       : word;                // Control B 
    Reserved1   : array[0..1] of byte;
    WINCTRL     : byte;                // Window Monitor Control 
    Reserved2   : array[0..2] of byte;
    SWTRIG      : byte;                // Software Trigger 
    Reserved3   : array[0..2] of byte;
    INPUTCTRL   : longword;            // Input Control 
    EVCTRL      : byte;                // Event Control 
    Reserved4   : array[0..0] of byte;
    INTENCLR    : byte;                // Interrupt Enable Clear 
    INTENSET    : byte;                // Interrupt Enable Set 
    INTFLAG     : byte;                // Interrupt Flag Status and Clear 
    STATUS      : byte;                // Status 
    RESULT      : word;                // Result 
    WINLT       : word;                // Window Monitor Lower Threshold 
    Reserved5   : array[0..1] of byte;
    WINUT       : word;                // Window Monitor Upper Threshold 
    Reserved6   : array[0..1] of byte;
    GAINCORR    : word;                // Gain Correction 
    OFFSETCORR  : word;                // Offset Correction 
    CALIB       : word;                // Calibration 
    DBGCTRL     : byte;                // Debug Control 
  end;

  TDac_Registers = record
    CTRLA       : byte;                // Control A 
    CTRLB       : byte;                // Control B 
    EVCTRL      : byte;                // Event Control 
    Reserved1   : array[0..0] of byte;
    INTENCLR    : byte;                // Interrupt Enable Clear 
    INTENSET    : byte;                // Interrupt Enable Set 
    INTFLAG     : byte;                // Interrupt Flag Status and Clear 
    STATUS      : byte;                // Status 
    DATA        : word;                // Data 
    Reserved2   : array[0..1] of byte;
    DATABUF     : word;                // Data Buffer 
  end;

  TDmac_Registers = record
    CTRL        : word;                // Control 
    CRCCTRL     : word;                // CRC Control 
    CRCDATAIN   : longword;            // CRC Data Input 
    CRCCHKSUM   : longword;            // CRC Checksum 
    CRCSTATUS   : byte;                // CRC Status 
    DBGCTRL     : byte;                // Debug Control 
    QOSCTRL     : byte;                // QOS Control 
    Reserved1   : array[0..0] of byte;
    SWTRIGCTRL  : longword;            // Software Trigger Control 
    PRICTRL0    : longword;            // Priority Control 0 
    Reserved2   : array[0..7] of byte;
    INTPEND     : word;                // Interrupt Pending 
    Reserved3   : array[0..1] of byte;
    INTSTATUS   : longword;            // Interrupt Status 
    BUSYCH      : longword;            // Busy Channels 
    PENDCH      : longword;            // Pending Channels 
    ACTIVE      : longword;            // Active Channel and Levels 
    BASEADDR    : longword;            // Descriptor Memory Section Base Address 
    WRBADDR     : longword;            // Write-Back Memory Section Base Address 
    Reserved4   : array[0..2] of byte;
    CHID        : byte;                // Channel ID 
    CHCTRLA     : byte;                // Channel Control A 
    Reserved5   : array[0..2] of byte;
    CHCTRLB     : longword;            // Channel Control B 
    Reserved6   : array[0..3] of byte;
    CHINTENCLR  : byte;                // Channel Interrupt Enable Clear 
    CHINTENSET  : byte;                // Channel Interrupt Enable Set 
    CHINTFLAG   : byte;                // Channel Interrupt Flag Status and Clear 
    CHSTATUS    : byte;                // Channel Status 
  end;

  TDmacDescriptor_Registers = record
    BTCTRL      : word;                // Block Transfer Control 
    BTCNT       : word;                // Block Transfer Count 
    SRCADDR     : longword;            // Block Transfer Source Address 
    DSTADDR     : longword;            // Block Transfer Destination Address 
    DESCADDR    : longword;            // Next Descriptor Address 
  end;

  TDsu_Registers = record
    CTRL        : byte;                // Control 
    STATUSA     : byte;                // Status A 
    STATUSB     : byte;                // Status B 
    Reserved1   : array[0..0] of byte;
    ADDR        : longword;            // Address 
    LENGTH      : longword;            // Length 
    DATA        : longword;            // Data 
    DCC         : array[0..1] of longword; // Debug Communication Channel n 
    DID         : longword;            // Device Identification 
    Reserved2   : array[0..4067] of byte;
    ENTRY       : array[0..1] of longword; // Coresight ROM Table Entry n 
    &END        : longword;            // Coresight ROM Table End 
    Reserved3   : array[0..4031] of byte;
    MEMTYPE     : longword;            // Coresight ROM Table Memory Type 
    PID4        : longword;            // Peripheral Identification 4 
    Reserved4   : array[0..11] of byte;
    PID0        : longword;            // Peripheral Identification 0 
    PID1        : longword;            // Peripheral Identification 1 
    PID2        : longword;            // Peripheral Identification 2 
    PID3        : longword;            // Peripheral Identification 3 
    CID0        : longword;            // Component Identification 0 
    CID1        : longword;            // Component Identification 1 
    CID2        : longword;            // Component Identification 2 
    CID3        : longword;            // Component Identification 3 
  end;

  TEic_Registers = record
    CTRL        : byte;                // Control 
    STATUS      : byte;                // Status 
    NMICTRL     : byte;                // Non-Maskable Interrupt Control 
    NMIFLAG     : byte;                // Non-Maskable Interrupt Flag Status and Clear 
    EVCTRL      : longword;            // Event Control 
    INTENCLR    : longword;            // Interrupt Enable Clear 
    INTENSET    : longword;            // Interrupt Enable Set 
    INTFLAG     : longword;            // Interrupt Flag Status and Clear 
    WAKEUP      : longword;            // Wake-Up Enable 
    CONFIG      : array[0..1] of longword; // Configuration n 
  end;

  TEvsys_Registers = record
    CTRL        : byte;                // Control 
    Reserved1   : array[0..2] of byte;
    CHANNEL     : longword;            // Channel 
    USER        : word;                // User Multiplexer 
    Reserved2   : array[0..1] of byte;
    CHSTATUS    : longword;            // Channel Status 
    INTENCLR    : longword;            // Interrupt Enable Clear 
    INTENSET    : longword;            // Interrupt Enable Set 
    INTFLAG     : longword;            // Interrupt Flag Status and Clear 
  end;

  TGclk_Registers = record
    CTRL        : byte;                // Control 
    STATUS      : byte;                // Status 
    CLKCTRL     : word;                // Generic Clock Control 
    GENCTRL     : longword;            // Generic Clock Generator Control 
    GENDIV      : longword;            // Generic Clock Generator Division 
  end;

  THmatrixbPrs_Registers = record
    PRAS        : longword;            // Priority A for Slave 
    PRBS        : longword;            // Priority B for Slave 
  end;

  THmatrixb_Registers = record
    Reserved1   : array[0..127] of byte;
    Prs         : array[0..15] of THmatrixbPrs_Registers; // HmatrixbPrs groups 
    Reserved2   : array[0..15] of byte;
    SFR         : array[0..15] of longword; // Special Function 
  end;

  TI2s_Registers = record
    CTRLA       : byte;                // Control A 
    Reserved1   : array[0..2] of byte;
    CLKCTRL     : array[0..1] of longword; // Clock Unit n Control 
    INTENCLR    : word;                // Interrupt Enable Clear 
    Reserved2   : array[0..1] of byte;
    INTENSET    : word;                // Interrupt Enable Set 
    Reserved3   : array[0..1] of byte;
    INTFLAG     : word;                // Interrupt Flag Status and Clear 
    Reserved4   : array[0..1] of byte;
    SYNCBUSY    : word;                // Synchronization Status 
    Reserved5   : array[0..5] of byte;
    SERCTRL     : array[0..1] of longword; // Serializer n Control 
    Reserved6   : array[0..7] of byte;
    DATA        : array[0..1] of longword; // Data n 
  end;

  TMtb_Registers = record
    POSITION    : longword;            // MTB Position 
    MASTER      : longword;            // MTB Master 
    FLOW        : longword;            // MTB Flow 
    BASE        : longword;            // MTB Base 
    Reserved1   : array[0..3823] of byte;
    ITCTRL      : longword;            // MTB Integration Mode Control 
    Reserved2   : array[0..155] of byte;
    CLAIMSET    : longword;            // MTB Claim Set 
    CLAIMCLR    : longword;            // MTB Claim Clear 
    Reserved3   : array[0..7] of byte;
    LOCKACCESS  : longword;            // MTB Lock Access 
    LOCKSTATUS  : longword;            // MTB Lock Status 
    AUTHSTATUS  : longword;            // MTB Authentication Status 
    DEVARCH     : longword;            // MTB Device Architecture 
    Reserved4   : array[0..7] of byte;
    DEVID       : longword;            // MTB Device Configuration 
    DEVTYPE     : longword;            // MTB Device Type 
    PID4        : longword;            // CoreSight 
    PID5        : longword;            // CoreSight 
    PID6        : longword;            // CoreSight 
    PID7        : longword;            // CoreSight 
    PID0        : longword;            // CoreSight 
    PID1        : longword;            // CoreSight 
    PID2        : longword;            // CoreSight 
    PID3        : longword;            // CoreSight 
    CID0        : longword;            // CoreSight 
    CID1        : longword;            // CoreSight 
    CID2        : longword;            // CoreSight 
    CID3        : longword;            // CoreSight 
  end;

  TNvmctrl_Registers = record
    CTRLA       : word;                // Control A 
    Reserved1   : array[0..1] of byte;
    CTRLB       : longword;            // Control B 
    PARAM       : longword;            // NVM Parameter 
    INTENCLR    : byte;                // Interrupt Enable Clear 
    Reserved2   : array[0..2] of byte;
    INTENSET    : byte;                // Interrupt Enable Set 
    Reserved3   : array[0..2] of byte;
    INTFLAG     : byte;                // Interrupt Flag Status and Clear 
    Reserved4   : array[0..2] of byte;
    STATUS      : word;                // Status 
    Reserved5   : array[0..1] of byte;
    ADDR        : longword;            // Address 
    LOCK        : word;                // Lock Section 
  end;

  TPac_Registers = record
    WPCLR       : longword;            // Write Protection Clear 
    WPSET       : longword;            // Write Protection Set 
  end;

  TPm_Registers = record
    CTRL        : byte;                // Control 
    SLEEP       : byte;                // Sleep Mode 
    Reserved1   : array[0..5] of byte;
    CPUSEL      : byte;                // CPU Clock Select 
    APBASEL     : byte;                // APBA Clock Select 
    APBBSEL     : byte;                // APBB Clock Select 
    APBCSEL     : byte;                // APBC Clock Select 
    Reserved2   : array[0..7] of byte;
    AHBMASK     : longword;            // AHB Mask 
    APBAMASK    : longword;            // APBA Mask 
    APBBMASK    : longword;            // APBB Mask 
    APBCMASK    : longword;            // APBC Mask 
    Reserved3   : array[0..15] of byte;
    INTENCLR    : byte;                // Interrupt Enable Clear 
    INTENSET    : byte;                // Interrupt Enable Set 
    INTFLAG     : byte;                // Interrupt Flag Status and Clear 
    Reserved4   : array[0..0] of byte;
    RCAUSE      : byte;                // Reset Cause 
  end;

  TPortGroup_Registers = record
    DIR         : longword;            // Data Direction 
    DIRCLR      : longword;            // Data Direction Clear 
    DIRSET      : longword;            // Data Direction Set 
    DIRTGL      : longword;            // Data Direction Toggle 
    OUT         : longword;            // Data Output Value 
    OUTCLR      : longword;            // Data Output Value Clear 
    OUTSET      : longword;            // Data Output Value Set 
    OUTTGL      : longword;            // Data Output Value Toggle 
    &IN         : longword;            // Data Input Value 
    CTRL        : longword;            // Control 
    WRCONFIG    : longword;            // Write Configuration 
    Reserved1   : array[0..3] of byte;
    PMUX        : array[0..15] of byte; // Peripheral Multiplexing n 
    PINCFG      : array[0..31] of byte; // Pin Configuration n 
    Reserved2   : array[0..31] of byte;
  end;

  TPort_Registers = record
    Group       : array[0..1] of TPortGroup_Registers; // PortGroup groups [GROUPS] 
  end;

  TRtcMode2Alarm_Registers = record
    ALARM       : longword;            // MODE2_ALARM Alarm n Value 
    MASK        : byte;                // MODE2_ALARM Alarm n Mask 
    Reserved1   : array[0..2] of byte;
  end;

  TRtcMode0_Registers = record
    CTRL        : word;                // MODE0 Control 
    READREQ     : word;                // Read Request 
    EVCTRL      : word;                // MODE0 Event Control 
    INTENCLR    : byte;                // MODE0 Interrupt Enable Clear 
    INTENSET    : byte;                // MODE0 Interrupt Enable Set 
    INTFLAG     : byte;                // MODE0 Interrupt Flag Status and Clear 
    Reserved1   : array[0..0] of byte;
    STATUS      : byte;                // Status 
    DBGCTRL     : byte;                // Debug Control 
    FREQCORR    : byte;                // Frequency Correction 
    Reserved2   : array[0..2] of byte;
    COUNT       : longword;            // MODE0 Counter Value 
    Reserved3   : array[0..3] of byte;
    COMP        : array[0..0] of longword; // MODE0 Compare n Value 
  end;

  TRtcMode1_Registers = record
    CTRL        : word;                // MODE1 Control 
    READREQ     : word;                // Read Request 
    EVCTRL      : word;                // MODE1 Event Control 
    INTENCLR    : byte;                // MODE1 Interrupt Enable Clear 
    INTENSET    : byte;                // MODE1 Interrupt Enable Set 
    INTFLAG     : byte;                // MODE1 Interrupt Flag Status and Clear 
    Reserved1   : array[0..0] of byte;
    STATUS      : byte;                // Status 
    DBGCTRL     : byte;                // Debug Control 
    FREQCORR    : byte;                // Frequency Correction 
    Reserved2   : array[0..2] of byte;
    COUNT       : word;                // MODE1 Counter Value 
    Reserved3   : array[0..1] of byte;
    PER         : word;                // MODE1 Counter Period 
    Reserved4   : array[0..1] of byte;
    COMP        : array[0..1] of word; // MODE1 Compare n Value 
  end;

  TRtcMode2_Registers = record
    CTRL        : word;                // MODE2 Control 
    READREQ     : word;                // Read Request 
    EVCTRL      : word;                // MODE2 Event Control 
    INTENCLR    : byte;                // MODE2 Interrupt Enable Clear 
    INTENSET    : byte;                // MODE2 Interrupt Enable Set 
    INTFLAG     : byte;                // MODE2 Interrupt Flag Status and Clear 
    Reserved1   : array[0..0] of byte;
    STATUS      : byte;                // Status 
    DBGCTRL     : byte;                // Debug Control 
    FREQCORR    : byte;                // Frequency Correction 
    Reserved2   : array[0..2] of byte;
    CLOCK       : longword;            // MODE2 Clock Value 
    Reserved3   : array[0..3] of byte;
    Mode2Alarm  : array[0..0] of TRtcMode2Alarm_Registers; // RtcMode2Alarm groups [ALARM_NUM] 
  end;

  TSercomI2cm_Registers = record
    CTRLA       : longword;            // I2CM Control A 
    CTRLB       : longword;            // I2CM Control B 
    Reserved1   : array[0..3] of byte;
    BAUD        : longword;            // I2CM Baud Rate 
    Reserved2   : array[0..3] of byte;
    INTENCLR    : byte;                // I2CM Interrupt Enable Clear 
    Reserved3   : array[0..0] of byte;
    INTENSET    : byte;                // I2CM Interrupt Enable Set 
    Reserved4   : array[0..0] of byte;
    INTFLAG     : byte;                // I2CM Interrupt Flag Status and Clear 
    Reserved5   : array[0..0] of byte;
    STATUS      : word;                // I2CM Status 
    SYNCBUSY    : longword;            // I2CM Syncbusy 
    Reserved6   : array[0..3] of byte;
    ADDR        : longword;            // I2CM Address 
    DATA        : byte;                // I2CM Data 
    Reserved7   : array[0..6] of byte;
    DBGCTRL     : byte;                // I2CM Debug Control 
  end;

  TSercomI2cs_Registers = record
    CTRLA       : longword;            // I2CS Control A 
    CTRLB       : longword;            // I2CS Control B 
    Reserved1   : array[0..11] of byte;
    INTENCLR    : byte;                // I2CS Interrupt Enable Clear 
    Reserved2   : array[0..0] of byte;
    INTENSET    : byte;                // I2CS Interrupt Enable Set 
    Reserved3   : array[0..0] of byte;
    INTFLAG     : byte;                // I2CS Interrupt Flag Status and Clear 
    Reserved4   : array[0..0] of byte;
    STATUS      : word;                // I2CS Status 
    SYNCBUSY    : longword;            // I2CS Syncbusy 
    Reserved5   : array[0..3] of byte;
    ADDR        : longword;            // I2CS Address 
    DATA        : byte;                // I2CS Data 
  end;

  TSercomSpi_Registers = record
    CTRLA       : longword;            // SPI Control A 
    CTRLB       : longword;            // SPI Control B 
    Reserved1   : array[0..3] of byte;
    BAUD        : byte;                // SPI Baud Rate 
    Reserved2   : array[0..6] of byte;
    INTENCLR    : byte;                // SPI Interrupt Enable Clear 
    Reserved3   : array[0..0] of byte;
    INTENSET    : byte;                // SPI Interrupt Enable Set 
    Reserved4   : array[0..0] of byte;
    INTFLAG     : byte;                // SPI Interrupt Flag Status and Clear 
    Reserved5   : array[0..0] of byte;
    STATUS      : word;                // SPI Status 
    SYNCBUSY    : longword;            // SPI Syncbusy 
    Reserved6   : array[0..3] of byte;
    ADDR        : longword;            // SPI Address 
    DATA        : longword;            // SPI Data 
    Reserved7   : array[0..3] of byte;
    DBGCTRL     : byte;                // SPI Debug Control 
  end;

  TSercomUsart_Registers = record
    CTRLA       : longword;            // USART Control A 
    CTRLB       : longword;            // USART Control B 
    Reserved1   : array[0..3] of byte;
    BAUD        : word;                // USART Baud Rate 
    RXPL        : byte;                // USART Receive Pulse Length 
    Reserved2   : array[0..4] of byte;
    INTENCLR    : byte;                // USART Interrupt Enable Clear 
    Reserved3   : array[0..0] of byte;
    INTENSET    : byte;                // USART Interrupt Enable Set 
    Reserved4   : array[0..0] of byte;
    INTFLAG     : byte;                // USART Interrupt Flag Status and Clear 
    Reserved5   : array[0..0] of byte;
    STATUS      : word;                // USART Status 
    SYNCBUSY    : longword;            // USART Syncbusy 
    Reserved6   : array[0..7] of byte;
    DATA        : word;                // USART Data 
    Reserved7   : array[0..5] of byte;
    DBGCTRL     : byte;                // USART Debug Control 
  end;

  TOSC32Kctrl_Registers = record
    INTENCLR    : longword;            // Interrupt Enable Clear 
    INTENSET    : longword;            // Interrupt Enable Set 
    INTFLAG     : longword;            // Interrupt Flag Status and Clear 
    STATUS      : longword;
    RTCCTRL     : byte;
    Reserved1   : array[0..2] of byte;
    XOSC32K     : word;
    CFDCTRL     : byte;
    EVCTRL      : byte;
    Reserved2   : array[0..3] of byte;
    OSCULP32K   : longword;
  end;

  TDpll_Registers = record
    DPLLCTRLA      : byte;
    Reserved1      : array[0..2] of byte;
    DPLLRATIO      : longword;
    DPLLCTRLB      : longword;
    DPLLSYNCBUSY   : longword;
    DPLLSTATUS     : longword;
  end;

  TOscctrl_Registers = record
    EVCTRL      : byte;
    Reserved1   : array[0..2] of byte;
    INTENCLR    : longword;            // Interrupt Enable Clear 
    INTENSET    : longword;            // Interrupt Enable Set 
    INTFLAG     : longword;            // Interrupt Flag Status and Clear 
    STATUS      : longword;
    XOSCCTRL    : array[0..1] of longword;
    DFLLCTRLA   : byte;
    Reserved2   : array[0..2] of byte;
    DFLLCTRLB   : byte;
    Reserved3   : array[0..2] of byte;
    DFLLVAL     : longword;
    DFLLMUL     : longword;
    DFLLSYNC    : byte;
    Reserved4   : array[0..2] of byte;
    DPLL        : array[0..1] of TDpll_Registers;
  end;

  TTcCount8_Registers = record
    CTRLA       : word;                // Control A 
    READREQ     : word;                // Read Request 
    CTRLBCLR    : byte;                // Control B Clear 
    CTRLBSET    : byte;                // Control B Set 
    CTRLC       : byte;                // Control C 
    Reserved1   : array[0..0] of byte;
    DBGCTRL     : byte;                // Debug Control 
    Reserved2   : array[0..0] of byte;
    EVCTRL      : word;                // Event Control 
    INTENCLR    : byte;                // Interrupt Enable Clear 
    INTENSET    : byte;                // Interrupt Enable Set 
    INTFLAG     : byte;                // Interrupt Flag Status and Clear 
    STATUS      : byte;                // Status 
    COUNT       : byte;                // COUNT8 Counter Value 
    Reserved3   : array[0..2] of byte;
    PER         : byte;                // COUNT8 Period Value 
    Reserved4   : array[0..2] of byte;
    CC          : array[0..1] of byte; // COUNT8 Compare/Capture 
  end;

  TTcCount16_Registers = record
    CTRLA       : word;                // Control A 
    READREQ     : word;                // Read Request 
    CTRLBCLR    : byte;                // Control B Clear 
    CTRLBSET    : byte;                // Control B Set 
    CTRLC       : byte;                // Control C 
    Reserved1   : array[0..0] of byte;
    DBGCTRL     : byte;                // Debug Control 
    Reserved2   : array[0..0] of byte;
    EVCTRL      : word;                // Event Control 
    INTENCLR    : byte;                // Interrupt Enable Clear 
    INTENSET    : byte;                // Interrupt Enable Set 
    INTFLAG     : byte;                // Interrupt Flag Status and Clear 
    STATUS      : byte;                // Status 
    COUNT       : word;                // COUNT16 Counter Value 
    Reserved3   : array[0..5] of byte;
    CC          : array[0..1] of word; // COUNT16 Compare/Capture 
  end;

  TTcCount32_Registers = record
    CTRLA       : word;                // Control A 
    READREQ     : word;                // Read Request 
    CTRLBCLR    : byte;                // Control B Clear 
    CTRLBSET    : byte;                // Control B Set 
    CTRLC       : byte;                // Control C 
    Reserved1   : array[0..0] of byte;
    DBGCTRL     : byte;                // Debug Control 
    Reserved2   : array[0..0] of byte;
    EVCTRL      : word;                // Event Control 
    INTENCLR    : byte;                // Interrupt Enable Clear 
    INTENSET    : byte;                // Interrupt Enable Set 
    INTFLAG     : byte;                // Interrupt Flag Status and Clear 
    STATUS      : byte;                // Status 
    COUNT       : longword;            // COUNT32 Counter Value 
    Reserved3   : array[0..3] of byte;
    CC          : array[0..1] of longword; // COUNT32 Compare/Capture 
  end;

  TTcc_Registers = record
    CTRLA       : longword;            // Control A 
    CTRLBCLR    : byte;                // Control B Clear 
    CTRLBSET    : byte;                // Control B Set 
    Reserved1   : array[0..1] of byte;
    SYNCBUSY    : longword;            // Synchronization Busy 
    FCTRLA      : longword;            // Recoverable Fault A Configuration 
    FCTRLB      : longword;            // Recoverable Fault B Configuration 
    WEXCTRL     : longword;            // Waveform Extension Configuration 
    DRVCTRL     : longword;            // Driver Control 
    Reserved2   : array[0..1] of byte;
    DBGCTRL     : byte;                // Debug Control 
    Reserved3   : array[0..0] of byte;
    EVCTRL      : longword;            // Event Control 
    INTENCLR    : longword;            // Interrupt Enable Clear 
    INTENSET    : longword;            // Interrupt Enable Set 
    INTFLAG     : longword;            // Interrupt Flag Status and Clear 
    STATUS      : longword;            // Status 
    COUNT       : longword;            // Count 
    PATT        : word;                // Pattern 
    Reserved4   : array[0..1] of byte;
    WAVE        : longword;            // Waveform Control 
    PER         : longword;            // Period 
    CC          : array[0..3] of longword; // Compare and Capture 
    Reserved5   : array[0..15] of byte;
    PATTB       : word;                // Pattern Buffer 
    Reserved6   : array[0..1] of byte;
    WAVEB       : longword;            // Waveform Control Buffer 
    PERB        : longword;            // Period Buffer 
    CCB         : array[0..3] of longword; // Compare and Capture Buffer 
  end;

  TUsbDeviceDescBank_Registers = record
    ADDR        : longword;            // DEVICE_DESC_BANK Endpoint Bank, Adress of Data Buffer 
    PCKSIZE     : longword;            // DEVICE_DESC_BANK Endpoint Bank, Packet Size 
    EXTREG      : word;                // DEVICE_DESC_BANK Endpoint Bank, Extended 
    STATUS_BK   : byte;                // DEVICE_DESC_BANK Enpoint Bank, Status of Bank 
    Reserved1   : array[0..4] of byte;
  end;

  TUsbHostDescBank_Registers = record
    ADDR        : longword;            // HOST_DESC_BANK Host Bank, Adress of Data Buffer 
    PCKSIZE     : longword;            // HOST_DESC_BANK Host Bank, Packet Size 
    EXTREG      : word;                // HOST_DESC_BANK Host Bank, Extended 
    STATUS_BK   : byte;                // HOST_DESC_BANK Host Bank, Status of Bank 
    Reserved1   : array[0..0] of byte;
    CTRL_PIPE   : word;                // HOST_DESC_BANK Host Bank, Host Control Pipe 
    STATUS_PIPE : word;                // HOST_DESC_BANK Host Bank, Host Status Pipe 
  end;

  TUsbDeviceEndpoint_Registers = record
    EPCFG       : byte;                // DEVICE_ENDPOINT End Point Configuration 
    Reserved1   : array[0..2] of byte;
    EPSTATUSCLR : byte;                // DEVICE_ENDPOINT End Point Pipe Status Clear 
    EPSTATUSSET : byte;                // DEVICE_ENDPOINT End Point Pipe Status Set 
    EPSTATUS    : byte;                // DEVICE_ENDPOINT End Point Pipe Status 
    EPINTFLAG   : byte;                // DEVICE_ENDPOINT End Point Interrupt Flag 
    EPINTENCLR  : byte;                // DEVICE_ENDPOINT End Point Interrupt Clear Flag 
    EPINTENSET  : byte;                // DEVICE_ENDPOINT End Point Interrupt Set Flag 
    Reserved2   : array[0..21] of byte;
  end;

  TUsbHostPipe_Registers = record
    PCFG        : byte;                // HOST_PIPE End Point Configuration 
    Reserved1   : array[0..1] of byte;
    BINTERVAL   : byte;                // HOST_PIPE Bus Access Period of Pipe 
    PSTATUSCLR  : byte;                // HOST_PIPE End Point Pipe Status Clear 
    PSTATUSSET  : byte;                // HOST_PIPE End Point Pipe Status Set 
    PSTATUS     : byte;                // HOST_PIPE End Point Pipe Status 
    PINTFLAG    : byte;                // HOST_PIPE Pipe Interrupt Flag 
    PINTENCLR   : byte;                // HOST_PIPE Pipe Interrupt Flag Clear 
    PINTENSET   : byte;                // HOST_PIPE Pipe Interrupt Flag Set 
    Reserved2   : array[0..21] of byte;
  end;

  TUsbDevice_Registers = record
    CTRLA       : byte;                // Control A 
    Reserved1   : array[0..0] of byte;
    SYNCBUSY    : byte;                // Synchronization Busy 
    QOSCTRL     : byte;                // USB Quality Of Service 
    Reserved2   : array[0..3] of byte;
    CTRLB       : word;                // DEVICE Control B 
    DADD        : byte;                // DEVICE Device Address 
    Reserved3   : array[0..0] of byte;
    STATUS      : byte;                // DEVICE Status 
    FSMSTATUS   : byte;                // Finite State Machine Status 
    Reserved4   : array[0..1] of byte;
    FNUM        : word;                // DEVICE Device Frame Number 
    Reserved5   : array[0..1] of byte;
    INTENCLR    : word;                // DEVICE Device Interrupt Enable Clear 
    Reserved6   : array[0..1] of byte;
    INTENSET    : word;                // DEVICE Device Interrupt Enable Set 
    Reserved7   : array[0..1] of byte;
    INTFLAG     : word;                // DEVICE Device Interrupt Flag 
    Reserved8   : array[0..1] of byte;
    EPINTSMRY   : word;                // DEVICE End Point Interrupt Summary 
    Reserved9   : array[0..1] of byte;
    DESCADD     : longword;            // Descriptor Address 
    PADCAL      : word;                // USB PAD Calibration 
    Reserved10  : array[0..213] of byte;
    DeviceEndpoint : array[0..7] of TUsbDeviceEndpoint_Registers; // UsbDeviceEndpoint groups [EPT_NUM] 
  end;

  TUsbHost_Registers = record
    CTRLA       : byte;                // Control A 
    Reserved1   : array[0..0] of byte;
    SYNCBUSY    : byte;                // Synchronization Busy 
    QOSCTRL     : byte;                // USB Quality Of Service 
    Reserved2   : array[0..3] of byte;
    CTRLB       : word;                // HOST Control B 
    HSOFC       : byte;                // HOST Host Start Of Frame Control 
    Reserved3   : array[0..0] of byte;
    STATUS      : byte;                // HOST Status 
    FSMSTATUS   : byte;                // Finite State Machine Status 
    Reserved4   : array[0..1] of byte;
    FNUM        : word;                // HOST Host Frame Number 
    FLENHIGH    : byte;                // HOST Host Frame Length 
    Reserved5   : array[0..0] of byte;
    INTENCLR    : word;                // HOST Host Interrupt Enable Clear 
    Reserved6   : array[0..1] of byte;
    INTENSET    : word;                // HOST Host Interrupt Enable Set 
    Reserved7   : array[0..1] of byte;
    INTFLAG     : word;                // HOST Host Interrupt Flag 
    Reserved8   : array[0..1] of byte;
    PINTSMRY    : word;                // HOST Pipe Interrupt Summary 
    Reserved9   : array[0..1] of byte;
    DESCADD     : longword;            // Descriptor Address 
    PADCAL      : word;                // USB PAD Calibration 
    Reserved10  : array[0..213] of byte;
    HostPipe    : array[0..7] of TUsbHostPipe_Registers; // UsbHostPipe groups [EPT_NUM*HOST_IMPLEMENTED] 
  end;

  TUsbDeviceDescriptor_Registers = record
    DeviceDescBank : array[0..1] of TUsbDeviceDescBank_Registers; // UsbDeviceDescBank groups 
  end;

  TUsbHostDescriptor_Registers = record
    HostDescBank : array[0..1] of TUsbHostDescBank_Registers; // UsbHostDescBank groups [2*HOST_IMPLEMENTED] 
  end;

  TWdt_Registers = record
    CTRL        : byte;                // Control 
    CONFIG      : byte;                // Configuration 
    EWCTRL      : byte;                // Early Warning Interrupt Control 
    Reserved1   : array[0..0] of byte;
    INTENCLR    : byte;                // Interrupt Enable Clear 
    INTENSET    : byte;                // Interrupt Enable Set 
    INTFLAG     : byte;                // Interrupt Flag Status and Clear 
    STATUS      : byte;                // Status 
    CLEAR       : byte;                // Clear 
  end;

  TRtc_Registers = record
    case byte of
      0: ( MODE0 : TRtcMode0_Registers );
      1: ( MODE1 : TRtcMode1_Registers );
      2: ( MODE2 : TRtcMode2_Registers );
  end;

  TSercom_Registers = record
    case byte of
      0: ( I2CM : TSercomI2cm_Registers );
      1: ( I2CS : TSercomI2cs_Registers );
      2: ( SPI : TSercomSpi_Registers );
      3: ( USART : TSercomUsart_Registers );
  end;

  TTc_Registers = record
    case byte of
      0: ( COUNT8 : TTcCount8_Registers );
      1: ( COUNT16 : TTcCount16_Registers );
      2: ( COUNT32 : TTcCount32_Registers );
  end;

  TUsb_Registers = record
    case byte of
      0: ( DEVICE : TUsbDevice_Registers );
      1: ( HOST : TUsbHost_Registers );
  end;

const
  AC_BASE                            = $42002000;
  ADC0_BASE                          = $43001C00;
  ADC1_BASE                          = $43002000;
  AES_BASE                           = $42002400;
  CCL_BASE                           = $42003800;
  CMCC_BASE                          = $41006000;
  CMCC_AHB_BASE                      = $03000000;
  DAC_BASE                           = $43002400;
  DMAC_BASE                          = $4100A000;
  DSU_BASE                           = $41002000;
  EIC_BASE                           = $40002800;
  EVSYS_BASE                         = $4100E000;
  FREQM_BASE                         = $40002C00;
  GCLK_BASE                          = $40001C00;
  HMATRIX_BASE                       = $4100C000;
  ICM_BASE                           = $42002C00;
  I2S_BASE                           = $43002800;
  MCLK_BASE                          = $40000800;
  NVMCTRL_BASE                       = $41004000;
  NVMCTRL_CB_BASE                    = $00800000;
  NVMCTRL_CBW0_BASE                  = $00800000;
  NVMCTRL_CBW1_BASE                  = $00800010;
  NVMCTRL_CBW2_BASE                  = $00800020;
  NVMCTRL_CBW3_BASE                  = $00800030;
  NVMCTRL_CBW4_BASE                  = $00800040;
  NVMCTRL_CBW5_BASE                  = $00800050;
  NVMCTRL_CBW6_BASE                  = $00800060;
  NVMCTRL_CBW7_BASE                  = $00800070;
  NVMCTRL_FS_BASE                    = $00806000;
  NVMCTRL_SW0_BASE                   = $00800080;
  NVMCTRL_SW1_BASE                   = $00800090;
  NVMCTRL_SW2_BASE                   = $008000A0;
  NVMCTRL_SW3_BASE                   = $008000B0;
  NVMCTRL_SW4_BASE                   = $008000C0;
  NVMCTRL_SW5_BASE                   = $008000D0;
  NVMCTRL_SW6_BASE                   = $008000E0;
  NVMCTRL_SW7_BASE                   = $008000F0;
  NVMCTRL_TEMP_LOG_BASE              = $00800100;
  NVMCTRL_TEMP_LOG_W0_BASE           = $00800100;
  NVMCTRL_TEMP_LOG_W1_BASE           = $00800110;
  NVMCTRL_TEMP_LOG_W2_BASE           = $00800120;
  NVMCTRL_TEMP_LOG_W3_BASE           = $00800130;
  NVMCTRL_TEMP_LOG_W4_BASE           = $00800140;
  NVMCTRL_TEMP_LOG_W5_BASE           = $00800150;
  NVMCTRL_TEMP_LOG_W6_BASE           = $00800160;
  NVMCTRL_TEMP_LOG_W7_BASE           = $00800170;
  NVMCTRL_TLATCH_BASE                = $00802000;
  NVMCTRL_USER_BASE                  = $00804000;
  OSCCTRL_BASE                       = $40001000;
  OSC32KCTRL_BASE                    = $40001400;
  PAC_BASE                           = $40000000;
  PCC_BASE                           = $43002C00;
  PDEC_BASE                          = $42001C00;
  PM_BASE                            = $40000400;
  PORT_BASE                          = $41008000;
  PUKCC_BASE                         = $42003000;
  PUKCC_AHB_BASE                     = $02000000;
  QSPI_BASE                          = $42003400;
  QSPI_AHB_BASE                      = $04000000;
  RAMECC_BASE                        = $41020000;
  RSTC_BASE                          = $40000C00;
  RTC_BASE                           = $40002400;
  SDHC0_BASE                         = $45000000;
  SDHC1_BASE                         = $46000000;
  SERCOM0_BASE                       = $40003000;
  SERCOM1_BASE                       = $40003400;
  SERCOM2_BASE                       = $41012000;
  SERCOM3_BASE                       = $41014000;
  SERCOM4_BASE                       = $43000000;
  SERCOM5_BASE                       = $43000400;
  SERCOM6_BASE                       = $43000800;
  SERCOM7_BASE                       = $43000C00;
  SUPC_BASE                          = $40001800;
  TAL_BASE                           = $4101E000;
  TC0_BASE                           = $40003800;
  TC1_BASE                           = $40003C00;
  TC2_BASE                           = $4101A000;
  TC3_BASE                           = $4101C000;
  TC4_BASE                           = $42001400;
  TC5_BASE                           = $42001800;
  TC6_BASE                           = $43001400;
  TC7_BASE                           = $43001800;
  TCC0_BASE                          = $41016000;
  TCC1_BASE                          = $41018000;
  TCC2_BASE                          = $42000C00;
  TCC3_BASE                          = $42001000;
  TCC4_BASE                          = $43001000;
  TRNG_BASE                          = $42002800;
  USB_BASE                           = $41000000;
  WDT_BASE                           = $40002000;

var
  AC            : TAc_Registers absolute AC_BASE;
  ADC0          : TAdc_Registers absolute ADC0_BASE;
  ADC1          : TAdc_Registers absolute ADC1_BASE;
  DAC           : TDac_Registers absolute DAC_BASE;
  DMAC          : TDmac_Registers absolute DMAC_BASE;
  DSU           : TDsu_Registers absolute DSU_BASE;
  EIC           : TEic_Registers absolute EIC_BASE;
  EVSYS         : TEvsys_Registers absolute EVSYS_BASE;
  GCLK          : TGclk_Registers absolute GCLK_BASE;
  HMATRIX       : THmatrixb_Registers absolute HMATRIX_BASE;
  I2S           : TI2s_Registers absolute I2S_BASE;
  NVMCTRL       : TNvmctrl_Registers absolute NVMCTRL_BASE;
  PAC           : TPac_Registers absolute PAC_BASE;
  PM            : TPm_Registers absolute PM_BASE;
  PORT          : TPort_Registers absolute PORT_BASE;
  RTC           : TRtc_Registers absolute RTC_BASE;
  SERCOM0       : TSercom_Registers absolute SERCOM0_BASE;
  SERCOM1       : TSercom_Registers absolute SERCOM1_BASE;
  SERCOM2       : TSercom_Registers absolute SERCOM2_BASE;
  SERCOM3       : TSercom_Registers absolute SERCOM3_BASE;
  SERCOM4       : TSercom_Registers absolute SERCOM4_BASE;
  SERCOM5       : TSercom_Registers absolute SERCOM5_BASE;
  SERCOM6       : TSercom_Registers absolute SERCOM6_BASE;
  SERCOM7       : TSercom_Registers absolute SERCOM7_BASE;
  OSC32K        : TOSC32Kctrl_Registers absolute OSC32KCTRL_BASE;
  OSC           : TOscctrl_Registers absolute OSCCTRL_BASE;
  TC3           : TTc_Registers absolute TC3_BASE;
  TC4           : TTc_Registers absolute TC4_BASE;
  TC5           : TTc_Registers absolute TC5_BASE;
  TC6           : TTc_Registers absolute TC6_BASE;
  TC7           : TTc_Registers absolute TC7_BASE;
  TCC0          : TTcc_Registers absolute TCC0_BASE;
  TCC1          : TTcc_Registers absolute TCC1_BASE;
  TCC2          : TTcc_Registers absolute TCC2_BASE;
  USB           : TUsb_Registers absolute USB_BASE;
  WDT           : TWdt_Registers absolute WDT_BASE;

implementation

procedure NonMaskableInt_Handler; external name 'NonMaskableInt_Handler';
procedure HardFault_Handler; external name 'HardFault_Handler';
procedure MemoryManagement_Handler; external name 'MemoryManagement_Handler';
procedure BusFault_Handler; external name 'BusFault_Handler';
procedure UsageFault_Handler; external name 'UsageFault_Handler';
procedure SVC_Handler; external name 'SVC_Handler';
procedure DebugMonitor_Handler; external name 'DebugMonitor_Handler';
procedure PendSV_Handler; external name 'PendSV_Handler';
procedure SysTick_Handler; external name 'SysTick_Handler';

procedure PM_Handler; external name 'PM_Handler';
procedure MCLK_Handler; external name 'MCLK_Handler';
procedure OSCCTRL_0_Handler; external name 'OSCCTRL_0_Handler';
procedure OSCCTRL_1_Handler; external name 'OSCCTRL_1_Handler';
procedure OSCCTRL_2_Handler; external name 'OSCCTRL_2_Handler';
procedure OSCCTRL_3_Handler; external name 'OSCCTRL_3_Handler';
procedure OSCCTRL_4_Handler; external name 'OSCCTRL_4_Handler';
procedure OSC32KCTRL_Handler; external name 'OSC32KCTRL_Handler';
procedure SUPC_0_Handler; external name 'SUPC_0_Handler';
procedure SUPC_1_Handler; external name 'SUPC_1_Handler';
procedure WDT_Handler; external name 'WDT_Handler';
procedure RTC_Handler; external name 'RTC_Handler';
procedure EIC_0_Handler; external name 'EIC_0_Handler';
procedure EIC_1_Handler; external name 'EIC_1_Handler';
procedure EIC_2_Handler; external name 'EIC_2_Handler';
procedure EIC_3_Handler; external name 'EIC_3_Handler';
procedure EIC_4_Handler; external name 'EIC_4_Handler';
procedure EIC_5_Handler; external name 'EIC_5_Handler';
procedure EIC_6_Handler; external name 'EIC_6_Handler';
procedure EIC_7_Handler; external name 'EIC_7_Handler';
procedure EIC_8_Handler; external name 'EIC_8_Handler';
procedure EIC_9_Handler; external name 'EIC_9_Handler';
procedure EIC_10_Handler; external name 'EIC_10_Handler';
procedure EIC_11_Handler; external name 'EIC_11_Handler';
procedure EIC_12_Handler; external name 'EIC_12_Handler';
procedure EIC_13_Handler; external name 'EIC_13_Handler';
procedure EIC_14_Handler; external name 'EIC_14_Handler';
procedure EIC_15_Handler; external name 'EIC_15_Handler';
procedure FREQM_Handler; external name 'FREQM_Handler';
procedure NVMCTRL_0_Handler; external name 'NVMCTRL_0_Handler';
procedure NVMCTRL_1_Handler; external name 'NVMCTRL_1_Handler';
procedure DMAC_0_Handler; external name 'DMAC_0_Handler';
procedure DMAC_1_Handler; external name 'DMAC_1_Handler';
procedure DMAC_2_Handler; external name 'DMAC_2_Handler';
procedure DMAC_3_Handler; external name 'DMAC_3_Handler';
procedure DMAC_4_Handler; external name 'DMAC_4_Handler';
procedure EVSYS_0_Handler; external name 'EVSYS_0_Handler';
procedure EVSYS_1_Handler; external name 'EVSYS_1_Handler';
procedure EVSYS_2_Handler; external name 'EVSYS_2_Handler';
procedure EVSYS_3_Handler; external name 'EVSYS_3_Handler';
procedure EVSYS_4_Handler; external name 'EVSYS_4_Handler';
procedure PAC_Handler; external name 'PAC_Handler';
procedure TAL_0_Handler; external name 'TAL_0_Handler';
procedure TAL_1_Handler; external name 'TAL_1_Handler';
//procedure Reserved44; external name 'Reserved44';
procedure RAMECC_Handler; external name 'RAMECC_Handler';
procedure SERCOM0_0_Handler; external name 'SERCOM0_0_Handler';
procedure SERCOM0_1_Handler; external name 'SERCOM0_1_Handler';
procedure SERCOM0_2_Handler; external name 'SERCOM0_2_Handler';
procedure SERCOM0_3_Handler; external name 'SERCOM0_3_Handler';
procedure SERCOM1_0_Handler; external name 'SERCOM1_0_Handler';
procedure SERCOM1_1_Handler; external name 'SERCOM1_1_Handler';
procedure SERCOM1_2_Handler; external name 'SERCOM1_2_Handler';
procedure SERCOM1_3_Handler; external name 'SERCOM1_3_Handler';
procedure SERCOM2_0_Handler; external name 'SERCOM2_0_Handler';
procedure SERCOM2_1_Handler; external name 'SERCOM2_1_Handler';
procedure SERCOM2_2_Handler; external name 'SERCOM2_2_Handler';
procedure SERCOM2_3_Handler; external name 'SERCOM2_3_Handler';
procedure SERCOM3_0_Handler; external name 'SERCOM3_0_Handler';
procedure SERCOM3_1_Handler; external name 'SERCOM3_1_Handler';
procedure SERCOM3_2_Handler; external name 'SERCOM3_2_Handler';
procedure SERCOM3_3_Handler; external name 'SERCOM3_3_Handler';
procedure SERCOM4_0_Handler; external name 'SERCOM4_0_Handler';
procedure SERCOM4_1_Handler; external name 'SERCOM4_1_Handler';
procedure SERCOM4_2_Handler; external name 'SERCOM4_2_Handler';
procedure SERCOM4_3_Handler; external name 'SERCOM4_3_Handler';
procedure SERCOM5_0_Handler; external name 'SERCOM5_0_Handler';
procedure SERCOM5_1_Handler; external name 'SERCOM5_1_Handler';
procedure SERCOM5_2_Handler; external name 'SERCOM5_2_Handler';
procedure SERCOM5_3_Handler; external name 'SERCOM5_3_Handler';
procedure SERCOM6_0_Handler; external name 'SERCOM6_0_Handler';
procedure SERCOM6_1_Handler; external name 'SERCOM6_1_Handler';
procedure SERCOM6_2_Handler; external name 'SERCOM6_2_Handler';
procedure SERCOM6_3_Handler; external name 'SERCOM6_3_Handler';
procedure SERCOM7_0_Handler; external name 'SERCOM7_0_Handler';
procedure SERCOM7_1_Handler; external name 'SERCOM7_1_Handler';
procedure SERCOM7_2_Handler; external name 'SERCOM7_2_Handler';
procedure SERCOM7_3_Handler; external name 'SERCOM7_3_Handler';
procedure CAN0_Handler; external name 'CAN0_Handler';
procedure CAN1_Handler; external name 'CAN1_Handler';
procedure USB_0_Handler; external name 'USB_0_Handler';
procedure USB_1_Handler; external name 'USB_1_Handler';
procedure USB_2_Handler; external name 'USB_2_Handler';
procedure USB_3_Handler; external name 'USB_3_Handler';
procedure GMAC_Handler; external name 'GMAC_Handler';
procedure TCC0_0_Handler; external name 'TCC0_0_Handler';
procedure TCC0_1_Handler; external name 'TCC0_1_Handler';
procedure TCC0_2_Handler; external name 'TCC0_2_Handler';
procedure TCC0_3_Handler; external name 'TCC0_3_Handler';
procedure TCC0_4_Handler; external name 'TCC0_4_Handler';
procedure TCC0_5_Handler; external name 'TCC0_5_Handler';
procedure TCC0_6_Handler; external name 'TCC0_6_Handler';
procedure TCC1_0_Handler; external name 'TCC1_0_Handler';
procedure TCC1_1_Handler; external name 'TCC1_1_Handler';
procedure TCC1_2_Handler; external name 'TCC1_2_Handler';
procedure TCC1_3_Handler; external name 'TCC1_3_Handler';
procedure TCC1_4_Handler; external name 'TCC1_4_Handler';
procedure TCC2_0_Handler; external name 'TCC2_0_Handler';
procedure TCC2_1_Handler; external name 'TCC2_1_Handler';
procedure TCC2_2_Handler; external name 'TCC2_2_Handler';
procedure TCC2_3_Handler; external name 'TCC2_3_Handler';
procedure TCC3_0_Handler; external name 'TCC3_0_Handler';
procedure TCC3_1_Handler; external name 'TCC3_1_Handler';
procedure TCC3_2_Handler; external name 'TCC3_2_Handler';
procedure TCC4_0_Handler; external name 'TCC4_0_Handler';
procedure TCC4_1_Handler; external name 'TCC4_1_Handler';
procedure TCC4_2_Handler; external name 'TCC4_2_Handler';
procedure TC0_Handler; external name 'TC0_Handler';
procedure TC1_Handler; external name 'TC1_Handler';
procedure TC2_Handler; external name 'TC2_Handler';
procedure TC3_Handler; external name 'TC3_Handler';
procedure TC4_Handler; external name 'TC4_Handler';
procedure TC5_Handler; external name 'TC5_Handler';
procedure TC6_Handler; external name 'TC6_Handler';
procedure TC7_Handler; external name 'TC7_Handler';
procedure PDEC_0_Handler; external name 'PDEC_0_Handler';
procedure PDEC_1_Handler; external name 'PDEC_1_Handler';
procedure PDEC_2_Handler; external name 'PDEC_2_Handler';
procedure ADC0_0_Handler; external name 'ADC0_0_Handler';
procedure ADC0_1_Handler; external name 'ADC0_1_Handler';
procedure ADC1_0_Handler; external name 'ADC1_0_Handler';
procedure ADC1_1_Handler; external name 'ADC1_1_Handler';
procedure AC_Handler; external name 'AC_Handler';
procedure DAC_0_Handler; external name 'DAC_0_Handler';
procedure DAC_1_Handler; external name 'DAC_1_Handler';
procedure DAC_2_Handler; external name 'DAC_2_Handler';
procedure DAC_3_Handler; external name 'DAC_3_Handler';
procedure DAC_4_Handler; external name 'DAC_4_Handler';
procedure I2S_Handler; external name 'I2S_Handler';
procedure PCC_Handler; external name 'PCC_Handler';
procedure AES_Handler; external name 'AES_Handler';
procedure TRNG_Handler; external name 'TRNG_Handler';
procedure ICM_Handler; external name 'ICM_Handler';
procedure PUKCC_Handler; external name 'PUKCC_Handler';
procedure QSPI_Handler; external name 'QSPI_Handler';
procedure SDHC0_Handler; external name 'SDHC0_Handler';
procedure SDHC1_Handler; external name 'SDHC1_Handler';

//.section ".init.interrupt_vectors,\"ax\",@progbits"
//.section ".init.interrupt_vectors"

{$i cortexm4f_start.inc}

procedure Vectors; assembler; nostackframe;
label interrupt_vectors;
asm
  .section ".init.interrupt_vectors"
  interrupt_vectors:
  .long _stack_top
  .long Startup
  .long NonMaskableInt_Handler
  .long HardFault_Handler
  .long MemoryManagement_Handler
  .long BusFault_Handler
  .long UsageFault_Handler
  .long 0
  .long 0
  .long 0
  .long 0
  .long SVC_Handler
  .long DebugMonitor_Handler
  .long 0
  .long PendSV_Handler
  .long SysTick_Handler
  .long PM_Handler
  .long MCLK_Handler
  .long OSCCTRL_0_Handler
  .long OSCCTRL_1_Handler
  .long OSCCTRL_2_Handler
  .long OSCCTRL_3_Handler
  .long OSCCTRL_4_Handler
  .long OSC32KCTRL_Handler
  .long SUPC_0_Handler
  .long SUPC_1_Handler
  .long WDT_Handler
  .long RTC_Handler
  .long EIC_0_Handler
  .long EIC_1_Handler
  .long EIC_2_Handler
  .long EIC_3_Handler
  .long EIC_4_Handler
  .long EIC_5_Handler
  .long EIC_6_Handler
  .long EIC_7_Handler
  .long EIC_8_Handler
  .long EIC_9_Handler
  .long EIC_10_Handler
  .long EIC_11_Handler
  .long EIC_12_Handler
  .long EIC_13_Handler
  .long EIC_14_Handler
  .long EIC_15_Handler
  .long FREQM_Handler
  .long NVMCTRL_0_Handler
  .long NVMCTRL_1_Handler
  .long DMAC_0_Handler
  .long DMAC_1_Handler
  .long DMAC_2_Handler
  .long DMAC_3_Handler
  .long DMAC_4_Handler
  .long EVSYS_0_Handler
  .long EVSYS_1_Handler
  .long EVSYS_2_Handler
  .long EVSYS_3_Handler
  .long EVSYS_4_Handler
  .long PAC_Handler
  .long TAL_0_Handler
  .long TAL_1_Handler
  .long 0
  .long RAMECC_Handler
  .long SERCOM0_0_Handler
  .long SERCOM0_1_Handler
  .long SERCOM0_2_Handler
  .long SERCOM0_3_Handler
  .long SERCOM1_0_Handler
  .long SERCOM1_1_Handler
  .long SERCOM1_2_Handler
  .long SERCOM1_3_Handler
  .long SERCOM2_0_Handler
  .long SERCOM2_1_Handler
  .long SERCOM2_2_Handler
  .long SERCOM2_3_Handler
  .long SERCOM3_0_Handler
  .long SERCOM3_1_Handler
  .long SERCOM3_2_Handler
  .long SERCOM3_3_Handler
  .long SERCOM4_0_Handler
  .long SERCOM4_1_Handler
  .long SERCOM4_2_Handler
  .long SERCOM4_3_Handler
  .long SERCOM5_0_Handler
  .long SERCOM5_1_Handler
  .long SERCOM5_2_Handler
  .long SERCOM5_3_Handler
  .long SERCOM6_0_Handler
  .long SERCOM6_1_Handler
  .long SERCOM6_2_Handler
  .long SERCOM6_3_Handler
  .long SERCOM7_0_Handler
  .long SERCOM7_1_Handler
  .long SERCOM7_2_Handler
  .long SERCOM7_3_Handler
  .long CAN0_Handler
  .long CAN1_Handler
  .long USB_0_Handler
  .long USB_1_Handler
  .long USB_2_Handler
  .long USB_3_Handler
  .long GMAC_Handler
  .long TCC0_0_Handler
  .long TCC0_1_Handler
  .long TCC0_2_Handler
  .long TCC0_3_Handler
  .long TCC0_4_Handler
  .long TCC0_5_Handler
  .long TCC0_6_Handler
  .long TCC1_0_Handler
  .long TCC1_1_Handler
  .long TCC1_2_Handler
  .long TCC1_3_Handler
  .long TCC1_4_Handler
  .long TCC2_0_Handler
  .long TCC2_1_Handler
  .long TCC2_2_Handler
  .long TCC2_3_Handler
  .long TCC3_0_Handler
  .long TCC3_1_Handler
  .long TCC3_2_Handler
  .long TCC4_0_Handler
  .long TCC4_1_Handler
  .long TCC4_2_Handler
  .long TC0_Handler
  .long TC1_Handler
  .long TC2_Handler
  .long TC3_Handler
  .long TC4_Handler
  .long TC5_Handler
  .long TC6_Handler
  .long TC7_Handler
  .long PDEC_0_Handler
  .long PDEC_1_Handler
  .long PDEC_2_Handler
  .long ADC0_0_Handler
  .long ADC0_1_Handler
  .long ADC1_0_Handler
  .long ADC1_1_Handler
  .long AC_Handler
  .long DAC_0_Handler
  .long DAC_1_Handler
  .long DAC_2_Handler
  .long DAC_3_Handler
  .long DAC_4_Handler
  .long I2S_Handler
  .long PCC_Handler
  .long AES_Handler
  .long TRNG_Handler
  .long ICM_Handler
  .long PUKCC_Handler
  .long QSPI_Handler
  .long SDHC0_Handler
  .long SDHC1_Handler

  .weak NonMaskableInt_Handler
  .weak HardFault_Handler
  .weak MemoryManagement_Handler
  .weak BusFault_Handler
  .weak UsageFault_Handler
  .weak SVC_Handler
  .weak DebugMonitor_Handler
  .weak PendSV_Handler
  .weak SysTick_Handler
  .weak PM_Handler
  .weak MCLK_Handler
  .weak OSCCTRL_0_Handler
  .weak OSCCTRL_1_Handler
  .weak OSCCTRL_2_Handler
  .weak OSCCTRL_3_Handler
  .weak OSCCTRL_4_Handler
  .weak OSC32KCTRL_Handler
  .weak SUPC_0_Handler
  .weak SUPC_1_Handler
  .weak WDT_Handler
  .weak RTC_Handler
  .weak EIC_0_Handler
  .weak EIC_1_Handler
  .weak EIC_2_Handler
  .weak EIC_3_Handler
  .weak EIC_4_Handler
  .weak EIC_5_Handler
  .weak EIC_6_Handler
  .weak EIC_7_Handler
  .weak EIC_8_Handler
  .weak EIC_9_Handler
  .weak EIC_10_Handler
  .weak EIC_11_Handler
  .weak EIC_12_Handler
  .weak EIC_13_Handler
  .weak EIC_14_Handler
  .weak EIC_15_Handler
  .weak FREQM_Handler
  .weak NVMCTRL_0_Handler
  .weak NVMCTRL_1_Handler
  .weak DMAC_0_Handler
  .weak DMAC_1_Handler
  .weak DMAC_2_Handler
  .weak DMAC_3_Handler
  .weak DMAC_4_Handler
  .weak EVSYS_0_Handler
  .weak EVSYS_1_Handler
  .weak EVSYS_2_Handler
  .weak EVSYS_3_Handler
  .weak EVSYS_4_Handler
  .weak PAC_Handler
  .weak TAL_0_Handler
  .weak TAL_1_Handler
  .weak RAMECC_Handler
  .weak SERCOM0_0_Handler
  .weak SERCOM0_1_Handler
  .weak SERCOM0_2_Handler
  .weak SERCOM0_3_Handler
  .weak SERCOM1_0_Handler
  .weak SERCOM1_1_Handler
  .weak SERCOM1_2_Handler
  .weak SERCOM1_3_Handler
  .weak SERCOM2_0_Handler
  .weak SERCOM2_1_Handler
  .weak SERCOM2_2_Handler
  .weak SERCOM2_3_Handler
  .weak SERCOM3_0_Handler
  .weak SERCOM3_1_Handler
  .weak SERCOM3_2_Handler
  .weak SERCOM3_3_Handler
  .weak SERCOM4_0_Handler
  .weak SERCOM4_1_Handler
  .weak SERCOM4_2_Handler
  .weak SERCOM4_3_Handler
  .weak SERCOM5_0_Handler
  .weak SERCOM5_1_Handler
  .weak SERCOM5_2_Handler
  .weak SERCOM5_3_Handler
  .weak SERCOM6_0_Handler
  .weak SERCOM6_1_Handler
  .weak SERCOM6_2_Handler
  .weak SERCOM6_3_Handler
  .weak SERCOM7_0_Handler
  .weak SERCOM7_1_Handler
  .weak SERCOM7_2_Handler
  .weak SERCOM7_3_Handler
  .weak CAN0_Handler
  .weak CAN1_Handler
  .weak USB_0_Handler
  .weak USB_1_Handler
  .weak USB_2_Handler
  .weak USB_3_Handler
  .weak GMAC_Handler
  .weak TCC0_0_Handler
  .weak TCC0_1_Handler
  .weak TCC0_2_Handler
  .weak TCC0_3_Handler
  .weak TCC0_4_Handler
  .weak TCC0_5_Handler
  .weak TCC0_6_Handler
  .weak TCC1_0_Handler
  .weak TCC1_1_Handler
  .weak TCC1_2_Handler
  .weak TCC1_3_Handler
  .weak TCC1_4_Handler
  .weak TCC2_0_Handler
  .weak TCC2_1_Handler
  .weak TCC2_2_Handler
  .weak TCC2_3_Handler
  .weak TCC3_0_Handler
  .weak TCC3_1_Handler
  .weak TCC3_2_Handler
  .weak TCC4_0_Handler
  .weak TCC4_1_Handler
  .weak TCC4_2_Handler
  .weak TC0_Handler
  .weak TC1_Handler
  .weak TC2_Handler
  .weak TC3_Handler
  .weak TC4_Handler
  .weak TC5_Handler
  .weak TC6_Handler
  .weak TC7_Handler
  .weak PDEC_0_Handler
  .weak PDEC_1_Handler
  .weak PDEC_2_Handler
  .weak ADC0_0_Handler
  .weak ADC0_1_Handler
  .weak ADC1_0_Handler
  .weak ADC1_1_Handler
  .weak AC_Handler
  .weak DAC_0_Handler
  .weak DAC_1_Handler
  .weak DAC_2_Handler
  .weak DAC_3_Handler
  .weak DAC_4_Handler
  .weak I2S_Handler
  .weak PCC_Handler
  .weak AES_Handler
  .weak TRNG_Handler
  .weak ICM_Handler
  .weak PUKCC_Handler
  .weak QSPI_Handler
  .weak SDHC0_Handler
  .weak SDHC1_Handler

  .set NonMaskableInt_Handler, Haltproc
  .set HardFault_Handler, Haltproc
  .set MemoryManagement_Handler, Haltproc
  .set BusFault_Handler, Haltproc
  .set UsageFault_Handler, Haltproc
  .set SVC_Handler, Haltproc
  .set DebugMonitor_Handler, Haltproc
  .set PendSV_Handler, Haltproc
  .set SysTick_Handler, Haltproc
  .set PM_Handler, Haltproc
  .set MCLK_Handler, Haltproc
  .set OSCCTRL_0_Handler, Haltproc
  .set OSCCTRL_1_Handler, Haltproc
  .set OSCCTRL_2_Handler, Haltproc
  .set OSCCTRL_3_Handler, Haltproc
  .set OSCCTRL_4_Handler, Haltproc
  .set OSC32KCTRL_Handler, Haltproc
  .set SUPC_0_Handler, Haltproc
  .set SUPC_1_Handler, Haltproc
  .set WDT_Handler, Haltproc
  .set RTC_Handler, Haltproc
  .set EIC_0_Handler, Haltproc
  .set EIC_1_Handler, Haltproc
  .set EIC_2_Handler, Haltproc
  .set EIC_3_Handler, Haltproc
  .set EIC_4_Handler, Haltproc
  .set EIC_5_Handler, Haltproc
  .set EIC_6_Handler, Haltproc
  .set EIC_7_Handler, Haltproc
  .set EIC_8_Handler, Haltproc
  .set EIC_9_Handler, Haltproc
  .set EIC_10_Handler, Haltproc
  .set EIC_11_Handler, Haltproc
  .set EIC_12_Handler, Haltproc
  .set EIC_13_Handler, Haltproc
  .set EIC_14_Handler, Haltproc
  .set EIC_15_Handler, Haltproc
  .set FREQM_Handler, Haltproc
  .set NVMCTRL_0_Handler, Haltproc
  .set NVMCTRL_1_Handler, Haltproc
  .set DMAC_0_Handler, Haltproc
  .set DMAC_1_Handler, Haltproc
  .set DMAC_2_Handler, Haltproc
  .set DMAC_3_Handler, Haltproc
  .set DMAC_4_Handler, Haltproc
  .set EVSYS_0_Handler, Haltproc
  .set EVSYS_1_Handler, Haltproc
  .set EVSYS_2_Handler, Haltproc
  .set EVSYS_3_Handler, Haltproc
  .set EVSYS_4_Handler, Haltproc
  .set PAC_Handler, Haltproc
  .set TAL_0_Handler, Haltproc
  .set TAL_1_Handler, Haltproc
  .set RAMECC_Handler, Haltproc
  .set SERCOM0_0_Handler, Haltproc
  .set SERCOM0_1_Handler, Haltproc
  .set SERCOM0_2_Handler, Haltproc
  .set SERCOM0_3_Handler, Haltproc
  .set SERCOM1_0_Handler, Haltproc
  .set SERCOM1_1_Handler, Haltproc
  .set SERCOM1_2_Handler, Haltproc
  .set SERCOM1_3_Handler, Haltproc
  .set SERCOM2_0_Handler, Haltproc
  .set SERCOM2_1_Handler, Haltproc
  .set SERCOM2_2_Handler, Haltproc
  .set SERCOM2_3_Handler, Haltproc
  .set SERCOM3_0_Handler, Haltproc
  .set SERCOM3_1_Handler, Haltproc
  .set SERCOM3_2_Handler, Haltproc
  .set SERCOM3_3_Handler, Haltproc
  .set SERCOM4_0_Handler, Haltproc
  .set SERCOM4_1_Handler, Haltproc
  .set SERCOM4_2_Handler, Haltproc
  .set SERCOM4_3_Handler, Haltproc
  .set SERCOM5_0_Handler, Haltproc
  .set SERCOM5_1_Handler, Haltproc
  .set SERCOM5_2_Handler, Haltproc
  .set SERCOM5_3_Handler, Haltproc
  .set SERCOM6_0_Handler, Haltproc
  .set SERCOM6_1_Handler, Haltproc
  .set SERCOM6_2_Handler, Haltproc
  .set SERCOM6_3_Handler, Haltproc
  .set SERCOM7_0_Handler, Haltproc
  .set SERCOM7_1_Handler, Haltproc
  .set SERCOM7_2_Handler, Haltproc
  .set SERCOM7_3_Handler, Haltproc
  .set CAN0_Handler, Haltproc
  .set CAN1_Handler, Haltproc
  .set USB_0_Handler, Haltproc
  .set USB_1_Handler, Haltproc
  .set USB_2_Handler, Haltproc
  .set USB_3_Handler, Haltproc
  .set GMAC_Handler, Haltproc
  .set TCC0_0_Handler, Haltproc
  .set TCC0_1_Handler, Haltproc
  .set TCC0_2_Handler, Haltproc
  .set TCC0_3_Handler, Haltproc
  .set TCC0_4_Handler, Haltproc
  .set TCC0_5_Handler, Haltproc
  .set TCC0_6_Handler, Haltproc
  .set TCC1_0_Handler, Haltproc
  .set TCC1_1_Handler, Haltproc
  .set TCC1_2_Handler, Haltproc
  .set TCC1_3_Handler, Haltproc
  .set TCC1_4_Handler, Haltproc
  .set TCC2_0_Handler, Haltproc
  .set TCC2_1_Handler, Haltproc
  .set TCC2_2_Handler, Haltproc
  .set TCC2_3_Handler, Haltproc
  .set TCC3_0_Handler, Haltproc
  .set TCC3_1_Handler, Haltproc
  .set TCC3_2_Handler, Haltproc
  .set TCC4_0_Handler, Haltproc
  .set TCC4_1_Handler, Haltproc
  .set TCC4_2_Handler, Haltproc
  .set TC0_Handler, Haltproc
  .set TC1_Handler, Haltproc
  .set TC2_Handler, Haltproc
  .set TC3_Handler, Haltproc
  .set TC4_Handler, Haltproc
  .set TC5_Handler, Haltproc
  .set TC6_Handler, Haltproc
  .set TC7_Handler, Haltproc
  .set PDEC_0_Handler, Haltproc
  .set PDEC_1_Handler, Haltproc
  .set PDEC_2_Handler, Haltproc
  .set ADC0_0_Handler, Haltproc
  .set ADC0_1_Handler, Haltproc
  .set ADC1_0_Handler, Haltproc
  .set ADC1_1_Handler, Haltproc
  .set AC_Handler, Haltproc
  .set DAC_0_Handler, Haltproc
  .set DAC_1_Handler, Haltproc
  .set DAC_2_Handler, Haltproc
  .set DAC_3_Handler, Haltproc
  .set DAC_4_Handler, Haltproc
  .set I2S_Handler, Haltproc
  .set PCC_Handler, Haltproc
  .set AES_Handler, Haltproc
  .set TRNG_Handler, Haltproc
  .set ICM_Handler, Haltproc
  .set PUKCC_Handler, Haltproc
  .set QSPI_Handler, Haltproc
  .set SDHC0_Handler, Haltproc
  .set SDHC1_Handler, Haltproc

  .text
  end;
end.

