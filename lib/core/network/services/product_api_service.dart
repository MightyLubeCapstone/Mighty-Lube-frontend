import '../api_client.dart';
import '../api_endpoints.dart';
import '../api_response.dart';

class ProductApiService {
  ProductApiService._();

  // =========================================================
  // ADD PRODUCT TO CONFIGURATOR
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> addOrder({
    required String productId,
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    switch (productId) {
    // -------------------------------------------------------
    // MIGHTY LUBE CC5 CHAIN LUBRICATOR
    // -------------------------------------------------------

      case 'CC5_CL':
        return _addCC5ChainLubricator(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // CC5 OP-40E
    // -------------------------------------------------------

      case 'CC5_OP40E':
        return _addCC5Op40e(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // CATERPILLAR DRIVE LUBRICATORS
    // -------------------------------------------------------

      case 'COE_CDL':
        return _addCaterpillarDriveLubricators(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // MIGHTY LUBE CHAIN ON EDGE LUBRICATOR
    // -------------------------------------------------------

      case 'COE_CEL':
        return _addMightyLubeChainOnEdgeLubricator(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // CATERPILLAR DRIVE OP-40E
    // -------------------------------------------------------

      case 'COE_OP4OE':
        return _addCaterpillarOp40e(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETIPO UN91 / RW91
    // -------------------------------------------------------

      case 'ETI_91':
        return _addEtipoUn91(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETIPO 8074-B / 8075-B
    // -------------------------------------------------------

      case 'ETI_807':
        return _addEtipo8074(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETIPO 9000INVL
    // -------------------------------------------------------

      case 'ETI_9000INVL':
        return _addEtipo9000Invl(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETIPO OP-48E
    // -------------------------------------------------------

      case 'ETI_OP48E':
        return _addEtipoOp48e(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETIPO OP-41A
    // -------------------------------------------------------

      case 'ETI_OP41A':
        return _addEtipoOp41a(
          configuration: configuration,
          quantity: quantity,
        );


      case 'ETI_MLAIO':
        return _addEtiMlaio(
          configuration: configuration,
          quantity: quantity,
        );
    // -------------------------------------------------------
    // ETOPO 2100L
    // -------------------------------------------------------

      case 'ETO_2100':
        return _addEtopo2100L(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETOPO 9000L
    // -------------------------------------------------------

      case 'ETO_9000E':
        return _addEtopo9000L(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETOPO OP-48E
    // -------------------------------------------------------

      case 'ETO_OP48E':
        return _addEtopoOp48e(
          configuration: configuration,
          quantity: quantity,
        );

      case 'ETO_OP41A':
        return _addEtopoOp41a(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETOPO PORTABLE MULTI-LINE MONITORING SYSTEM
    // -------------------------------------------------------

      case 'ETO_PMLMS':
        return _addEtopoPmlms(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // ETOPO MULTI LINE ALL IN ONE MONITORING + LUBRICATION
    // -------------------------------------------------------

      case 'ETO_MLAIO':
        return _addEtopoMlaio(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // FREE CARRIER - FREE RAIL 314 "LOAD" WHEEL GREASER
    // -------------------------------------------------------

      case 'FC_314':
        return _addFreeCarrier314(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // FREE CARRIER - FREE RAIL 317 "GUIDE" WHEEL GREASER
    // -------------------------------------------------------

      case 'FC_317':
        return _addFreeCarrier317(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // FLAT TOP OPCO 300
    // -------------------------------------------------------

      case 'FT_OPCO':
        return _addFlatTopOpco300(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // MIGHTY LUBE FLAT TOP LUBRICATOR
    // -------------------------------------------------------

      case 'FT_MLCEL':
        return _addFlatTopMightyLubeLubricator(
          configuration: configuration,
          quantity: quantity,
        );


    // -------------------------------------------------------
// FLAT TOP - CATERPILLAR DRIVE LUBRICATORS
// Product ID: FT_CDL
// POST /api/ft_cdl
// -------------------------------------------------------

      case 'FT_CDL':
        return _addFlatTopCaterpillarDriveLubricators(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // FLAT TOP OP-40E
    // -------------------------------------------------------

      case 'FT_OP40E':
        return _addFlatTopOp40e(
          configuration: configuration,
          quantity: quantity,
        );


    // -------------------------------------------------------
    // C CHANNEL - OVERSPRAY ELIMINATOR BRUSH
    // -------------------------------------------------------

      case 'FRO_OEB':
        return _addCChannelOversprayEliminatorBrush(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // C CHANNEL - FREE RAIL 314 "LOAD" WHEEL GREASER
    // -------------------------------------------------------

      case 'FRO_314':
        return _addCChannelFreeRail314(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // C CHANNEL - FREE RAIL 317 "GUIDE" WHEEL GREASER
    // -------------------------------------------------------

      case 'FRO_317':
        return _addCChannelFreeRail317(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // C CHANNEL - 9000L SERIES CENTRAL SYSTEM
    // FREE CARRIER CONVEYOR LUBRICATORS
    // -------------------------------------------------------

      case '9000L':
        return _addCChannel9000LSeries(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // C CHANNEL - E-SERIES
    // -------------------------------------------------------

      case 'FRO_ES':
        return _addCChannelESeries(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // C CHANNEL - OP-139A
    // -------------------------------------------------------

      case 'FRO_OP139A':
        return _addCChannelOp139A(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // IN FLOOR TOW LINE - MIGHTY LUBE IN FLOOR TOW LINE
    // -------------------------------------------------------

      case 'IFT_IFTL':
        return _addInFloorTowLineMightyLube(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // IN FLOOR TOW LINE - OP-40E
    // Product ID: IFT_OP4OE
    // -------------------------------------------------------

      case 'IFT_OP4OE':
        return _addInFloorTowLineOp40e(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // IN-BOARD ROLLER CHAIN
    // MIGHTY LUBE ROLLER FLIGHT CONVEYOR
    // Product ID: IBR_RFC
    // -------------------------------------------------------

      case 'IBR_RFC':
        return _addInBoardRollerChainMightyLubeRollerFlightConveyor(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // IN-BOARD ROLLER CHAIN
    // OP-40E
    // Product ID: IBR_OP4OE
    // -------------------------------------------------------

      case 'IBR_OP4OE':
        return _addInBoardRollerChainOp40e(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
// IN-BOARD ROLLER CHAIN
// OPCO 300 SERIES AUTOMATIC SEALED WHEEL LUBRICATOR
// Product ID: IBRC_300
// POST /api/ibrc_300
// -------------------------------------------------------

      case 'IBRC_300':
        return _addInBoardRollerChain300(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // OVER HEAD POWER RAIL L-BEAM
    // I-BEAM CONVEYOR BEAM SWEEP
    // Product ID: OH_CCS_IBEAM
    // -------------------------------------------------------

      case 'OH_CCS_IBEAM':
        return _addOverheadIBeamConveyorBeamSweep(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // OVER HEAD POWER RAIL L-BEAM
    // OP-13 SANITARY HOOK CLEANER
    // Product ID: OH_CCS_OP13
    // -------------------------------------------------------

      case 'OH_CCS_OP13':
        return _addOverheadOp13SanitaryHookCleaner(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // OVER HEAD POWER RAIL L-BEAM
    // OVERSPRAY ELIMINATOR BRUSH
    // Product ID: OH_CCS_BRUSH
    // -------------------------------------------------------

      case 'OH_CCS_BRUSH':
        return _addOverheadOversprayEliminatorBrush(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // OVER HEAD POWER RAIL L-BEAM
    // NON-POWERED MIGHTY LUBE BRUSH CLEANERS 300I / 400I / 600I
    // Product ID: OH_CCS_3000
    // -------------------------------------------------------

      case 'OH_CCS_3000':
        return _addOverheadNonPoweredBrushCleaners300i400i600i(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // OVER HEAD POWER RAIL L-BEAM
    // OP-8 POWER BRUSH CLEANING SYSTEM
    // CONVEYOR CHAIN & TROLLEY WHEEL CLEANER
    // Product ID: OH_CCS_OP8
    // -------------------------------------------------------

      case 'OH_CCS_OP8':
        return _addOverheadOp8PowerBrushCleaningSystem(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // OVER HEAD POWER RAIL L-BEAM
    // OP-8NP NON-POWER BRUSH CLEANING SYSTEM
    // I-BEAM CONVEYOR CHAIN CLEANER
    // Product ID: OH_CCS_OP8NP
    // -------------------------------------------------------

      case 'OH_CCS_OP8NP':
        return _addOverheadOp8npNonPowerBrushCleaningSystem(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // OVER HEAD POWER RAIL L-BEAM
    // OP-55
    // Product ID: OH_CCS_O55
    // -------------------------------------------------------

      case 'OH_CCS_O55':
        return _addOverheadOp55(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // OVER HEAD POWER RAIL L-BEAM
    // YOKE CLEANING BRUSH
    // Product ID: OH_CCS_CLEANING_BRUSH
    // -------------------------------------------------------

      case 'OH_CCS_CLEANING_BRUSH':
        return _addOverheadYokeCleaningBrush(
          configuration: configuration,
          quantity: quantity,
        );


    // -------------------------------------------------------
    // GREASER POWER CHAIN
    // Product ID: OHP_GPC
    // -------------------------------------------------------

      case 'OHP_GPC':
        return _addOverheadGreaserPowerChain(
          configuration: configuration,
          quantity: quantity,
        );


    // ---------------------------------------------------------
    // 2100L SERIES SELF-CONTAINED I-BEAM CONVEYOR LUBRICATORS
    // Product ID: OHP_2100I
    // POST /api/ohp_2100i
    // ---------------------------------------------------------

      case 'OHP_2100I':
        return _addOverhead2100LSelfContainedIBeamConveyorLubricators(
          configuration: configuration,
          quantity: quantity,
        );


    // ---------------------------------------------------------
    // 9000L SERIES CENTRAL SYSTEM I-BEAM CONVEYOR LUBRICATORS
    // Product ID: OHP_9000I
    // POST /api/ohp_9000i
    // ---------------------------------------------------------

      case 'OHP_9000I':
        return _addOverhead9000LCentralSystemIBeamConveyorLubricators(
          configuration: configuration,
          quantity: quantity,
        );


      case 'OHP_CDL':
        return _addOverhead9125_9126CaterpillarDrive(
          configuration: configuration,
          quantity: quantity,
        );

      case 'OHP_ES':
        return _addOverheadESeries(
          configuration: configuration,
          quantity: quantity,
        );

      case 'OHP_OP4A':
        return _addOverheadOp4A(
          configuration: configuration,
          quantity: quantity,
        );


      case 'OHP_OP52':
        return _addOverheadOp52(
          configuration: configuration,
          quantity: quantity,
        );

      case 'OHP_OP139A':
        return _addOverheadOp139A(
          configuration: configuration,
          quantity: quantity,
        );

      case 'OHP_MLP':
        return _addOverheadMlp(
          configuration: configuration,
          quantity: quantity,
        );

      case 'OHP_PML':
        return _addOverheadPml(
          configuration: configuration,
          quantity: quantity,
        );

      case 'SLMLMS':
        return _addslmlms(
          configuration: configuration,
          quantity: quantity,
        );

      case 'OHP_PMM':
        return _addOverheadPmm(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // POWER AND FREE OVERHEAD OR INVERTED
    // NON-POWERED MIGHTY LUBE BRUSH CLEANERS 300I / 400I / 600I
    // Product ID: PFO_CCS_300I
    // -------------------------------------------------------

      case 'PFO_CCS_300I':
        return _addPfoNonPoweredBrushCleaners300i400i600i(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // POWER AND FREE OVERHEAD OR INVERTED
    // OP-8 POWER BRUSH CLEANING SYSTEM
    // Product ID: PFO_CCS_OP8
    // -------------------------------------------------------

      case 'PFO_CCS_OP8':
        return _addPfoOp8PowerBrushCleaningSystem(
          configuration: configuration,
          quantity: quantity,
        );

    // -------------------------------------------------------
    // POWER AND FREE OVERHEAD OR INVERTED
    // OP-8NP NON-POWER BRUSH CLEANING SYSTEM
    // Product ID: PFO_CCS_OP8NP
    // -------------------------------------------------------

      case 'PFO_CCS_OP8NP':
        return _addPfoOp8npNonPowerBrushCleaningSystem(
          configuration: configuration,
          quantity: quantity,
        );


      case 'PFO_CGS_FR314':
        return _addPfoFreeRail314LoadWheelGreaser(
          configuration: configuration,
          quantity: quantity,
        );

      case 'PFO_CGS_FR317':
        return _addPfoFreeRail317GuideWheelGreaser(
          configuration: configuration,
          quantity: quantity,
        );

      case 'PFO_CGS_GPC':
        return _addPfoGreaserPowerChain(
          configuration: configuration,
          quantity: quantity,
        );

      case 'PFO_CLS_9000LIBEAM':
        return _addPfo9000lbeam(
          configuration: configuration,
          quantity: quantity,
        );

      case 'PFO_CLS_9000LETCL':
        return _addPfo9000LETCL(
          configuration: configuration,
          quantity: quantity,
        );

      case '9000LCCL':
        return _addPfo9000lCentralSystemPowerAndFreeCChannelConveyorLubricators(
          configuration: configuration,
          quantity: quantity,
        );

      case 'PFO_CLS_CDL':
        return _addPfoCaterpillarDriveLubricators(
          configuration: configuration,
          quantity: quantity,
        );

      case 'PFO_CLS_ES':
        return _addPfoESeries(
          configuration: configuration,
          quantity: quantity,
        );

    // ========================================================
    // PFO - CONVEYOR LUBRICATION SYSTEMS
    // OP-139A
    //
    // Product ID:
    // PFO_CLS_OP139A
    //
    // API:
    // POST /api/pfo_cls_op139a
    // ========================================================

      case 'PFO_CLS_OP139A':
        return _addPfoOp139A(
          configuration: configuration,
          quantity: quantity,
        );


    // ========================================================
    // PFO - CONVEYOR MONITOR SYSTEMS
    // MULTI LINE (PERMANENT) ALL IN ONE
    // MONITORING + LUBRICATION
    //
    // Product ID:
    // PFO_CMS_MLAIO
    //
    // Endpoint:
    // POST /api/pfo_cms_mlaio
    // ========================================================

      case 'PFO_CMS_MLAIO':
        return _addPfoMultiLinePermanentAllInOne(
          configuration: configuration,
          quantity: quantity,
        );

    // ========================================================
    // PFO - CONVEYOR MONITOR SYSTEMS
    // PORTABLE (MULTI-LINE) MIGHTY LUBE® MONITORING SYSTEM
    //
    // Product ID:
    // PFO_CMS_PMLMS
    //
    // Endpoint:
    // POST /api/pfo_cms_pmlms
    // ========================================================

      case 'PFO_CMS_PMLMS':
        return _addPfoPortableMultiLineMonitoringSystem(
          configuration: configuration,
          quantity: quantity,
        );


    // ========================================================
    // PFO - CONVEYOR MONITOR SYSTEMS
    // PAINT MARKER FOR MONITORING SYSTEM (OPTIONAL)
    //
    // Product ID:
    // PFO_CMS_PMMS
    //
    // Endpoint:
    // POST /api/pfo_cms_pmms
    // ========================================================

      case 'PFO_CMS_PMMS':
        return _addPfoPaintMarkerMonitoringSystem(
          configuration: configuration,
          quantity: quantity,
        );






    // ========================================================
    // PROTEIN
    // FOOD GRADE CLEANER OP-8SS
    //
    // Product ID:
    // PROTEIN_OP8SS
    //
    // Endpoint:
    // POST /api/protein_op8ss
    // ========================================================

      case 'PROTEIN_OP8SS':
        return _addProteinFoodGradeCleanerOp8ss(
          configuration: configuration,
          quantity: quantity,
        );


    // ========================================================
    // PROTEIN
    // FOOD GRADE LUBRICATION AND MONITOR
    //
    // Product ID:
    // PROTEIN_FGLM
    //
    // Endpoint:
    // POST /api/protein_fglm
    // ========================================================

      case 'PROTEIN_FGLM':
        return _addProteinFoodGradeLubricationMonitor(
          configuration: configuration,
          quantity: quantity,
        );

    // ========================================================
    // TECHNICIAN
    // TECHNICIAN NOTES
    //
    // Product ID:
    // TECHNICIAN_NOTES
    //
    // Endpoint:
    // POST /api/technician_notes
    // ========================================================

      case 'TECHNICIAN_NOTES':
        return _addTechnicianNotes(
          configuration: configuration,
          quantity: quantity,
        );
    // -------------------------------------------------------
    // UNKNOWN PRODUCT
    // -------------------------------------------------------

      default:
        return Future.value(
          ApiResponse<Map<String, dynamic>>.failure(
            message: 'Unsupported product: $productId',
          ),
        );
    }
  }



  // =========================================================
  // CC5 CHAIN LUBRICATOR
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addCC5ChainLubricator({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'CC5_CLData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.cc5ChainLubricator,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // CC5 OP-40E
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addCC5Op40e({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'CC5_OP4OEData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.cc5Op40e,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // CATERPILLAR DRIVE LUBRICATORS
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addCaterpillarDriveLubricators({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'COE_CDLData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.caterpillarDriveLubricators,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // MIGHTY LUBE CHAIN ON EDGE LUBRICATOR
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addMightyLubeChainOnEdgeLubricator({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'COE_CELData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.mightyLubeChainOnEdgeLubricator,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // CATERPILLAR DRIVE OP-40E
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addCaterpillarOp40e({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'COE_OP4OEData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.caterpillarOp40e,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETIPO UN91 / RW91
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtipoUn91({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETI_91Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etipoUn91,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETIPO 8074-B / 8075-B
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtipo8074({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETI_807Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etipo8074,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETIPO 9000INVL
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtipo9000Invl({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETI_9000INVLData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etipo9000Invl,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETIPO OP-48E
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtipoOp48e({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETI_OP48EData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etipoOp48e,
      body: body,
      parser: _mapParser,
    );
  }


  // =========================================================
  // ETIPO OP-41A
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtipoOp41a({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETI_OP41AData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etipoOp41a,
      body: body,
      parser: _mapParser,
    );
  }


  static Future<ApiResponse<Map<String, dynamic>>> _addEtiMlaio({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETI_MLAIOData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etiMlaio,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETOPO 2100L SERIES SELF-CONTAINED CONVEYOR LUBRICATORS
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtopo2100L({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETO_2100Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etopo2100L,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETOPO 9000L SERIES
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtopo9000L({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETO_9000EData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etopo9000L,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETOPO OP-48E
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtopoOp48e({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETO_OP48EData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etopoOp48e,
      body: body,
      parser: _mapParser,
    );
  }


  // =========================================================
  // ETIPO OP-41A
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtopoOp41a({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETO_OP41AData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etopoOp41a,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETOPO PORTABLE MULTI-LINE MONITORING SYSTEM
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtopoPmlms({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETO_PMLMSData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etopoPmlms,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // ETOPO MULTI LINE ALL IN ONE
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addEtopoMlaio({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'ETO_MLAIOData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.etopoMlaio,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // FREE CARRIER - FREE RAIL 314 "LOAD" WHEEL GREASER
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addFreeCarrier314({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FC_314Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.freeCarrier314,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // FREE CARRIER - FREE RAIL 317 "GUIDE" WHEEL GREASER
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addFreeCarrier317({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FC_317Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.freeCarrier317,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // FLAT TOP - OPCO 300 SERIES AUTOMATIC SEALED WHEEL
  // LUBRICATOR
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addFlatTopOpco300({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FT_OPCOData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.flatTopOpco300,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // FLAT TOP - MIGHTY LUBE FLAT TOP LUBRICATOR
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addFlatTopMightyLubeLubricator({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FT_MLCELData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.flatTopMightyLubeLubricator,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
// FLAT TOP - CATERPILLAR DRIVE LUBRICATORS
// =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addFlatTopCaterpillarDriveLubricators({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FT_CDLData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.flatTopCdl,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // FLAT TOP - OP-40E
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addFlatTopOp40e({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FT_OP40EData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.flatTopOp40e,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // C CHANNEL OVERHEAD OR INVERTED
  // OVERSPRAY ELIMINATOR BRUSH
  // Product ID: FRO_OEB
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addCChannelOversprayEliminatorBrush({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FRO_OEBData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.cChannelOversprayEliminatorBrush,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // C CHANNEL OVERHEAD OR INVERTED
  // FREE RAIL 314 "LOAD" WHEEL GREASER
  // Product ID: FRO_314
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addCChannelFreeRail314({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FRO_314Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.cChannelFreeRail314,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // C CHANNEL OVERHEAD OR INVERTED
  // FREE RAIL 317 "GUIDE" WHEEL GREASER
  // Product ID: FRO_317
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addCChannelFreeRail317({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FRO_317Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.cChannelFreeRail317,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // C CHANNEL OVERHEAD OR INVERTED
  // 9000L SERIES CENTRAL SYSTEM FREE CARRIER
  // CONVEYOR LUBRICATORS
  //
  // Product ID: 9000L
  // Backend Model/Route: FRO_9000F
  // POST /api/fro_9000f
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addCChannel9000LSeries({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FRO_9000FData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.cChannel9000LSeries,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // C CHANNEL OVERHEAD OR INVERTED
  // E-SERIES
  //
  // Product ID: FRO_ES
  // POST /api/fro_es
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addCChannelESeries({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FRO_ESData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.cChannelESeries,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // C CHANNEL OVERHEAD OR INVERTED
  // OP-139A
  //
  // Product ID: FRO_OP139A
  // POST /api/fro_op139a
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addCChannelOp139A({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'FRO_OP139AData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.cChannelOp139A,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // IN FLOOR TOW LINE
  // MIGHTY LUBE IN FLOOR TOW LINE
  //
  // Product ID: IFT_IFTL
  // Request Body: IFT_IFTLData
  // POST /api/ift_iftl
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addInFloorTowLineMightyLube({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'IFT_IFTLData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.inFloorTowLineMightyLube,
      body: body,
      parser: _mapParser,
    );
  }


  // =========================================================
  // IN FLOOR TOW LINE
  // OP-40E
  //
  // Product ID: IFT_OP4OE
  // Request Body: IFT_OP4OEData
  // POST /api/ift_op4oe
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addInFloorTowLineOp40e({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'IFT_OP4OEData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.inFloorTowLineOp40e,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // IN-BOARD ROLLER CHAIN
  // MIGHTY LUBE ROLLER FLIGHT CONVEYOR
  //
  // Product ID: IBR_RFC
  // Request Body: IBR_RFCData
  // POST /api/ibr_rfc
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addInBoardRollerChainMightyLubeRollerFlightConveyor({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'IBR_RFCData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.inBoardRollerChainMightyLubeRollerFlightConveyor,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // IN-BOARD ROLLER CHAIN
  // OP-40E
  //
  // Product ID: IBR_OP4OE
  // Request Body: IBR_OP4OEData
  // POST /api/ibr_op4oe
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addInBoardRollerChainOp40e({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'IBR_OP4OEData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.inBoardRollerChainOp40e,
      body: body,
      parser: _mapParser,
    );
  }


  // =========================================================
// IN-BOARD ROLLER CHAIN
// OPCO 300 SERIES AUTOMATIC SEALED WHEEL LUBRICATOR
// =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addInBoardRollerChain300({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'IBRC_300Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.inBoardRollerChain300,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // OVER HEAD POWER RAIL L-BEAM
  // I-BEAM CONVEYOR BEAM SWEEP
  //
  // Product ID: OH_CCS_IBEAM
  // Request Body: OH_CCS_IBEAMData
  // POST /api/oh_ccs_ibeam
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverheadIBeamConveyorBeamSweep({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OH_CCS_IBEAMData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadIBeamConveyorBeamSweep,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // OVER HEAD POWER RAIL L-BEAM
  // OP-13 SANITARY HOOK CLEANER
  //
  // Product ID: OH_CCS_OP13
  // Request Body: OH_CCS_OP13Data
  // POST /api/oh_ccs_op13
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverheadOp13SanitaryHookCleaner({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OH_CCS_OP13Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadOp13SanitaryHookCleaner,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // OVER HEAD POWER RAIL L-BEAM
  // OVERSPRAY ELIMINATOR BRUSH
  //
  // Product ID: OH_CCS_BRUSH
  // Request Body: OH_CCS_BRUSHData
  // POST /api/oh_ccs_brush
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverheadOversprayEliminatorBrush({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OH_CCS_BRUSHData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadOversprayEliminatorBrush,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // OVER HEAD POWER RAIL L-BEAM
  // NON-POWERED MIGHTY LUBE BRUSH CLEANERS 300I / 400I / 600I
  //
  // Product ID: OH_CCS_3000
  // Request Body: OH_CCS_3000Data
  // POST /api/oh_ccs_3000
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverheadNonPoweredBrushCleaners300i400i600i({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OH_CCS_3000Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadNonPoweredBrushCleaners300i400i600i,
      body: body,
      parser: _mapParser,
    );
  }


  // =========================================================
  // OVER HEAD POWER RAIL L-BEAM
  // OP-8 POWER BRUSH CLEANING SYSTEM
  // CONVEYOR CHAIN & TROLLEY WHEEL CLEANER
  //
  // Product ID: OH_CCS_OP8
  // Request Body: OH_CCS_OP8Data
  // POST /api/oh_ccs_op8
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverheadOp8PowerBrushCleaningSystem({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OH_CCS_OP8Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadOp8PowerBrushCleaningSystem,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // OVER HEAD POWER RAIL L-BEAM
  // OP-8NP NON-POWER BRUSH CLEANING SYSTEM
  // I-BEAM CONVEYOR CHAIN CLEANER
  //
  // Product ID: OH_CCS_OP8NP
  // Request Body: OH_CCS_OP8NPData
  // POST /api/oh_ccs_op8np
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverheadOp8npNonPowerBrushCleaningSystem({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OH_CCS_OP8NPData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadOp8npNonPowerBrushCleaningSystem,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // OVER HEAD POWER RAIL L-BEAM
  // OP-55
  //
  // Product ID: OH_CCS_O55
  // Request Body: OH_CCS_O55Data
  // POST /api/oh_ccs_o55
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addOverheadOp55({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OH_CCS_O55Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadOp55,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // OVER HEAD POWER RAIL L-BEAM
  // YOKE CLEANING BRUSH
  //
  // Product ID: OH_CCS_CLEANING_BRUSH
  // Request Body: OH_CCS_CLEANING_BRUSHData
  // POST /api/oh_ccs_cleaning_brush
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverheadYokeCleaningBrush({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OH_CCS_CLEANING_BRUSHData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadYokeCleaningBrush,
      body: body,
      parser: _mapParser,
    );
  }


  // =========================================================
  // GREASER POWER CHAIN
  //
  // Product ID: OHP_GPC
  // Request Body: OHP_GPCData
  // POST /api/ohp_gpc
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverheadGreaserPowerChain({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_GPCData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadGreaserPowerChain,
      body: body,
      parser: _mapParser,
    );
  }

  // ---------------------------------------------------------
// 2100L SERIES SELF-CONTAINED I-BEAM CONVEYOR LUBRICATORS
// Product ID: OHP_2100I
// Request Body: OHP_2100IData
// POST /api/ohp_2100i
// ---------------------------------------------------------

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverhead2100LSelfContainedIBeamConveyorLubricators({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_2100IData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overhead2100LSelfContainedIBeamConveyorLubricators,
      body: body,
      parser: _mapParser,
    );
  }

  // ---------------------------------------------------------
// 9000L SERIES CENTRAL SYSTEM I-BEAM CONVEYOR LUBRICATORS
// Product ID: OHP_9000I
// Request Body: OHP_9000IData
// POST /api/ohp_9000i
// ---------------------------------------------------------

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverhead9000LCentralSystemIBeamConveyorLubricators({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_9000IData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overhead9000LCentralSystemIBeamConveyorLubricators,
      body: body,
      parser: _mapParser,
    );
  }


  // ---------------------------------------------------------
// 9125/9126 CATERPILLAR DRIVE
// Product ID: OHP_CDL
// Request Body: OHP_CDLData
// POST /api/ohp_cdl
// ---------------------------------------------------------

  static Future<ApiResponse<Map<String, dynamic>>>
  _addOverhead9125_9126CaterpillarDrive({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_CDLData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overhead9125_9126CaterpillarDrive,
      body: body,
      parser: _mapParser,
    );
  }


  static Future<ApiResponse<Map<String, dynamic>>> _addOverheadESeries({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_ESData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadESeries,
      body: body,
      parser: _mapParser,
    );
  }


  static Future<ApiResponse<Map<String, dynamic>>> _addOverheadOp4A({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_OP4AData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadOp4A,
      body: body,
      parser: _mapParser,
    );
  }


  static Future<ApiResponse<Map<String, dynamic>>> _addOverheadOp52({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_OP52Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadOp52,
      body: body,
      parser: _mapParser,
    );
  }

  static Future<ApiResponse<Map<String, dynamic>>> _addOverheadOp139A({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_OP139AData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadOp139A,
      body: body,
      parser: _mapParser,
    );
  }


  static Future<ApiResponse<Map<String, dynamic>>> _addOverheadMlp({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_MLPData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadMlp,
      body: body,
      parser: _mapParser,
    );
  }


  static Future<ApiResponse<Map<String, dynamic>>> _addOverheadPml({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_PMLData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadPml,
      body: body,
      parser: _mapParser,
    );
  }


  static Future<ApiResponse<Map<String, dynamic>>> _addslmlms({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'SLMLMSData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadslmlms,
      body: body,
      parser: _mapParser,
    );
  }


  static Future<ApiResponse<Map<String, dynamic>>> _addOverheadPmm({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'OHP_PMMData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.overheadPmm,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // GET CONFIGURATOR / CART
  // =========================================================

  static Future<ApiResponse<List<dynamic>>> getOrders() {
    return ApiClient.get<List<dynamic>>(
      url: ApiEndpoints.cart,
      parser: (data) {
        if (data is List) {
          return List<dynamic>.from(data);
        }

        return <dynamic>[];
      },
    );
  }

  // =========================================================
  // GET USER ORDERS
  // =========================================================

  static Future<ApiResponse<List<dynamic>>> getUserOrders() {
    return ApiClient.get<List<dynamic>>(
      url: ApiEndpoints.userOrders,
      parser: (data) {
        if (data is List) {
          return List<dynamic>.from(data);
        }

        return <dynamic>[];
      },
    );
  }

  // =========================================================
  // GET CONFIGURATIONS
  // =========================================================

  static Future<ApiResponse<List<dynamic>>> getConfigurations() {
    return ApiClient.get<List<dynamic>>(
      url: ApiEndpoints.configurations,
      parser: (data) {
        if (data is List) {
          return List<dynamic>.from(data);
        }

        return <dynamic>[];
      },
    );
  }

  // =========================================================
  // COMMON MAP PARSER
  // =========================================================

  static Map<String, dynamic> _mapParser(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    return <String, dynamic>{};
  }


  // =========================================================
  // POWER AND FREE OVERHEAD OR INVERTED
  // NON-POWERED MIGHTY LUBE BRUSH CLEANERS 300I / 400I / 600I
  //
  // Product ID: PFO_CCS_300I
  // Request Body: PFO_CCS_300IData
  // POST /api/pfo_ccs_300i
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addPfoNonPoweredBrushCleaners300i400i600i({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'PFO_CCS_300IData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.pfoNonPoweredBrushCleaners300i400i600i,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // POWER AND FREE OVERHEAD OR INVERTED
  // OP-8 POWER BRUSH CLEANING SYSTEM
  //
  // Product ID: PFO_CCS_OP8
  // Request Body: PFO_CCS_OP8Data
  // POST /api/pfo_ccs_op8
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addPfoOp8PowerBrushCleaningSystem({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'PFO_CCS_OP8Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.pfoOp8PowerBrushCleaningSystem,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // POWER AND FREE OVERHEAD OR INVERTED
  // OP-8NP NON-POWER BRUSH CLEANING SYSTEM
  //
  // Product ID: PFO_CCS_OP8NP
  // Request Body: PFO_CCS_OP8NPData
  // POST /api/pfo_ccs_op8np
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addPfoOp8npNonPowerBrushCleaningSystem({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'PFO_CCS_OP8NPData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.pfoOp8npNonPowerBrushCleaningSystem,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // POWER AND FREE OVERHEAD OR INVERTED
  // FREE RAIL 314 "LOAD" WHEEL GREASER
  //
  // Product ID: PFO_CGS_FR314
  // Request Body: PFO_CGS_FR314Data
  // POST /api/pfo_cgs_fr314
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addPfoFreeRail314LoadWheelGreaser({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'PFO_CGS_FR314Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.pfoFreeRail314LoadWheelGreaser,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // POWER AND FREE OVERHEAD OR INVERTED
  // FREE RAIL 317 "GUIDE" WHEEL GREASER
  //
  // Product ID: PFO_CGS_FR317
  // Request Body: PFO_CGS_FR317Data
  // POST /api/pfo_cgs_fr317
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addPfoFreeRail317GuideWheelGreaser({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'PFO_CGS_FR317Data': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.pfoFreeRail317GuideWheelGreaser,
      body: body,
      parser: _mapParser,
    );
  }


  // =========================================================
  // POWER AND FREE OVERHEAD OR INVERTED
  // GREASER POWER CHAIN
  //
  // Product ID: PFO_CGS_GPC
  // Request Body: PFO_CGS_GPCData
  // POST /api/pfo_cgs_gpc
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addPfoGreaserPowerChain({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'PFO_CGS_GPCData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.pfoGreaserPowerChain,
      body: body,
      parser: _mapParser,
    );
  }


  // =========================================================
  // POWER AND FREE OVERHEAD OR INVERTED
  // 9000L SERIES CENTRAL OVERHEAD I-BEAM CONVEYOR LUBRICATORS
  //
  // Product ID: PFO_CLS_9000L
  // Request Body: PFO_CLS_9000LData
  // POST /api/pfo_cls_9000l
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addPfo9000lbeam({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'PFO_CLS_9000LIBEAMData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.pfo9000LIBEAM,
      body: body,
      parser: _mapParser,
    );
  }

  // =========================================================
  // PFO - CONVEYOR LUBRICATION SYSTEMS
  // 9000L SERIES CENTRAL SYSTEM ENCLOSED TRACK
  // CONVEYOR LUBRICATORS
  //
  // Product ID: PFO_CLS_9000LECCCL
  // Request Body: PFO_CLS_9000LECCCLData
  // POST /api/pfo_cls_9000lecccl
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addPfo9000LETCL({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'PFO_CLS_9000LETCLData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.pfo9000LETCL,
      body: body,
      parser: _mapParser,
    );
  }

// =========================================================
// PFO - CONVEYOR LUBRICATION SYSTEMS
// 9000L SERIES CENTRAL SYSTEM POWER AND FREE
// C-CHANNEL CONVEYOR LUBRICATORS
//
// Product ID: 9000LCCL
// Request Body: 9000LCCLData
// POST /api/9000lccl
// =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addPfo9000lCentralSystemPowerAndFreeCChannelConveyorLubricators({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      '9000LCCLData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.pfo9000lCCL,
      body: body,
      parser: _mapParser,
    );
  }

  static Future<ApiResponse<Map<String, dynamic>>>
  _addPfoCaterpillarDriveLubricators({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'PFO_CLS_CDLData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.pfoCaterpillarDriveLubricators,
      body: body,
      parser: _mapParser,
    );
  }



  static Future<ApiResponse<Map<String, dynamic>>> _addPfoESeries({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    final Map<String, dynamic> body = {
      'PFO_CLS_ESData': configuration,
      'numRequested': quantity,
    };

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.pfoESeries,
      body: body,
      parser: _mapParser,
    );
  }

  // ============================================================
  // PFO - CONVEYOR LUBRICATION SYSTEMS
  // OP-139A
  //
  // Product ID:
  // PFO_CLS_OP139A
  //
  // Endpoint:
  // POST /api/pfo_cls_op139a
  //
  // Body:
  // {
  //   "PFO_CLS_OP139AData": configuration,
  //   "numRequested": quantity
  // }
  //
  // The backend first validates the configuration using the
  // PFO_CLS_OP139A product-specific Mongoose model.
  //
  // The validated configuration is then persisted inside the
  // generic ProductConfiguration collection.
  // ============================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addPfoOp139A({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    // ----------------------------------------------------------
    // Build backend request body.
    //
    // IMPORTANT:
    // The key "PFO_CLS_OP139AData" must remain exactly the same
    // as the key expected by:
    //
    // routes/PFO/CLS/PFO_CLS_OP139A.js
    // ----------------------------------------------------------

    final Map<String, dynamic> body = {
      'PFO_CLS_OP139AData': configuration,
      'numRequested': quantity,
    };

    // ----------------------------------------------------------
    // Send configuration to the OP-139A backend endpoint.
    // ----------------------------------------------------------

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.pfoOp139A,
      body: body,
      parser: _mapParser,
    );
  }



  // ============================================================
  // PFO - CONVEYOR MONITOR SYSTEMS
  // MULTI LINE (PERMANENT) ALL IN ONE
  // MONITORING + LUBRICATION
  //
  // Product ID:
  // PFO_CMS_MLAIO
  //
  // Endpoint:
  // POST /api/pfo_cms_mlaio
  //
  // Request Body:
  // {
  //   "PFO_CMS_MLAIOData": configuration,
  //   "numRequested": quantity
  // }
  //
  // Backend Flow:
  //
  // Flutter configuration
  //        ↓
  // POST /api/pfo_cms_mlaio
  //        ↓
  // PFO_CMS_MLAIO.js route
  //        ↓
  // PFO_CMS_MLAIO Mongoose validation model
  //        ↓
  // ProductConfiguration
  //
  // IMPORTANT:
  // The product-specific Mongoose model is used only for
  // validation. The final configuration is persisted in the
  // generic ProductConfiguration collection.
  // ============================================================

  static Future<ApiResponse<Map<String, dynamic>>> _addPfoMultiLinePermanentAllInOne({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    // ----------------------------------------------------------
    // Build request body.
    //
    // IMPORTANT:
    // "PFO_CMS_MLAIOData" must exactly match the key expected
    // by the backend route.
    // ----------------------------------------------------------

    final Map<String, dynamic> body = {
      'PFO_CMS_MLAIOData': configuration,
      'numRequested': quantity,
    };

    // ----------------------------------------------------------
    // Submit the product configuration.
    // ----------------------------------------------------------

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.pfoMultiLinePermanentAllInOne,
      body: body,
      parser: _mapParser,
    );
  }


  // ============================================================
  // PFO - CONVEYOR MONITOR SYSTEMS
  // PORTABLE (MULTI-LINE) MIGHTY LUBE® MONITORING SYSTEM
  //
  // Product ID:
  // PFO_CMS_PMLMS
  //
  // Endpoint:
  // POST /api/pfo_cms_pmlms
  //
  // Request Body:
  // {
  //   "PFO_CMS_PMLMSData": configuration,
  //   "numRequested": quantity
  // }
  //
  // Backend Flow:
  //
  // Flutter Product Configurator
  //          ↓
  // POST /api/pfo_cms_pmlms
  //          ↓
  // routes/PFO/CMS/PFO_CMS_PMLMS.js
  //          ↓
  // models/PFO/CMS/PFO_CMS_PMLMS.js
  //          ↓
  // Product-specific validation
  //          ↓
  // ProductConfiguration
  //
  // IMPORTANT:
  // PFO_CMS_PMLMS is only the validation model.
  // The final configuration is stored in the generic
  // ProductConfiguration collection.
  // ============================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addPfoPortableMultiLineMonitoringSystem({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    // ----------------------------------------------------------
    // Build request body.
    //
    // IMPORTANT:
    // "PFO_CMS_PMLMSData" must exactly match the request key
    // expected by the backend route.
    // ----------------------------------------------------------

    final Map<String, dynamic> body = {
      'PFO_CMS_PMLMSData': configuration,
      'numRequested': quantity,
    };

    // ----------------------------------------------------------
    // Submit Portable Multi-Line Monitoring configuration.
    // ----------------------------------------------------------

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.pfoPortableMultiLineMonitoringSystem,
      body: body,
      parser: _mapParser,
    );
  }


  // ============================================================
  // PFO - CONVEYOR MONITOR SYSTEMS
  // PAINT MARKER FOR MONITORING SYSTEM (OPTIONAL)
  //
  // Product ID:
  // PFO_CMS_PMMS
  //
  // Endpoint:
  // POST /api/pfo_cms_pmms
  //
  // Request Body:
  // {
  //   "PFO_CMS_PMMSData": configuration,
  //   "numRequested": quantity
  // }
  //
  // Backend Flow:
  //
  // Flutter Product Configurator
  //          ↓
  // POST /api/pfo_cms_pmms
  //          ↓
  // routes/PFO/CMS/PFO_CMS_PMMS.js
  //          ↓
  // models/PFO/CMS/PFO_CMS_PMMS.js
  //          ↓
  // Product-specific validation
  //          ↓
  // ProductConfiguration
  //
  // IMPORTANT:
  // The PFO_CMS_PMMS Mongoose model is used only for
  // validating this product's configuration.
  //
  // The final configuration is stored in the generic
  // ProductConfiguration collection.
  // ============================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addPfoPaintMarkerMonitoringSystem({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    // ----------------------------------------------------------
    // Build request body.
    //
    // IMPORTANT:
    // "PFO_CMS_PMMSData" must exactly match the key expected
    // by the backend route.
    // ----------------------------------------------------------

    final Map<String, dynamic> body = {
      'PFO_CMS_PMMSData': configuration,
      'numRequested': quantity,
    };

    // ----------------------------------------------------------
    // Send configuration to the backend.
    // ----------------------------------------------------------

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.pfoPaintMarkerMonitoringSystem,
      body: body,
      parser: _mapParser,
    );
  }









  // ============================================================
  // PROTEIN
  // FOOD GRADE CLEANER OP-8SS
  //
  // IMPORTANT:
  // PROTEIN_OP8SS is only the product-specific validation
  // model. Final persistence is handled by the generic
  // ProductConfiguration model.
  // ============================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addProteinFoodGradeCleanerOp8ss({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    // ----------------------------------------------------------
    // Build backend request body.
    //
    // PROTEIN_OP8SSData must exactly match the request key
    // expected by the Node.js backend route.
    // ----------------------------------------------------------

    final Map<String, dynamic> body = {
      'PROTEIN_OP8SSData': configuration,
      'numRequested': quantity,
    };

    // ----------------------------------------------------------
    // Submit configuration.
    // ----------------------------------------------------------

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.proteinFoodGradeCleanerOp8ss,
      body: body,
      parser: _mapParser,
    );
  }

  // ============================================================
  // PROTEIN
  // FOOD GRADE LUBRICATION AND MONITOR
  //
  // Product ID:
  // PROTEIN_FGLM
  //
  // Endpoint:
  // POST /api/protein_fglm
  //
  // Request Body:
  //
  // {
  //   "PROTEIN_FGLMData": configuration,
  //   "numRequested": quantity
  // }
  //
  // FLOW:
  //
  // Flutter Product Configurator
  //          ↓
  // POST /api/protein_fglm
  //          ↓
  // routes/Protein/PROTEIN_FGLM.js
  //          ↓
  // models/Protein/PROTEIN_FGLM.js
  //          ↓
  // Product-specific validation
  //          ↓
  // ProductConfiguration
  //
  // IMPORTANT:
  // PROTEIN_FGLM is only used for product-specific validation.
  //
  // The final configuration is persisted using the generic
  // ProductConfiguration model.
  // ============================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addProteinFoodGradeLubricationMonitor({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    // ----------------------------------------------------------
    // Build backend request body.
    //
    // "PROTEIN_FGLMData" must exactly match the key expected
    // by the Node.js backend route.
    // ----------------------------------------------------------

    final Map<String, dynamic> body = {
      'PROTEIN_FGLMData': configuration,
      'numRequested': quantity,
    };

    // ----------------------------------------------------------
    // Submit Food Grade Lubrication and Monitor configuration.
    // ----------------------------------------------------------

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.proteinFoodGradeLubricationMonitor,
      body: body,
      parser: _mapParser,
    );
  }


  // ============================================================
  // TECHNICIAN
  // TECHNICIAN NOTES
  //
  // Product ID:
  // TECHNICIAN_NOTES
  //
  // Endpoint:
  // POST /api/technician_notes
  //
  // Request Body:
  //
  // {
  //   "TECHNICIAN_NOTESData": {
  //     "notes": "..."
  //   },
  //   "numRequested": 1
  // }
  //
  // FLOW:
  //
  // Technician Notes Configurator
  //          ↓
  // ProductApiService.addOrder()
  //          ↓
  // _addTechnicianNotes()
  //          ↓
  // POST /api/technician_notes
  //          ↓
  // Backend Technician Notes Route
  //
  // IMPORTANT:
  // Quantity is handled by the generic configurator flow.
  // Only the technician-specific configuration is sent inside
  // TECHNICIAN_NOTESData.
  // ============================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  _addTechnicianNotes({
    required Map<String, dynamic> configuration,
    required int quantity,
  }) {
    // ----------------------------------------------------------
    // Build request body.
    //
    // "TECHNICIAN_NOTESData" must exactly match the request key
    // expected by the backend route.
    // ----------------------------------------------------------

    final Map<String, dynamic> body = {
      'TECHNICIAN_NOTESData': configuration,
      'numRequested': quantity,
    };

    // ----------------------------------------------------------
    // Send Technician Notes configuration to backend.
    // ----------------------------------------------------------

    return ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.technicianNotes,
      body: body,
      parser: _mapParser,
    );
  }
}