!=======================================================================
! Generated by  : PSCAD v4.5.0.0
!
! Warning:  The content of this file is automatically generated.
!           Do not modify, as any changes made here will be lost!
!-----------------------------------------------------------------------
! Component     : Main
! Description   : 
!-----------------------------------------------------------------------


!=======================================================================

      SUBROUTINE MainDyn()

!---------------------------------------
! Standard includes
!---------------------------------------

      INCLUDE 'nd.h'
      INCLUDE 'emtconst.h'
      INCLUDE 'emtstor.h'
      INCLUDE 's0.h'
      INCLUDE 's1.h'
      INCLUDE 's2.h'
      INCLUDE 's4.h'
      INCLUDE 'branches.h'
      INCLUDE 'pscadv3.h'
      INCLUDE 'fnames.h'
      INCLUDE 'radiolinks.h'
      INCLUDE 'matlab.h'
      INCLUDE 'rtconfig.h'

!---------------------------------------
! Function/Subroutine Declarations
!---------------------------------------

      REAL    EMTDC_XPI     ! 'Proportional-Integral Controller /w Interpolation'
      REAL    LIMIT         ! Hard Limiter
!     SUBR    EMTDC_X2COMP  ! 'Comparator with Interpolation'

!---------------------------------------
! Variable Declarations
!---------------------------------------


! Subroutine Arguments

! Electrical Node Indices

! Control Signals
      INTEGER  S2a, S1a, IT_1, IT_2, CLK
      REAL     RT_1, RT_2, RT_3, RT_4, RT_5, RT_6
      REAL     RT_7, Iin, RT_8, RT_9, S1(2)
      REAL     S2(2), S3(2), S4(2), Vin, Iout, Ia
      REAL     Vout, Vsec, I_out, RT_10, RT_11
      REAL     RT_12, RT_13, RT_14, RT_15, RT_16
      REAL     RT_17, RT_18, RT_19, RT_20, RT_21
      REAL     RT_22, RT_23(7), RT_24(7)
      REAL     RT_25(7), RT_26(7), RT_27
      REAL     RT_28(15), RT_29(15), Vprim

! Internal Variables
      REAL     RVD2_1(2), RVD1_1, RVD1_2, RVD1_3
      REAL     RVD1_4

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER ISTOI, ISTOF, IT_0                  ! Storage Indices
      INTEGER IPGB                                ! Control/Monitoring
      INTEGER ISUBS, SS(1), IBRCH(1), INODE       ! SS/Node/Branch/Xfmr
      INTEGER IXFMR


!---------------------------------------
! Local Indices
!---------------------------------------

! Dsdyn <-> Dsout transfer index storage

      NTXFR = NTXFR + 1

      TXFR(NTXFR,1) = NSTOL
      TXFR(NTXFR,2) = NSTOI
      TXFR(NTXFR,3) = NSTOF
      TXFR(NTXFR,4) = NSTOC

! Increment and assign runtime configuration call indices

      ICALL_NO  = NCALL_NO
      NCALL_NO  = NCALL_NO + 1

! Increment global storage indices

      ISTOI     = NSTOI
      NSTOI     = NSTOI + 5
      ISTOF     = NSTOF
      NSTOF     = NSTOF + 97
      IPGB      = NPGB
      NPGB      = NPGB + 9
      INODE     = NNODE + 2
      NNODE     = NNODE + 14
      IXFMR     = NXFMR
      NXFMR     = NXFMR + 1

! Initialize Subsystem Mapping

      ISUBS = NSUBS + 0
      NSUBS = NSUBS + 1

      DO IT_0 = 1,1
         SS(IT_0) = SUBS(ISUBS + IT_0)
      END DO

! Initialize Branch Mapping.

      IBRCH(1)     = NBRCH(SS(1))
      NBRCH(SS(1)) = NBRCH(SS(1)) + 28
!---------------------------------------
! Transfers from storage arrays
!---------------------------------------

      RT_1     = STOF(ISTOF + 1)
      RT_2     = STOF(ISTOF + 2)
      RT_3     = STOF(ISTOF + 3)
      RT_4     = STOF(ISTOF + 4)
      RT_5     = STOF(ISTOF + 5)
      S2a      = STOI(ISTOI + 1)
      RT_6     = STOF(ISTOF + 6)
      RT_7     = STOF(ISTOF + 7)
      Iin      = STOF(ISTOF + 8)
      S1a      = STOI(ISTOI + 2)
      IT_1     = STOI(ISTOI + 3)
      IT_2     = STOI(ISTOI + 4)
      RT_8     = STOF(ISTOF + 9)
      RT_9     = STOF(ISTOF + 10)
      CLK      = STOI(ISTOI + 5)
      Vin      = STOF(ISTOF + 19)
      Iout     = STOF(ISTOF + 20)
      Ia       = STOF(ISTOF + 21)
      Vout     = STOF(ISTOF + 22)
      Vsec     = STOF(ISTOF + 23)
      I_out    = STOF(ISTOF + 24)
      RT_10    = STOF(ISTOF + 25)
      RT_11    = STOF(ISTOF + 26)
      RT_12    = STOF(ISTOF + 27)
      RT_13    = STOF(ISTOF + 28)
      RT_14    = STOF(ISTOF + 29)
      RT_15    = STOF(ISTOF + 30)
      RT_16    = STOF(ISTOF + 31)
      RT_17    = STOF(ISTOF + 32)
      RT_18    = STOF(ISTOF + 33)
      RT_19    = STOF(ISTOF + 34)
      RT_20    = STOF(ISTOF + 35)
      RT_21    = STOF(ISTOF + 36)
      RT_22    = STOF(ISTOF + 37)
      RT_27    = STOF(ISTOF + 66)
      Vprim    = STOF(ISTOF + 97)

