import '../config/app_environment.dart';

class ApiEndpoints {
  ApiEndpoints._();

  // =========================================================
  // BASE URL
  // =========================================================

  static String get baseUrl {
    return AppEnvironmentConfig.baseUrl;
  }

  // =========================================================
  // API BASE URL
  // =========================================================

  static String get apiBaseUrl {
    return '$baseUrl/api';
  }

  // =========================================================
  // AUTH
  // =========================================================

  static String get login {
    return '$apiBaseUrl/sessions';
  }

  static String get logout {
    return '$apiBaseUrl/sessions';
  }

  // =========================================================
  // USER / PROFILE
  // =========================================================

  static String get users {
    return '$apiBaseUrl/users';
  }

  // =========================================================
  // CART
  // =========================================================

  static String get cart {
    return '$apiBaseUrl/cart';
  }

  // =========================================================
  // CONFIGURATIONS
  // =========================================================

  static String get configurations {
    return '$apiBaseUrl/configurations';
  }

  // =========================================================
  // ORDERS
  // =========================================================

  static String get orders {
    return '$apiBaseUrl/orders';
  }

  static String get userOrders {
    return '$apiBaseUrl/user_orders';
  }

  // =========================================================
  // PRODUCT CONFIGURATION ENDPOINTS
  // =========================================================

  // ---------------------------------------------------------
  // MIGHTY LUBE CC5 CHAIN LUBRICATOR
  // Product ID: CC5_CL
  // POST /api/cc5_cl
  // ---------------------------------------------------------

  static String get cc5ChainLubricator {
    return '$apiBaseUrl/cc5_cl';
  }

  // ---------------------------------------------------------
  // CC5 OP-40E
  // Product ID: CC5_OP40E
  // POST /api/cc5_op40e
  // ---------------------------------------------------------

  static String get cc5Op40e {
    return '$apiBaseUrl/cc5_op40e';
  }

  // ---------------------------------------------------------
  // CATERPILLAR DRIVE LUBRICATORS
  // Product ID: COE_CDL
  // POST /api/coe_cdl
  // ---------------------------------------------------------

  static String get caterpillarDriveLubricators {
    return '$apiBaseUrl/coe_cdl';
  }

  // ---------------------------------------------------------
  // MIGHTY LUBE CHAIN ON EDGE LUBRICATOR
  // Product ID: COE_CEL
  // POST /api/coe_cel
  // ---------------------------------------------------------

  static String get mightyLubeChainOnEdgeLubricator {
    return '$apiBaseUrl/coe_cel';
  }

  // ---------------------------------------------------------
  // CATERPILLAR DRIVE OP-40E
  // Product ID: COE_OP4OE
  // POST /api/coe_op4oe
  // ---------------------------------------------------------

  static String get caterpillarOp40e {
    return '$apiBaseUrl/coe_op4oe';
  }

  // ---------------------------------------------------------
  // ETIPO - OVERHEAD NON-POWERED MIGHTY LUBE
  // RAIL CLEANERS UN91 / RW91
  //
  // Product ID: ETI_91
  // POST /api/eti_91
  // ---------------------------------------------------------

  static String get etipoUn91 {
    return '$apiBaseUrl/eti_91';
  }

  // ---------------------------------------------------------
  // ETIPO - OVERHEAD NON-POWERED MIGHTY LUBE
  // CHAIN CLEANERS 8074-B / 8075-B
  //
  // Product ID: ETI_807
  // POST /api/eti_807
  // ---------------------------------------------------------

  static String get etipo8074 {
    return '$apiBaseUrl/eti_807';
  }

  // ---------------------------------------------------------
  // ETIPO - 9000INVL INVERTED SERIES
  // ENCLOSED TRACK CONVEYOR LUBRICATORS
  //
  // Product ID: ETI_9000INVL
  // POST /api/eti_9000invl
  // ---------------------------------------------------------

  static String get etipo9000Invl {
    return '$apiBaseUrl/eti_9000invl';
  }

  // ---------------------------------------------------------
  // ETIPO - OP-48E
  // ENCLOSED TRACK INVERTED CONVEYOR LUBRICATORS
  //
  // Product ID: ETI_OP48E
  // POST /api/eti_op48e
  // ---------------------------------------------------------

  static String get etipoOp48e {
    return '$apiBaseUrl/eti_op48e';
  }

  // ---------------------------------------------------------
  // ETIPO - OP-41A
  // Enclosed Track Inverted Conveyor Lubricators
  //
  // Product ID: ETI_OP41A
  // POST /api/eti_op41a
  // ---------------------------------------------------------

  static String get etipoOp41a {
    return '$apiBaseUrl/eti_op41a';
  }

  static String get etiMlaio {
    return '$apiBaseUrl/eti_mlaio';
  }

  // ---------------------------------------------------------
  // ETOPO - 2100L SERIES SELF-CONTAINED
  // CONVEYOR LUBRICATORS
  //
  // Product ID: ETO_2100
  // POST /api/eto_2100
  // ---------------------------------------------------------

  static String get etopo2100L {
    return '$apiBaseUrl/eto_2100';
  }

  // ---------------------------------------------------------
  // ETOPO - 9000L SERIES
  // ENCLOSED TRACK CONVEYOR LUBRICATORS
  //
  // Product ID: ETO_9000E
  // POST /api/eto_9000e
  // ---------------------------------------------------------

  static String get etopo9000L {
    return '$apiBaseUrl/eto_9000e';
  }

  // ---------------------------------------------------------
  // ETOPO - OP-48E
  // ENCLOSED TRACK OVERHEAD CONVEYOR LUBRICATORS
  //
  // Product ID: ETO_OP48E
  // POST /api/eto_op48e
  // ---------------------------------------------------------

  static String get etopoOp48e {
    return '$apiBaseUrl/eto_op48e';
  }

  static String get etopoOp41a {
    return '$apiBaseUrl/eto_op41a';
  }

  // ---------------------------------------------------------
  // ETOPO - PORTABLE (MULTI-LINE)
  // MIGHTY LUBE MONITORING SYSTEM
  //
  // Product ID: ETO_PMLMS
  // POST /api/eto_pmlms
  // ---------------------------------------------------------

  static String get etopoPmlms {
    return '$apiBaseUrl/eto_pmlms';
  }

  // ---------------------------------------------------------
  // ETOPO - MULTI LINE (PERMANENT)
  // ALL IN ONE MONITORING + LUBRICATION
  //
  // Product ID: ETO_MLAIO
  // POST /api/eto_mlaio
  // ---------------------------------------------------------

  static String get etopoMlaio {
    return '$apiBaseUrl/eto_mlaio';
  }

  // ---------------------------------------------------------
  // FREE CARRIER - FREE RAIL 314 "LOAD" WHEEL GREASER
  //
  // Product ID: FC_314
  // POST /api/fc_314
  // ---------------------------------------------------------

  static String get freeCarrier314 {
    return '$apiBaseUrl/fc_314';
  }

  // ---------------------------------------------------------
  // FREE CARRIER - FREE RAIL 317 "GUIDE" WHEEL GREASER
  //
  // Product ID: FC_317
  // POST /api/fc_317
  // ---------------------------------------------------------

  static String get freeCarrier317 {
    return '$apiBaseUrl/fc_317';
  }

  // ---------------------------------------------------------
  // FLAT TOP - OPCO 300 SERIES
  // AUTOMATIC SEALED WHEEL LUBRICATOR
  //
  // Product ID: FT_OPCO
  // POST /api/ft_opco
  // ---------------------------------------------------------

  static String get flatTopOpco300 {
    return '$apiBaseUrl/ft_opco';
  }

  // ---------------------------------------------------------
  // FLAT TOP - MIGHTY LUBE FLAT TOP LUBRICATOR
  //
  // Product ID: FT_MLCEL
  // POST /api/ft_mlcel
  // ---------------------------------------------------------

  static String get flatTopMightyLubeLubricator {
    return '$apiBaseUrl/ft_mlcel';
  }