! Array (1:2) quantities...
      DO IT_0 = 1,2
         S1(IT_0) = STOF(ISTOF + 10 + IT_0)
         S2(IT_0) = STOF(ISTOF + 12 + IT_0)
         S3(IT_0) = STOF(ISTOF + 14 + IT_0)
         S4(IT_0) = STOF(ISTOF + 16 + IT_0)
      END DO

! Array (1:7) quantities...
      DO IT_0 = 1,7
         RT_23(IT_0) = STOF(ISTOF + 37 + IT_0)
         RT_24(IT_0) = STOF(ISTOF + 44 + IT_0)
         RT_25(IT_0) = STOF(ISTOF + 51 + IT_0)
         RT_26(IT_0) = STOF(ISTOF + 58 + IT_0)
      END DO

! Array (1:15) quantities...
      DO IT_0 = 1,15
         RT_28(IT_0) = STOF(ISTOF + 66 + IT_0)
         RT_29(IT_0) = STOF(ISTOF + 81 + IT_0)
      END DO

!---------------------------------------
! Electrical Node Lookup
!---------------------------------------


!---------------------------------------
! Configuration of Models
!---------------------------------------

      IF ( TIMEZERO ) THEN
         FILENAME = 'Main.dta'
         CALL EMTDC_OPENFILE
         SECTION = 'DATADSD:'
         CALL EMTDC_GOTOSECTION
      ENDIF
!---------------------------------------
! Generated code from module definition
!---------------------------------------


! 90:[const] Real Constant 
      RT_12 = 54.0

! 150:[signalgen] Signal Generator /w Interpolation 
      CALL COMPONENT_ID(ICALL_NO,352787754)
      CALL E_XSGEN1_EXE(1,200000.0,RVD2_1)
      RT_3 = RVD2_1(1)

! 160:[const] Real Constant 
      RT_13 = 0.5

! 170:[const] Real Constant 
      RT_16 = 0.0

! 180:[signalgen] Signal Generator /w Interpolation 
      CALL COMPONENT_ID(ICALL_NO,50234200)
      CALL E_XSGEN1_EXE(1,100000.0,RVD2_1)
      RT_14 = RVD2_1(1)

! 190:[const] Real Constant 
      RT_18 = 0.0

! 200:[const] Real Constant 
      RT_15 = 0.5

! 210:[const] Real Constant 
      RT_17 = 0.0

! 220:[const] Real Constant 
      RT_19 = 0.0

! 280:[sumjct] Summing/Differencing Junctions 
      RT_10 = + RT_12 - RT_1

! 290:[pi_ctlr] PI Controller \w Interpolation 
      RVD1_1 = RTCF(NRTCF)
      NRTCF = NRTCF + 1
      RVD2_1(1) = RT_10
      RVD2_1(2) = 0.0
      RT_11 = EMTDC_XPI(0,0.9946,2.95e-005,0.0,10.0,RVD1_1,RVD2_1)

! 300:[hardlimit] Hard Limiter 
!  Hard_Limit
      RT_5 = LIMIT(0.0, 10.0, RT_11)
!

! 310:[sumjct] Summing/Differencing Junctions 
      RT_9 = + RT_5 - RT_8

! 320:[pi_ctlr] PI Controller \w Interpolation 
      RVD1_1 = RTCF(NRTCF)
      NRTCF = NRTCF + 1
      RVD2_1(1) = RT_9
      RVD2_1(2) = 0.0
      RT_2 = EMTDC_XPI(0,3.488,1.48e-005,0.0,3.3,RVD1_1,RVD2_1)

! 330:[compar] Two Input Comparator 
!
      CALL EMTDC_X2COMP(0,0,RT_2,RT_3,1.0,0.0,0.0,RVD2_1)
      RT_4 = RVD2_1(1)

! 340:[inv] Interpolated Logic Inverter 
      IF (NINT(RT_4) .NE. 0) THEN
         CLK = 0
      ELSE
         CLK = 1
      ENDIF

! 350:[compar] Two Input Comparator 
!
      CALL EMTDC_X2COMP(0,0,RT_13,RT_14,1.0,0.0,0.0,RVD2_1)
      S1a = NINT(RVD2_1(1))

! 360:[compar] Two Input Comparator 
!
      CALL EMTDC_X2COMP(0,0,RT_14,RT_15,1.0,0.0,0.0,RVD2_1)
      S2a = NINT(RVD2_1(1))

! 370:[logic_mult] Multiple Input Logic Gate 
!
! Multi input XOR gate
!
      IF ( (S1a .NE. 0) .NEQV. (CLK .NE. 0) ) THEN
        IT_2 = 1
      ELSE
        IT_2 = 0
      ENDIF

! 400:[logic_mult] Multiple Input Logic Gate 
!
! Multi input XOR gate
!
      IF ( (S2a .NE. 0) .NEQV. (CLK .NE. 0) ) THEN
        IT_1 = 1
      ELSE
        IT_1 = 0
      ENDIF

! 420:[compar] Two Input Comparator 
!
      CALL EMTDC_X2COMP(1,0,REAL(IT_2),RT_19,1.0,0.0,0.0,S4)

! 430:[compar] Two Input Comparator 
!
      CALL EMTDC_X2COMP(1,0,REAL(S2a),RT_17,1.0,0.0,0.0,S2)

! 440:[compar] Two Input Comparator 
!
      CALL EMTDC_X2COMP(1,0,REAL(IT_1),RT_18,1.0,0.0,0.0,S3)

! 450:[compar] Two Input Comparator 
!
      CALL EMTDC_X2COMP(1,0,REAL(S1a),RT_16,1.0,0.0,0.0,S1)

! 460:[pgb] Output Channel 'PIi'

      PGB(IPGB+6) = RT_2

! 470:[pgb] Output Channel 'PIv'

      PGB(IPGB+7) = RT_5

! 480:[peswitch] Power electronic switch 
! Power Electronic Switch Model: IGBT
      CALL COMPONENT_ID(ICALL_NO,847844730)
      CALL PESWITCH1_EXE(SS(1), (IBRCH(1)+15), NINT(S4(1)), S4(2))

! 490:[peswitch] Power electronic switch 
! Power Electronic Switch Model: IGBT
      CALL COMPONENT_ID(ICALL_NO,2000451045)
      CALL PESWITCH1_EXE(SS(1), (IBRCH(1)+17), NINT(S2(1)), S2(2))

! 500:[peswitch] Power electronic switch 
! Power Electronic Switch Model: IGBT
      CALL COMPONENT_ID(ICALL_NO,1939479375)
      CALL PESWITCH1_EXE(SS(1), (IBRCH(1)+13), NINT(S3(1)), S3(2))

! 510:[peswitch] Power electronic switch 
! Power Electronic Switch Model: IGBT
      CALL COMPONENT_ID(ICALL_NO,1246536179)
      CALL PESWITCH1_EXE(SS(1), (IBRCH(1)+11), NINT(S1(1)), S1(2))

! 1:[peswitch] Power electronic switch 
! Power Electronic Switch Model: Diode
      CALL COMPONENT_ID(ICALL_NO,1108536286)
      CALL PESWITCH1_EXE(SS(1), (IBRCH(1)+19), 1, 0.0)

! 1:[peswitch] Power electronic switch 
! Power Electronic Switch Model: Diode
      CALL COMPONENT_ID(ICALL_NO,175940598)
      CALL PESWITCH1_EXE(SS(1), (IBRCH(1)+23), 1, 0.0)

! 1:[source_1] Single Phase Voltage Source Model 2 'Source1'
!  DC source: Type: Ideal
      RVD1_1 = RTCF(NRTCF)
      RVD1_2 = RTCF(NRTCF+1)
      RVD1_3 = RTCF(NRTCF+2)
      RVD1_4 = RTCF(NRTCF+3)
      NRTCF = NRTCF + 4
      CALL EMTDC_1PVSRC(SS(1), (IBRCH(1)+5),RVD1_4,0,RVD1_1,RVD1_2,RVD1_&
     &3)

! 1:[peswitch] Power electronic switch 
! Power Electronic Switch Model: Diode
      CALL COMPONENT_ID(ICALL_NO,1776758656)
      CALL PESWITCH1_EXE(SS(1), (IBRCH(1)+24), 1, 0.0)

! 1:[xfmr-3w] Single Phase 3 Winding Transformer 
!  TRANSFORMER SATURATION SUBROUTINE
      CALL TSAT1_EXE( (IBRCH(1)+4),0,0,SS(1),1.0,0)
!

! 1:[source_1] Single Phase Voltage Source Model 2 'Source1'
!  Single Phase AC source: Type: Ideal
      RVD1_1 = RTCF(NRTCF)
      RVD1_2 = RTCF(NRTCF+1)
      RVD1_3 = RTCF(NRTCF+2)
      RVD1_4 = RTCF(NRTCF+3)
      NRTCF = NRTCF + 4
      CALL EMTDC_1PVSRC(SS(1), (IBRCH(1)+10),RVD1_4,1,RVD1_1,RVD1_2,RVD1&
     &_3)

! 1:[peswitch] Power electronic switch 
! Power Electronic Switch Model: Diode
      CALL COMPONENT_ID(ICALL_NO,577431945)
      CALL PESWITCH1_EXE(SS(1), (IBRCH(1)+26), 1, 0.0)