  static String get flatTopCdl {
    return '$apiBaseUrl/ft_cdl';
  }

  // ---------------------------------------------------------
  // FLAT TOP - OP-40E
  // Product ID: FT_OP40E
  // POST /api/ft_op40e
  // ---------------------------------------------------------

  static String get flatTopOp40e {
    return '$apiBaseUrl/ft_op40e';
  }

  // ---------------------------------------------------------
  // C CHANNEL OVERHEAD OR INVERTED
  // OVERSPRAY ELIMINATOR BRUSH
  //
  // Product ID: FRO_OEB
  // POST /api/fro_oeb
  // ---------------------------------------------------------

  static String get cChannelOversprayEliminatorBrush {
    return '$apiBaseUrl/fro_oeb';
  }

  // ---------------------------------------------------------
  // C CHANNEL OVERHEAD OR INVERTED
  // FREE RAIL 314 "LOAD" WHEEL GREASER
  //
  // Product ID: FRO_314
  // POST /api/fro_314
  // ---------------------------------------------------------

  static String get cChannelFreeRail314 {
    return '$apiBaseUrl/fro_314';
  }

  // ---------------------------------------------------------
  // C CHANNEL OVERHEAD OR INVERTED
  // FREE RAIL 317 "GUIDE" WHEEL GREASER
  //
  // Product ID: FRO_317
  // POST /api/fro_317
  // ---------------------------------------------------------

  static String get cChannelFreeRail317 {
    return '$apiBaseUrl/fro_317';
  }

  // ---------------------------------------------------------
  // C CHANNEL OVERHEAD OR INVERTED
  // 9000L SERIES CENTRAL SYSTEM FREE CARRIER
  // CONVEYOR LUBRICATORS
  //
  // Product ID: 9000L
  // Backend Route/Model: FRO_9000F
  // POST /api/fro_9000f
  // ---------------------------------------------------------

  static String get cChannel9000LSeries {
    return '$apiBaseUrl/fro_9000f';
  }

  // ---------------------------------------------------------
  // C CHANNEL OVERHEAD OR INVERTED
  // E-SERIES
  //
  // Product ID: FRO_ES
  // POST /api/fro_es
  // ---------------------------------------------------------

  static String get cChannelESeries {
    return '$apiBaseUrl/fro_es';
  }

  // ---------------------------------------------------------
  // C CHANNEL OVERHEAD OR INVERTED
  // OP-139A
  //
  // Product ID: FRO_OP139A
  // POST /api/fro_op139a
  // ---------------------------------------------------------

  static String get cChannelOp139A {
    return '$apiBaseUrl/fro_op139a';
  }

  // ---------------------------------------------------------
  // IN FLOOR TOW LINE
  // MIGHTY LUBE IN FLOOR TOW LINE
  //
  // Product ID: IFT_IFTL
  // POST /api/ift_iftl
  // ---------------------------------------------------------

  static String get inFloorTowLineMightyLube {
    return '$apiBaseUrl/ift_iftl';
  }

  // ---------------------------------------------------------
  // IN FLOOR TOW LINE
  // OP-40E
  //
  // Product ID: IFT_OP4OE
  // POST /api/ift_op4oe
  // ---------------------------------------------------------

  static String get inFloorTowLineOp40e {
    return '$apiBaseUrl/ift_op4oe';
  }

  // ---------------------------------------------------------
  // IN-BOARD ROLLER CHAIN
  // MIGHTY LUBE ROLLER FLIGHT CONVEYOR
  //
  // Product ID: IBR_RFC
  // POST /api/ibr_rfc
  // ---------------------------------------------------------

  static String get inBoardRollerChainMightyLubeRollerFlightConveyor {
    return '$apiBaseUrl/ibr_rfc';
  }

  // ---------------------------------------------------------
  // IN-BOARD ROLLER CHAIN
  // OP-40E
  //
  // Product ID: IBR_OP4OE
  // POST /api/ibr_op4oe
  // ---------------------------------------------------------