! 1:[peswitch] Power electronic switch 
! Power Electronic Switch Model: Diode
      CALL COMPONENT_ID(ICALL_NO,1547009214)
      CALL PESWITCH1_EXE(SS(1), (IBRCH(1)+25), 1, 0.0)

! 1:[peswitch] Power electronic switch 
! Power Electronic Switch Model: Diode
      CALL COMPONENT_ID(ICALL_NO,969245996)
      CALL PESWITCH1_EXE(SS(1), (IBRCH(1)+21), 1, 0.0)

!---------------------------------------
! Feedbacks and transfers to storage
!---------------------------------------

      STOF(ISTOF + 1) = RT_1
      STOF(ISTOF + 2) = RT_2
      STOF(ISTOF + 3) = RT_3
      STOF(ISTOF + 4) = RT_4
      STOF(ISTOF + 5) = RT_5
      STOI(ISTOI + 1) = S2a
      STOF(ISTOF + 6) = RT_6
      STOF(ISTOF + 7) = RT_7
      STOF(ISTOF + 8) = Iin
      STOI(ISTOI + 2) = S1a
      STOI(ISTOI + 3) = IT_1
      STOI(ISTOI + 4) = IT_2
      STOF(ISTOF + 9) = RT_8
      STOF(ISTOF + 10) = RT_9
      STOI(ISTOI + 5) = CLK
      STOF(ISTOF + 19) = Vin
      STOF(ISTOF + 20) = Iout
      STOF(ISTOF + 21) = Ia
      STOF(ISTOF + 22) = Vout
      STOF(ISTOF + 23) = Vsec
      STOF(ISTOF + 24) = I_out
      STOF(ISTOF + 25) = RT_10
      STOF(ISTOF + 26) = RT_11
      STOF(ISTOF + 27) = RT_12
      STOF(ISTOF + 28) = RT_13
      STOF(ISTOF + 29) = RT_14
      STOF(ISTOF + 30) = RT_15
      STOF(ISTOF + 31) = RT_16
      STOF(ISTOF + 32) = RT_17
      STOF(ISTOF + 33) = RT_18
      STOF(ISTOF + 34) = RT_19
      STOF(ISTOF + 35) = RT_20
      STOF(ISTOF + 36) = RT_21
      STOF(ISTOF + 37) = RT_22
      STOF(ISTOF + 66) = RT_27
      STOF(ISTOF + 97) = Vprim

! Array (1:2) quantities...
      DO IT_0 = 1,2
         STOF(ISTOF + 10 + IT_0) = S1(IT_0)
         STOF(ISTOF + 12 + IT_0) = S2(IT_0)
         STOF(ISTOF + 14 + IT_0) = S3(IT_0)
         STOF(ISTOF + 16 + IT_0) = S4(IT_0)
      END DO

! Array (1:7) quantities...
      DO IT_0 = 1,7
         STOF(ISTOF + 37 + IT_0) = RT_23(IT_0)
         STOF(ISTOF + 44 + IT_0) = RT_24(IT_0)
         STOF(ISTOF + 51 + IT_0) = RT_25(IT_0)
         STOF(ISTOF + 58 + IT_0) = RT_26(IT_0)
      END DO

! Array (1:15) quantities...
      DO IT_0 = 1,15
         STOF(ISTOF + 66 + IT_0) = RT_28(IT_0)
         STOF(ISTOF + 81 + IT_0) = RT_29(IT_0)
      END DO

!---------------------------------------
! Transfer to Exports
!---------------------------------------

!---------------------------------------
! Close Model Data read
!---------------------------------------

      IF ( TIMEZERO ) CALL EMTDC_CLOSEFILE
      RETURN
      END

!=======================================================================

      SUBROUTINE MainOut()

!---------------------------------------
! Standard includes
!---------------------------------------

      INCLUDE 'nd.h'
      INCLUDE 'emtconst.h'
      INCLUDE 'emtstor.h'
      INCLUDE 's0.h'
      INCLUDE 's1.h'
      INCLUDE 's2.h'
      INCLUDE 's4.h'
      INCLUDE 'branches.h'
      INCLUDE 'pscadv3.h'
      INCLUDE 'fnames.h'
      INCLUDE 'radiolinks.h'
      INCLUDE 'matlab.h'
      INCLUDE 'rtconfig.h'

!---------------------------------------
! Function/Subroutine Declarations
!---------------------------------------

      REAL    EMTDC_VVDC    ! 
!     SUBR    FTN180        ! FFT Calculation
      REAL    VBRANCH       ! Voltage across the branch

!---------------------------------------
! Variable Declarations
!---------------------------------------


! Electrical Node Indices
      INTEGER  NT_2, NT_3, NT_4, NT_6, NT_8
      INTEGER  NT_12

! Control Signals
      REAL     RT_1, RT_6, RT_7, Iin, RT_8, Vin
      REAL     Iout, Ia, Vout, Vsec, I_out, RT_20
      REAL     RT_21, RT_22, RT_23(7), RT_24(7)
      REAL     RT_25(7), RT_26(7), RT_27
      REAL     RT_28(15), RT_29(15), Vprim

! Internal Variables
      INTEGER  IVD1_1

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER ISTOL, ISTOI, ISTOF, ISTOC, IT_0    ! Storage Indices
      INTEGER IPGB                                ! Control/Monitoring
      INTEGER ISUBS, SS(1), IBRCH(1), INODE       ! SS/Node/Branch/Xfmr
      INTEGER IXFMR


!---------------------------------------
! Local Indices
!---------------------------------------

! Dsdyn <-> Dsout transfer index storage

      NTXFR = NTXFR + 1

      ISTOL = TXFR(NTXFR,1)
      ISTOI = TXFR(NTXFR,2)
      ISTOF = TXFR(NTXFR,3)
      ISTOC = TXFR(NTXFR,4)

! Increment and assign runtime configuration call indices

      ICALL_NO  = NCALL_NO
      NCALL_NO  = NCALL_NO + 1

! Increment global storage indices

      IPGB      = NPGB
      NPGB      = NPGB + 9
      INODE     = NNODE + 2
      NNODE     = NNODE + 14
      IXFMR     = NXFMR
      NXFMR     = NXFMR + 1

! Initialize Subsystem Mapping

      ISUBS = NSUBS + 0
      NSUBS = NSUBS + 1

      DO IT_0 = 1,1
         SS(IT_0) = SUBS(ISUBS + IT_0)
      END DO

! Initialize Branch Mapping.

      IBRCH(1)     = NBRCH(SS(1))
      NBRCH(SS(1)) = NBRCH(SS(1)) + 28
!---------------------------------------
! Transfers from storage arrays
!---------------------------------------

      RT_1     = STOF(ISTOF + 1)
      RT_6     = STOF(ISTOF + 6)
      RT_7     = STOF(ISTOF + 7)
      Iin      = STOF(ISTOF + 8)
      RT_8     = STOF(ISTOF + 9)
      Vin      = STOF(ISTOF + 19)
      Iout     = STOF(ISTOF + 20)
      Ia       = STOF(ISTOF + 21)
      Vout     = STOF(ISTOF + 22)
      Vsec     = STOF(ISTOF + 23)
      I_out    = STOF(ISTOF + 24)
      RT_20    = STOF(ISTOF + 35)
      RT_21    = STOF(ISTOF + 36)
      RT_22    = STOF(ISTOF + 37)
      RT_27    = STOF(ISTOF + 66)
      Vprim    = STOF(ISTOF + 97)

! Array (1:7) quantities...
      DO IT_0 = 1,7
         RT_23(IT_0) = STOF(ISTOF + 37 + IT_0)
         RT_24(IT_0) = STOF(ISTOF + 44 + IT_0)
         RT_25(IT_0) = STOF(ISTOF + 51 + IT_0)
         RT_26(IT_0) = STOF(ISTOF + 58 + IT_0)
      END DO

! Array (1:15) quantities...
      DO IT_0 = 1,15
         RT_28(IT_0) = STOF(ISTOF + 66 + IT_0)
         RT_29(IT_0) = STOF(ISTOF + 81 + IT_0)
      END DO

!---------------------------------------
! Electrical Node Lookup
!---------------------------------------

      NT_2  = NODE(INODE + 2)
      NT_3  = NODE(INODE + 3)
      NT_4  = NODE(INODE + 4)
      NT_6  = NODE(INODE + 6)
      NT_8  = NODE(INODE + 8)
      NT_12 = NODE(INODE + 11)

!---------------------------------------
! Configuration of Models
!---------------------------------------

      IF ( TIMEZERO ) THEN
         FILENAME = 'Main.dta'
         CALL EMTDC_OPENFILE
         SECTION = 'DATADSO:'
         CALL EMTDC_GOTOSECTION
      ENDIF
!---------------------------------------
! Generated code from module definition
!---------------------------------------


! 10:[ammeter] Current Meter 'Iin'
      Iin = ( CBR((IBRCH(1)+8), SS(1)))

! 20:[voltmeter] Voltmeter (Line - Line) 'Vsec'
      Vsec = EMTDC_VVDC(SS(1), NT_8, 0)

! 30:[ammeter] Current Meter 'Ia'
      Ia = ( CBR((IBRCH(1)+6), SS(1)))

! 40:[voltmeter] Voltmeter (Line - Line) 'Vin'
      Vin = EMTDC_VVDC(SS(1), NT_6, NT_3)

! 50:[ammeter] Current Meter 'Iout'
      Iout = (-CBR((IBRCH(1)+7), SS(1)))

! 60:[voltmeter] Voltmeter (Line - Line) 'Vprim'
      Vprim = EMTDC_VVDC(SS(1), NT_2, NT_12)

! 70:[ammeter] Current Meter 'I_out'
      I_out = ( CBR((IBRCH(1)+9), SS(1)))

! 80:[voltmeter] Voltmeter (Line - Line) 'Vout'
      Vout = EMTDC_VVDC(SS(1), NT_4, 0)