  static String get inBoardRollerChainOp40e {
    return '$apiBaseUrl/ibr_op4oe';
  }

  // ---------------------------------------------------------
// IN-BOARD ROLLER CHAIN
// OPCO 300 SERIES AUTOMATIC SEALED WHEEL LUBRICATOR
//
// Product ID: IBRC_300
// POST /api/ibrc_300
// ---------------------------------------------------------

  static String get inBoardRollerChain300 {
    return '$apiBaseUrl/ibrc_300';
  }

  // ---------------------------------------------------------
  // OVER HEAD POWER RAIL L-BEAM
  // I-BEAM CONVEYOR BEAM SWEEP
  //
  // Product ID: OH_CCS_IBEAM
  // POST /api/oh_ccs_ibeam
  // ---------------------------------------------------------

  static String get overheadIBeamConveyorBeamSweep {
    return '$apiBaseUrl/oh_ccs_ibeam';
  }

  // ---------------------------------------------------------
  // OVER HEAD POWER RAIL L-BEAM
  // OP-13 SANITARY HOOK CLEANER
  //
  // Product ID: OH_CCS_OP13
  // POST /api/oh_ccs_op13
  // ---------------------------------------------------------

  static String get overheadOp13SanitaryHookCleaner {
    return '$apiBaseUrl/oh_ccs_op13';
  }

  // ---------------------------------------------------------
  // OVER HEAD POWER RAIL L-BEAM
  // OVERSPRAY ELIMINATOR BRUSH
  //
  // Product ID: OH_CCS_BRUSH
  // POST /api/oh_ccs_brush
  // ---------------------------------------------------------

  static String get overheadOversprayEliminatorBrush {
    return '$apiBaseUrl/oh_ccs_brush';
  }

  // ---------------------------------------------------------
  // OVER HEAD POWER RAIL L-BEAM
  // NON-POWERED MIGHTY LUBE BRUSH CLEANERS 300I / 400I / 600I
  //
  // Product ID: OH_CCS_3000
  // POST /api/oh_ccs_3000
  // ---------------------------------------------------------

  static String get overheadNonPoweredBrushCleaners300i400i600i {
    return '$apiBaseUrl/oh_ccs_3000';
  }

  // ---------------------------------------------------------
  // OVER HEAD POWER RAIL L-BEAM
  // OP-8 POWER BRUSH CLEANING SYSTEM
  // CONVEYOR CHAIN & TROLLEY WHEEL CLEANER
  //
  // Product ID: OH_CCS_OP8
  // POST /api/oh_ccs_op8
  // ---------------------------------------------------------

  static String get overheadOp8PowerBrushCleaningSystem {
    return '$apiBaseUrl/oh_ccs_op8';
  }

  // ---------------------------------------------------------
  // OVER HEAD POWER RAIL L-BEAM
  // OP-8NP NON-POWER BRUSH CLEANING SYSTEM
  // I-BEAM CONVEYOR CHAIN CLEANER
  //
  // Product ID: OH_CCS_OP8NP
  // POST /api/oh_ccs_op8np
  // ---------------------------------------------------------

  static String get overheadOp8npNonPowerBrushCleaningSystem {
    return '$apiBaseUrl/oh_ccs_op8np';
  }

  // ---------------------------------------------------------
  // OVER HEAD POWER RAIL L-BEAM
  // OP-55
  //
  // Product ID: OH_CCS_O55
  // POST /api/oh_ccs_o55
  // ---------------------------------------------------------

  static String get overheadOp55 {
    return '$apiBaseUrl/oh_ccs_o55';
  }

  // ---------------------------------------------------------
  // OVER HEAD POWER RAIL L-BEAM
  // YOKE CLEANING BRUSH
  //
  // Product ID: OH_CCS_CLEANING_BRUSH
  // POST /api/oh_ccs_cleaning_brush
  // ---------------------------------------------------------

  static String get overheadYokeCleaningBrush {
    return '$apiBaseUrl/oh_ccs_cleaning_brush';
  }