! 100:[pgb] Output Channel 'Iout'

      PGB(IPGB+1) = 1000.0 * I_out

! 110:[gain] Gain Block 
!  Gain
      RT_1 = 1000.0 * Vout

! 120:[pgb] Output Channel 'Vout'

      PGB(IPGB+2) = RT_1

! 130:[gain] Gain Block 
!  Gain
      RT_8 = 1000.0 * Iout

! 140:[pgb] Output Channel 'Iout'

      PGB(IPGB+3) = RT_8

! 230:[fft] On-Line Frequency Scanner 
      IVD1_1=0
      CALL FTN180(1,0,15,1,120.0,120.0,Vout,IVD1_1,RT_28,RT_29,RT_27)
!

! 240:[mult] Multiplier 
      RT_7 = Vout * Iout

! 250:[mult] Multiplier 
      RT_20 = Vin * Iin

! 260:[fft] On-Line Frequency Scanner 
      IVD1_1=0
      CALL FTN180(1,0,7,1,100.0,100.0,RT_20,IVD1_1,RT_23,RT_24,RT_6)
!

! 270:[pgb] Output Channel 'Iin'

      PGB(IPGB+4) = 1000.0 * Iin

! 380:[div] Divider 
!
      IF (ABS(RT_6) .LT. 1.0E-10) THEN
         IF (RT_6 .LT. 0.0)  THEN
            RT_21 = -1.0E10 * RT_7
         ELSE
            RT_21 =  1.0E10 * RT_7
         ENDIF
      ELSE
         RT_21 = RT_7 / RT_6
      ENDIF
!

! 390:[fft] On-Line Frequency Scanner 
      IVD1_1=0
      CALL FTN180(1,0,7,1,100.0,100.0,RT_21,IVD1_1,RT_25,RT_26,RT_22)
!

! 410:[pgb] Output Channel 'EficiÍncia'

      PGB(IPGB+5) = RT_22

! 520:[pgb] Output Channel 'Ia'

      PGB(IPGB+8) = 1000.0 * Ia

! 530:[pgb] Output Channel 'Vsec'

      PGB(IPGB+9) = 1000.0 * Vsec

!---------------------------------------
! Feedbacks and transfers to storage
!---------------------------------------

      STOF(ISTOF + 1) = RT_1
      STOF(ISTOF + 6) = RT_6
      STOF(ISTOF + 7) = RT_7
      STOF(ISTOF + 8) = Iin
      STOF(ISTOF + 9) = RT_8
      STOF(ISTOF + 19) = Vin
      STOF(ISTOF + 20) = Iout
      STOF(ISTOF + 21) = Ia
      STOF(ISTOF + 22) = Vout
      STOF(ISTOF + 23) = Vsec
      STOF(ISTOF + 24) = I_out
      STOF(ISTOF + 35) = RT_20
      STOF(ISTOF + 36) = RT_21
      STOF(ISTOF + 37) = RT_22
      STOF(ISTOF + 66) = RT_27
      STOF(ISTOF + 97) = Vprim

! Array (1:7) quantities...
      DO IT_0 = 1,7
         STOF(ISTOF + 37 + IT_0) = RT_23(IT_0)
         STOF(ISTOF + 44 + IT_0) = RT_24(IT_0)
         STOF(ISTOF + 51 + IT_0) = RT_25(IT_0)
         STOF(ISTOF + 58 + IT_0) = RT_26(IT_0)
      END DO

! Array (1:15) quantities...
      DO IT_0 = 1,15
         STOF(ISTOF + 66 + IT_0) = RT_28(IT_0)
         STOF(ISTOF + 81 + IT_0) = RT_29(IT_0)
      END DO

!---------------------------------------
! Close Model Data read
!---------------------------------------

      IF ( TIMEZERO ) CALL EMTDC_CLOSEFILE
      RETURN
      END

!=======================================================================

      SUBROUTINE MainDyn_Begin()

!---------------------------------------
! Standard includes
!---------------------------------------

      INCLUDE 'nd.h'
      INCLUDE 'emtconst.h'
      INCLUDE 's0.h'
      INCLUDE 's1.h'
      INCLUDE 's4.h'
      INCLUDE 'branches.h'
      INCLUDE 'pscadv3.h'
      INCLUDE 'rtconfig.h'

!---------------------------------------
! Function/Subroutine Declarations
!---------------------------------------


!---------------------------------------
! Variable Declarations
!---------------------------------------


! Subroutine Arguments

! Electrical Node Indices

! Control Signals
      REAL     RT_12, RT_13, RT_15, RT_16, RT_17
      REAL     RT_18, RT_19

! Internal Variables
      INTEGER  IVD1_1
      REAL     RVD1_1, RVD1_2, RVD1_3, RVD1_4

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER IT_0                                ! Storage Indices
      INTEGER ISUBS, SS(1), IBRCH(1), INODE       ! SS/Node/Branch/Xfmr
      INTEGER IXFMR


!---------------------------------------
! Local Indices
!---------------------------------------


! Increment and assign runtime configuration call indices

      ICALL_NO  = NCALL_NO
      NCALL_NO  = NCALL_NO + 1

! Increment global storage indices

      INODE     = NNODE + 2
      NNODE     = NNODE + 14
      IXFMR     = NXFMR
      NXFMR     = NXFMR + 1

! Initialize Subsystem Mapping

      ISUBS = NSUBS + 0
      NSUBS = NSUBS + 1

      DO IT_0 = 1,1
         SS(IT_0) = SUBS(ISUBS + IT_0)
      END DO

! Initialize Branch Mapping.

      IBRCH(1)     = NBRCH(SS(1))
      NBRCH(SS(1)) = NBRCH(SS(1)) + 28
!---------------------------------------
! Electrical Node Lookup
!---------------------------------------


!---------------------------------------
! Generated code from module definition
!---------------------------------------


! 90:[const] Real Constant 

! 150:[signalgen] Signal Generator /w Interpolation 
      CALL COMPONENT_ID(ICALL_NO,352787754)
      CALL E_XSGEN1_CFG(1,0.0,100.0,3.3,0.0)

! 160:[const] Real Constant 

! 170:[const] Real Constant 

! 180:[signalgen] Signal Generator /w Interpolation 
      CALL COMPONENT_ID(ICALL_NO,50234200)
      CALL E_XSGEN1_CFG(1,0.0,0.0,1.0,0.0)

! 190:[const] Real Constant 

! 200:[const] Real Constant 

! 210:[const] Real Constant 

! 220:[const] Real Constant 

! 280:[sumjct] Summing/Differencing Junctions 

! 290:[pi_ctlr] PI Controller \w Interpolation 
      RTCF(NRTCF) = 0.0
      NRTCF = NRTCF + 1

! 300:[hardlimit] Hard Limiter 

! 310:[sumjct] Summing/Differencing Junctions 

! 320:[pi_ctlr] PI Controller \w Interpolation 
      RTCF(NRTCF) = 0.0
      NRTCF = NRTCF + 1

! 330:[compar] Two Input Comparator 

! 340:[inv] Interpolated Logic Inverter 

! 350:[compar] Two Input Comparator 

! 360:[compar] Two Input Comparator 

! 420:[compar] Two Input Comparator 

! 430:[compar] Two Input Comparator 

! 440:[compar] Two Input Comparator 

! 450:[compar] Two Input Comparator 

! 460:[pgb] Output Channel 'PIi'

! 470:[pgb] Output Channel 'PIv'

! 480:[peswitch] Power electronic switch 
      CALL PESWITCH1_CFG(3, 0,0.0, 1.0e+012, 1.0e+012, 1.0e+012, 0.0, 0.&
     &0)
      CALL E_BRANCH_CFG( (IBRCH(1)+16),SS(1),1,0,1,5.0e+012,0.0,0.05)

! 490:[peswitch] Power electronic switch 
      CALL PESWITCH1_CFG(3, 0,0.0, 1.0e+012, 1.0e+012, 1.0e+012, 0.0, 0.&
     &0)
      CALL E_BRANCH_CFG( (IBRCH(1)+18),SS(1),1,0,1,5.0e+012,0.0,0.05)

! 500:[peswitch] Power electronic switch 
      CALL PESWITCH1_CFG(3, 0,0.0, 1.0e+012, 1.0e+012, 1.0e+012, 0.0, 0.&
     &0)
      CALL E_BRANCH_CFG( (IBRCH(1)+14),SS(1),1,0,1,5.0e+012,0.0,0.05)

! 510:[peswitch] Power electronic switch 
      CALL PESWITCH1_CFG(3, 0,0.0, 1.0e+012, 1.0e+012, 1.0e+012, 0.0, 0.&
     &0)
      CALL E_BRANCH_CFG( (IBRCH(1)+12),SS(1),1,0,1,5.0e+012,0.0,0.05)

! 1:[peswitch] Power electronic switch 
      CALL PESWITCH1_CFG(0, 0,0.01, 1.0e+012, 1.0e+012, 1.0e+012, 0.0, 0&
     &.0)
      CALL E_BRANCH_CFG( (IBRCH(1)+20),SS(1),1,0,1,5.0e+012,0.0,0.05)

! 1:[peswitch] Power electronic switch 
      CALL PESWITCH1_CFG(0, 0,0.01, 1.0e+012, 1.0e+012, 1.0e+012, 0.0, 0&
     &.0)

! 1:[source_1] Single Phase Voltage Source Model 2 'Source1'
      CALL E_1PVSRC_CFG(0,0,6,0.4,60.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0)

! 1:[peswitch] Power electronic switch 
      CALL PESWITCH1_CFG(0, 0,0.01, 1.0e+012, 1.0e+012, 1.0e+012, 0.0, 0&
     &.0)