  // ---------------------------------------------------------
  // GREASER POWER CHAIN
  //
  // Product ID: OHP_GPC
  // POST /api/ohp_gpc
  // ---------------------------------------------------------

  static String get overheadGreaserPowerChain {
    return '$apiBaseUrl/ohp_gpc';
  }

  // ---------------------------------------------------------
  // 2100L SERIES SELF-CONTAINED I-BEAM CONVEYOR LUBRICATORS
  //
  // Product ID: OHP_2100I
  // POST /api/ohp_2100i
  // ---------------------------------------------------------

  static String get overhead2100LSelfContainedIBeamConveyorLubricators {
    return '$apiBaseUrl/ohp_2100i';
  }

  // ---------------------------------------------------------
  // 9000L SERIES CENTRAL SYSTEM I-BEAM CONVEYOR LUBRICATORS
  //
  // Product ID: OHP_9000I
  // POST /api/ohp_9000i
  // ---------------------------------------------------------

  static String get overhead9000LCentralSystemIBeamConveyorLubricators {
    return '$apiBaseUrl/ohp_9000i';
  }


  static String get overhead9125_9126CaterpillarDrive {
    return '$apiBaseUrl/ohp_cdl';
  }

  // ---------------------------------------------------------
  // E-SERIES
  //
  // Product ID: OHP_ES
  // POST /api/ohp_es
  // ---------------------------------------------------------

  static String get overheadESeries {
    return '$apiBaseUrl/ohp_es';
  }

  static String get overheadOp4A {
    return '$apiBaseUrl/ohp_op4a';
  }

  static String get overheadOp52 {
    return '$apiBaseUrl/ohp_op52';
  }

  static String get overheadOp139A {
    return '$apiBaseUrl/ohp_op139a';
  }

  static String get overheadMlp {
    return '$apiBaseUrl/ohp_mlp';
  }

  static String get overheadPml {
    return '$apiBaseUrl/ohp_pml';
  }

  static String get overhead001 {
    return '$apiBaseUrl/ohp_001';
  }

  static String get overheadPmm {
    return '$apiBaseUrl/ohp_pmm';
  }


  // ---------------------------------------------------------
  // POWER AND FREE OVERHEAD OR INVERTED
  // NON-POWERED MIGHTY LUBE BRUSH CLEANERS 300I / 400I / 600I
  //
  // Product ID: PFO_CCS_300I
  // POST /api/pfo_ccs_300i
  // ---------------------------------------------------------

  static String get pfoNonPoweredBrushCleaners300i400i600i {
    return '$apiBaseUrl/pfo_ccs_300i';
  }

  // ---------------------------------------------------------
  // POWER AND FREE OVERHEAD OR INVERTED
  // OP-8 POWER BRUSH CLEANING SYSTEM
  // CONVEYOR CHAIN & TROLLEY WHEEL CLEANER
  //
  // Product ID: PFO_CCS_OP8
  // POST /api/pfo_ccs_op8
  // ---------------------------------------------------------

  static String get pfoOp8PowerBrushCleaningSystem {
    return '$apiBaseUrl/pfo_ccs_op8';
  }

  // ---------------------------------------------------------
  // POWER AND FREE OVERHEAD OR INVERTED
  // OP-8NP NON-POWER BRUSH CLEANING SYSTEM
  //
  // Product ID: PFO_CCS_OP8NP
  // POST /api/pfo_ccs_op8np
  // ---------------------------------------------------------

  static String get pfoOp8npNonPowerBrushCleaningSystem {
    return '$apiBaseUrl/pfo_ccs_op8np';
  }

  // ---------------------------------------------------------
  // POWER AND FREE OVERHEAD OR INVERTED
  // FREE RAIL 314 "LOAD" WHEEL GREASER
  //
  // Product ID: PFO_CGS_FR314
  // POST /api/pfo_cgs_fr314
  // ---------------------------------------------------------

  static String get pfoFreeRail314LoadWheelGreaser {
    return '$apiBaseUrl/pfo_cgs_fr314';
  }
// =========================================================
// FUTURE PRODUCT ENDPOINTS
// =========================================================
}