! 1:[xfmr-3w] Single Phase 3 Winding Transformer 
      CALL COMPONENT_ID(ICALL_NO,1690817836)
      CALL E_TF3W_CFG((IXFMR + 1),1,100.0,100000.0,1.0e-006,1.0e-006,1.0&
     &e-006,0.0,0.4,0.08,0.08,0.4)
      IF (0.0 .LT. 0.001) THEN
        RVD1_1 = 0.0
        IVD1_1 = 0
      ELSE
        RVD1_4 = 0.0
        RVD1_1 = 3.0/(100.0*RVD1_4)
        IVD1_1 = 1
      ENDIF
      RVD1_2 = RVD1_1*0.4*0.4
      RVD1_3 = RVD1_1*0.08*0.08
      RVD1_4 = RVD1_1*0.08*0.08
      CALL E_BRANCH_CFG( (IBRCH(1)+1),SS(1),IVD1_1,0,0,RVD1_2,0.0,0.0)
      CALL E_BRANCH_CFG( (IBRCH(1)+2),SS(1),IVD1_1,0,0,RVD1_3,0.0,0.0)
      CALL E_BRANCH_CFG( (IBRCH(1)+3),SS(1),IVD1_1,0,0,RVD1_4,0.0,0.0)
      CALL TSAT1_CFG( (IBRCH(1)+4),0,0,SS(1),100.0,0.4,0.2,1.17,100000.0&
     &,0.0,0.4,0.0)

! 1:[source_1] Single Phase Voltage Source Model 2 'Source1'
      CALL E_1PVSRC_CFG(1,0,6,0.0005,120.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0)

! 1:[peswitch] Power electronic switch 
      CALL PESWITCH1_CFG(0, 0,0.01, 1.0e+012, 1.0e+012, 1.0e+012, 0.0, 0&
     &.0)

! 1:[peswitch] Power electronic switch 
      CALL PESWITCH1_CFG(0, 0,0.01, 1.0e+012, 1.0e+012, 1.0e+012, 0.0, 0&
     &.0)

! 1:[peswitch] Power electronic switch 
      CALL PESWITCH1_CFG(0, 0,0.01, 1.0e+012, 1.0e+012, 1.0e+012, 0.0, 0&
     &.0)
      CALL E_BRANCH_CFG( (IBRCH(1)+22),SS(1),1,0,1,5.0e+012,0.0,0.05)

      RETURN
      END

!=======================================================================

      SUBROUTINE MainOut_Begin()

!---------------------------------------
! Standard includes
!---------------------------------------

      INCLUDE 'nd.h'
      INCLUDE 'emtconst.h'
      INCLUDE 's0.h'
      INCLUDE 's1.h'
      INCLUDE 's4.h'
      INCLUDE 'branches.h'
      INCLUDE 'pscadv3.h'
      INCLUDE 'rtconfig.h'

!---------------------------------------
! Function/Subroutine Declarations
!---------------------------------------


!---------------------------------------
! Variable Declarations
!---------------------------------------


! Subroutine Arguments

! Electrical Node Indices
      INTEGER  NT_2, NT_3, NT_4, NT_6, NT_8
      INTEGER  NT_12

! Control Signals

! Internal Variables

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER IT_0                                ! Storage Indices
      INTEGER ISUBS, SS(1), IBRCH(1), INODE       ! SS/Node/Branch/Xfmr
      INTEGER IXFMR


!---------------------------------------
! Local Indices
!---------------------------------------


! Increment and assign runtime configuration call indices

      ICALL_NO  = NCALL_NO
      NCALL_NO  = NCALL_NO + 1

! Increment global storage indices

      INODE     = NNODE + 2
      NNODE     = NNODE + 14
      IXFMR     = NXFMR
      NXFMR     = NXFMR + 1

! Initialize Subsystem Mapping

      ISUBS = NSUBS + 0
      NSUBS = NSUBS + 1

      DO IT_0 = 1,1
         SS(IT_0) = SUBS(ISUBS + IT_0)
      END DO

! Initialize Branch Mapping.

      IBRCH(1)     = NBRCH(SS(1))
      NBRCH(SS(1)) = NBRCH(SS(1)) + 28
!---------------------------------------
! Electrical Node Lookup
!---------------------------------------

      NT_2  = NODE(INODE + 2)
      NT_3  = NODE(INODE + 3)
      NT_4  = NODE(INODE + 4)
      NT_6  = NODE(INODE + 6)
      NT_8  = NODE(INODE + 8)
      NT_12 = NODE(INODE + 11)

!---------------------------------------
! Generated code from module definition
!---------------------------------------


! 100:[pgb] Output Channel 'Iout'

! 110:[gain] Gain Block 

! 120:[pgb] Output Channel 'Vout'

! 130:[gain] Gain Block 

! 140:[pgb] Output Channel 'Iout'

! 230:[fft] On-Line Frequency Scanner 

! 240:[mult] Multiplier 

! 250:[mult] Multiplier 

! 260:[fft] On-Line Frequency Scanner 

! 270:[pgb] Output Channel 'Iin'

! 380:[div] Divider 

! 390:[fft] On-Line Frequency Scanner 

! 410:[pgb] Output Channel 'EficiÍncia'

! 520:[pgb] Output Channel 'Ia'

! 530:[pgb] Output Channel 'Vsec'

      RETURN
      END

